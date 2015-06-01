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
		private var base:BaseObject = new BaseObject();
		public function Base() 
		{
			addChild(base);
			this.x = 400;
			this.y = 300;
			this.scaleX = 0.3;
			this.scaleY = 0.3;
		}
		
	}

}