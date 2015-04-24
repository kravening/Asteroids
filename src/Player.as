package 
{
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
		const maxSpeed = 16;
		const acceleration = 1;
		const rotationSpeed = 8;
		const friction = 0.8;
		
		var velocity:Point = new Point();
		var upKey:Boolean = false;
		var downKey:Boolean = false;
		var leftKey:Boolean = false;
		var rightKey:Boolean = false;
		
		
		public function Player() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.x = 300;
			this.y = 300;
			this.scaleX = 0.3;
			this.scaleY = 0.3;
			
		}
		
		private function loop (e:Event):void //main loop
		{	
			if (upKey) {
				velocity.y += acceleration * Math.sin(this.rotation / 180 * Math.PI);
				velocity.x += acceleration * Math.cos(this.rotation / 180 * Math.PI);
				}
				
			else if (downKey) {
				velocity.y -= acceleration * Math.sin(this.rotation / 180 * Math.PI);
				velocity.x -= acceleration * Math.cos(this.rotation / 180 * Math.PI);
				} else {
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
				
				var getCurrSpd = Math.sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y));
				
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
		
		private function keyDown(e:KeyboardEvent) {
			if (e.keyCode == 37) {
				leftKey = true;
			}
			if (e.keyCode == 38) {
				upKey = true;
			}
			if (e.keyCode == 39) {
				rightKey = true;
			}
			if (e.keyCode == 40) {
				leftKey = true;
			}
			
		}
		
		private function keyUp(e:KeyboardEvent) {
			if (e.keyCode == 37) {
				leftKey = false;
			}
			if (e.keyCode == 38) {
				upKey = false;
			}
			if (e.keyCode == 39) {
				rightKey = false;
			}
			if (e.keyCode == 40) {
				leftKey = false;
			}
			
		}
		
	}

}