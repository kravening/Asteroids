package 
{
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point; //k
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author hubbub
	 */
	public class PlayerTrail extends Sprite
	{
		private var _muzzleFlash:Muzzle_Flash = new Muzzle_Flash;
		private var stageRef:Stage;
		private var trailLength:Number = .010;
		private var trailSize:Number = .20;
		private var rotationInRadians:Number;
		
		public function PlayerTrail(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number) 
		{
			addChild(_muzzleFlash);
			this.rotation = Math.random() * 10;
			this.scaleX = trailSize;
			this.scaleY = trailSize;
			this.alpha = .5;
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI;
			
			addEventListener(Event.ENTER_FRAME, loop)
		}
		
		private function loop(e:Event):void
		{
			this.rotation += 10;
			this.alpha -= trailLength ;
			this.scaleX -= trailLength / 2;
			this.scaleY -= trailLength / 2;
			if (this.alpha <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, loop);
				removeChild(_muzzleFlash);
			}
		
		}
	}

}