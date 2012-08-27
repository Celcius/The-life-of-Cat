package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class EndState4 extends FlxState
	{
		
		override public function EndState4():void
		{
			var txt5:FlxText;
				
			txt5 = new FlxText(0, (FlxG.width / 2)-30, FlxG.width, "EVOLUTION.")
            txt5.setFormat(null, 16, 0xFFFFFFFF, "center");
			this.add(txt5);
		}
		
		override public function update():void
        {
           FlxG.camera.flash(0xff000000, 6,on_fade_completed);
        }
		
		public function on_fade_completed():void
		{
			FlxG.switchState(new EndState5);
		}
			
	}

}