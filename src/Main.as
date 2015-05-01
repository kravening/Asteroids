package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
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
		private var enemies:Vector.<Enemy> = new Vector.<Enemy>;
		private var spawnTimer:Timer = new Timer (2500, 0);
		private var base1:MovieClip;
		
		
		public function Main()
		{
			player1 = new Player();
			base1 = new Base;
			MovingObjects.push(player1); // movingObjects[0]
			addChild(MovingObjects[0]); // player ship
			addChild(base1);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function spawnEnemy(e:TimerEvent):void
		{
			enemies.push(new Enemy);
			addChild(new Enemy);
		}
		
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
			spawnTimer.start();
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
		
		public function createBullet(e:Event):void {
			
		}
		
	}
	
}