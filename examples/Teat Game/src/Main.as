package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	/**
	 * ...
	 * @author Marc Qualie
	 */
	public class Main extends MovieClip 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			// Initliaze FogAPI
			FogAPI.init( { game:21415, clip: root } );
			FogAPI.preloader.start();
			FogAPI.log("after preloader display");
			
		}
		
	}
	
}