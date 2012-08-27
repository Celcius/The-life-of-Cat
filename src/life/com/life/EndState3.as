package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class EndState3 extends FlxState
	{
		
		override public function EndState3():void
		{
			var txt4:FlxText;
				
			txt4 = new FlxText(0, (FlxG.width / 2)-50, FlxG.width, "This cycle of survival of the fittest is what we call")
            txt4.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt4);
		}
		
		override public function update():void
        {
           FlxG.camera.flash(0xff000000, 8, on_fade_completed);
        }
		
		public function on_fade_completed():void
		{
			FlxG.switchState(new EndState4);
		}
		
	}

}