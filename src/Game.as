package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
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
	public class Game extends MovieClip
	{
		private var player1:Sprite = new Player();
		private var enemy:Sprite = new Enemy();
		private var MovingObjects:Array = new Array();
		private var BulletArray:Array = new Array();
		private var enemies:Array = new Array();
		private var spawnTimer:Timer;
		private var spawnCooldown:int;
		private var base1:Base = new Base;
		private var playerShoots:Boolean;
		private var playerbuild:Boolean;
		private var bulletCooldown:int;
		private var randomNumGen:Number;
		private var blackBarLeft:Black_Bar = new Black_Bar();
		private var blackBarRight:Black_Bar = new Black_Bar();
		private var background:Background = new Background();
		private var impactFlash:Muzzle_Flash = new Muzzle_Flash();
		private var frameCounter:int = 60;
		private var currentSpawnCooldown:int;
		private var _playSound:Boolean = true;
		private var shootMode:int = 1;
		private var trailSpeed:int = 0;
		private var traceCooldown:int = 0;
		private var ScoreField:int = 0;
		private var collectedCollectables:int = 0;
		private var baseHealth:int = 3;
		private var playerScoreText:TextField = new TextField();
		private var playerAtp:TextField = new TextField(); //playerHealth
		private var playerCollectedField:TextField = new TextField(); //collectedCollectables
		private var ScoreFormat:TextFormat = new TextFormat("Nulshock RG", 50, 0xffffff);
		//private var InformationWindow:TextField = new TextField;
		private var playerHealth:int = 3;
		private var addMuzzleArtCounter:int = 3;
		private var topBar:info_Bar = new info_Bar();
		public var isPlayerOrBaseDead:Boolean = false;
		private var dropRate:int = 40;
		
		private var collectableArray:Array = [];
		public var fireWallArray:Array = [];
		private var soundCooldown:int = 60;
		private var prevShootMode:int = 1;
		private var staticFilter:StaticFilter = new StaticFilter();
		private var SFXTransform:SoundTransform = new SoundTransform(.5, 0);
		private var BGAudioTransform:SoundTransform = new SoundTransform(1, 0);
		
		//placeholder variables for audio
		private var pickupOneShot:URLRequest = new URLRequest("http://18648.hosts.ma-cloud.nl/Sounds/Pickup.mp3");
		//private var onImpactOneShot:URLRequest = new URLRequest("../lib/Sounds/Die echte hit.mp3");
		private var EnemyDies:URLRequest = new URLRequest("http://18648.hosts.ma-cloud.nl/Sounds/EnemyDies.mp3");
		private var playerDies:URLRequest = new URLRequest("http://18648.hosts.ma-cloud.nl/Sounds/PlayerDies.mp3");
		private var laserOneShot:URLRequest = new URLRequest("http://18648.hosts.ma-cloud.nl/Sounds/Laser1.mp3");
		private var Soundtrack:URLRequest = new URLRequest("http://18648.hosts.ma-cloud.nl/Sounds/BGaudio.mp3");
		
		private var shoot:Sound = new Sound(laserOneShot);
		private var bgAudio:Sound = new Sound(Soundtrack);
		private var pickup:Sound = new Sound(pickupOneShot);
		//private var bulletHit:Sound = new Sound(onImpactOneShot);
		private var playerDead:Sound = new Sound(playerDies);
		private var enemyDead:Sound = new Sound(EnemyDies);
		private var barExists:Boolean = false;
		private var dontRepeatThis:Boolean = true;
		public var shakeItBaby:int;
		
		private var myChannel:SoundChannel = new SoundChannel();
		
		public function Game()
		{
			//gameCleared = false;
			//InformationWindow = "Player Health" + playerHealth + "Patches" + collectedCollectables;
			spawnCooldown = 3000;
			currentSpawnCooldown = spawnCooldown;
			spawnTimer = new Timer(spawnCooldown, 0);
			
			//this.stage.color = 0x000000;
			
			//stage.frameRate = 60;
			addChild(background);
			background.x = 400;
			background.y = 300;
			//background.scaleX = 1.1;
			//background.scaleY = 1.1;
			
			addChild(base1);
			player1 = new Player();
			MovingObjects.push(player1); // movingObjects[0]
			addChild(MovingObjects[0]); // player ship
			
			if (stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
			topBar.x = 400;
			addEventListener(Event.ENTER_FRAME, loop);
			
			playerScoreText.type = TextFieldType.DYNAMIC;
			playerAtp.type = TextFieldType.DYNAMIC;
			playerCollectedField.type = TextFieldType.DYNAMIC;
			
			playerScoreText.defaultTextFormat = ScoreFormat;
			playerAtp.defaultTextFormat = ScoreFormat;
			playerCollectedField.defaultTextFormat = ScoreFormat;
			playerAtp.scaleY = .5;
			playerCollectedField.scaleY = .5;
			//playerScoreText.scaleY = .5;
		}
		
		public function canHazShake():int {
			return shakeItBaby;
		}
		
		public function isGameOver():Boolean //-------------------------------------------------------------------------------------------------------------------------------------
		{
			return isPlayerOrBaseDead;
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
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUnPressed);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemy);
			myChannel = bgAudio.play(0,1,BGAudioTransform);
			spawnTimer.start();
			// entry point
		}
		private function scoreScale():void {
			//playerScoreText.scaleX = 1;
			playerScoreText.scaleY = 1;
		}
		
		private function loop(e:Event):void //main loop
		{
			if (shakeItBaby >= 0) {
				shakeItBaby--;
			}
			if (playerScoreText.scaleY >= .5) {
				//playerScoreText.scaleX -= .01;
				playerScoreText.scaleY -= .05;
			}
			if(isPlayerOrBaseDead == false){
				ScoreField++;
			}
			playerScoreText.text = String(ScoreField);
			playerAtp.text = String(playerHealth + "/" + baseHealth);
			playerCollectedField.text = String(collectedCollectables);
			
			if (trailSpeed >= 1)
			{
				if (MovingObjects[0] != null)
				{
					if (MovingObjects[0].playerMoves())
					{
						if (MovingObjects[0].PlayerHealth() >= 1)
						{
							var muzzleFlash:PlayerTrail = new PlayerTrail(stage, MovingObjects[0].x, MovingObjects[0].y, MovingObjects[0].rotation);
							addChild(muzzleFlash);
							trailSpeed = 0;
						}
					}
				}
			}
			else
			{
				trailSpeed++;
			}
			
			soundCooldown++;
			
			randomNumGen = Math.random() * 100;
			CheckCollision();
			if (frameCounter <= 0)
			{
				
				frameCounter = 60;
				currentSpawnCooldown -= 1000;
			}
			if (currentSpawnCooldown <= 1000)
			{
				currentSpawnCooldown = 1000;
			}
			if (enemies.length <= 2)
			{
				spawnCooldown = 1000;
			}
			else
			{
				spawnCooldown = currentSpawnCooldown;
			}
			if (MovingObjects[0] != null)
			{
				//var playerMuzFlash:PlayerMuzzleFlash = new PlayerMuzzleFlash(stage, (MovingObjects[0].x), (MovingObjects[0].y));
				
				if (shootMode == 1)
				{
					if (playerShoots && bulletCooldown >= 3)
					{
						myChannel = shoot.play(0,0,SFXTransform);
						var bulletSpread1:int = 14;
						//addChild(playerMuzFlash);
						
						for (var u:int = 3; u >= 0; u--)
						{
							var bullet:Bullet = new Bullet(stage, (MovingObjects[0].x), (MovingObjects[0].y), (MovingObjects[0].rotation + (bulletSpread1 / 2) - (Math.random() * bulletSpread1)));
							addChild(bullet);
							BulletArray.push(bullet);
						}
						MovingObjects[0].knockBack();
						bulletCooldown = 0;
					}
					else
					{
						bulletCooldown++;
					}
				}
				
				if (shootMode == 2)
				{
					if (playerShoots && bulletCooldown >= 12)
					{
						myChannel = shoot.play(0,0,SFXTransform);
						var bulletSpread2:int = 40;
						//addChild(playerMuzFlash);
						
						for (var u:int = 12; u >= 0; u--)
						{
							
							var bullet:Bullet = new Bullet(stage, (MovingObjects[0].x), (MovingObjects[0].y), (MovingObjects[0].rotation + (bulletSpread2 / 2) - (Math.random() * bulletSpread2)));
							addChild(bullet);
							BulletArray.push(bullet);
						}
						MovingObjects[0].knockBack();
						bulletCooldown = 0;
					}
					else
					{
						bulletCooldown++;
					}
				}
				
				if (shootMode == 3)
				{
					if (playerShoots && bulletCooldown >= 1)
					{
						//addChild(playerMuzFlash);
						myChannel = shoot.play(0,0,SFXTransform);
						var bulletSpread3:int = 6;
						var bullet1:Bullet = new Bullet(stage, (MovingObjects[0].x), (MovingObjects[0].y), (MovingObjects[0].rotation + (bulletSpread3 / 2) - (Math.random() * bulletSpread3)));
						addChild(bullet1);
						BulletArray.push(bullet1);
						MovingObjects[0].knockBack();
						bulletCooldown = 0;
					}
					else
					{
						bulletCooldown++;
					}
				}
				if (shootMode == 4)
				{
					if (playerShoots && bulletCooldown >= 20 && collectedCollectables >= 1)
					{
						collectedCollectables--;
						myChannel = shoot.play(0,0,SFXTransform);
						var bulletSpread4:int = 360;
						//addChild(playerMuzFlash);
						
						for (var u:int = 150; u >= 0; u--)
						{
							
							var bullet:Bullet = new Bullet(stage, (MovingObjects[0].x), (MovingObjects[0].y), (MovingObjects[0].rotation + (bulletSpread4 / 2) - (Math.random() * bulletSpread4)));
							addChild(bullet);
							BulletArray.push(bullet);
						}
						bulletCooldown = 0;
					}
					else
					{
						bulletCooldown++;
					}
				}
			}
			if (barExists)
			{
				removeChild(blackBarLeft);
				removeChild(blackBarRight);
				removeChild(topBar);
				removeChild(staticFilter);
				removeChild(playerScoreText);
				addChild(staticFilter);
				addChild(topBar);
				addChild(playerScoreText);
				addChild(playerAtp);
				addChild(playerCollectedField);
				topBar.alpha = .8;
				
				playerScoreText.alpha = 1;
				playerAtp.alpha = 1;
				playerCollectedField.alpha = 1;
				playerScoreText.x = (topBar.width / 2) - (playerScoreText.length / 2);
				playerAtp.x = (topBar.width / 7);
				playerCollectedField.x = (topBar.width / 1.166);
				playerScoreText.y = topBar.height / 6;
				playerAtp.y = topBar.height / 16;
				playerCollectedField.y = topBar.height / 16;
				
				addChild(blackBarLeft);
				blackBarLeft.x = -blackBarLeft.width;
				blackBarLeft.y = 0;
				blackBarLeft.scaleY = 20;
				
				addChild(blackBarRight);
				blackBarRight.x = 800;
				blackBarRight.y = 0;
				blackBarRight.scaleY = 20;
				
			}
			else
			{
				addChild(playerScoreText);
				addChild(topBar);
				addChild(blackBarLeft);
				addChild(blackBarRight);
				addChild(staticFilter);
				barExists = true;
			}
			staticFilter.y = Math.random() * 8;
			staticFilter.alpha = Math.random() /6;
		/*if(traceCooldown >= 60){
		   trace("logging collectedCollectables  :" + collectedCollectables);
		   trace("logging collectableArray Length:" + collectableArray.length);
		   trace("logging BulletArray Length     :" + BulletArray.length);
		   }else {
		   traceCooldown++;
		   }*/
		}
		
		public function KeyPressed(e:KeyboardEvent):void
		{
			if (MovingObjects[0] != null)
			{
				if (MovingObjects[0].PlayerHealth() >= 1)
				{
					
					if (e.keyCode == Keyboard.J)
					{
						playerShoots = true;
					}
					
					if (e.keyCode == Keyboard.K)
					{
						if (collectedCollectables >= 3)
						{
							var fireWall:FireWall = new FireWall(stage, player1.x, player1.y, player1.rotation);
							addChild(fireWall);
							fireWallArray.push(fireWall);
							collectedCollectables -= 3;
						}
					}
					
					if (e.keyCode == Keyboard.U)
					{
						shootMode = 1;
						prevShootMode = 1;
					}
					
					if (e.keyCode == Keyboard.I)
					{
						shootMode = 2;
						prevShootMode = 2;
					}
					
					if (e.keyCode == Keyboard.O)
					{
						shootMode = 3;
						prevShootMode = 3;
					}
					
					if (e.keyCode == Keyboard.SPACE)
					{
						playerShoots = true;
						shootMode = 4;
					}
				}
			}
		}
		
		public function KeyUnPressed(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.J)
			{
				playerShoots = false;
			}
			if (e.keyCode == Keyboard.SPACE)
			{
				playerShoots = false;
				shootMode = prevShootMode;
			}
		
		}
		
		private function CheckCollision():void
		{
			var l:int = enemies.length;
			var k:int = BulletArray.length;
			var o:int = collectableArray.length;
			var b:int = fireWallArray.length;
			var particleAmount:int = 50;
			
			for (var n:int = k - 1; n >= 0; n--)
			{
				if (BulletArray[n] != null)
				{
					if (BulletArray[n].isBulletShrunk() <= 0)
					{
						//var groundExplosion:Explosion = new Explosion(stage, BulletArray[y].x, BulletArray[y].y);
						BulletArray.splice(n, 1);
					}
				}
				
			}
			
			for (var g:int = o - 1; g >= 0; g--)
			{
				if (collectableArray[g] != null)
				{
					if (collectableArray[g].GetAlpha() <= 0)
					{
						collectableArray[g].DestroyCollectable();
						collectableArray.splice(g, 1);
					}
				}
			}
			
			for (var x:int = o - 1; x >= 0; x--)
			{
				if (collectableArray[x] != null && MovingObjects[0] != null)
				{
					if (collectableArray[x].hitTestObject(MovingObjects[0]))
					{
						
						collectableArray[x].startLoop();
						
						if (soundCooldown >= 60)
						{
							soundCooldown = 0;
							myChannel = pickup.play(0,0, SFXTransform);
						}
						
						if (collectableArray[x].GetAlpha() <= .15)
						{
							collectedCollectables++;
							collectableArray[x].DestroyCollectable();
							collectableArray.splice(x, 1);
						}
					}
				}
			}
			for (var y:int = k - 1; y >= 0; y--)
			{
				for (var t:int = k - 1; t >= 0; t--)
				{
					if (BulletArray[y] != null && fireWallArray[t] != null)
					{
						if (BulletArray[y].hitTestObject(fireWallArray[t]))
						{
							//---------------------------------------------------------------------------------------------------------------------------------bulletbounce ding
							var wallExplosion:Explosion = new Explosion(stage, BulletArray[y].x, BulletArray[y].y);
							fireWallArray[t].HitByBullet();
							//jBulletArray[y].GetWallRotation(fireWallArray[t].rotation);
							//BulletArray[y].BulletBounce();
							BulletArray[y].DestroyBullet();
							BulletArray.splice(y, 1);
							addChild(wallExplosion);
							//myChannel = bulletHit.play(0,0, SFXTransform);
						}
					}
				}
			}
			for (var i:int = l - 1; i >= 0; i--)
			{
				for (var z:int = b - 1; z >= 0; z--)
				{
					if (enemies[i] != null && fireWallArray[z] != null)
					{
						if (fireWallArray[z].hitTestObject(enemies[i]))
						{
							myChannel = enemyDead.play(0,0,SFXTransform);
							var enemyExplode:EnemyExplosion = new EnemyExplosion(stage, enemies[i].x, enemies[i].y);
							addChild(enemyExplode)
							
							for (var h:int = particleAmount - 1; h >= 0; h--)
							{
								var particles3:ScatteringParticles = new ScatteringParticles(stage, enemies[i].x, enemies[i].y);
								addChild(particles3);
							}
							enemies[i].Destroy();
							enemies.splice(i, 1);
							fireWallArray[z].HitByEnemy();
							ScoreField += 1000;
							scoreScale();
							if (fireWallArray[z].GetHealth() <= 0)
							{
								for (var h:int = particleAmount - 1; h >= 0; h--)
								{
									var particlesWall:ScatteringParticles = new ScatteringParticles(stage, fireWallArray[z].x, fireWallArray[z].y);
									addChild(particlesWall);
								}
								fireWallArray[z].DestroyFireWall();
								fireWallArray.splice(z, 1);
							}
						}
					}
				}
				
				if (enemies[i] != null && base1 != null)
				{
					if (enemies[i].hitTestObject(base1))
					{
						var enemyExplode2:EnemyExplosion = new EnemyExplosion(stage, enemies[i].x, enemies[i].y);
						
						for (var w:int = particleAmount - 1; w >= 0; w--)
						{
							var particles2:ScatteringParticles = new ScatteringParticles(stage, enemies[i].x, enemies[i].y);
							addChild(particles2);
						}
						base1.baseShake();
						baseHealth--;
						addChild(enemyExplode2)
						myChannel = enemyDead.play(0,0, SFXTransform);
						enemies[i].Destroy();
						enemies.splice(i, 1);
						if (base1.GetBaseHealth() <= 0) {
							isPlayerOrBaseDead = true;
							base1.DestroyBase();
						}
					}
				}
				
				if (MovingObjects[0] != null && enemies[i] != null) {
					
					if (enemies[i].hitTestObject(MovingObjects[0]))
					{
						
						var playerExplode:EnemyExplosion = new EnemyExplosion(stage, MovingObjects[0].x, MovingObjects[0].y);
						addChild(playerExplode);
						for (var c:int = particleAmount - 1; c >= 0; c--)
						{
							var particles:ScatteringParticles = new ScatteringParticles(stage, MovingObjects[0].x, MovingObjects[0].y);
							addChild(particles);
						}
						myChannel = playerDead.play(0,0,SFXTransform);
						MovingObjects[0].Playerhit();
						playerHealth--;
						MovingObjects[0].y = 300;
						MovingObjects[0].x = 400;
						if (MovingObjects[0].PlayerHealth() <= 0)
						{
							isPlayerOrBaseDead = true;
							MovingObjects[0].Destroy();
							MovingObjects.splice(0, 1);
						}
					}
				}
				for (var j:int = k - 1; j >= 0; j--)
				{
					if (enemies[i] != null && BulletArray[j] != null)
					{
						
						if (BulletArray[j].hitTestObject(enemies[i]))
						{
							var explosion:Explosion = new Explosion(stage, BulletArray[j].x, BulletArray[j].y);
							//trace("banana3");
							BulletArray[j].DestroyBullet();
							enemies[i].BulletHit();
							BulletArray.splice(j, 1);
							addChild(explosion);
							//myChannel = bulletHit.play(0,0, SFXTransform);
							if (enemies[i].GetHealth() <= 0)
							{
								shakeItBaby = 30;
								var collectable:PlayerCollectable = new PlayerCollectable(stage, enemies[i].x, enemies[i].y);
								var enemyExplode:EnemyExplosion = new EnemyExplosion(stage, enemies[i].x, enemies[i].y);
								ScoreField += 1000;
								scoreScale();
								for (var v:int = particleAmount - 1; v >= 0; v--)
								{
									var particles:ScatteringParticles = new ScatteringParticles(stage, enemies[i].x, enemies[i].y);
									addChild(particles);
								}
								
								addChild(enemyExplode)
								enemies[i].Destroy();
								enemies.splice(i, 1);
								myChannel = enemyDead.play(0,0,SFXTransform);
								
								if (randomNumGen <= dropRate)
								{
									addChild(collectable);
									collectableArray.push(collectable);
									dropRate = 40;
								}else {
									dropRate += 10;
								}
							}
						}
					}
				}
			}
		}
	}
}