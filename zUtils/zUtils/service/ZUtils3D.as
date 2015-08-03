package zUtils.service
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;

	/**
	 * Date: 30.11.12
	 * Time: 16:41
	 * @author zaidite
	 * @description
	 */
	public class ZUtils3D
	{
		// --- PRIVATE STATIC VAR ------------------------------------ //
		// --- PUBLIC STATIC VAR ------------------------------------- //
		// --- INTERNAL STATIC VAR ----------------------------------- //
		// --- PROTECTED STATIC VAR ---------------------------------- //
		// --- GET --------------------------------------------------- //
		// --- SET --------------------------------------------------- //
		// --- PUBLIC STATIC CONSTANT -------------------------------- //
		// --- PRIVATE STATIC CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function ZUtils3D() {}

		//***********************************************************


		// --- PRIVATE STATIC FUNCTION ------------------------------- //
		// --- PUBLIC STATIC FUNCTION -------------------------------- //
		/**
		 * Заливает прозрачность картинки белым цветом.
		 *
		 * @param target
		 * @return
		 */
		public static function makeDiffuseMap(target:DisplayObject):BitmapData
		{
			var map:BitmapData = new BitmapData(target.width, target.height, false, 0xFFFFFF);
			map.draw(target);
			return map;
		}

		/**
		 * Создаёт из картинки с прозрачностью - маску прозрачности.
		 * Прозрачные области заливаются чёрным цветом а изображение заливается белым цветом.
		 *
		 * @param target
		 * @return
		 */
		public static function makeOpacityMap(target:DisplayObject):BitmapData
		{
			var matrix:Array = [];
			matrix = matrix.concat([255, 255, 255, 255, 255]);// red
			matrix = matrix.concat([255, 255, 255, 255, 255]);// green
			matrix = matrix.concat([255, 255, 255, 255, 255]);// blue
			matrix = matrix.concat([0, 0, 0, 1, 0]);// alpha
			var whiteColor:ColorMatrixFilter = new ColorMatrixFilter(matrix);

			target.filters = [whiteColor];

			var map:BitmapData = new BitmapData(target.width, target.height, false, 0x000000);
			map.draw(target);
			target.filters = [];
			return map;
		}

		// --- INTERNAL STATIC FUNCTION ------------------------------ //
		// --- PROTECTED STATIC FUNCTION ----------------------------- //
		// --- OVERRIDE STATIC PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE STATIC PUBLIC FUNCTION ----------------------- //
		// --- OVERRIDE STATIC INTERNAL FUNCTION --------------------- //

	} //end class
}//end package