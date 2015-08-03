(function($) {
		
	var ImageScrollerPlugin = function(elm, options) {
		this.init(elm, options);
	}
	
	
	ImageScrollerPlugin.prototype = {
		
		init: function(elm, options) 
		{
			var obj = this;
			
			this.element = elm;
			
			var $parent = $(elm);
			
			this.settings = $.extend({}, {
				mobile		: false,
				animation	: 'slide',
				selector	: ".project-gallery-content img"
			}, options);
			
			this.images = $(this.settings.selector, elm);
			
			// Add the event listeners for the back and previous buttons
			$("a.next", elm).click(function()
			{
				if(obj.settings.animation == 'slide') {
					var prevPos = obj.getPosition(obj.prevImage);
					prevPos.left = -(obj.prevImage.width());
					
					var nextPos = obj.getPosition(obj.nextImage);
					nextPos.left = obj.getRightSide();
					
					obj.prevImage.css(prevPos);
					obj.nextImage.css(nextPos);
				}
				obj.next();
				return false;
			});
			$("a.prev", elm).click(function()
			{
				if(obj.settings.animation == 'slide') {
					var prevPos = obj.getPosition(obj.prevImage);
					prevPos.left = -(obj.prevImage.width());
					
					var nextPos = obj.getPosition(obj.nextImage);
					nextPos.left = obj.getRightSide();
					
					obj.prevImage.css(prevPos);
					obj.nextImage.css(nextPos);
				}
				obj.prev();
				return false;
			});
				
			if(this.settings.mobile) {
				
				// Add the back button
				var $back = $('<a class="project-gallery-back"><span>Back</span></a>');
				$(".prev", elm).wrap('<div class="project-gallery-header"></div>');
				$('.project-gallery-header', elm).prepend($back).append($(".next", elm)).hide();
			
				$(".gallery-mobile > *", $parent).click(function() {
					obj.open();
				});
				$('.project-gallery-back', $parent).click(function() {
					obj.close();
				});
						    
			    //$(window).hashchange(function() { obj.onHashChanged() });
			    
			} else {
				this.show();
			}
			
		},
		
		index: 0,
		isOpen: false,
		
		onHashChanged: function()
		{
/*
			if(window.location.hash == ""){
		    	if(this.isOpen) this.close();
		    } else if(window.location.hash == "#"+$(this.element).attr("id")) {
		    	if(!this.isOpen) this.open();
		    }
*/
		},
		
		/**
		 * Close the gallery
		 */
		close: function()
		{
			this.isOpen = false;
		
			window.location.hash = "";
		
			$("body").removeClass('gallery-open');
			
			// hide the gallery
			$('.project-gallery-content, .caption', this.element).hide();
			
			// replace the gallery back in place of the placeholder
			var $placeholder = $('.gallery-placeholder');
			$placeholder.after(this.element);
			$(".gallery-mobile", this.element).show();
			$placeholder.remove();
			
			$(".current", this.element).removeClass("current");
			
			// remove the event listeners for the touch
			this.element.removeEventListener('touchstart', this, false);
			this.element.removeEventListener('touchmove', this, false);
			this.element.removeEventListener('touchend', this, false);
			
			document.removeEventListener("orientationchange", this, false);
			window.removeEventListener("orientationchange", this, false);
			
		},
		
		
		/**
		 * Open the gallery for mobile
		 */
		open: function()
		{
			var obj = this;
		
			window.location.hash = $(this.element).attr("id")
			
			this.isOpen = true;
		
			$("body").addClass('gallery-open');
			
			$(".gallery-mobile", this.element).hide();
			$('.caption, .project-gallery-header', this.element).show();
			
			// put in a place holder to replace the gallery later
			$(this.element).after('<div class="gallery-placeholder"></div>').show().find('.project-gallery-content').show();
			
			// add the gallery to the top off the page
			$("body").append(this.element);
			
			// set the first image as current
			this.index = 0;
			this.setCurrent(this.images.eq(0).addClass("current"));			
			this.setPosition();
			this.onHashChanged();
			
			setTimeout(function() {
				obj.setPosition();
			}, 500);
			
			this.element.addEventListener('touchstart', this, false);
			
			document.addEventListener("orientationchange", this, false);
			window.addEventListener("orientationchange", this, false);
			
		},
		
		
		onOrientationChanged: function(event)
		{
			var obj = this;
			
			obj.onAnimationComplete(obj.currentImage);
			obj.setPosition();
			
			setTimeout(function() {
				obj.setPosition();
			}, 500);
			
		},
		
		/**
		 * Open the gallery for normal browsers
		 */
		show: function ()
		{
			var obj = this;
			
			// TODO: rename imagescroller-positions to imagescroller-indication
			
			if($('.imagescroller-positions',this.element).length > 0)
			{
				var ul = $('<ul></ul>').appendTo($('.imagescroller-positions',this.element));
			
				this.images.each(function(i)
				{
					var clazz = "invisible";
					if(i==0) {
						clazz = "visible";
					}
					
					ul
					.append($('<li class="'+clazz+'"></li>')
					.data("index", i)
					.click(function() {
						obj.goto($(this).data("index"));
					}));
				});
			}
			
			this.index = 0;
			// on loaded so the size of the image is known
			this.images.eq(0).addClass("current").load(function() {
				obj.setCurrent($(this));
			})
			
		},
		
		
		/**
		 * Touch event handlers
		 */
		handleEvent: function(event) {
			switch(event.type) {
				case 'mousedown':
				case 'touchstart': 
					this.onTouchStart(event);
				break;
				case 'mousemove':
				case 'touchmove':
					this.onTouchMove(event);
				return false;
				case 'mouseup':
				case 'touchend':
					this.onTouchEnd(event);
				break;
				case 'orientationchange':
					this.onOrientationChanged(event);
			}
		},
		onTouchStart: function(event)
		{
			this.moved = false;
			
			if(event.touches) {
				var touch = event.touches[0];
				this.startTouchX = touch.pageX;
				this.touchY = touch.pageY;
			} else {
				this.startTouchX = event.pageX;
				this.touchY = event.pageY;
			}
			this.images.stop(true, true);
			
			this.element.addEventListener('touchmove', this, false);
			this.element.addEventListener('touchend', this, false);
			
	//		this.element.addEventListener('mousemove', this, false);
	//		this.element.addEventListener('mouseup', this, false);
			
		},
		onTouchMove: function(event)
		{
			this.moved = true;
						
			if(event.touches) {
				var touch = event.touches[0];
				this.touchDiff = this.startTouchX - touch.pageX;
				this.touchY = touch.pageY;
			} else {
				this.touchDiff = this.startTouchX - event.pageX;
				this.touchY = event.pageY;
			}
			
			var pos = this.getPosition(this.currentImage);
			
			if(this.touchDiff > 0) {
				this.nextImage.addClass("animation").css({
					top: pos.top,
					left: (-this.touchDiff)+this.getRightSide()/* this.nextImage.width() */
				});
			} else {
				this.prevImage.addClass("animation").css({
					top: pos.top,
					left: (-this.touchDiff)-this.prevImage.width()
				});
			}
			
			this.currentImage.css({
				left: pos.left-this.touchDiff
			});
			
			if(event.preventDefault) {
				event.preventDefault();
			}
			
		},
		onTouchEnd: function(event)
		{
			
			if(!this.moved) {
				if(this.touchY > 40) {
					this.switchEnvironment();
				}
				return;
			}
			
		
			var obj = this;
			
			this.element.removeEventListener('touchmove', this, false);
			this.element.removeEventListener('touchend', this, false);
			
	//		this.element.removeEventListener('mousemove', this, false);
	//		this.element.removeEventListener('mouseup', this, false);
			
			if(this.touchDiff > 50) {
				this.next();
			}
			else if(this.touchDiff < -50) {
				this.prev();
			}
			else
			{
				this.currentImage.animate(this.getPosition(this.currentImage), {
					complete: function() {
						obj.onAnimationComplete(this);
					},
					duration: 'fast'
				});
				this.nextImage.animate({
					left: obj.getRightSide() //this.nextImage.width()
				}, {
					duration: 'fast'
				});
				this.prevImage.animate({
					left: -this.prevImage.width()
				}, {
					duration: 'fast'
				});
			}
		},
		
		
		switchEnvironment: function() {
			if($(".caption", this.element).is(':visible')) {
				$(".caption, .project-gallery-header", this.element).fadeOut('fast');
			} else {
				$(".caption, .project-gallery-header", this.element).fadeIn('fast');
			}
		},
		
		
		// only accepts yet -1 and 1
		getIndexByDiff: function(diff)
		{
			var index = this.index;
			
			if(diff > 0) {
				index++;
				if(index > this.images.length-1) {
					index = 0;
				}
			} else if(diff < 0) {
				index--;
				if(index < 0) {
					index = this.images.length-1;
				}
			}
			return index;
		},
		
		
		/**
		 * Navigate the gallery forward
		 */
		next: function()
		{
			if(this.settings.animation == 'fade') {
				this.goto(this.getIndexByDiff(1));
				return;
			}
		
			var obj = this;
			var to = this.getPosition(this.nextImage);
			
			//this.prevImage.stop(true, true);
			
			this.currentImage.animate({
				left: obj.getLeftSide()
			}, {
			
				duration: 'fast'
			});
			
			this.nextImage.addClass("animation").animate(to, {
				complete: function() {
					obj.onAnimationComplete(this);
				},
				duration: 'fast'
			});
			
			this.index = this.getIndexByDiff(1);
			this.setCurrent(this.nextImage);
		},
		
		/**
		 * Navigate the gallery backward
		 */
		prev: function()
		{
			if(this.settings.animation == 'fade') {
				this.goto(this.getIndexByDiff(-1));
				return;
			}
		
			var obj = this;
			var to = this.getPosition(this.prevImage);
			
			this.currentImage.animate({
				left: obj.getRightSide() //this.currentImage.width()
			}, {
				duration: 'fast'
			});
			this.prevImage.addClass("animation").animate(to, {
				complete: function() {
					obj.onAnimationComplete(this);
				},
				duration: 'fast'
			});
			
			this.index = this.getIndexByDiff(-1);
			this.setCurrent(this.prevImage);
		},
		
		
		onAnimationComplete: function(elm) {
			$(".current", this.element).removeClass("current");
			$(".animation", this.element).removeClass("animation");
			$(elm).addClass("current");
		},
		
		
		goto: function(index)
		{
			var obj = this;
			
			var el = this.get(index);
			var css = this.getPosition(el);
			css.display = "none";
			
			el
			.addClass("animation")
			.css(css)
			.fadeIn('slow', function() {
				obj.onAnimationComplete(this);
			});
			
			obj.index = index;
			obj.setCurrent(el);
		},
		
		/**
		 * Get the image for the index
		 */
		get: function(index) {
			return this.images.eq(index);
		},
		
		
		/**
		 * Set the image to the current image
		 */
		setCurrent: function (el)
		{
			var obj = this;
		
			this.currentImage = el;
			this.prevImage = this.get(this.getIndexByDiff(-1));
			this.nextImage = this.get(this.getIndexByDiff(1));
			
//			$("img", this.element).hide();
			//this.currentImage.addClass("current").show();
			
			var title = "<p><strong>"+el.attr("title")+"</strong> "+el.attr("alt")+"</p>";
				
			
			if(!this.settings.mobile)
			{
				$(".caption", this.element).stop(true, true).fadeOut('fast', function()
				{
					$(this).html(title);
					
					$(obj.element).animate({
						height: el.height() + $(".caption", obj.element).height()
					}, {
						complete: function() {
							$(".caption", obj.element).fadeIn('fast');
						}
					});
				});
			}
			else
			{
				$(".caption", this.element).html(title);
			}
			
			if($('.imagescroller-positions',this.element).length > 0)
			{
				$(".imagescroller-positions .visible", this.element).removeClass("visible").addClass("invisible");
				$(".imagescroller-positions li", this.element).eq(this.index).removeClass("invisible").addClass("visible");
			}
			
		},
		
		getLeftSide: function() {
			return -this.currentImage.width()
		},
		
		getRightSide: function() {
			if(!this.settings.mobile) {
				return $(this.element).width();
			}
			return $(window).width();
		},
		
		
		/**
		 * Get the center position of an image
		 */
		getPosition: function(image)
		{
			if(!this.settings.mobile) {
				return {
					left: 0,
					right: 0
				}
			}
		
			var pw = $(window).width();
			var ph = parseInt($(this.element).height());
			
			var w = image.width();
			var h = image.height();
			
			var ratio = pw/w;
			
			if(w > pw) {
				w = pw;
				h = h * ratio;
			}
			return {
				width: w,
				height: h,
				top: (ph-h)/2>0?(ph-h)/2:0,
				left: (pw-w)/2>0?(pw-w)/2:0
			};
		},
		
		/**
		 * Set the center position for the images
		 */
		setPosition: function()
		{
			var obj = this;
			
			this.images.each(function() {
				$(this).css(obj.getPosition($(this)));
			});
		}
		
		
	};
	
	$.fn.imageScroller = function(options)
	{
		return this.each(function()
		{
			var element = $(this);
			
			// Return early if this element already has a plugin instance
			if (element.data('imageScroller')) return;
			
			// pass options to plugin constructor
			var imageScroller = new ImageScrollerPlugin(this, options);
			
			// Store plugin object in this element's data
			element.data('imageScroller', imageScroller);
		});
	};
	
	// for further extending:
	//$.fn.imageScroller.prototype = ImageScrollerPlugin.prototype;
	
})(jQuery)