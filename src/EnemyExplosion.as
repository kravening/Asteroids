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
	public class EnemyExplosion extends Sprite
	{
		private var explosionArt:Muzzle_Flash = new Muzzle_Flash();
		private var stageRef:Stage;
		private var rotationSpeed:Number;
		private var anotherIllogicalThing:Boolean = true;
		public function EnemyExplosion(stageRef:Stage, X:int, Y:int) 
		{
			addChild(explosionArt);
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.scaleX = 1.5;
			this.scaleY = 1.5;
			rotationSpeed = -10 + (Math.random() * 20);
			addEventListener(Event.ENTER_FRAME, loop)
		}
		
		private function loop(e:Event):void {
			this.rotation += rotationSpeed;
			if (this.alpha <= .999 && anotherIllogicalThing){
				anotherIllogicalThing = false;
				this.alpha = .4
			}
			this.alpha -= .020;
				
			if (this.alpha <= 0) {
				//trace("ayylmao");
				removeEventListener(Event.ENTER_FRAME, loop);
				removeChild(explosionArt);
			}
		}
	}

}