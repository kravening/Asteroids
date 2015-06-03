package
{
	//import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Base extends Sprite
	{
		private var base:Player_base = new Player_base();
		public function Base() 
		{
			addChild(base);
			this.x = 400;
			this.y = 300;
			this.scaleX = 0.2;
			this.scaleY = 0.2;
		}
		
	}

}