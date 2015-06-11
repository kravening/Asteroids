package
{
	import flash.automation.ActionGenerator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.ui.KeyLocation;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Player extends Sprite //extends character class
	{
		private var player1:Player_Body = new Player_Body;
		
		private var maxSpeed:int = 7;
		private var acceleration:Number = .5;
		private var rotationSpeed:int = 8;
		private var friction:Number = .85;
		private var bulletSpeed:int = 16;
		private var knockbackAmount:Number = .5;
		private var _health:int = 3;
		private var velocity:Point = new Point();
		private var upKey:Boolean = false;
		private var downKey:Boolean = false;
		private var leftKey:Boolean = false;
		private var rightKey:Boolean = false;
		private var playerIsMoving:Boolean = false;
		
		private var initMaxSpeed:int;
		private var initRotationSpeed:int;
		private var initFriction:Number;
		private var normalizedFriction:Number;
		private var shoots:Boolean = false;
		private var checkIfArtExists:Array = [];
		
		private var brake:Boolean = false;
		
		public var isGameOver:Boolean = false;
		
		public function Player()
		{
			checkIfArtExists.push(player1);
			addChild(checkIfArtExists[0]);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			this.x = 300;
			this.y = 300;
			this.scaleX = 0.1;
			this.scaleY = 0.1;
			this.alpha = 1;
		
		}
		
		private function init(e:Event):void
		{
			initMaxSpeed = maxSpeed;
			initRotationSpeed = rotationSpeed;
			initFriction = friction;
			
			stage.addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
		
		private function loop(e:Event):void //main loop
		{
			if(checkIfArtExists[0] != null){
				if (friction >= .95)
				{
					friction = .94;
				}
				
				if ((this.x) < 0 - (this.height / 2))
				{
					this.x = stage.stageWidth + this.height / 2;
				}
				if ((this.x) > (stage.stageWidth + this.height / 2))
				{
					this.x = -this.height / 2;
				}
				if ((this.y) < 0 - (this.height / 2))
				{
					this.y = stage.stageHeight + this.height / 2;
				}
				if ((this.y) > (stage.stageHeight + this.height / 2))
				{
					this.y = -this.height / 2;
				}
				if (upKey)
				{
					playerIsMoving = true;
					brake = false;
					velocity.y += acceleration * Math.sin(this.rotation / 180 * Math.PI);
					velocity.x += acceleration * Math.cos(this.rotation / 180 * Math.PI);
				}
				else if (downKey)
				{
					playerIsMoving = true;
					brake = false;
					velocity.y += -(acceleration * Math.sin(this.rotation / 180 * Math.PI));
					velocity.x += -(acceleration * Math.cos(this.rotation / 180 * Math.PI));
				}
				else
				{
					brake = true;
					playerIsMoving = false;
					
				}
				if (brake)
				{
					velocity.x *= friction;
					velocity.y *= friction;
				}
				
				if (rightKey)
				{
					this.rotation += rotationSpeed;
				}
				
				if (leftKey)
				{
					this.rotation -= rotationSpeed;
				}
				
				this.x += velocity.x;
				this.y += velocity.y;
				var getCurrSpd:Number = Math.sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y));
				
				if (getCurrSpd > maxSpeed)
				{
					velocity.y *= (maxSpeed / getCurrSpd);
					velocity.x *= (maxSpeed / getCurrSpd);
				}
			}
		}
		
		public function knockBack():void
		{
			this.velocity.y += -(knockbackAmount * Math.sin(this.rotation / 180 * Math.PI));
			this.velocity.x += -(knockbackAmount * Math.cos(this.rotation / 180 * Math.PI));
		}
		public function playerMoves():Boolean {
			return playerIsMoving;
		}
		private function keyDown(e:KeyboardEvent):void
		{
			
			if (e.keyCode == Keyboard.U)
			{ //normal
				rotationSpeed = initRotationSpeed;
				maxSpeed = initMaxSpeed;
				friction = initFriction;
				knockbackAmount = .5;
				normalizedFriction = friction;
			}
			if (e.keyCode == Keyboard.I)
			{ //shotgun
				rotationSpeed = initRotationSpeed * .75;
				maxSpeed = initMaxSpeed * 1.2;
				friction = initFriction * 1.2;
				knockbackAmount = 3;
				normalizedFriction = friction;
			}
			if (e.keyCode == Keyboard.O)
			{ // rapidfire
				rotationSpeed = initRotationSpeed * .5;
				maxSpeed = initMaxSpeed;
				friction = initFriction;
				knockbackAmount = .25;
				normalizedFriction = friction;
			}
			
			if (e.keyCode == Keyboard.A)
			{
				leftKey = true;
			}
			if (e.keyCode == Keyboard.W)
			{
				upKey = true;
			}
			if (e.keyCode == Keyboard.D)
			{
				rightKey = true;
			}
			
			if (e.keyCode == Keyboard.S)
			{
				downKey = true;
			}
		
		}
		
		private function keyUp(e:KeyboardEvent):void
		{
			
			if (e.keyCode == Keyboard.A)
			{
				leftKey = false;
			}
			if (e.keyCode == Keyboard.W)
			{
				upKey = false;
			}
			if (e.keyCode == Keyboard.D)
			{
				rightKey = false;
			}
			if (e.keyCode == Keyboard.S)
			{
				downKey = false;
			}
		
		}
		
		public function Destroy():void {
			stage.removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
			removeChild(player1);
			checkIfArtExists.splice(0, 1);
			
			
		}
		
		public function Playerhit():void {
			this._health--;
		}
		
		public function PlayerHealth():int {
			return _health;
		}
	
	}

}