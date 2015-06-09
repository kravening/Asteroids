package 
{
	import flash.display.JointStyle;
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point; //k
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author hubbub
	 */
	public class PlayerMuzzleFlash extends Sprite
	{
		private var MuzzleFlashArt:Muzzle_Flash = new Muzzle_Flash();
		private var rotationInRadians:Number = 0;
		private var stageRef:Stage;
		private var xVel:Number = 0; //velocity over the x axis.
		private var yVel:Number = 0; //velocity over the y axis.
		private var deleteIfZero:int = 3;
		
		public function PlayerMuzzleFlash()
		{
			this.rotation = Math.random() * 360;
			this.scaleX = 4;
			this.scaleY = 4;
			this.alpha = .8;
			addChild(MuzzleFlashArt);
			
			addEventListener(Event.ENTER_FRAME, loop);
			
		}
		
		public function loop(e:Event):void {
			this.alpha -= .5;
			deleteIfZero--;
			
			if (this.alpha <= 0) {
				Destroy();
			}
		}
		
		private function Destroy():void {
			trace("ayylmao");
			removeEventListener(Event.ENTER_FRAME, loop);
			parent.removeChild(this);
		}
		
		public function DestroyFromOutside():void {
			this.removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(MuzzleFlashArt);
		}
		
	}

}