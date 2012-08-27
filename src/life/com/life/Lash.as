package life.com.life
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	import org.flixel.*;
	
	public class Lash extends FlxSprite
	{
		[Embed(source='../assets/Lash.png')]
		private var ImgLash:Class;
		
		private var timer:Number;
		private var launched:Boolean;
		
		public function Lash(X:Number, Y:Number, XVelocity:Number, YVelocity:Number)
		{
			loadGraphic(ImgLash, true, true, 8, 16);
			launched = false;
			//Basic movement speeds
			maxVelocity.x = 200;
			maxVelocity.y = 200;
			
			timer = 0;
			width = 5;
			height = 5;
			offset.x = 6;
			offset.y = 6;
			
			addAnimation("normal", [0, 1, 2, 3], 10, false);
			
			exists = false;
		}
		
		override public function update():void
		{
			super.update();
			if (launched)
			{
				timer -= FlxG.elapsed;
				if (timer <= 0)
					kill();
			}
		}
		
		public function hitBottom(Contact:FlxObject, Velocity:Number):void
		{
			kill();
			return; // super.hitBottom(Contact, Velocity);
		}
		
		public function hitLeft(Contact:FlxObject, Velocity:Number):void
		{
			kill();
			return; // super.hitLeft(Contact, Velocity);
		}
		
		public function hitRight(Contact:FlxObject, Velocity:Number):void
		{
			kill();
			return; // super.hitRight(Contact, Velocity);
		}
		
		public function hitTop(Contact:FlxObject, Velocity:Number):void
		{
			kill();
			return; // super.hitTop(Contact, Velocity);
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
		public function resetLash(X:Number, Y:Number, xVelocity:Number, yVelocity:Number, DIR:uint):void
		{
			x = X;
			y = Y;
			launched = true;
			exists = true;
			visible = true;
			timer = 0.5;
			play("normal"); //Play the animation
			if (DIR == RIGHT)
			{
				facing = RIGHT;
				x += 16;
			}
			else
				facing = LEFT;
		
		}
	}
}