package
{
	import flash.display.Sprite;
	import flash.events.Event;	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.net.*;
	/**
	 * ...
	 * @author Benjamin
	 */
	public class Main extends Sprite
	{
		private var game:Game = new Game();
		private var playButton:PlayButton = new PlayButton();
		private var menuBackground:Menubg = new Menubg();
		private var inButton:InstructionButton = new InstructionButton();
		//private var crButton:CreditButton = new CreditButton();
		private var bButton:BackButton = new BackButton();
		private var inBackground:Instruction_Page = new Instruction_Page();
		private var crBackground:Credit_Page = new Credit_Page();
		private var gameOver:Boolean = false;
		private var goBG:GameOverbg = new GameOverbg();
		private var mmButton:MainMenuButton = new MainMenuButton();
		private var shakeLength:int = 30;
		
		public function Main()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init);

		}
		
		private function init(e:Event):void {
			inBackground.x = -35;
			stage.color = 0x000000;
			stage.frameRate = 60;
			addButtons();
			playButton.addEventListener(MouseEvent.CLICK, playButtonClick);
			inButton.addEventListener(MouseEvent.CLICK, inButtonClick);
			addEventListener(Event.ENTER_FRAME , loop);
		}
		
		private function inButtonClick(e:MouseEvent):void 
		{
			gotoInstructions();
		}
		
		private function gotoInstructions():void 
		{
			addChild(inBackground);
			addChild(bButton);
			bButton.x = 400;
			bButton.y = 400;
			bButton.addEventListener(MouseEvent.CLICK, bButtonClick);
		}
		
		private function bButtonClick(e:MouseEvent):void 
		{
			removeChild(inBackground);
			removeChild(bButton);
		}
		
		private function playButtonClick(e:MouseEvent):void {
			removeChild(menuBackground);
			removeChild(inButton);
			removeChild(playButton);
			addChild(game);
			gameOver = false;
		}
		
		private function addButtons():void {
			
			addChild(menuBackground);
			addChild(inButton);
			addChild(playButton);
			playButton.x = 200;
			playButton.y = 300;
			inButton.x = 600;
			inButton.y = 300;
		}
		
		private function loop(e:Event):void
		{
			//var shakeIt:int = game.
			if (game.isGameOver() == true && gameOver == false) {
				//trace("GAMEISOVER");
				gameOver = true;
				//trace(gameOver);
				//removeChild(game);
				addChild(goBG);
				addChild(mmButton);
				mmButton.x = 290;
				mmButton.y = 250;
				mmButton.addEventListener(MouseEvent.CLICK, init);
				mmButton.addEventListener(MouseEvent.CLICK, mmButtonClick);
				game.isPlayerOrBaseDead = false;
			}
			if (game.canHazShake() >= 0) {
				game.x = (Math.random() * game.shakeItBaby) - game.shakeItBaby / 2;
				game.y = (Math.random() * game.shakeItBaby) - game.shakeItBaby / 2;
			}else {
				game.x = 0;
				game.y = 0;
			}
		}
		
		private function mmButtonClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(stage.loaderInfo.url), "_level0");
		}
	}
}