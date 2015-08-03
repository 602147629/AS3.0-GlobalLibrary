package zUtils.drag
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * Date: 05.10.12
	 * Time: 11:33
	 * @author zaidite
	 * @description
	 */
	public class ElasticDrag
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _target:Sprite;
		private var _stage:Stage;
		private var _dragging:Boolean;

		//Скорости по х и у
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;

		//общая скорость
		private var _speed:Number = 10;
		private var _startDragPos:Point;


		//Переменная упругости (насколько сильный эффект упругости)
		private var _springFactor:Number = 0.2;

		//Трение для анимации
		private var _friction:Number = 0.9;

		//Ускорение для скоростей по x и y
		private var _accX:Number = 0;
		private var _accY:Number = 0;
		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function ElasticDrag(target:Sprite)
		{
			_target = target;
			if(_target.stage)startInteractive();
			else _target.addEventListener(Event.ADDED_TO_STAGE, startInteractive);
		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //

		private function mUp(event:MouseEvent):void
		{
			_dragging = false;
		}

		private function mDown(event:MouseEvent):void
		{
			_startDragPos = new Point(_target.mouseX, _target.mouseY);
			_dragging = true;
		}

		private function move(event:Event):void
		{
			if(!_dragging)return;

			//Вычислим расстояния по x и y от шара до мыши
			var distX:Number = _stage.mouseX - (_target.x + _startDragPos.x);
						var distY:Number = _stage.mouseY - (_target.y + _startDragPos.y);

			//Изменяем ускорения x и y
			_accX = distX * _springFactor;
			_accY = distY * _springFactor;

			//Добавим ускорение к скорости
			_speedX += _accX;
			_speedY += _accY;

			//Добавляем трение, иначе анимация
			//будет продолжаться вечно.
			_speedX *= _friction;
			_speedY *= _friction;

			//Двигаем шар на новые координаты (ближе к мыши)
			_target.x += _speedX;
			_target.y += _speedY;


		}

		private function startInteractive(event:Event = null):void
		{
			_stage = _target.stage;
			_target.addEventListener(Event.REMOVED_FROM_STAGE, clearData);
			_target.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
			_stage.addEventListener(Event.ENTER_FRAME, move);
		}

		private function stopInteractive(event:Event = null):void
		{
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, mDown);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, mUp);
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, clearData);
			_stage.removeEventListener(Event.ENTER_FRAME, move);
		}

		// --- PUBLIC FUNCTION -------------------------------- //
		public function clearData(event:Event = null):void
		{
			_target.stopDrag();
			stopInteractive();
			_target = null;
			_stage = null;
		}

		// --- INTERNAL FUNCTION ------------------------------ //
		// --- PROTECTED FUNCTION ----------------------------- //
		// --- OVERRIDE PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE PUBLIC FUNCTION ----------------------- //
		// --- OVERRIDE INTERNAL FUNCTION --------------------- //

	} //end class
}//end package