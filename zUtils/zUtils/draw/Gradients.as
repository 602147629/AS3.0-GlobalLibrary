package zUtils.draw
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;

	/**
	 * Zaidite 14.01.2012
	 */
	public class Gradients
	{

		//*********************** CONSTRUCTOR **********************

		public function Gradients(){}

		//**********************************************************



		/**
		 * Матрица трансформации градиентной заливки
		 * @param H:Number = 100 - ширина
		 * @param W:Number = 100 - высота
		 * @param rotationInRad:Number = 0 - поворот в радианах
		 * @param shiftX:Number = 0 - сдвиг по Х
		 * @param shiftY:Number = 0 - сдвиг по Y
		 * @return
		 *
		 */
		public function gradientMatrixDefault(H:Number=100, W:Number=100, rotationInRad:Number=0, shiftX:Number=0, shiftY:Number=0) : Matrix
		{
			var matr:Matrix = new Matrix();
			matr.createGradientBox(H, W, rotationInRad, shiftX, shiftY);
			return matr ;
		}


		/**
		 * Объект с настройками градиента для заливки фигуры
		 * @param illType:String = GradientType.LINEAR - тип заливки
		 * @param colors:Array = [ZDraw.colorsManager().BLUE, ZDraw.colorsManager().YELLOW] - цвета заливки
		 * @param alphas:Array = [1, 1] - прозрачность цветов заливки
		 * @param ratios:Array = [0, 200] - перетекание заливки на границах цветов
		 * @param matrix:Matrix = ZDraw.GRADIENTS.gradientMatrixDefault() - матрица трансформации заливки
		 * @param spreadMethod:String = SpreadMethod.PAD - метод заливки
		 * @return
		 *
		 */
		public function gradientDefault(colors:Array=null,
										alphas:Array=null,
										ratios:Array = null,
										matrix:Matrix = null,
										fillType:String = GradientType.LINEAR,
										spreadMethod:String = SpreadMethod.PAD) : Object

		{
			if(!colors)colors = [ZDraw.colorsManager().YELLOW, ZDraw.colorsManager().LIGHT_BROWN];
			if(!alphas)alphas = [1, 1];
			if(!ratios)ratios = [0, 255];
			if(!matrix)matrix = ZDraw.gradientsManager().gradientMatrixDefault()

			return {fillType:fillType, colors:colors, alphas:alphas, ratios:ratios, matrix:matrix, spreadMethod:spreadMethod};
		}

		/**
		 * Устанавливает настройки градиента в объекте Graphics. Если объект grad не передаётся, то создаются настройки градиента по умолчанию
		 * @param graphics
		 *
		 */
		public function setGradient(graphics:Graphics, grad:Object=null) : void
		{
			if(!grad)grad = gradientDefault();
			graphics.beginGradientFill(grad['fillType'], grad['colors'], grad['alphas'], grad['ratios'], grad['matrix'], grad['spreadMethod']);
		}


	} //end class
} // end package