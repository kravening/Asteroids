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
	public class ScatteringParticles extends Sprite
	{
		private var rotationInRadians:Number = 0;
		private var stageRef:Stage;
		private var xVel:Number = 0; //velocity over the x axis.
		private var yVel:Number = 0; //velocity over the y axis.
		
		private var speed:Number = 5 //bullet speed.
		private var particleArt:Muzzle_Flash = new Muzzle_Flash();
		
		
		public function ScatteringParticles(stageRef:Stage, X:int, Y:int) 
		{
			addChild(particleArt);
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.rotationInRadians = /*rotationInDegrees*/ (Math.random() * 360) * Math.PI / 180;
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			this.scaleX = .4;
			this.scaleY = .4;
			
		}
		
		public function loop(e:Event):void {
			
			xVel = Math.cos(rotationInRadians) * speed;
			yVel = Math.sin(rotationInRadians) * speed;
			x += xVel;
			y += yVel;
			this.rotation += 20;
			this.alpha -= .025;
			this.scaleX -= .01;
			this.scaleY -= .01;
			if (this.alpha <= 0) {
				//trace("ayylmao");
				removeEventListener(Event.ENTER_FRAME, loop);
				this.parent.removeChild(this);
			}
		}
		
	}

}