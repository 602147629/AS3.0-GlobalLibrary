package zUtils.service
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Date: 24.10.12
	 * Time: 9:55
	 * @author zaidite
	 * @description
	 */
	public class Arrange
	{
		// --- PRIVATE VAR ------------------------------------ //
		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function Arrange()
		{
			initData();
		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //

		private function initData():void
		{

		}

		// --- PUBLIC FUNCTION -------------------------------- //

		public function clearData():void {}

		// --- INTERNAL FUNCTION ------------------------------ //
		// --- PROTECTED FUNCTION ----------------------------- //
		// --- OVERRIDE PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE PUBLIC FUNCTION ----------------------- //
		// --- OVERRIDE INTERNAL FUNCTION --------------------- //

		/**
		 * Распределяем переданные прямоугольные области в указанном контейнере. Распределение начинается со строк.
		 * @param area - область для распределения
		 * @param targets - вектор с прямоугольниками для размещения
		 * @param distanceBetweenColumns дистанция между колонками : 10
		 * @param distanceBetweenRows - дистанция между строками : 10
		 * @return возвращает вектор с поместившимися в указанную область прямоугольниками
		 */
		public static function columnsAndRows(area:Rectangle, targets:Vector.<Rectangle>, distanceBetweenColumns:Number = 10, distanceBetweenRows:Number = 10):Vector.<Rectangle>
		{
			if(!area || !area.width || !area.height)throw new Error('Arrange.toColumnsAndRows :: Not the correct area!!!');
			if(!targets || !targets.length)throw new Error(!'Arrange.toColumnsAndRows :: Not the correct targets data!!!')

			var target:Rectangle;
			var arrangeTargets:Vector.<Rectangle> = new Vector.<Rectangle>();
			var count:int = 0;
			var tempX:Number;
			var tempY:Number;
			var len:int = targets.length;

			for(var i:int = 0; i < len; i++)
			{
				for(var j:int = 0; j < len; j++)
				{
					if(count < targets.length)
					{
						target = targets[count];
						tempX = (target.x + target.width + distanceBetweenColumns) * j;
						tempY = (target.y + target.height + distanceBetweenRows) * i;

						if(tempX + target.width <= area.width && tempY + target.height <= area.height)
						{
							target.x = tempX;
							target.y = tempY;
							arrangeTargets.push(new Rectangle(target.x, target.y, target.width, target.height));
							count++;
						}
						else
						{
							continue;
						}
					}
				}
			}
			return arrangeTargets;
		}

		/**
		 * Выстраивает прямоугольники столбиком в центре области
		 * @param area- область для распределения
		 * @param targets - вектор с прямоугольниками для размещения
		 * @param distanceBetweenRows - дистанция между строками : 10
		 * @return возвращает вектор с поместившимися в указанную область прямоугольниками
		 */
		public static function oneColumnOnCenter(area:Rectangle, targets:Vector.<Rectangle>, distanceBetweenRows:Number = 10):Vector.<Rectangle>
		{
			if(!area || !area.width || !area.height)throw new Error('Arrange.toColumnsAndRows :: Not the correct area!!!');
			if(!targets || !targets.length)throw new Error(!'Arrange.toColumnsAndRows :: Not the correct targets data!!!')

			var target:Rectangle;
			var arrangeTargets:Vector.<Rectangle> = new Vector.<Rectangle>();
			var count:int = 0;
			var tempX:Number;
			var tempY:Number;
			var len:int = targets.length;

			for(var i:int = 0; i < len; i++)
			{
				for(var j:int = 0; j < len; j++)
				{
					if(count < targets.length)
					{
						target = targets[count];
						tempX = (area.width - target.width) / 2;
						tempY = (target.y + target.height + distanceBetweenRows) * j;

						if(tempX + target.width <= area.width && tempY + target.height <= area.height)
						{
							target.x = tempX;
							target.y = tempY;
							arrangeTargets.push(new Rectangle(target.x, target.y, target.width, target.height));
							count++;
						}
						else
						{
							continue;
						}
					}
				}
			}
			return arrangeTargets;
		}


		/**
		 * Располагает уазанный прямоугольник в центер области
		 * @param holder - область
		 * @param target - прямоугольник
		 * @param locCenter - центрирован ли прямоугольник по центру или в верхнем левом углу
		 * @return
		 */
		public static function onCenterHolder(holder:Rectangle, target:Rectangle, locCenter:Boolean = false):Rectangle
		{
			if(locCenter)
			{
				target.x = holder.width / 2;
				target.y = holder.height / 2;
			}
			else
			{
				target.x = (holder.width - target.width) / 2;
				target.y = (holder.height - target.height) / 2;
			}
			return target;

		}


	} //end class
}//end package