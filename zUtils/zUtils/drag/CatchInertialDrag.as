package zUtils.drag
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * Date: 05.10.12
	 * Time: 11:59
	 * @author zaidite
	 * @description
	 */
	public class CatchInertialDrag
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _target:Sprite;
		private var _stage:Stage;
		private var _inertial:Number = 20;

		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function CatchInertialDrag(target:Sprite)
		{
			_target = target;
			if(_target.stage)startInteractive();
			else _target.addEventListener(Event.ADDED_TO_STAGE, startInteractive);
		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //


		private function startInteractive(event:Event = null):void
		{
			_stage = _target.stage;
			_stage.addEventListener(Event.ENTER_FRAME, move);

		}

		private function stopInteractive(event:Event = null):void
		{
			_stage.removeEventListener(Event.ENTER_FRAME, move);
		}

		// --- PUBLIC FUNCTION -------------------------------- //
		public function clearData(event:Event = null):void
		{
			stopInteractive();
			_target = null;
			_stage = null;
		}


		private function move(event:Event):void
		{
			_target.x -= (_target.x - _stage.mouseX) / _inertial;
			_target.y -= (_target.y - _stage.mouseY) / _inertial;
		}

		// --- PUBLIC FUNCTION -------------------------------- //
		// --- INTERNAL FUNCTION ------------------------------ //
		// --- PROTECTED FUNCTION ----------------------------- //
		// --- OVERRIDE PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE PUBLIC FUNCTION ----------------------- //
		// --- OVERRIDE INTERNAL FUNCTION --------------------- //

	} //end class
}//end package