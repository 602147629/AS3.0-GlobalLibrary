package zUtils.motionBehavior
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * Date: 08.10.12
	 * Time: 9:45
	 * @author zaidite
	 * @description
	 */
	public class BehaviorBase extends Sprite
	{
		// --- PRIVATE VAR ------------------------------------ //
		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		protected var _edgeBehavior:String = BOUNCE;
		protected var _mass:Number = 1.0;
		protected var _maxSpeed:Number = 10;
		protected var _position:Vector2D;
		protected var _velocity:Vector2D;
		protected var _target:DisplayObject;
		private var _id : String ;



		// --- GET -------------------------------------------- //

		public function get id():String {return _id;}

		public function get edgeBehavior():String {return _edgeBehavior;}

		public function get mass():Number {return _mass;}

		public function get maxSpeed():Number {return _maxSpeed;}

		public function get position():Vector2D {return _position;}

		public function get velocity():Vector2D {return _velocity;}

		// --- SET -------------------------------------------- //

		/**
		 * Сеттер/геттер максимальной скорости носителя.
		 */
		public function set maxSpeed(value:Number):void
		{_maxSpeed = value;}

		/**
		 * Сеттер/геттер для определения поведения носителя при столкновении с краем сцены.
		 */
		public function set edgeBehavior(value:String):void
		{_edgeBehavior = value;}

		/**
		 * Сеттер/геттер массы носителя.
		 */
		public function set mass(value:Number):void
		{_mass = value;}

		/**
		 * Сеттер/геттер позиции носителя (определяется как вектор Vector2D).
		 */
		public function set position(value:Vector2D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
		}

		/**
		 * Сеттер/геттер скорости носителя (определяется как вектор Vector2D).
		 */
		public function set velocity(value:Vector2D):void
		{_velocity = value;}

		/**
		 * Сеттер координаты у носителя. Overrides Sprite.y to set internal Vector2D position as well.
		 */
		override public function set y(value:Number):void
		{
			super.y = value;
			_position.y = y;
		}

		/**
		 * Сеттер координаты х носителя. Overrides Sprite.x to set internal Vector2D position as well.
		 */
		override public function set x(value:Number):void
		{
			super.x = value;
			_position.x = x;
		}

		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //
		// --- PUBLIC STATIC CONSTANT ------------------------- //

		public static const WRAP:String = "wrap";
		public static const BOUNCE:String = "bounce";


		//*********************** CONSTRUCTOR ***********************
		public function BehaviorBase(id:String, target:DisplayObject=null)
		{
			_id = id;
			_target = target;
			_position = new Vector2D();
			_velocity = new Vector2D();
			draw();
		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //

		/**
		 * Если носитель достигает края сцены,
		 * то отталкивается от него и возвращается на сцену
		 */
		private function bounce():void
		{
			if(stage != null)
			{
				if(position.x > stage.stageWidth)
				{
					position.x = stage.stageWidth;
					velocity.x *= -1;
				}
				else if(position.x < 0)
				{
					position.x = 0;
					velocity.x *= -1;
				}

				if(position.y > stage.stageHeight)
				{
					position.y = stage.stageHeight;
					velocity.y *= -1;
				}
				else if(position.y < 0)
				{
					position.y = 0;
					velocity.y *= -1;
				}
			}
		}

		/**
		 * Если носитель сталкивается с краем сцены, то появляется с противоположного края сцены.
		 */
		private function wrap():void
		{
			if(stage != null)
			{
				if(position.x > stage.stageWidth) position.x = 0;
				if(position.x < 0) position.x = stage.stageWidth;
				if(position.y > stage.stageHeight) position.y = 0;
				if(position.y < 0) position.y = stage.stageHeight;
			}
		}

		// --- PUBLIC FUNCTION -------------------------------- //

		/**
		 * Метод, который перемещает носитель. Может вызываться в каждом кадре или временном интервале.
		 */
		public function update():void
		{
			// убеждаемся, что скорость не больше максимально допустимой величины.
			_velocity.truncate(_maxSpeed);

			// добавляем скорость в позицию
			_position = _position.add(_velocity);

			// в зависимости от выбранного варианта поведения при столкновенни с краем
			// сцены, вызываем соответствующий метод
			if(_edgeBehavior == WRAP)
			{
				wrap();
			}
			else if(_edgeBehavior == BOUNCE)
			{
				bounce();
			}

			// обновляем позицию
			x = position.x;
			y = position.y;

			// поворачиваем носитель, чтобы он был ориентирован также, как и вектор скорости
			rotation = _velocity.angle * 180 / Math.PI;
		}

		public function clearData():void
		{

		}

		// --- INTERNAL FUNCTION ------------------------------ //
		// --- PROTECTED FUNCTION ----------------------------- //
		/**
		 * Изображение нашего носителя, может быть переопределено в подклассе
		 */
		protected function draw():void
		{
			if(_target)
			{
				addChild(_target);
			}
			else
			{
				graphics.clear();
				graphics.lineStyle(0);
				graphics.moveTo(10, 0);
				graphics.lineTo(-10, 5);
				graphics.lineTo(-10, -5);
				graphics.lineTo(10, 0);
			}
		}

		// --- OVERRIDE PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE PUBLIC FUNCTION ----------------------- //
		// --- OVERRIDE INTERNAL FUNCTION --------------------- //



	} //end class
}//end package