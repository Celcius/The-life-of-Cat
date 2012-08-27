package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class EndState2 extends FlxState
	{
		
		override public function EndState2():void
		{
			var txt2:FlxText;
			var txt3:FlxText;

			txt2 = new FlxText(0, (FlxG.width / 2)-100, FlxG.width, "He had little cubs who grew up big and strong ")
            txt2.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt2);
			
			txt3 = new FlxText(0, (FlxG.width / 2)-90, FlxG.width, "and they in turn had little cubs themselves.")
            txt3.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt3);
		}
		
		override public function update():void
        {
           FlxG.camera.flash(0xff000000, 9, on_fade_completed);	
        }
		
		public function on_fade_completed():void
		{
			FlxG.switchState(new EndState3);
		}
		
	}
	
}