package zUtils.drag
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Date: 05.10.12
	 * Time: 10:57
	 * @author zaidite
	 * @description
	 */
	public class SimpleDrag
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _target:Sprite;
		private var _stage : Stage ;


		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function SimpleDrag(target:Sprite)
		{
			_target = target;
			if(_target.stage)startInteractive();
			else _target.addEventListener(Event.ADDED_TO_STAGE, startInteractive);
		}


		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //

		private function mUp(event:MouseEvent):void
		{
			_target.stopDrag();
		}

		private function mDown(event:MouseEvent):void
		{
			_target.startDrag();
		}

		private function startInteractive(event:Event = null):void
		{
			_stage = _target.stage;
			_target.addEventListener(Event.REMOVED_FROM_STAGE, clearData);
			_target.addEventListener(MouseEvent.MOUSE_DOWN, mDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mUp);
		}

		private function stopInteractive(event:Event = null):void
		{
			_target.removeEventListener(MouseEvent.MOUSE_DOWN, mDown);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, mUp);
			_target.removeEventListener(Event.REMOVED_FROM_STAGE, clearData);
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