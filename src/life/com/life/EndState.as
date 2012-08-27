package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class EndState extends FlxState
	{
		
		override public function EndState():void
		{
			var txt1:FlxText;

			txt1 = new FlxText(0, 20, FlxG.width, "Cat lived a long life.");
			txt1.setFormat(null, 16, 0xFFFFFFFF, "center");
            this.add(txt1);
		}
		
		override public function create():void {
			FlxG.bgColor = 0xff000000;
		}
		
		override public function update():void
        {
           FlxG.camera.flash(0xff000000, 6, on_fade_completed);
		}
		
		public function on_fade_completed():void
		{
			FlxG.switchState(new EndState2);
		}
		
	}

}