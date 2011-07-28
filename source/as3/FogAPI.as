package {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.utils.setTimeout;
	
	public class FogAPI {
		
		private static var version:String			= "0.0.1";
		private static var domain:String			= "local.fogdev.com";
		private static var libpath:String			= "http://" + domain + "/api/as3/lib.swf";
		
		private static var clip:MovieClip;
		
		public static var gameId:int				= 0;
		public static var game:Object				= new Object();
		public static var userId:int				= 0;
		public static var user:Object				= new Object();
		public static var params:Object				= new Object();
		public static var service:Object			= { init: load_service };
		
		//
		private static function load_service (opt:Object): void {
			
			Security.allowDomain("x.fogdev.com");
			log("Connecting to FogAPI Server ...");
			
			if (!opt.clip) FogAPI.error("No Clip specified");
			if (!opt.game) FogAPI.error("No GameID specified");
			clip = opt.clip;
			gameId = opt.game;
			params = LoaderInfo(clip.root.loaderInfo).parameters;
			
			try {
				var l:Loader = new Loader();
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, service_load_handle);
				l.load(new URLRequest(libpath));
//				clip.addChild(l);
			} catch (e:Error) {
				log("Error! " + e.message);
			}
			
		}
		private static function service_load_handle (e:Event): void {
			if (e.currentTarget.content != null && e.currentTarget.content.service != null) {
				service = e.currentTarget.content.service;
				service.connect( { 'game':gameId, 'clip':clip } );
			} else {
				log("Failed to load service Library");
			}
		}
		
		// Debuging
		public static function error (v1:String): void {
			trace("[FogAPI]", v1);
		}
		public static function log (v1:String = ''): void {
			trace("[FogAPI]", v1);
		}
		
	}

}