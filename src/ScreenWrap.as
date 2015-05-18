package  
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author hubbub
	 */
	public class ScreenWrap extends MovieClip
	{
		
		public function ScreenWrap() 
		{		
				if ((this.x) < 0 - (this.height /2)) {
					this.x = stage.stageWidth + this.height/2;
					}
				if ((this.x) > (stage.stageWidth + this.height / 2)) {
						this.x = this.height/2;
					}
				if ((this.y) < 0 - (this.height / 2)) {
						this.y = stage.stageHeight + this.height/2;
					}
				if ((this.y) > (stage.stageHeight + this.height / 2)) {
						this.y = -this.height / 2;
					}
				}
		}
		
	}