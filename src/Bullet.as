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
	public class Bullet extends Sprite
	{
		private var bullet:Player_bullet = new Player_bullet;
		private var muzzleFlash1:Muzzle_01 = new Muzzle_01;
		private var muzzleFlash2:Muzzle_02 = new Muzzle_02;
		private var muzzleFlash3:Muzzle_03 = new Muzzle_03;
		
		private var fpscounter:int = 30;
		private var randomNumGen:Number = Math.random() * 3;
		private var stageRef:Stage;
		private var speed:Number = 10 //bullet speed.
		private var xVel:Number = 0; //velocity over the x axis.
		private var yVel:Number = 0; //velocity over the y axis.
		private var rotationInRadians:Number = 0; //stores rotation.
		private var bulletRange:Number = 40;
		private var bulletShrinkThreshold:Number = 0;
		private var bulletShrinkAmountX:Number = 0;
		private var bulletShrinkAmountY:Number = 0;
		private var onImpact:Boolean = false;
		//the constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing.
		
		public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number):void {
			addChild(bullet);
			
			//addChild(muzzleFlash1);
			muzzleFlash1.scaleX = 10;
			muzzleFlash1.scaleY = 10;
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
			//muzzleFlash1.scaleX -= 5;
			//muzzleFlash1.scaleY -= 5;
			
			//if (muzzleFlash1.scaleY == 0) {
			//	removeChild(muzzleFlash1);
			//}
			 fpscounter --;
			xVel = Math.cos(rotationInRadians) * speed; 
			yVel = Math.sin(rotationInRadians) * speed;
			x += xVel;
			y += yVel;
			
			if ((this.x) < 0 - (this.height /2)) {
			this.x = stage.stageWidth + this.height/2;
			}
			if ((this.x) > (stage.stageWidth + this.height / 2)) {
					this.x = -this.height/2;
			}
			if ((this.y) < 0 - (this.height / 2)) {
					this.y = stage.stageHeight + this.height/2;
			}
			if ((this.y) > (stage.stageHeight + this.height / 2)) {
					this.y = -this.height/2;
			}
			
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
		
		public function DestroyBullet():void {
			removeChild(bullet);
		}
		
	}

}