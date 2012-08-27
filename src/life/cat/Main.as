package life.cat
{
	import org.flixel.*;
	import life.com.life.PlayState3;
	import life.com.life.MenuState;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")]
	[Frame(factoryClass = "Preloader")]
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class Main extends FlxGame
	{
		
		public function Main() 
		{
			super(320, 240, MenuState, 2);
			
		}
		
	}

}