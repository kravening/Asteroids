package 
{
	import flash.display.MovieClip;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Enemy extends Sprite
	{
		private var base1:Base = new Base;
		
		private var baseX:int = base1.x - 30;
		private var baseY:int = base1.y - 30;
		private var dX:int;
		private var dY:int;
		private var health:int = 20;
		private var isX:Boolean;
		private var randomNumGen:int;
		private var top:Boolean;
		private var bot:Boolean;
		private var left:Boolean;
		private var right:Boolean;
		private var enemy:Enemy_Body = new Enemy_Body();
		
		private var move:Number;
		private var spawnPos:Number;
		private var spawnSwitch:Number;
		private var moveSpeed:Number = 1;
		
		public function Enemy() 
		{
			addChild(enemy);
			addEventListener(Event.ADDED_TO_STAGE, init);
			spawnPos = Math.random() * 1;
			spawnSwitch = Math.random() * 1;
			if (spawnSwitch <= 0.5) {
				
			
				if (spawnPos <= 0.5) { // top or bottom
					this.x = Math.random() * 800 -50; //top
					this.y = Math.random() * 10 - 100;
					this.rotation = 90;
					
					top = true;
					bot = false;
					left = false;
					right = false;
					
				}else {
					this.x = Math.random() * 800 -50; //bottom
					this.y = Math.random() * 10 + 600;
					this.rotation = 270;
					
					top = false;
					bot = true;
					left = false;
					right = false;
				}
				
			}else {
				
				if (spawnPos <= 0.5) { //left or right
					this.x = Math.random() * -1 -this.width; //left
					this.y = Math.random() * 600 - 50;
					
					top = false;
					bot = false;
					left = true;
					right = false;
				}else {
					this.x = Math.random() * 10 + 800; //right
					this.y = Math.random() * 600 - 50;
					this.rotation = 180;
					
					top = false;
					bot = false;
					left = false;
					right = true;
				}
			}
			
			this.scaleX = 0.2;
			this.scaleY = 0.2;
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
			if (move >= 1)
			{
				move = move / 2;
				moveSpeed = moveSpeed / 2;
			}
			
			
			//if (this.x < baseX + 1 && this.x > baseX - 1 && this.y < baseY + 1 && this.y > baseY - 1)
			//{
				
			//}
			else
			{
				if (isX)
				{
					if (this.dX <= 0)
					{
						this.x += moveSpeed;
					}
					else
					{
						this.x -= moveSpeed;
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
						this.y += moveSpeed;
					}
					else
					{
						this.y -= moveSpeed;
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
		public function BulletHit():void {
			health--;
			
			if(top){
				this.y -= 2;
			}
			
			if (bot) {
				this.y += 2;
			}
			
			if (left) {
				this.x -= 2;
			}
			
			if (right) {
				this.x += 2;
			}
			if (health < 0) {
				Destroy();
			}
		}
		public function Destroy():void {
				removeChild(enemy);
		}
		
	}

}