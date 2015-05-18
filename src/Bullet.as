package  
{
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point;     //k
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kaj Loevesijn
	 */
	public class Bullet extends Player_Bullet
	{
		private var stageRef:Stage;
		private var speed:Number = 15; //bullet speed.
		private var xVel:Number = 0; //velocity over the x axis.
		private var yVel:Number = 0; //velocity over the y axis.
		private var rotationInRadians:Number = 0; //stores rotation.
		private var bulletRange:Number = 30;
		private var bulletShrinkThreshold:Number = 0;
		private var bulletShrinkAmountX:Number = 0;
		private var bulletShrinkAmountY:Number = 0;
		private var onImpact:Boolean = false;
		//the constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing.
		
		public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number):void {
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180;
			
			bulletShrinkThreshold = bulletRange * 0.8; // starts after 80%(1 = 100%, 0.5 = 50%, 0 = 0% etc) of the bullet lifespan
			bulletShrinkAmountX = this.scaleX / (bulletRange - bulletShrinkThreshold) // calculates the amount of frames left before the bullet dissapears then bases the scale reduction on the amount of frames left, pretty damn flexible for if i want to balance things out later.
			bulletShrinkAmountY = this.scaleY / (bulletRange - bulletShrinkThreshold) // same thing but for the Y scaling ^^.
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			
		}
		
		private function loop (e:Event):void {
			xVel = Math.cos(rotationInRadians) * speed; 
			yVel = Math.sin(rotationInRadians) * speed;
			x += xVel;
			y += yVel;
			
			bulletRange --;
			bulletShrinkThreshold --;
			
			if (bulletShrinkThreshold < 0) {
				this.scaleX -= bulletShrinkAmountX;
				this.scaleY -= bulletShrinkAmountY;
			}
			if (bulletRange < 0) { // destroys bullet after bullet range is depleted till 0.
				DestroyBullet();
			}
			
			if (onImpact) { //just a placeholder for impactiness n stuff.
				DestroyBullet();
			}
		}
		
		private function DestroyBullet() {
			this.parent.removeChild(this);
		}
		
	}

}