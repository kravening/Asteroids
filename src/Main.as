package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite 
	{
		private var player1:MovieClip;
		
		public function Main() 
		{
			player1 = new Player();
			addChild(player1);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
	}
	
}