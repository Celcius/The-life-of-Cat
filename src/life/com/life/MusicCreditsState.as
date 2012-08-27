package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class MusicCreditsState extends FlxState
	{
		private var menuButton:FlxButton;
		
		public function MusicCreditsState() 
		{
			var txt1:FlxText;
			var txt2:FlxText;
			var txt3:FlxText;
			var txt4:FlxText;
			var txt5:FlxText;
			var txt6:FlxText;
			var txt7:FlxText;
			var txt8:FlxText;
			var txt9:FlxText;
			var txt10:FlxText;
			var txt11:FlxText;
			var txt12:FlxText;
			var txt13:FlxText;
			var txt14:FlxText;
			
			txt1 = new FlxText(5, 220, FlxG.width, "Ludum Dare 24 - Jam - Evolution");
			txt1.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt1);
			
			txt2 = new FlxText(5, 10, FlxG.width, "Music by Brioskj");
			txt2.setFormat(null, 16, 0xFF000000, "left");
			this.add(txt2);
			
			txt3 = new FlxText(5, 30, FlxG.width, "Album: Escape From The City");
			txt3.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt3);
			
			txt4 = new FlxText(5, 50, FlxG.width, "Tracks:");
			txt4.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt4);
			
			txt5 = new FlxText(5, 60, FlxG.width, "Landing On Kahvi Planet");
			txt5.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt5);
			
			txt6 = new FlxText(5, 70, FlxG.width, "Escape From The City");
			txt6.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt6);
			
			txt7 = new FlxText(5, 80, FlxG.width, "Trip To Camargue");
			txt7.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt7);
			
			txt8 = new FlxText(5, 90, FlxG.width, "Souls");
			txt8.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt8);
			
			txt9 = new FlxText(5, 100, FlxG.width, "Mysterious Wood");
			txt9.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt9);
			
			txt10 = new FlxText(5, 130, FlxG.width, "Sounds taken from");
			txt10.setFormat(null, 16, 0xFF000000, "left");
			this.add(txt10);
			
			txt14 = new FlxText(5, 150, FlxG.width, "http://www.freesound.org/");
			txt14.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt14);
			
			txt11 = new FlxText(5, 170, FlxG.width, "gelo-papas - rusty metal squeak goose");
			txt11.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt11);
			
			txt12 = new FlxText(5, 180, FlxG.width, "noisecollector - cat2");
			txt12.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt12);
			
			txt13 = new FlxText(5, 190, FlxG.width, "inchadney - craw");
			txt13.setFormat(null, 8, 0xFF000000, "left");
			this.add(txt13);
		}
		
		override public function create():void {
			FlxG.bgColor = 0xfffff8dc;
			FlxG.mouse.show();
			menuButton = new FlxButton(230, 210, "Back to Menu", menu);
			add(menuButton);
		}
		
		private function menu():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new MenuState);
		}
		
	}

}