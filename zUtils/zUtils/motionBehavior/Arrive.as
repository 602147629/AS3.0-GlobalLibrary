package zUtils.motionBehavior
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * Date: 08.10.12
	 * Time: 9:49
	 * @author zaidite
	 * @description
	 */
	public class Arrive extends BehaviorBase
	{
		// --- PRIVATE VAR ------------------------------------ //
		private var _maxForce:Number = 1;
		private var _arrivalThreshold:Number = 100;
		private var _steeringForce:Vector2D = new Vector2D();




		// --- PUBLIC VAR ------------------------------------- //
		// --- INTERNAL VAR ----------------------------------- //
		// --- PROTECTED VAR ---------------------------------- //
		// --- GET -------------------------------------------- //

		public function get arriveThreshold():Number {return _arrivalThreshold;}
		public function get maxForce():Number {return _maxForce;}

		// --- SET -------------------------------------------- //

		public function set arriveThreshold(value:Number):void {_arrivalThreshold = value;}
		public function set maxForce(value:Number):void {_maxForce = value;}

		// --- PUBLIC CONSTANT -------------------------------- //
		// --- PRIVATE CONSTANT ------------------------------- //


		//*********************** CONSTRUCTOR ***********************
		public function Arrive(id:String, target:DisplayObject=null)
		{
			super(id, target);
		}

		//***********************************************************


		// --- PRIVATE FUNCTION ------------------------------- //

		// --- PUBLIC FUNCTION -------------------------------- //
		public function arrive(targetPosition:Point):void
		{
			var target:Vector2D = new Vector2D(targetPosition.x, targetPosition.y);
			var desiredVelocity:Vector2D = target.subtract(_position);
			desiredVelocity.normalize();

			var dist:Number = _position.dist(target);


			if(dist > _arrivalThreshold)
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed);
			}
			else
			{
				desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
			}

			var force:Vector2D = desiredVelocity.subtract(_velocity);
			_steeringForce = _steeringForce.add(force);

			update();
		}

		// --- INTERNAL FUNCTION ------------------------------ //
		// --- PROTECTED FUNCTION ----------------------------- //
		// --- OVERRIDE PROTECTED FUNCTION -------------------- //
		// --- OVERRIDE PUBLIC FUNCTION ----------------------- //


		override public function update():void
		{

			_steeringForce.truncate(_maxForce);
			_steeringForce = _steeringForce.divide(_mass);
			_velocity = _velocity.add(_steeringForce);
			_steeringForce = new Vector2D();
			super.update();

//			if(!stage)return;
//
//			x = mouseX;
//			y = mouseY;

		}


		override public function clearData():void
		{
			super.clearData();
		}

// --- OVERRIDE INTERNAL FUNCTION --------------------- //

	} //end class
}//end package