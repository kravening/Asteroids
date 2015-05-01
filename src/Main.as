package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite 
	{
		private var player1:MovieClip;
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
			if ((MovingObjects[0].x) < 0 - (MovingObjects[0].height /2)) {
			MovingObjects[0].x = stage.stageWidth + MovingObjects[0].height/2;
			}
			if ((MovingObjects[0].x) > (stage.stageWidth + MovingObjects[0].height / 2)) {
				MovingObjects[0].x = -MovingObjects[0].height/2;
			}
			if ((MovingObjects[0].y) < 0 - (MovingObjects[0].height / 2)) {
				MovingObjects[0].y = stage.stageHeight + MovingObjects[0].height/2;
			}
			if ((MovingObjects[0].y) > (stage.stageHeight + MovingObjects[0].height / 2)) {
				MovingObjects[0].y = -MovingObjects[0].height/2;
			}
		}
		
	}
	
}