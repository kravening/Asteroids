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
			
		}
		
		private function init(e:Event):void
		{
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
	}

}