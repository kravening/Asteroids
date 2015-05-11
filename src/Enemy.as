package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Enemy extends EnemyCube
	{
		private var base1:MovieClip = new Base;
		private var baseX:int = base1.x - 46;
		private var baseY:int = base1.y - 46;
		private var dX:int;
		private var dY:int;
		private var isX:Boolean;
		private var move:Number;
		private var spawnPos:Number;
		private var spawnSwitch:Number;
		public function Enemy() 
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			spawnPos = Math.random() * 1;
			spawnSwitch = Math.random() * 1;
			if (spawnSwitch <= 0.5) {
				
			
				if (spawnPos <= 0.5) { // top or bottom
					this.x = Math.random() * 800 -50;
					this.y = Math.random() * 10 - 100;
					
				}else {
					this.x = Math.random() * 800 -50;
					this.y = Math.random() * 10 + 600;
				}
				
			}else {
				
				if (spawnPos <= 0.5) { //left or right
					this.x = Math.random() * 0 -50;
					this.y = Math.random() * 600 - 50;
					
				}else {
					this.x = Math.random() * 10 +800;
					this.y = Math.random() * 600 - 50;
					
				}
			}
			this.scaleX = 0.3;
			this.scaleY = 0.3;
			this.dX = this.x - baseX;
			this.dY = this.y - baseY;
			if (Math.abs(this.dX) < Math.abs(this.dY))
			{
				isX = true;
				move = Math.abs(this.dY) / Math.abs(this.dX);
			}
			else
			{
				isX = false;
				move = Math.abs(this.dX) / Math.abs(this.dY);
			}
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{	
			if (this.x < baseX + 1 && this.x > baseX - 1)
			{
				
			}
			else
			{
				if (isX)
				{
					if (this.dX <= 0)
					{
						this.x += 1;
					}
					else
					{
						this.x -= 1;
					}
					if (this.dY <= 0)
					{
						this.y += move;
					}
					else
					{
						this.y -= move;
					}
				}
				else
				{
					if (this.dY <= 0)
					{
						this.y += 1;
					}
					else
					{
						this.y -= 1;
					}
					if (this.dX <= 0)
					{
						this.x += move;
					}
					else
					{
						this.x -= move;
					}
				}
			}
		}
		
	}

}