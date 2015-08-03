package zUtils.draw
{
    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Sprite;

    import zUtils.draw.ZDraw;

    /**
     * Date: 07.05.12
     * Time: 22:53
     * @author zaidite
     * @description
     */

    public class SpriteSimpleFill
    {

        //*********************** CONSTRUCTOR ***********************
        public function SpriteSimpleFill()
        {

        }

        //***********************************************************

        //- PUBLIC FUNCTION --------------------------------

        /**
         * Прямоугольник с однородной заливкой
         * @param width:Number = 150 - ширина
         * @param height:Number = 100 - высота
         * @param fillAlpha:Number = 1 - прозрачность заливки
         * @param fillColor:uint = 0xCCCCCC - цвет заливки
         * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
         * @param xPosition:Number = 0 - позиция х отрисованного шейпа
         * @param yPosition:Number = 0 - позиция у отрисованного шейпа
         * @return
                *
         */
        public function drawRectangle(width:Number = 150,
                                  height:Number = 100,
                                  fillColor:uint = 0x848482,
                                  fillAlpha:Number = 1,
                                  lineStile:Object = null,
                                  xPosition:Number = 0,
                                  yPosition:Number = 0) : Sprite
        {
            var handler:Sprite = new Sprite();
            var shape:Shape = new Shape();
            var gr:Graphics = shape.graphics;

            ZDraw.linesManager().makeDefaultLine(gr, lineStile);

            gr.beginFill(fillColor, fillAlpha);
            gr.drawRect(xPosition, yPosition, width, height);
            gr.endFill();
            handler.addChild(shape);

            return handler;
        }


        /**
      		 * Прямоугольник со скруглёнными краями с однородной заливкой
      		 * @param width:Number = 150 - ширина
      		 * @param height:Number = 100 - высота
      		 * @param ellipseWidth:Number = 100 - Ширина эллипса, используемая для отрисовки скругленных углов (в пикселах).
      		 * @param ellipseHeight:Number = 100 - Высота эллипса, используемая для отрисовки скругленных углов (в пикселах).
      		 * @param fillColor:uint = 0xCCCCCC - цвет заливки
      		 * @param fillAlpha:Number = 1 - прозрачность заливки
      		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
      		 * @param xPosition:Number = 0 - позиция х
      		 * @param yPosition:Number = 0 - позиция у
      		 * @return :Sprite
      		 *
      		 */
      		public function drawRoundRectangle(width:Number = 150,
      									   height:Number = 100,
      									   ellipseWidth:Number = 10,
      									   ellipseHeight:Number = 10,
      									   fillColor:uint = 0x848482,
      									   fillAlpha:Number = 1,
      									   lineStile:Object = null,
      									   xPosition:Number = 0,
      									   yPosition:Number = 0) : Sprite
      		{
      			var handler:Sprite = new Sprite();
      			var shape:Shape = new Shape();
      			var gr:Graphics = shape.graphics;

      			ZDraw.linesManager().makeDefaultLine(gr, lineStile);

      			gr.beginFill(fillColor, fillAlpha);
      			gr.drawRoundRect(xPosition, yPosition, width, height, ellipseWidth, ellipseHeight);
      			gr.endFill();
      			handler.addChild(shape);

      			return handler;
      		}




      		/**
      		 * Круг с однородной заливкой
      		 * @param radius:Number = 50 - диаметр
      		 * @param fillColor:uint = 0xCCCCCC - цвет заливки
      		 * @param fillAlpha:Number = 1 - прозрачность заливки
      		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
      		 * @param xPosition:Number = 0 - позиция х
      		 * @param yPosition:Number = 0 - позиция у
      		 * @return :Sprite
      		 *
      		 */
      		public function drawCircle(radius:Number = 50,
      							   fillColor:uint = 0x848482,
      							   fillAlpha:Number = 1,
      							   lineStile:Object = null,
      							   xPosition:Number = 0,
      							   yPosition:Number = 0) : Sprite
      		{
      			var handler:Sprite = new Sprite();
      			var shape:Shape = new Shape();
      			var gr:Graphics = shape.graphics;
      			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
      			gr.beginFill(fillColor, fillAlpha);
      			gr.drawCircle(xPosition, yPosition, radius);
      			gr.endFill();
      			handler.addChild(shape);

      			return handler;
      		}

      		/**
      		 * Элипс с однородной заливкой
      		 * @param width:Number = 150 - ширина
      		 * @param height:Number = 100 - высота
      		 * @param fillColor:uint = 0xCCCCCC - цвет заливки
      		 * @param fillAlpha:Number = 1 - прозрачность заливки
      		 * @param lineStile:Object = null - объект с параметами линии обводки : ZDraw.linesManager().lineStileDefault
      		 * @param xPosition:Number = 0 - позиция х
      		 * @param yPosition:Number = 0 - позиция у
      		 * @return :Sprite
      		 *
      		 */
      		public function drawEllipse(width:Number = 150,
      								height:Number = 100,
      								fillColor:uint = 0x848482,
      								fillAlpha:Number = 1,
      								lineStile:Object = null,
      								xPosition:Number = 0,
      								yPosition:Number = 0) : Sprite
      		{
      			var handler:Sprite = new Sprite();
      			var shape:Shape = new Shape();
      			var gr:Graphics = shape.graphics;
      			ZDraw.linesManager().makeDefaultLine(gr, lineStile);
      			gr.beginFill(fillColor, fillAlpha);
      			gr.drawEllipse(xPosition, yPosition, width, height);
      			gr.endFill();
      			handler.addChild(shape);

      			return handler;
      		}



    } //end class
} // end package
