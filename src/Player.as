package 
{
	import flash.automation.ActionGenerator;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyLocation;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Player extends PlayerPlane //extends character class
	{
		private const maxSpeed:int = 5;
		private const acceleration:Number = .5;
		private const rotationSpeed:int = 6;
		private const friction:Number = .8;
		private const bulletSpeed:int = 16;
		
		private var bulletAmount:Number;
		private var bulletIndex:Number;
		private var bulletReloadCounter:Number;
		
		private var velocity:Point = new Point();
		private var upKey:Boolean = false;
		private var downKey:Boolean = false;
		private var leftKey:Boolean = false;
		private var rightKey:Boolean = false;
		
		private var brake:Boolean = false;
		
		public function Player() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.x = 300;
			this.y = 300;
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			
		}
		
		private function loop (e:Event):void //main loop
		{
			
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
			
			if (upKey) {
				brake = false;
				velocity.y += acceleration * Math.sin(this.rotation / 180 * Math.PI);
				velocity.x += acceleration * Math.cos(this.rotation / 180 * Math.PI);
				}
			else if (downKey) {
				brake = false;
				velocity.y += -(acceleration * Math.sin(this.rotation / 180 * Math.PI));
				velocity.x += -(acceleration * Math.cos(this.rotation / 180 * Math.PI));
			}else {
				brake = true;
				
			}
			if (brake) {
				velocity.x *= friction;
				velocity.y *= friction;
			}
			
			if (rightKey) {
					this.rotation += rotationSpeed;
				}
				
			if (leftKey) {
					this.rotation -= rotationSpeed;
				}
				this.x += velocity.x;
				this.y += velocity.y;
				
				var getCurrSpd:Number = Math.sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y));
				
			if (getCurrSpd > maxSpeed) {
				
				velocity.y *= (maxSpeed / getCurrSpd);
				velocity.x *= (maxSpeed / getCurrSpd);
			}
		}
		
		private function init(e:Event):void
		{
			
			stage.addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function keyDown(e:KeyboardEvent):void {
			
			if (e.keyCode == Keyboard.A) {
				leftKey = true;
			}
			if (e.keyCode == Keyboard.W) {
				upKey = true;
			}
			if (e.keyCode == Keyboard.D) {
				rightKey = true;
			}
			
			if (e.keyCode == Keyboard.S) {
				downKey = true;
			}
			

		}
		
		private function keyUp(e:KeyboardEvent):void {
			
			if (e.keyCode == Keyboard.A) {
				leftKey = false;
			}
			if (e.keyCode == Keyboard.W) {
				upKey = false;
			}
			if (e.keyCode == Keyboard.D) {
				rightKey = false;
			}
			if (e.keyCode == Keyboard.S) {
				downKey = false;
			}
			
		}
		
	}

}