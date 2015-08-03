package zUtils.drag
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	import zUtils.drag.CatchingDrag;

	/**
	 * Date: 05.10.12
	 * Time: 10:52
	 * @author zaidite
	 * @description
	 */
	public class Drag
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _simpleDrag:SimpleDrag;
		private var _catchingDrag:CatchingDrag;
		private var _elasticDrag:ElasticDrag;
		private var _catchInertialDrag : CatchInertialDrag ;




		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- GET -------------------------------------------- //
		// --- SET -------------------------------------------- //
		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //
		// --- PRIVATE STATIC VAR ----------------------------- //
		private static var _instance:Drag;


		//*********************** CONSTRUCTOR ***********************
		public function Drag(secure:PrivateClass)
		{

		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //
		// --- PUBLIC FUNCTION -------------------------------- //

		public function startCatchInertialDrag(target:Sprite) : void
		{
			if(_catchInertialDrag)
			{
				_catchInertialDrag.clearData();
				_catchInertialDrag = null;
			}

			_catchInertialDrag = new CatchInertialDrag(target);
		}

		public function startElasticDrag(target:Sprite):void
		{
			if(_elasticDrag)
			{
				_elasticDrag.clearData();
				_elasticDrag = null;
			}
			_elasticDrag = new ElasticDrag(target);
		}


		public function startCatchingDrag(target:Sprite):void
		{
			if(_catchingDrag)
			{
				_catchingDrag.clearData();
				_catchingDrag = null;
			}
			_catchingDrag = new CatchingDrag(target);
		}


		public function startSimpleDrag(target:Sprite):void
		{
			if(_simpleDrag)
			{
				_simpleDrag.clearData();
				_simpleDrag = null;
			}
			_simpleDrag = new SimpleDrag(target);

		}


		// --- INTERNAL FUNCTION ------------------------------ //
		//- PUBLIC STATIC FUNCTION ---------------------------- //

		public static function manager():Drag
		{
			if(!_instance)
			{
				Drag._instance = new Drag(new PrivateClass());
			}
			return _instance;
		}


	} //end class
}//end package

class PrivateClass
{
	public function PrivateClass():void {}
}