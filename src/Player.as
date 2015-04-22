package 
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.KeyLocation;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Player extends PlayerCube//extends character class
	{
		private var buttonIsPressed:Boolean = false;
		
		public function Player() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.x = 300;
			this.y = 300;
			this.scaleX = 0.3;
			this.scaleY = 0.3;
		}
		
		private function update (e:Event):void
		{
			if (buttonIsPressed)
			{
				this.x += 10;
			}
		}
		
		private function init(e:Event):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 39)
			{
				buttonIsPressed = true;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if (e.keyCode == 39)
			{
				buttonIsPressed = false;
			}
		}
		
	}

}