package life.com.life 
{
	/**
	 * ...
	 * @author Sandra
	 */
	import org.flixel.*;
	public class EndState5 extends FlxState
	{
		private var creditsButton:FlxButton;
		public function EndState5() 
		{
			var txt1:FlxText;
			var txt2:FlxText;
			var txt3:FlxText;
			var txt4:FlxText;
			var txt5:FlxText;
			var txtfinal:FlxText;
			var tree:Tree;
		
			txt1 = new FlxText(0, 20, FlxG.width, "Cat lived a long life.");
			txt1.setFormat(null, 16, 0xFFFFFFFF, "center");
            this.add(txt1);
		
			txt2 = new FlxText(0, (FlxG.width / 2)-100, FlxG.width, "He had little cubs who grew up big and strong ")
            txt2.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt2);
			
			txt3 = new FlxText(0, (FlxG.width / 2)-90, FlxG.width, "and they in turn had little cubs themselves.")
            txt3.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt3);
				
			txt4 = new FlxText(0, (FlxG.width / 2)-50, FlxG.width, "This cycle of survival of the fittest is what we call")
            txt4.setFormat(null, 8, 0xFFFFFFFF, "center");
			this.add(txt4);
				
			txt5 = new FlxText(0, (FlxG.width / 2) - 30, FlxG.width, "EVOLUTION.");
            txt5.setFormat(null, 16, 0xFFFFFFFF, "center");
			this.add(txt5);

			tree = new Tree(143, 160);
			this.add(tree);
			
			txtfinal = new FlxText(5, 215, FlxG.width, "Press X to go to the Menu");
			txtfinal.setFormat(null, 8, 0xFFFFFFFF, "left");
			this.add(txtfinal);
		}
		
		override public function create():void {
			FlxG.mouse.show();
			creditsButton = new FlxButton(230, 210, "Credits", credits);
			add(creditsButton);
		}
		
		private function credits():void
		{
			FlxG.mouse.hide();
			FlxG.switchState(new CreditsState);
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
            FlxG.switchState(new MenuState);
        }
		
	}

}