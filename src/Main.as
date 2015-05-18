package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyLocation;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.display.MovieClip
	import flash.globalization.NumberFormatter;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
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
		private var playerShoots:Boolean;
		private var bulletCooldown:int;
		
		private var laserOneShot:URLRequest = new URLRequest("../lib/Sounds/Laser1.mp3"); 
		private var shoot:Sound = new Sound(laserOneShot);
		private var myChannel:SoundChannel = new SoundChannel();
		
		public function Main()
		{
			stage.frameRate = 60;
			player1 = new Player();
			base1 = new Base;
			MovingObjects.push(player1); // movingObjects[0]
			addChild(MovingObjects[0]); // player ship
			addChild(base1);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, loop);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUnPressed);
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
			
			if (playerShoots && bulletCooldown > 10) {
				myChannel.stop();
				myChannel = shoot.play();
				var bullet:Bullet = new Bullet(stage, MovingObjects[0].x, MovingObjects[0].y, MovingObjects[0].rotation)
				stage.addChild(bullet);
				MovingObjects.push(bullet);
				bulletCooldown = 0;
				shoot.close();
			}else {
				bulletCooldown ++;
			}
			
		}
		
		public function KeyPressed(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) {
				playerShoots = true;
			}
		}
		
		public function KeyUnPressed(e:KeyboardEvent):void {
			if (e.keyCode == Keyboard.SPACE) {
				playerShoots = false;
				
			}
			
		}
		
	}
	
}