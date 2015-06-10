package
{
	import flash.display.Sprite;
	import flash.events.Event;	
	import flash.events.MouseEvent;
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
		private var bButton:BackButton = new BackButton();
		private var inBackground:Instructionbg = new Instructionbg();
		private var ayy:Boolean = false;
		private var goBG:GameOverbg = new GameOverbg();
		private var mmButton:MainMenuButton = new MainMenuButton();
		private var paButton:PlayAgainButton = new PlayAgainButton();
		
		public function Main()
		{
			stage.color = 0x000000;
			stage.frameRate = 60;
			addEventListener(Event.ADDED_TO_STAGE, init);

		}
		
		private function init(e:Event):void {
			
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
			ayy = false;
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
			/*if (game.isGameOver() == true && ayy == false) {
				trace("GAMEISOVER");
				ayy = true;
				removeChild(game);
				addChild(goBG);
				addChild(mmButton);
				addChild(paButton);
				mmButton.addEventListener(MouseEvent.CLICK, mmButtonClick);
				paButton.addEventListener(MouseEvent.CLICK, paButtonClick);
				
			}*/
		}
		
		private function mmButtonClick(e:MouseEvent):void 
		{
			addButtons();
		}
		
		private function paButtonClick(e:MouseEvent):void 
		{
			addChild(game);
		}
	}
}