package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author hubbub
	 */
	public class Bullet extends PlayerBullet
	{
		private var moveX:Number = 0;
		private var moveY:Number = 0;
		private var speed:Number = 15;
		
		public function createBullet(r:Number, tPos:Point) 
		{
			//super();
			addChild(new PlayerBullet());
			
			this.rotation = r;
			var radian:Number = r * Math.PI / 180;
			moveX = Math.cos(radian);
			moveY = Math.sin(radian);
			
			this.x += tPos.x + (66 * moveX);
			this.y += tPos.y + (66 * moveY);
			
		}
		public function update():void
		{
			this.x += moveX * speed;
			this.y += moveY * speed;
		}
		
	}

}