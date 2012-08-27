package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class CreditsState extends FlxState
	{
		private var menuButton:FlxButton;
		private var musicButton:FlxButton;
		
		public function CreditsState() 
		{
			var txt1:FlxText;
			var txt2:FlxText;
			var txt3:FlxText;
			var txt4:FlxText;
			var txt5:FlxText;
			var txt6:FlxText;
			
			txt1 = new FlxText(0, 30, FlxG.width, "This game was made by:");
			txt1.setFormat(null, 16, 0xFF000000, "center");
            this.add(txt1);
		
			txt2 = new FlxText(0, (FlxG.width / 2)-90, FlxG.width, "Amoaeba Junior")
            txt2.setFormat(null, 16, 0xFF000000, "center");
			this.add(txt2);
			
			txt3 = new FlxText(0, (FlxG.width / 2)-50, FlxG.width, "Ivo Capelo")
            txt3.setFormat(null, 8, 0xFF000000, "center");
			this.add(txt3);
				
			txt4 = new FlxText(0, (FlxG.width / 2)-40, FlxG.width, "Sandra Lourenço")
            txt4.setFormat(null, 8, 0xFF000000, "center");
			this.add(txt4);
				
			txt5 = new FlxText(0, (FlxG.width / 2) - 10, FlxG.width, "Thanks for playing! :)");
            txt5.setFormat(null, 16, 0xFF000000, "center");
			this.add(txt5);

			txt6 = new FlxText(5, 220, FlxG.width, "Ludum Dare 24 - Jam - Evolution");
			txt6.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt6);
		}
		
		override public function create():void {
			FlxG.bgColor = 0xfffff8dc;
			FlxG.mouse.show();
			menuButton = new FlxButton(230, 210, "Back to Menu", menu);
			add(menuButton);
			musicButton = new FlxButton(230, 185, "More", music);
			add(musicButton);
		}
		
		private function menu():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new MenuState);
		}
		
		private function music():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new MusicCreditsState);
		}
		
	}

}