package 
{
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point;     //k
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author hubbub
	 */
	public class FireWall extends Sprite
	{
		private var _fireWall:Player_Wall = new Player_Wall;
		private var stageRef:Stage;
		private var rotationInRadians:Number = 0;
		private var _health:int = 3;
		private var shakeLength:int;
		private var spawnX:int;
		private var spawnY:int;
		
		public function FireWall(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number) 
		{
			addChild(_fireWall);
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			spawnX = X;
			spawnY = Y;
			this.scaleX = .3;
			this.scaleY = .3;
			this.rotation = rotationInDegrees + 90;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		public function loop(e:Event):void {
			if (shakeLength >= 0) {
				this.x = spawnX + (Math.random() * shakeLength /1.5);
				this.y = spawnY + (Math.random() * shakeLength /1.5);
				shakeLength--;
			}
		}
		
		public function DestroyFireWall():void {
			removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(_fireWall);
		}
		public function HitByEnemy():void {
			this.shakeLength = 15;
			_health--;
		}
		public function HitByBullet():void {
			this.shakeLength = 5;
		}
		public function GetHealth():int {			
			return _health;
		}
		
	}

}