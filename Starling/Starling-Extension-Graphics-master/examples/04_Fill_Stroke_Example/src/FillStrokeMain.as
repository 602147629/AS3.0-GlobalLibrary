package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import starling.core.Starling;

	[SWF( width="800", height="600", backgroundColor="#CCCCCC", frameRate="60" )]
	public class FillStrokeMain extends Sprite
	{
		private var starling	:Starling;

		public function FillStrokeMain()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			starling = new Starling( FillStrokeExample, stage );

			starling.antiAliasing = 1;
			starling.start();
		}

	}

}