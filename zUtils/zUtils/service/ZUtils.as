/*
 Абстрактынй Класс служебных методов.
 by zaidite
 */


package zUtils.service
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.LocalConnection;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;

	public class ZUtils extends Sprite
	{


		//******************** CONSTRUCTOR ***********************
		public function ZUtils()
		{

		}


		/**
		 * Draw target to bitmap with scaling and rotation
		 * @param target
		 * @param scX
		 * @param scY
		 * @param rot
		 * @return
		 *
		 */
		public static function targetToBitmap(target:DisplayObject, scX:Number = 1, scY:Number = 1, rot:Number = 0):Bitmap
		{
			var targetBm:Bitmap;

			if(target && scX > 0 && scY > 0)
			{
				var border:uint = 2;
				var savedMatrix:Matrix = target.transform.matrix;
				var savedParent:DisplayObjectContainer = target.parent;

				var holderTarget:Sprite = new Sprite();
				holderTarget.addChild(target);

				var boundsTarget:Rectangle = target.getBounds(target);

				var mat:Matrix = new Matrix();
				mat.createBox(scX, scY, rot * Math.PI / 180, -boundsTarget.x, -boundsTarget.y);
				target.transform.matrix = mat;

				var boundsAfterTransform:Rectangle = target.getBounds(holderTarget);

				mat.translate(-boundsAfterTransform.x, -boundsAfterTransform.y);
				target.transform.matrix = mat;

				var allBmd:BitmapData = new BitmapData(boundsAfterTransform.width + border, boundsAfterTransform.height + border, true, 0x55CC55);
				allBmd.draw(target, mat, null, null, null, true);

				var notAlphaAreaRect:Rectangle = allBmd.getColorBoundsRect(0xFF000000, 0x00000000, false);

				var notAlphaAreaBmd:BitmapData = new BitmapData(notAlphaAreaRect.width, notAlphaAreaRect.height, true, 0x55cc55);
				notAlphaAreaBmd.copyPixels(allBmd, notAlphaAreaRect, new Point(0, 0));

				targetBm = new Bitmap(notAlphaAreaBmd);
				targetBm.smoothing = true;

				target.transform.matrix = savedMatrix;
				savedParent ? savedParent.addChild(target) : holderTarget.removeChild(target);
				holderTarget = null;
				allBmd.dispose();
				allBmd = null;
			}

			return targetBm;
		}

		/**
		 * Merges elements of all transfered arrays in one general array
		 * @param arrWithArr - array witn many arrays
		 * @return
		 *
		 */
		public static function mergeArrays(arrWithArr:Array):Array
		{
			var mixed:Array;

			var len:uint = arrWithArr.length
			for(var i:int = 0; i < len; i++)
			{
				if(arrWithArr[i])
				{
					if(!mixed)mixed = [];
					mixed = mixed.concat(arrWithArr[i]);
				}
			}

			return mixed;
		}


		/**
		 * Трейсит дерево ХМЛ
		 * @param xml
		 *
		 */
		public static function recursionXML(xml:XML):void
		{
			for each (var child:XML in xml.*)
			{
				var name:String = child.name();
				var parentName:String = child.parent().name();
				trace("name", name, "parentName", parentName);
				recursionXML(child);
			}
		}


		/**
		 * Удаляет все объекты в переданном контейнере
		 * @param handler
		 *
		 */
		public static function clearTarget(handler:DisplayObjectContainer):void
		{
			if(!handler)return;
			while(handler.numChildren)
			{
				var child:DisplayObject = handler.getChildAt(0);

				if(child as Bitmap)
				{
					(child as Bitmap).bitmapData.dispose();
					if(child.parent)child.parent.removeChild(child);
					child = null;
				}

				if(child is DisplayObjectContainer)
				{
					clearTarget(child as DisplayObjectContainer);
				}
				if(child as DisplayObject)
				{
					if(child.parent)child.parent.removeChild(child);
					child = null;
				}
			}
		}


		/**
		 * Определяет имя метода из которого вызываетсся данный метод
		 * @return
		 *
		 */
		public static function getFunctionPath():String
		{
			return (new Error().getStackTrace().match(/at [^)]+\)/g)[1] as String).substr(3);
		}


		/**
		 * Формируем падеж слова в зависимости от числительного, с которым слово использется
		 * @param wordBase - основа слова /дру/
		 * @param val - числительное
		 * @param case_0 - окончание слова в для иметнительного падежа /г/
		 * @param case_2_4 - окончание слова для родительного падежа /га/
		 * @param case_0_5_10 - родительного падежа во множественном числе /зей/
		 * @return String
		 *
		 */
		public static function makeWorld(wordBase:String, val:Number, case_0:String = '', case_2_4:String = '', case_0_5_10:String = ''):String
		{
			var word:String = wordBase;
			var lastNum:int;

			if(val >= 11 && val <= 20)
			{
				word = wordBase + case_0_5_10;
			}
			else
			{
				var strVal:String = val.toString();
				lastNum = int(strVal.substr(strVal.length - 1));

				if(lastNum == 1)word = wordBase + case_0;
				if(lastNum >= 2 && lastNum <= 4)word = wordBase + case_2_4;
				if(lastNum >= 5 && lastNum <= 10)word = wordBase + case_0_5_10;
			}

			if(val == 0 || lastNum == 0)word = wordBase + case_0_5_10;
			return word;
		}


		/**
		 * Перемешиваем массив
		 * @param dataArr:Array
		 * @return:Array
		 *
		 */
		public static function shuffle(dataArr:Array):Array
		{
			var arr:Array = dataArr.slice();
			var newArr:Array = [];
			var len:int = arr.length;
			for(var i:int = 0; i < len; i++)
			{
				var randInd:int = Math.random() * arr.length - 1;
				var element:Array = arr.splice(randInd, 1);
				var obj:* = element[0];
				newArr.push(obj);
			}
			return newArr;
		}


		/**
		 * Из объекта с данными формируем массив
		 * @param data
		 * @return
		 *
		 */
		public static function fromObjectToArray(data:Object):Array
		{
			var clonData:Object = clone(data);
			var newArr:Array = [];

			for(var prop:String in clonData)newArr.push(clonData[prop]);

			return newArr;
		}

		/**
		 * Из массива данных формируем объект данных
		 * @param data
		 * @return
		 *
		 */
		public static function fromArrayToObject(data:Array):Object
		{
			if(data)
			{
				var clonData:Array = data.slice();
				var newData:Object = {};


				for(var prop:String in clonData)
				{
					if(clonData[prop])
					{
						newData[prop] = clonData[prop]
					}
				}
			}

			return newData;
		}


		// ---------------------------------------- Случайное значение цвета
		/**
		 * Случайное значение цвета
		 * @return:uint
		 *
		 */
		public static function randColor():uint
		{
			return Math.random() * 0x1000000;
		}

		//------------------------------------- Выбор случайного значения из заданного диапазона
		/**
		 * Выбор случайного значения из заданного диапазона
		 * @param min:Number
		 * @param max:Number
		 * @return Number
		 *
		 */
		public static function randRange(min:Number, max:Number):Number
		{
			return Math.floor(Math.random() * (max - min)) + min;
			;
		}

		//----------------------------- Клонируем объект
		/**Клонируем объект
		 *
		 * @param targetObj:Object
		 * @return Object
		 *
		 */
		public static function clone(source:Object):Object
		{
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position = 0;
			return(copier.readObject());
		}

		/**
		 * Соединяем дынные из двух объектов в один
		 * @param data1
		 * @param data2
		 * @return
		 *
		 */
		public static function joinData(data1:Object, data2:Object):Object
		{
			var targetObj:Object = {};
			for(var prop1:String in data1)targetObj[prop1] = data1[prop1];
			for(var prop2:String in data2)targetObj[prop2] = data2[prop2];
			return targetObj;
		}


		/**Клонируем ассоциативный массив
		 *
		 * @param targetArr:Array
		 * @return Array
		 *
		 */
		public static function cloneArray(targetArr:Array):Array
		{
			var myArr:Array = [];
			for(var prop:String in targetArr)
			{
				myArr[prop] = targetArr[prop];
			}
			return myArr;
		}


		//------------------------------- Перезагрузка штмл-страницы, содержащей флешку
		/**
		 * Перезагрузка штмл-страницы, содержащей флешку
		 *
		 */
		public static function reload():void
		{
			ExternalInterface.call("window.location.reload");
		}

		//--------------------------------- позволяет вызвать принудительную итерацию GC

		/**
		 * позволяет вызвать принудительную итерацию GC
		 *
		 */
		public static function startGC():void
		{ //HACK - позволяет вызвать принудительную итерацию GC
			try
			{
				new LocalConnection().connect('Crio');
				new LocalConnection().connect('Crio');
			} catch(e:*)
			{
			}
		}

		/**
		 * Возвращаем время и дату из полученных секунд в виде - 14:38 2.10.2010.
		 * @param secund
		 * @return :String
		 *
		 */
		public static function timeAndDate(seconds:int):String
		{
			var time:Number = seconds * 1000;
			var date:Date = new Date(time);
			var td:String = date.hours + ':' + date.minutes + ' ' + date.day + '.' + date.month + '.' + date.fullYear;
			return td;
		}


		/**
		 * Возвращаем часы и минуты из минут
		 * @param m:int - минуты
		 * @return String
		 *
		 */
		public static function hourFromMin(m:int):String
		{
			if(m == 0) return "00 ч. 00 мин.";
			var strArr:Array = [];
			var h:int = (m / 60);
			if(h > 0)
			{
				m = m - (60 * h);
				strArr.push((h > 9 ? h : ('0' + h)) + " ч.");
			}
			else
			{
				strArr.push('00 ч.');
			}


			if(m > 0)strArr.push((m > 9 ? m : ('0' + m)) + " мин.");
			else strArr.push('00 мин.');

			return strArr.join(" ");
		}

		/**
		 * Возвращаем дни, часы и минуты из минут
		 * @param m:int - минуты
		 * @return String
		 *
		 */
		public static function dayHourFromMin(m:int):String
		{
			if(m == 0) return "00 ч. 00 мин.";
			var strArr:Array = [];
			var d:int = ((m / 60) / 24);
			if(d > 0)
			{
				m = m - ((24 * d) * 60);
				strArr.push((d > 9 ? d : ('0' + d)) + "д. ");
			}

			var h:int = (m / 60);
			if(h > 0)
			{
				m = m - (60 * h);
				strArr.push((h > 9 ? h : ('0' + h)) + "ч. ");
			}
			else
			{
				//strArr.push('00 ч.');
			}

			if(m > 0)strArr.push((m > 9 ? m : ('0' + m)) + "м.");
			return strArr.join("");
		}



		/**
		 * Помещаем битмап в указанный контейнер. Если битмап больше контейнера, он пропорционально уменьшается.
		 * @param pic:Bitmap - картинка
		 * @param handler:DisplayObjectContainer - контейнер
		 *
		 */
		public static function addScalePic(pic:Bitmap, handler:DisplayObjectContainer):void
		{
			if(handler.width < pic.width || handler.height < pic.height)
			{

				var sc:Number = Math.min(handler.width / pic.width, handler.height / pic.height);
				var mat:Matrix = new Matrix();
				mat.a = mat.d = sc;
				var scaledBmd:BitmapData = new BitmapData(pic.width * sc, pic.height * sc, true, 0);
				scaledBmd.draw(pic, mat);
				pic = new Bitmap(scaledBmd);
			}

			pic.x = (handler.width - pic.width) / 2;
			pic.y = (handler.height - pic.height) / 2;

			handler.addChild(pic);
		}

		/**
		 * ПРопорционально уменьшает картинку, для помещения в указанный контейнер
		 * @param pic:Bitmap - картинка
		 * @param handler:DisplayObjectContainer - контейнер
		 * @return scaledPic:Bitmap - отскейлиная картинка
		 * */
		public static function scalePic(pic:DisplayObject, handler:DisplayObjectContainer):DisplayObject
		{

			var scaledPic:DisplayObject = pic;

			if(handler.width < pic.width || handler.height < pic.height)
			{

				var sc:Number = Math.min(handler.width / pic.width, handler.height / pic.height);
				var mat:Matrix = new Matrix();
				mat.a = mat.d = sc;
				var scaledBmd:BitmapData = new BitmapData(pic.width * sc, pic.height * sc, true, 0);			//Создаём новый битмап
				scaledBmd.draw(pic, mat);
				scaledPic = new Bitmap(scaledBmd);							//Новый битмап из перерисованой фотки
			}

			return scaledPic;

			//handler.addChild(pic);
			//pic.x=(handler.width-pic.width)/2;
			//pic.y=(handler.height-pic.height)/2;
		}

		public static function radiansToDegrees(radians:Number):Number
		{
			return radians * 180 / Math.PI;
		}

		public static function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}

	}//end class
}//end package