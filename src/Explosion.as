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
	public class Explosion extends Sprite
	{
		private var explosion:Muzzle_Flash = new Muzzle_Flash;
		private var stageRef:Stage;
		private var iDontHaveAnLogicalNameForThis:Boolean = true;
		
		public function Explosion(stageRef:Stage, X:int, Y:int):void
		{
			addChild(explosion);
			this.rotation = Math.random() * 360;
			this.scaleX = .1;
			this.scaleY = .1;
			this.alpha = 1;
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			
			addEventListener(Event.ENTER_FRAME, loop)
		}
		
		private function loop(e:Event):void
		{
			this.rotation += 5;
			this.alpha -= .01;
			this.scaleX += .05;
			this.scaleY += .05;
			
			if (this.alpha <= .99) {// this makes the explosion "snappier" high initial blast slow fallof after, ayyyyyy
				if (iDontHaveAnLogicalNameForThis) {
					this.alpha = .2
					iDontHaveAnLogicalNameForThis = false;
				}
				this.alpha -= .005;
			}
			if (this.alpha <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, loop);
				parent.removeChild(this);
			}
		
		}
	
	}

}