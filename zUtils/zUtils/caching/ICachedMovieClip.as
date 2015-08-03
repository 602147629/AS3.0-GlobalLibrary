package zUtils.caching
{
    /**
     * Date: 24.06.12
     * Time: 15:22
     * @author zaidite
     * @description
     */
    public interface ICachedMovieClip
    {
        // --- OVERRIDE PUBLIC FUNCTION ------------------------------------ //

        function gotoAndStop(frame:Object, scene:String = null):void

        function gotoAndPlay(frame:Object, scene:String = null):void

        function play():void

        function stop():void

        function nextFrame():void

        function prevFrame():void

        // --- GET ------------------------------------ //

        function get animation():Animation
        function get speedAnimation():int

        // --- SET ------------------------------------ //

        function set speedAnimation(value:int):void

        // --- OVERRIDE GET ------------------------------------ //

        function get x():Number

        function get y():Number

        function get width():Number

        function get height():Number

        function get rotation():Number

        function get scaleX():Number

        function get scaleY():Number

        // --- OVERRIDE SET ------------------------------------ //

        function set x(value:Number):void

        function set y(value:Number):void

        function set width(value:Number):void

        function set height(value:Number):void

        function set rotation(value:Number):void

        function set scaleX(value:Number):void

        function set scaleY(value:Number):void


        // --- PUBLIC FUNCTION ------------------------------------ //

        function clear():void

    }
}
