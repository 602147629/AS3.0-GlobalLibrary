package zUtils.caching
{
    import flash.display.MovieClip;

    /**
     * Date: 24.06.12
     * Time: 15:21
     * @author zaidite
     * @description
     */
    public interface ICachedAnimation
    {

        function makeCachedMovieClip(target : MovieClip, id : String, scaleX : Number = 1, scaleY : Number = 1, rotation : Number = 0) : ICachedMovieClip ;
        function getCachedMovieClip(id:String) : ICachedMovieClip ;
        function clearManagerData() : void ;

    }
}
