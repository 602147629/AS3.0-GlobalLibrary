/*


by zaidite 2011

*/

package zUtils.draw
{

	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	/**
	 *
	 * by zaidite 22.01.2011
	 */
    public class SpriteBitmapFill
	{
		//******************** CONSTRUCTOR *************************

		public function SpriteBitmapFill(){}

		//**********************************************************


		//- PUBLIC  FUNCTION ---------------------------------------

		/**
		 * Прямоугольник с графической заливкой
		 * @param bmd:BitmapData - объект BitmapData для заливки прямоугольника
		 * @param width:Number = 150 - ширина
		 * @param height:Number = 100 - высота
		 * @param mat:Matrix = null - объект матрицы который можно использовать для определения преобразований в растровом изображении
		 * @param repeat:Boolean = true - При значении true растровое изображение повторяется по шаблону мозаики.
		 * При значении false растровое изображение не повторяется, а его края используются для заливки всей области, выходящей за его пределы.
		 * @param smooth:Boolean = false - исрользовать ли сглаживание при повторении растрового изображения
		 * @param fillColor:uint = 0xCCCCCC - цвет заливки
		 * @param fillAlpha:Number = 1 - прозрачность заливки
	     * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
		 * @param xPosition:Number = 0 - позиция х
		 * @param yPosition:Number = 0 - позиция у
		 * @return :Sprite
		 *
		 */
		public function drawRectangle(bmd:BitmapData,
								  width:Number = 150,
								  height:Number = 100,
								  mat:Matrix = null,
								  repeat:Boolean = true,
								  smooth:Boolean = false,
								  fillColor:uint = 0xCCCCCC,
								  fillAlpha:Number = 1,
								  lineStile:Object = null,
								  xPosition:Number = 0,
								  yPosition:Number = 0):Sprite
		{
			var handler:Sprite = new Sprite();
			var rec:Shape = new Shape();
			var gr:Graphics = rec.graphics;
			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
			gr.beginBitmapFill(bmd, mat, repeat, smooth);
			gr.drawRect(xPosition, yPosition, width, height);
			gr.endFill();
			handler.addChild(rec);

			return handler;
		}

	}//end class
}//end package
