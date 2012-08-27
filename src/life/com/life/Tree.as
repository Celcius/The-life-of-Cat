package life.com.life 
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	import org.flixel.*;
	
	public class Tree extends FlxSprite
	{
		[Embed(source = '../assets/arvore.png')] private var tree:Class;
		
		public function Tree(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(tree);
		}
		
	}

}