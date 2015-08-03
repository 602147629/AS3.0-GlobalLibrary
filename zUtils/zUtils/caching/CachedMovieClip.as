package zUtils.caching
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    /**
     * Date: 24.06.12
     * Time: 15:21
     * @author zaidite
     * @description
     */

        //TODO Сделать проигрывание анимации зацикленное и обыкновенное. Добавить loopAnimation:Boolean
    public class CachedMovieClip extends MovieClip implements ICachedMovieClip
    {

        // --- PRIVATE VAR ------------------------------------ //

        private var _animation:Animation;
        private var _timer:Timer;

        // --- GET ------------------------------------ //

        public function get animation():Animation {return _animation;}
        public function get speedAnimation():int {return _animation.speed;}

        // --- SET ------------------------------------ //

        public function set speedAnimation(value:int):void
        {
            _animation.speed = value;
            animation_restart();
        }

        // --- OVERRIDE GET ------------------------------------ //

        override public function get x():Number {return this.x;}
        override public function get y():Number {return this.y;}
        override public function get width():Number {return this.width;}
        override public function get height():Number {return this.height;}
        override public function get rotation():Number {return this.rotation;}
        override public function get scaleX():Number {return this.scaleX;}
        override public function get scaleY():Number {return this.scaleY;}

        // --- OVERRIDE SET ------------------------------------ //

        override public function set x(value:Number):void{this.x = value;}
        override public function set y(value:Number):void{this.y = value;}
        override public function set width(value:Number):void{this.width = value;}
        override public function set height(value:Number):void{this.height = value;}
        override public function set rotation(value:Number):void{this.rotation = value;}
        override public function set scaleX(value:Number):void{this.scaleX = value;}
        override public function set scaleY(value:Number):void{this.scaleY = value;}



        //*********************** CONSTRUCTOR ***********************

        public function CachedMovieClip(animation:Animation)
        {
            if(!animation)throw new Error('Animation data is null');
            _animation = animation;
            if(stage)init_data();
            else addEventListener(Event.ADDED_TO_STAGE, init_data);
        }

        //***********************************************************

        private function init_data(event:Event = null):void
        {
            _animation.speed = determinateAnimationSpeed();

            addChild(_animation);
            gotoAndStop(_animation.currentFrame);
        }

        private function timer_start():void
        {
            if(!_timer || !_animation)return;
            if(!_timer.running)
            {
                _timer.start();
                _animation.played = true;
            }
        }

        private function timer_stop():void
        {
            if(!_timer || !_animation)return;
            if(_timer.running)
            {
                _timer.stop();
                _animation.played = false;
            }
        }

        private function animation_restart():void
        {
            if(_animation.speed > 0)
            {
                if(_animation.played)
                {
                    timer_stop();
                    remove_timer();
                    play();
                }
            }
        }

        private function make_timer():void
        {
            if(_timer)return;
            if(!_animation)return;

            _animation.speed = determinateAnimationSpeed();
            if(!_animation.speed)return;

            _timer = new Timer(1000 / _animation.speed);
            _timer.addEventListener(TimerEvent.TIMER, changeAnimation);

        }

        private function remove_timer():void
        {
            if(!_timer)return;
            _timer.removeEventListener(TimerEvent.TIMER, changeAnimation);
            _timer.stop();
            _timer = null;
        }

        private function determinateAnimationSpeed():int
        {
            var speed:int = _animation.speed;
            if(!speed)speed = stage ? stage.frameRate : 0;
            return speed;
        }

        private function changeAnimation(e:TimerEvent):void
        {
            nextFrame();
        }

        // --- OVERRIDE PUBLIC FUNCTION ------------------------------------ //

        override public function gotoAndStop(frame:Object, scene:String = null):void
        {
            if(_animation && frame is int)_animation.gotoFrame(int(frame));
        }

        override public function gotoAndPlay(frame:Object, scene:String = null):void
        {

        }

        override public function play():void
        {
            if(_animation)_animation.gotoFrame(_animation.currentFrame);
            if(!_timer)make_timer();
            timer_start();

        }

        override public function stop():void
        {
            timer_stop();
        }

        override public function nextFrame():void
        {
            _animation.increaseFrameCount();
        }

        override public function prevFrame():void
        {

        }

        // --- PUBLIC FUNCTION ------------------------------------ //

        public function clear():void
        {

        }


    } //end class
} // end package
