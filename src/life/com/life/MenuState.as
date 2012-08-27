package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source='../assets/sound/kahvi198a_brioskj-landing_on_kahvi_planet.mp3')]
		private var TitleMusic:Class;
		private var creditsButton:FlxButton;

		override public function MenuState():void 
		{
			
			var txt1:FlxText;
			var txt2:FlxText;
			var menuCat:WalkingKitty;
			
			txt1 = new FlxText(0, 30, FlxG.width, "The life of Cat");
			txt1.setFormat(null, 16, 0xFF000000, "center");
            this.add(txt1);
			
			txt2 = new FlxText(0, (FlxG.width / 2)-50, FlxG.width, "Press X to play")
            txt2.setFormat(null, 8, 0xFF000000, "center");
            this.add(txt2);
			
			menuCat = new WalkingKitty(25, 190, 240);
			this.add(menuCat);
			
		}
		
		override public function create():void {
			FlxG.bgColor = 0xfffff8dc;
			FlxG.mouse.show();
			creditsButton = new FlxButton(230, 210, "Credits", credits);
			add(creditsButton);		
			FlxG.playMusic(TitleMusic,0.7);
			
		}
		
		override public function update():void
        {
            if (FlxG.keys.pressed("X"))
            {
                FlxG.camera.flash(0xffffffff, 0.75);
                FlxG.camera.fade(0xff000000, 1, onFade);
            }
        
            super.update();
	
        }
        
        private function onFade():void
        {
			FlxG.mouse.hide();
            FlxG.switchState(new PlayState);
		
		
        }
		
		private function credits():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new CreditsState);
			
			
		}
		
	}

}