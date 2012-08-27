package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class WalkingKitty extends FlxSprite
	{
		[Embed(source='../assets/cat_baby.png')]
		private var BabyPlayer:Class;
		
		static const WALKINGRIGHT:Number = 1;
		static const WALKINGLEFT:Number = 0;
		static const WAIT:Number = 2;
		static const END:Number = 3;
		private var _state:Number = WALKINGRIGHT;
		private var _jump_power:int = 800;
		private var _initX:Number;
		private var _iddleTime:Number;
		private static const _maxIddle:Number = 5;
		private var _range:Number;
		
		public function WalkingKitty(X:Number, Y:Number, r:Number)
		{
			super(X, Y);
			loadGraphic(BabyPlayer, true, true, 9, 8);
			maxVelocity.x = 10;
			velocity.y = 0;
			_range = r;
			_initX = X;
			addAnimation("normal", [0, 4, 5, 6], 5);
			addAnimation("stopped", [0, 1, 2, 3], 5);
			facing = RIGHT;
			_iddleTime = 0;
			acceleration.x = 120;
			//Friction
			drag.x = 300;
			//bounding box twe
		
		}
		
		override public function update():void
		{
			super.update();
			
			if (_state == WALKINGLEFT && velocity.y == 0)
			{
				velocity.x = -maxVelocity.x;
				acceleration.x = -420;
			}
			else if (_state == WALKINGRIGHT && velocity.y == 0)
			{
				velocity.x = maxVelocity.x;
				acceleration.x = 420;
			}
			
			if (_state == WALKINGLEFT && x <= _initX)
			{
				velocity.x = 0;
				acceleration.x = 0;
				x = _initX - 1;
				facing = RIGHT;
				_state = END;
			}
			else if (_state == WALKINGRIGHT && x >= _initX + _range)
			{
				velocity.x = 0;
				acceleration.x = 0;
				x = _initX + _range;
				facing = LEFT;
				_state = WAIT;
				_iddleTime = _maxIddle;
			}
			else if (_state == WAIT)
			{
				_iddleTime -= FlxG.elapsed * 3;
			}
			if (_state == WAIT && _iddleTime <= 0)
			{
				_state = WALKINGLEFT;
				_iddleTime == 0;
			}
			
			if ((_state == WALKINGLEFT || _state == WALKINGRIGHT))
				play("normal");
			else
				play("stopped");
		
		}
	
	}

}