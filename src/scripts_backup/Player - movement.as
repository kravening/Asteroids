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
		private var controlDir:Point;
		private var speed:Number;
		
		
		public function Player() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.x = 300;
			this.y = 300;
			this.scaleX = 0.3;
			this.scaleY = 0.3;
			
			controlDir = new Point(0, 0);
			
		}
		
		private function update (e:Event):void
		{
			speed = controlDir.y * -10;
			
			this.rotation += controlDir.x * 6;
			var radian:Number = this.rotation * Math.PI / 180;
										// van graden naar radians
			var xMove:Number = Math.cos(radian);
			var yMove:Number = Math.sin(radian);
			this.x += xMove * speed;
			this.y += yMove * speed;
			
			
		}
		
		private function init(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.W) 
			{
				controlDir.y = -1;
				
			}
			if (e.keyCode == Keyboard.A) 
			{
				controlDir.x = -1;
				
			}
			if (e.keyCode == Keyboard.S) 
			{
				controlDir.y = 1;
			}
			if (e.keyCode == Keyboard.D) 
			{
				controlDir.x = 1;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{	
			if (e.keyCode == Keyboard.W)
			{
				controlDir.y = 0;
				
			}
			if (e.keyCode == Keyboard.A)
			{
				controlDir.x = 0;
				
			}
			if (e.keyCode == Keyboard.S)
			{
				controlDir.y = 0;
				
			}
			if (e.keyCode == Keyboard.D)
			{
				controlDir.x = 0;
				
			}
		}
		
		private function wrapScreen (e:Event):void
		{
			
		}
		
	}

}