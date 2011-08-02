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
		
		private static var version:String				= "0.0.1";
		private static var libpath:String				= "http://fogdevlib.com/lib.swf";
		private static var domains:Array				= ['fogdevlib.com','local.fogdev.com',  'x.fogdev.com'];
		
		private static var i:int;
		private static var len:int;
		private static var clip:MovieClip;
		
		public static var gameId:int					= 0;
		public static var game:Object					= new Object();
		public static var userId:int					= 0;
		public static var user:Object					= new Object();
		public static var params:Object					= new Object();
		public static var options:Object				= new Object();
		public static var connected:Boolean				= false;
		public static var service:Object				= {};
		public static var library:MovieClip;
		
		//
		public static function init (opt:Object): void {
			
			log("Connecting to FogAPI Server ...");
			for (i = 0, len = domains.length; i < len ; i++) {
				Security.allowDomain(domains[i]);
			}
			
			if (!opt.clip) FogAPI.error("No Clip specified");
			if (!opt.game) FogAPI.error("No GameID specified");
			clip = opt.clip;
			gameId = opt.game;
			params = LoaderInfo(clip.root.loaderInfo).parameters;
			
			try {
				var l:Loader = new Loader();
				l.contentLoaderInfo.addEventListener(Event.COMPLETE, service_load_handle);
				l.load(new URLRequest(libpath + "?n=" + Math.round(Math.random() * 1000000)));
			} catch (e:Error) {
				log("Error! " + e.message);
			}
			
		}
		private static function service_load_handle (e:Event): void {
			try {
				if (e.currentTarget.content != null) {
					if (e.currentTarget.content.service != null) {
						library = e.currentTarget.content;
						library.connect( { 'game':gameId, 'clip':clip } );
						service = library.service;
						log("Library & Services are now available");
						connected = true;
						return;
					}
				}
			} catch (e:Error) {
				error("Library seems to be corrupted");
				return;
			}
			log("Failed to load service Library");
		}
		
		// Preloader
		public static var preloader:Object = {
			start: preloader_start
		}
		private static function preloader_start (): void {
			log("starting preloader..");
		}
		
		// Debug Helpers
		public static function error (s:String): void {
			log(s, 'error');
		}
		public static function log (s:String = '', t:String = 'log'): void {
			trace("[FogAPI:" + t + "]", s);
		}
		
	}

}