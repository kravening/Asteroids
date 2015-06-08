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
		private var _fireWall:Muzzle_Flash = new Muzzle_Flash;
		private var stageRef:Stage;
		private var rotationInRadians:Number = 0;
		private var _health:int = 3;
		
		public function FireWall(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number) 
		{
			addChild(_fireWall);
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.scaleX = .1;
			this.scaleY =  1;
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180;
			
		}
		
		public function DestroyFireWall():void {
			removeChild(_fireWall);
		}
		public function HitByEnemy():void {
			_health--;
		}
		public function GetHealth():int {			
			return _health;
		}
		
	}

}