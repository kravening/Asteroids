package
{
	//import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Base extends Sprite
	{
		private var base:Player_base = new Player_base();
		private var shakeLength:int;
		
		public function Base()
		{
			addChild(base);
			this.x = 400;
			this.y = 300;
			this.scaleX = 0.2;
			this.scaleY = 0.2;
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function baseShake():void {
			this.shakeLength = 30;
		}
		
		private function loop(e:Event):void {
			if (shakeLength >= 0) {
				this.x = 400 + Math.random() * shakeLength /1.5;
				this.y = 300 + Math.random() * shakeLength /1.5;
				shakeLength--;
			}
		}
	
	}

}