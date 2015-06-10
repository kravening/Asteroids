package 
{
	import flash.display.Sprite;
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class GameOver extends Sprite
	{
		private var goBG:GameOverbg = new GameOverbg();
		private var mmButton:MainMenuButton = new MainMenuButton();
		private var paButton:PlayAgainButton = new PlayAgainButton();
		private var game:Game = new Game();
		
		public function GameOver() 
		{
			if (isGameOver)
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		
		private function init(e:Event):void 
		{
			trace("does it work?")
			removeChild(game);
			addChild(goBG);
			addChild(mmButton);
			addChild(paButton);
			mmButton.addEventListener(MouseEvent.CLICK, mmButtonClick);
			paButton.addEventListener(MouseEvent.CLICK, paButtonClick);
		}
		
		private function mmButtonClick(e:MouseEvent):void 
		{
			removeChild(goBG);
			removeChild(mmButton);
			removeChild(paButton);
		}
		
		private function paButtonClick(e:MouseEvent):void 
		{
			removeChild(goBG);
			removeChild(mmButton);
			removeChild(paButton);
			addChild(game);
		}
		
	}

}