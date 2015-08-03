/*


by zaidite 2011

*/

package zUtils.draw
{

	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;

	/**
	 *
	 * by zaidite 19.01.2011
	 */
    public class MovieClipGradientFill
	{


		//******************** CONSTRUCTOR *************************

		public function MovieClipGradientFill(){}

		//**********************************************************

		//- PUBLIC  FUNCTION ---------------------------------------

		/**
		 * Прямоугольник с градиентной заливкой
		 * @param width:Number = 150 - ширина
		 * @param height:Number = 100 - высота
		 * @param grad:Object = null - объект с данными для линейной заливки фигуры
		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
		 * @param xPosition:Number = 0 - позиция х
		 * @param yPosition:Number = 0 - позиция у
		 * @return :MovieClip
		 *
		 */
		public function drawRectangle(width:Number = 150,
								  height:Number = 100,
								  gradient:Object = null,
								  lineStile:Object = null,
								  xPosition:Number = 0,
								  yPosition:Number = 0):MovieClip
		{
			var handler:MovieClip = new MovieClip();
			var shape:Shape = new Shape();
			var gr:Graphics = shape.graphics;
			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
			ZDraw.gradientsManager().setGradient(gr, gradient);
			gr.drawRect(xPosition, yPosition, width, height);
			gr.endFill();
			handler.addChild(shape);

			return handler;
		}


		/**
		 * Прямоугольник с закруглёнными углами и с градиентной заливкой
		 * @param width:Number = 150 - ширина
		 * @param height:Number = 100 - высота
		 * @param ellipsewidthidth:Number = 100 - Ширина эллипса, используемая для отрисовки скругленных углов (в пикселах).
		 * @param ellipseheighteight:Number = 100 - Высота эллипса, используемая для отрисовки скругленных углов (в пикселах).
		 * @param grad:Object = null - объект с данными для линейной заливки фигуры
		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
		 * @param xPosition:Number = 0 - позиция х
		 * @param yPosition:Number = 0 - позиция у
		 * @return :MovieClip
		 *
		 *
		 */
		public function drawRoundRectangle(width:Number = 150,
									   height:Number = 100,
									   ellipsewidthidth:Number = 10,
									   ellipseheighteight:Number = 10,
									   gradient:Object = null,
									   lineStile:Object = null,
									   xPosition:Number = 0,
									   yPosition:Number = 0):MovieClip
		{
			var handler:MovieClip = new MovieClip();
			var shape:Shape = new Shape();
			var gr:Graphics = shape.graphics;
			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
			ZDraw.gradientsManager().setGradient(gr, gradient);
			gr.drawRoundRect(xPosition, yPosition, width, height, ellipsewidthidth, ellipseheighteight);
			gr.endFill();
			handler.addChild(shape);

			return handler;
		}


		/**
		 * Круг с однородной заливкой
		 * @param R:Number = 50 - диаметр
		 * @param grad:Object = null - объект с данными для линейной заливки фигуры
		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
		 * @param xPosition:Number = 0 - позиция х
		 * @param yPosition:Number = 0 - позиция у
		 * @return :MovieClip
		 *
		 */
		public function drawCircle(R:Number = 50,
							   gradient:Object = null,
							   lineStile:Object = null,
							   xPosition:Number = 0,
							   yPosition:Number = 0) : MovieClip
		{
			var handler:MovieClip = new MovieClip();
			var shape:Shape = new Shape();
			var gr:Graphics = shape.graphics;
			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
			ZDraw.gradientsManager().setGradient(gr, gradient);
			gr.drawCircle(xPosition, yPosition, R);
			gr.endFill();
			handler.addChild(shape);

			return handler;
		}

		/**
		 * Элипс с однородной заливкой
		 * @param width:Number = 150 - ширина
		 * @param height:Number = 100 - высота
		 * @param grad:Object = null - объект с данными для линейной заливки фигуры
		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
		 * @param xPosition:Number = 0 - позиция х
		 * @param yPosition:Number = 0 - позиция у
		 * @return :MovieClip
		 *
		 */
		public function drawEllipse(width:Number = 150,
								height:Number = 100,
								gradient:Object = null,
								lineStile:Object = null,
								xPosition:Number = 0,
								yPosition:Number = 0) : MovieClip
		{
			var handler:MovieClip = new MovieClip();
			var shape:Shape = new Shape();
			var gr:Graphics = shape.graphics;
			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
			ZDraw.gradientsManager().setGradient(gr, gradient);
			gr.drawEllipse(xPosition, yPosition, width, height);
			gr.endFill();
			handler.addChild(shape);

			return handler;
		}


	}//end class
}//end package
