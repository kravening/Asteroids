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
		private const maxSpeed:int = 16;
		private const acceleration:int = 1;
		private const rotationSpeed:int = 8;
		private const friction:Number = 0.8;
		
		private var velocity:Point = new Point();
		private var upKey:Boolean = false;
		private var downKey:Boolean = false;
		private var leftKey:Boolean = false;
		private var rightKey:Boolean = false;
		
		
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
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) {
				leftKey = true;
			}
			if (e.keyCode == 38) {
				upKey = true;
			}
			if (e.keyCode == 39) {
				rightKey = true;
			}
			
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 37) {
				leftKey = false;
			}
			if (e.keyCode == 38) {
				upKey = false;
			}
			if (e.keyCode == 39) {
				rightKey = false;
			}
			
		}
		
	}

}