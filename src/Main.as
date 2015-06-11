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
		private var playButton:StartButton = new StartButton();
		
		private var inButton:InstructionButton = new InstructionButton();
		private var crButton:CreditsButton = new CreditsButton();
		private var bButton:BackButton = new BackButton();
		private var mmButton:MainMenuButton = new MainMenuButton();
		
		private var menuBackground:Menubg = new Menubg();
		private var inBackground:Instruction_Page = new Instruction_Page();
		private var crBackground:Credit_Page = new Credit_Page();
		private var goBG:GameOverbg = new GameOverbg();
		
		private var gameOver:Boolean = false;
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
			crButton.addEventListener(MouseEvent.CLICK, crButtonClick);
			addEventListener(Event.ENTER_FRAME , loop);
		}
		
		private function crButtonClick(e:MouseEvent):void 
		{
			gotoCredits();
		}
		
		private function gotoCredits():void 
		{
			addChild(crBackground);
			addChild(bButton);
			bButton.x = 420;
			bButton.y = 500;
			bButton.addEventListener(MouseEvent.CLICK, crBButtonClick);
		}
		
		private function crBButtonClick(e:MouseEvent):void 
		{
			removeChild(crBackground);
			bButton.removeEventListener(MouseEvent.CLICK, crBButtonClick);
			removeChild(bButton);
			
		}
		
		private function inButtonClick(e:MouseEvent):void 
		{
			gotoInstructions();
		}
		
		private function gotoInstructions():void 
		{
			addChild(inBackground);
			addChild(bButton);
			bButton.x = 330;
			bButton.y = 520;
			bButton.scaleX = 0.8;
			bButton.scaleY = 0.8;
			bButton.addEventListener(MouseEvent.CLICK, bButtonClick);
		}
		
		private function bButtonClick(e:MouseEvent):void 
		{
			removeChild(inBackground);
			bButton.removeEventListener(MouseEvent.CLICK, bButtonClick);
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
			menuBackground.x = -55;
			menuBackground.y = -20;
			menuBackground.scaleX = 1.2;
			menuBackground.scaleY = 1.2;
			addChild(inButton);
			addChild(playButton);
			playButton.x = 400;
			playButton.y = 300;
			inButton.x = 400;
			inButton.y = 370;
			addChild(crButton);
			crButton.x = 400;
			crButton.y = 440;
		}
		
		private function loop(e:Event):void
		{
			//var shakeIt:int = game.
			if (game.isGameOver() == true && gameOver == false) {
				//trace("GAMEISOVER");
				gameOver = true;
				//trace(gameOver);
				//removeChild(game);
				addChild(menuBackground);
				menuBackground.x = -55;
				menuBackground.y = -20;
				menuBackground.scaleX = 1.2;
				menuBackground.scaleY = 1.2;
				addChild(goBG);
				goBG.x = 400;
				goBG.y = 350;
				addChild(mmButton);
				mmButton.x = 410;
				mmButton.y = 380;
				mmButton.scaleX = 0.9;
				mmButton.scaleY = 0.9;
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