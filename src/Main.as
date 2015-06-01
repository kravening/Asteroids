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
	public class Main extends MovieClip
	{
		private var player1:MovieClip = new Player();
		private var enemy:Sprite = new Enemy();
		private var MovingObjects:Array = new Array();
		private var BulletArray:Array = new Array();
		private var enemies:Array = new Array();
		private var spawnTimer:Timer = new Timer (2500, 0);
		private var base1:Base = new Base;
		private var playerShoots:Boolean;
		private var bulletCooldown:int;
		private var randomNumGen:Number;

		private var collectableArray:Array = new Array();
		private var collectable:Sprite = new Collectable();
		
		private var laserOneShot:URLRequest = new URLRequest("../lib/Sounds/Laser1.mp3"); 
		private var shoot:Sound = new Sound(laserOneShot);
		private var myChannel:SoundChannel = new SoundChannel();
		
		public function Main()
		{
			
			stage.frameRate = 60;
			player1 = new Player();
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
			enemy = new Enemy();
			addChild(enemy);
			enemies.push(enemy);
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
			checkCollision();
			
			if (playerShoots && bulletCooldown > 2) {
				//myChannel.stop();
				//myChannel = shoot.play();
				var bullet:Bullet = new Bullet(stage, MovingObjects[0].x, MovingObjects[0].y, MovingObjects[0].rotation);
				addChild(bullet);
				BulletArray.push(bullet);
				bulletCooldown = 0;
				//shoot.close();
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
		
		private function checkCollision():void {
			var l:int = enemies.length;
			var k:int = BulletArray.length;
			for (var i:int = 0; i < l; i++) {
				if (enemies[i].hitTestObject(base1)) {
					enemies[i].Destroy();
					enemies.splice(i, 1);
					trace("banana1");
				}
				if(enemies[i].hitTestObject(player1)) {
					enemies[i].Destroy();
					trace("banana2");
				}
				
				for (var j:int = 0; j < k; j++) 
				{
					if (BulletArray[j].hitTestObject(enemies[i]))
					{
						trace("banana3");
						BulletArray[j].DestroyBullet();
						enemies[i].BulletHit();
					}
				}
			}
			
		}
		
		private function SpawnCollectable():void {
				randomNumGen = Math.random() * 100;
				if (randomNumGen < 33) {
					collectable = new Collectable();
					addChild(collectable);
					collectableArray.push(collectable);
			}
		}
		
	}
	
}