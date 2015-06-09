package
{
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point; //k
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Kaj Loevesijn
	 */
	public class Bullet extends Sprite
	{
		private var bullet:Player_bullet = new Player_bullet;
		private var fpscounter:int = 30;
		private var randomNumGen:Number = Math.random() * 3;
		private var stageRef:Stage;
		private var speed:Number = 20 //bullet speed.
		private var xVel:Number = 0; //velocity over the x axis.
		private var yVel:Number = 0; //velocity over the y axis.
		private var rotationInRadians:Number = 0; //stores rotation.
		private var bulletRange:Number = 20;
		private var bulletShrinkThreshold:Number = 0;
		private var bulletShrinkAmountX:Number = 0;
		private var bulletShrinkAmountY:Number = 0;
		private var onImpact:Boolean = false; 0
		private var addArtCounter:int = 0;
		private var muzzleFlashArt:Muzzle_Flash = new Muzzle_Flash();
		private var bulletInvert:Boolean = false;
		private var bounceAngle:Number;
		private var isBouncing:Boolean = false;
		
		//the constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing.
		
		public function Bullet(stageRef:Stage, X:int, Y:int, rotationInDegrees:Number):void
		{
			//addChild(bullet);
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.rotation = rotationInDegrees;
			this.rotationInRadians = rotationInDegrees * Math.PI / 180;
			muzzleFlashArt.scaleX = 3;
			muzzleFlashArt.scaleY = 3;
			
			bulletShrinkThreshold = bulletRange * 0.8; // starts after 80%(1 = 100%, 0.5 = 50%, 0 = 0% etc) of the bullet lifespan
			bulletShrinkAmountX = this.scaleX / (bulletRange - bulletShrinkThreshold) // calculates the amount of frames left before the bullet dissapears then bases the scale reduction on the amount of frames left, pretty damn flexible for if i want to balance things out later.
			bulletShrinkAmountY = this.scaleY / (bulletRange - bulletShrinkThreshold) // same thing but for the Y scaling ^^.
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		
		}
		
		private function loop(e:Event):void
		{
			if (addArtCounter <= 1) {
				addChild(bullet);
				addChild(muzzleFlashArt);
				muzzleFlashArt.rotation = Math.random() * 90;
			}else {
				addArtCounter--;
			}
			if(muzzleFlashArt != null){
					if (muzzleFlashArt.alpha <= .99){
						removeChild(muzzleFlashArt);
					}
					muzzleFlashArt.alpha -= .1;
			}
			fpscounter--;
			if (bulletInvert && isBouncing) {
				xVel = Math.cos(rotationInRadians - bounceAngle) * speed;
				yVel = Math.sin(rotationInRadians - bounceAngle) * speed;
				x -= xVel;
				y -= yVel;
			}else if (bulletInvert = false && isBouncing) {
				xVel = Math.cos(rotationInRadians + bounceAngle) * speed;
				yVel = Math.sin(rotationInRadians + bounceAngle) * speed;
				x += xVel;
				y += yVel;
			}else {
								xVel = Math.cos(rotationInRadians) * speed;
				yVel = Math.sin(rotationInRadians) * speed;
				x += xVel;
				y += yVel;
			}
			
			if ((this.x) < 0 - (this.height / 2))
			{
				this.x = stage.stageWidth + this.height / 2;
			}
			if ((this.x) > (stage.stageWidth + this.height / 2))
			{
				this.x = -this.height / 2;
			}
			if ((this.y) < 0 - (this.height / 2))
			{
				this.y = stage.stageHeight + this.height / 2;
			}
			if ((this.y) > (stage.stageHeight + this.height / 2))
			{
				this.y = -this.height / 2;
			}
			
			bulletRange--;
			bulletShrinkThreshold--;
			
			if (bulletShrinkThreshold <= 0)
			{
				this.scaleX -= bulletShrinkAmountX;
				this.scaleY -= bulletShrinkAmountY;
			}
			if (this.scaleX <= 0)
			{ // destroys bullet after bullet range is depleted till 0.
				DestroyBullet();
			}
			
			if (onImpact)
			{ //just a placeholder for impactiness n stuff.
				this.parent.removeChild(this);
			}
		}
		public function isBulletShrunk():Number {
			return this.scaleX;
			if (this.scaleX <=  0) {
				removeEventListener(Event.ENTER_FRAME, loop);
				parent.removeChild(this);
			}
		}
		public function DestroyBullet():void
		{
			this.muzzleFlashArt.alpha = 0;
			removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(bullet);
		}
		
		public function BulletBounce():void {
			/*trace("ayy");
			isBouncing = true;
			if (bulletInvert == true) {
				bulletInvert = false;
			}else{
				bulletInvert = true;
			}*/
		}
		
		public function GetWallRotation(fireWallRot:Number):void {
			/*var wallRot:int = fireWallRot;
			this.bounceAngle = wallRot * Math.PI / 180;*/
		}
	
	}

}