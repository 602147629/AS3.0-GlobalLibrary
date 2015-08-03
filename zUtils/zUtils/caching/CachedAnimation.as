package zUtils.caching
{
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    //TODO реализовать очистку данных

    /**
     * Date: 24.06.12
     * Time: 14:19
     * @author zaidite
     * @description
     */
    public class CachedAnimation extends Sprite implements ICachedAnimation
    {

        // --- PRIVATE VAR ------------------------------------ //

        private var _createdAnimation:Object = {};

        // --- PRIVATE CONSTANT ------------------------------------ //

        private const INDENT_FOR_FILTER:int = 64;
        private const INDENT_FOR_FILTER_DOUBLED:int = INDENT_FOR_FILTER * 2;
        private const DESTINATION_POINT:Point = new Point(0, 0);
        private const EMPTY_ID:String = '';

        // --- PRIVATE STATIC VAR ------------------------------------ //
        private static var _instance:CachedAnimation;

        //*********************** CONSTRUCTOR ***********************

        public function CachedAnimation(privateValue:PrivateClass) {}

        //***********************************************************

        private function createAnimationData(clip:MovieClip, id:String, scaleX:Number = 1, scaleY:Number = 1, rotation:Number = 0):Animation
        {
            var totalFrames:int = clip.totalFrames;

            var frames:Vector.<BitmapData> = new Vector.<BitmapData>();
            var framesPosition:Vector.<Point> = new Vector.<Point>();


            var rect:Rectangle;
            var trimBounds:Rectangle;
            var flooredX:int;
            var flooredY:int;
            var mtx:Matrix = new Matrix();
            var scratchBitmapData:BitmapData;
            var bmpData:BitmapData;

            for(var i:int = 1; i <= totalFrames; i++)
            {
                clip.gotoAndStop(i);
                rect = clip.getBounds(clip);
                rect.width = Math.ceil(rect.width) + INDENT_FOR_FILTER_DOUBLED;
                rect.height = Math.ceil(rect.height) + INDENT_FOR_FILTER_DOUBLED;

                flooredX = Math.floor(rect.x) - INDENT_FOR_FILTER;
                flooredY = Math.floor(rect.y) - INDENT_FOR_FILTER;
                mtx.tx = -flooredX;
                mtx.ty = -flooredY;

                mtx.createBox(scaleX, scaleY, rotation * Math.PI / 180, -flooredX, -flooredY);

                scratchBitmapData = new BitmapData(rect.width, rect.height, true, 0);
                scratchBitmapData.draw(clip, mtx);

                trimBounds = scratchBitmapData.getColorBoundsRect(0xFF000000, 0x00000000, false);
                trimBounds.x -= 1;
                trimBounds.y -= 1;
                trimBounds.width += 2;
                trimBounds.height += 2;

                bmpData = new BitmapData(trimBounds.width, trimBounds.height, true, 0);
                bmpData.copyPixels(scratchBitmapData, trimBounds, DESTINATION_POINT);

                flooredX += trimBounds.x;
                flooredY += trimBounds.y;

                frames.push(bmpData);
                framesPosition.push(new Point(flooredX, flooredY));

                scratchBitmapData.dispose();
            }

            var result:Animation = new Animation(frames, id, framesPosition);
            result.targetScaleX = scaleX;
            result.targetScaleY = scaleY;
            result.targetRotation = rotation;

            return result;
        }

        // --- PUBLIC FUNCTION ------------------------------------ //

        public function containsTarget(id:String):Boolean
        {
            var result:Boolean;

            if(id && id != EMPTY_ID)
            {
                result = _createdAnimation[id] ? true : false;
            }
            return result;
        }


        public function makeCachedMovieClip(target:MovieClip, id:String, scaleX:Number = 1, scaleY:Number = 1, rotation:Number = 0):ICachedMovieClip
        {
            var animation:Animation;
            var cachedMovieClip:ICachedMovieClip;
            if(target && id && id != EMPTY_ID)
            {
                animation = createAnimationData(target, id, scaleX, scaleY, rotation);
                if(animation)
                {
                    _createdAnimation[id] = animation;
                    cachedMovieClip = new CachedMovieClip(animation);
                }
            }
            return cachedMovieClip;
        }

        public function getCachedMovieClip(id:String):ICachedMovieClip
        {
            var animation:Animation;
            var cachedMovieClip:ICachedMovieClip;

            if(id && id != EMPTY_ID)
            {
                animation = _createdAnimation[id];
                cachedMovieClip = animation ? new CachedMovieClip(animation) : null;
            }
            return cachedMovieClip;
        }


        public function clearManagerData():void
        {
            _createdAnimation = null;
        }

        // --- PUBLIC STATIC FUNCTION ------------------------------------ //

        public static function manager():CachedAnimation
        {
            if(!_instance)_instance = new CachedAnimation(new PrivateClass());
            return _instance;
        }


    } //end class
} // end package

class PrivateClass
{
    public function PrivateClass():void {}
}