package
{
	import flash.display.Stage;
	import flash.display.Sprite; //k
	import flash.geom.Point; //k
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hubbub
	 */
	public class PlayerCollectable extends Sprite
	{
		private var playerCollectable:Collectable = new Collectable();
		private var stageRef:Stage;
		private var rotationInRadians:Number = 0;
		private var loopOn:Boolean;
		private var dissapear:Boolean;
		private var timer:int;
		private var notCollected:Boolean = true;
		
		public function PlayerCollectable(stageRef:Stage, X:int, Y:int)
		{
			addChild(playerCollectable);
			this.stageRef = stageRef;
			this.x = X;
			this.y = Y;
			this.scaleX = 0.2;
			this.scaleY = 0.2;
			this.alpha = .8;
			addEventListener(Event.ENTER_FRAME, loop)
		}
		
		public function DestroyCollectable():void
		{
			this.notCollected = false;
			removeEventListener(Event.ENTER_FRAME, loop);
			removeChild(playerCollectable);
		}
		
		public function startLoop():void
		{
			this.loopOn = true;
		}
		
		private function loop(e:Event):void
		{
			timer++;
			if (timer >= 300)
			{
				dissapear = true;
				
			}
			if (dissapear)
			{
				this.alpha -= .08;
				this.scaleX -= .02;
				this.scaleY -= .02;
			}
			
			if (loopOn)
			{
				this.scaleX += .025;
				this.scaleY += .025;
				this.alpha -= .05;
			}
		}
		public function GetAlpha():Number
		{
			return this.alpha;
		}
	}
}