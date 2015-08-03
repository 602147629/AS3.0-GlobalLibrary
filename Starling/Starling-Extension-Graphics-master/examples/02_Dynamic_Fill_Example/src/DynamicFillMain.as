package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	import starling.core.Starling;

	[SWF( width="800", height="600", backgroundColor="#CCCCCC", frameRate="60" )]
	public class DynamicFillMain extends Sprite
	{
		private var starling	:Starling;

		public function DynamicFillMain()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			starling = new Starling( DynamicFillExample, stage );

			starling.antiAliasing = 1;
			starling.start();
		}

	}

}