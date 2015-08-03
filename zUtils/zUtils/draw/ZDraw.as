package zUtils.draw
{
    import flash.display.Sprite;

    /**
     * Date: 14.05.12
     * Time: 17:58
     * @author zaidite
     * @description
     */

    public class ZDraw extends Sprite
    {

        /** Создаёт и возвращает фигуры - спрайты с однородной заливкой */
        private static var _simpleSpriteFactory:SpriteSimpleFill;
        private static var _gradientSpriteFactory:SpriteGradientFill;
        private static var _bitmapSpriteFactory:SpriteBitmapFill;
        private static var _simpleMovieClipsFactory:MovieClipSimpleFill;
        private static var _gradientMovieClipsFactory:MovieClipGradientFill;

        private static var _colorsManager:Colors;
        private static var _linesManager:LineStile;
        private static var _gradientsManager:Gradients;


        //*********************** CONSTRUCTOR ***********************
        public function ZDraw()
        {
        }

        //***********************************************************

        //- PUBLIC STATIC FUNCTION ------------------------------------------

        public  static function factorySimpleSprites() : SpriteSimpleFill
        {
           if(!_simpleSpriteFactory) _simpleSpriteFactory = new SpriteSimpleFill();
           return _simpleSpriteFactory ;
        }

        public  static function factoryGradientSprites() : SpriteGradientFill
        {
           if(!_gradientSpriteFactory) _gradientSpriteFactory = new SpriteGradientFill();
           return _gradientSpriteFactory ;
        }

        public  static function factoryBitmapFillSprites() : SpriteBitmapFill
        {
            if(!_bitmapSpriteFactory) _bitmapSpriteFactory = new SpriteBitmapFill();
            return _bitmapSpriteFactory ;
        }





        public  static function factorySimpleMovieClips() : MovieClipSimpleFill
        {
            if(!_simpleMovieClipsFactory) _simpleMovieClipsFactory = new MovieClipSimpleFill();
            return _simpleMovieClipsFactory ;
        }

        public  static function factoryGradientMovieClips() : MovieClipGradientFill
        {
            if(!_gradientMovieClipsFactory) _gradientMovieClipsFactory = new MovieClipGradientFill();
            return _gradientMovieClipsFactory ;
        }




        public  static function colorsManager() : Colors
        {
           if(!_colorsManager) _colorsManager = new Colors();
           return _colorsManager ;
        }

        public  static function linesManager() : LineStile
        {
           if(!_linesManager) _linesManager = new LineStile();
           return _linesManager ;
        }

        public  static function gradientsManager() : Gradients
        {
            if(!_gradientsManager) _gradientsManager = new Gradients();
            return _gradientsManager ;
        }



        public  static function clearData() : void
        {
            _simpleSpriteFactory = null;
            _colorsManager = null;
            _linesManager = null;
        }





    }//end class
}//end package