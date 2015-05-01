package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip
	import flash.globalization.NumberFormatter;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite 
	{
		private var player1:MovieClip = new Player();
		private var MovingObjects:Array = new Array();
		
		public function Main() 
		{	
			MovingObjects.push(player1); // movingObjects[0]
			addChild(MovingObjects[0]); // player ship
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		}
		
		private function loop (e:Event):void //main loop
		{
			//stop de screenwrap in een superclass "movable objects"
			var movObjIndex:int = MovingObjects.length;
			for (var i:int = 0; i < movObjIndex; i++) 
			{
				if ((MovingObjects[i].x) < 0 - (MovingObjects[i].height /2)) {
				MovingObjects[i].x = stage.stageWidth + MovingObjects[i].height/2;
				}
				if ((MovingObjects[i].x) > (stage.stageWidth + MovingObjects[i].height / 2)) {
					MovingObjects[i].x = -MovingObjects[i].height/2;
				}
				if ((MovingObjects[i].y) < 0 - (MovingObjects[i].height / 2)) {
					MovingObjects[i].y = stage.stageHeight + MovingObjects[i].height/2;
				}
				if ((MovingObjects[i].y) > (stage.stageHeight + MovingObjects[i].height / 2)) {
					MovingObjects[i].y = -MovingObjects[i].height/2;
				}
			}
		}
		
		public function createBullet(e:Event) {
			
		}
		
	}
	
}