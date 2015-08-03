package zUtils.drag
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * Date: 05.10.12
	 * Time: 11:20
	 * @author zaidite
	 * @description
	 */
	public class CatchingDrag
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _target:Sprite;
		private var _stage:Stage;
		private var _dragging:Boolean;
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _speed:Number = 10;
		private var _startDragPos : Point ;

		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function CatchingDrag(target:Sprite)
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

			var distX:Number = _stage.mouseX - (_target.x + _startDragPos.x);
			var distY:Number = _stage.mouseY - (_target.y + _startDragPos.y);
			var dist:Number = Math.sqrt(distX * distX + distY * distY);

			if(dist > 5)
			{
				var angle:Number = Math.atan2(distY, distX);

				_speedX = Math.cos(angle) * _speed;
				_speedY = Math.sin(angle) * _speed;

				_target.x += _speedX;
				_target.y += _speedY;
			}

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