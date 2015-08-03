package zUtils.motionBehavior
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;

	/**
	 * Date: 08.10.12
	 * Time: 9:45
	 * @author zaidite
	 * @description
	 */
	public class MotionBehavior
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _behaviorDict : Dictionary = new Dictionary();
		private var _count : int = 0;


		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //
		// --- PRIVATE STATIC VAR ----------------------------- //
		private static var _instance:MotionBehavior;

		// --- PUBLIC STATIC CONSTANT ------------------------- //

		public static const ARRIVE : String = 'arrive';




		//*********************** CONSTRUCTOR ***********************
		public function MotionBehavior(secure:PrivateClass)
		{

		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //
		// --- PUBLIC FUNCTION -------------------------------- //

		public function makeArriveItem(target:DisplayObject=null) : Arrive
		{
			var id:String = ARRIVE + _count++;
			var item:Arrive = new Arrive(id, target);
			_behaviorDict[id] = item;
			return item;
		}

		private function removeBehaviorItem(target:BehaviorBase) : void
		{
			target.clearData();
			delete _behaviorDict[target.id];
		}

		// --- INTERNAL FUNCTION ------------------------------ //
		//- PUBLIC STATIC FUNCTION ---------------------------- //

		public static function manager():MotionBehavior
		{
			if(!_instance)
			{
				MotionBehavior._instance = new MotionBehavior(new PrivateClass());
			}
			return _instance;
		}


	} //end class
}//end package

class PrivateClass
{
	public function PrivateClass():void {}
}