package {
    import flash.display.Sprite;
    import flash.events.Event;

    /**
     * Date   : 28.08.2014
     * Time   : 12:55
     * author : Vitaliy Snitko
     * mail   : zaidite@gmail.com
     *
     * description    :
     * responsibility :
     */
    public class Main extends Sprite {

        //*********************** CONSTRUCTOR ***********************
        public function Main() {
            if (stage && stage.stageWidth && stage.stageHeight)_initData();
            else addEventListener(Event.ENTER_FRAME, _initData);
        }

        //***********************************************************

        private function _initData(e:Event = null):void {
            if (!stage || !stage.stageWidth || !stage.stageHeight)return;
            removeEventListener(Event.ENTER_FRAME, _initData);
        }

    } //end class
}//end package