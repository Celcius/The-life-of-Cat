package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class JumpingKitty extends FlxSprite
	{
		[Embed(source='../assets/cat_child.png')]
		private var ChildPlayer:Class;
		private static const JUMPLEFT:Number = 0;
		private static const JUMPRIGHT:Number = 1;
		private static const WAIT:Number = 2;
		private var _state:Number = JUMPLEFT;
		private var _jump_power:int = 800;
		private var _initY:Number;
		private var _iddleTime:Number;
		private static const _maxIddle:Number = 5;
		
		public function JumpingKitty(X:Number, Y:Number)
		{
			super(X, Y - 1);
			loadGraphic(ChildPlayer, true, true, 12, 12);
			maxVelocity.x = 45;
			maxVelocity.y = 200;
			_initY = Y;
			_jump_power = 500;
			addAnimation("jump", [5, 6, 7, 7, 7, 7,], 3);
			addAnimation("stopped", [0, 1, 2, 3, 2, 1], 5);
			facing = LEFT;
			_iddleTime = 0;
			acceleration.y = 420;
			acceleration.x = 420;
			//Friction
			drag.x = 300;
			//bounding box twe
		
		}
		
		override public function update():void
		{
			
			if (_state == JUMPLEFT && velocity.y == 0)
			{
				velocity.x = -maxVelocity.x;
				velocity.y = -_jump_power;
				acceleration.y = 420;
				acceleration.x = -420;
			}
			else if (_state == JUMPRIGHT && velocity.y == 0)
			{
				velocity.x = maxVelocity.x;
				velocity.y = -_jump_power;
				acceleration.y = 420;
				acceleration.x = 420;
			}
			
			if ((_state == JUMPLEFT || _state == JUMPRIGHT) && y >= _initY)
			{
				velocity.x = 0;
				velocity.y = 0;
				acceleration.y = 0;
				acceleration.x = 0;
				y = _initY - 1;
				
				if (_state == JUMPLEFT)
					facing = RIGHT;
				else
					facing = LEFT;
				_iddleTime = _maxIddle;
				_state = WAIT;
			}
			else if (_state == WAIT)
			{
				_iddleTime -= FlxG.elapsed * 3;
			}
			
			if (_state == WAIT && _iddleTime < 0)
			{
				if (facing == LEFT)
					_state = JUMPLEFT;
				else
					_state = JUMPRIGHT;
				_iddleTime = 0;
				
			}
			if ((_state == JUMPLEFT || _state == JUMPRIGHT))
				play("jump");
			else
				play("stopped");
		
		}
	
	}

}