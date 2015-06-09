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
		
		public function Main()
		{
			stage.color = 0x000000;
			stage.frameRate = 60;
			addEventListener(Event.ADDED_TO_STAGE, init);

		}
		
		private function init(e:Event):void {
			addChild(menuBackground);
			addButton();
			playButton.addEventListener(MouseEvent.CLICK, playButtonClick);
			inButton.addEventListener(MouseEvent.CLICK, inButtonClick);
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
		}
		
		private function addButton():void {
			
			addChild(inButton);
			addChild(playButton);
			playButton.x = 200;
			playButton.y = 300;
			inButton.x = 600;
			inButton.y = 300;
		}
	}
}