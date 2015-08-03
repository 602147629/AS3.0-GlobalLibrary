package zUtils.caching
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;

    /**
     * Date: 24.06.12
     * Time: 17:45
     * @author zaidite
     * @description
     */

    internal class Animation extends Bitmap
    {
        private var _frames:Vector.<BitmapData>;
        private var _currentFrame:int = 1;
        private var _totalFrames:int;
        private var _animationID:String;
        private var _speed:int;
        private var _played:Boolean;
        private var _framePosition:Vector.<Point>;
        private var _targetScaleX:Number;
        private var _targetScaleY:Number;
        private var _targetRotation:Number;

        // --- GET ------------------------------------ //

        public function get frames():Vector.<BitmapData> {return _frames;}

        public function get currentFrame():int {return _currentFrame;}

        public function get totalFrames():int {return _totalFrames;}

        public function get animationID():String {return _animationID;}

        public function get speed():int {return _speed;}

        public function get played():Boolean {return _played;}

        public function get targetScaleX():Number {return _targetScaleX;}

        public function get targetScaleY():Number {return _targetScaleY;}

        public function get targetRotation():Number {return _targetRotation;}

        // --- SET ------------------------------------ //

        public function set currentFrame(value:int):void{_currentFrame = value;}

        public function set speed(value:int):void{_speed = value;}

        public function set played(value:Boolean):void{_played = value;}

        public function set targetScaleX(value:Number):void{_targetScaleX = value;}

        public function set targetScaleY(value:Number):void{_targetScaleY = value;}

        public function set targetRotation(value:Number):void{_targetRotation = value;}


        //*********************** CONSTRUCTOR ***********************
        public function Animation(frames:Vector.<BitmapData>, id:String, framesPosition:Vector.<Point>)
        {
            _frames = frames;
            _framePosition = framesPosition;
            _totalFrames = _frames.length;
            _animationID = id;
        }

        //***********************************************************

        //- INTERNAL  FUNCTION -------------------------------------
        internal function gotoFrame(frame:int):void
        {
            _currentFrame = frame;
            bitmapData = _frames[currentFrame - 1];
            x = _framePosition[currentFrame - 1].x;
            y = _framePosition[currentFrame - 1].y;
            smoothing = true;
        }

        internal function increaseFrameCount():void
        {
            _currentFrame++;
            if(_currentFrame > _totalFrames) _currentFrame = 1;
            gotoFrame(_currentFrame);
        }


        internal function clearData():void
        {
            var item:BitmapData
            var len:int = _frames.length;
            for(var i:int = 0; i < len; i++)
            {
                item = _frames[i] as BitmapData;
                item.dispose();
                item = null;
            }
            _frames = null;
            _currentFrame = 0;
            _totalFrames = 0;
            _animationID = null;

        }


    } //end class
} // end package
