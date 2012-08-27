package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class HuntKitty extends FlxSprite
	{
		[Embed(source='../assets/cat_adult.png')]
		private var BabyPlayer:Class;
		
		static const WALKINGRIGHT:Number = 1;
		static const WALKINGLEFT:Number = 0;
		static const WAIT:Number = 2;
		static const ATTACK:Number = 3;
		static const END:Number = 4;
		static const ADULT:Number = 5;
		static const HUNT:Number = 6;
		private var _state:Number = WALKINGRIGHT;
		private var _age:Number = ADULT;
		private var _jump_power:int = 800;
		private var _initX:Number;
		private var _iddleTime:Number;
		private static const _maxIddle:Number = 5;
		private var _range:Number;
		private var _throw:Boolean = false;
		private var _lash:Lash;
		private var _lashes:Array;
		
		public function HuntKitty(X:Number, Y:Number, r:Number, lashes:Array)
		{
			super(X, Y);
			loadGraphic(BabyPlayer, true, true, 15, 13);
			maxVelocity.x = 45;
			velocity.y = 0;
			_range = r;
			_initX = X;
			
			_lashes = lashes;
			facing = RIGHT;
			_iddleTime = 0;
			acceleration.x = 120;
			
			//Friction
			drag.x = 300;
			//bounding box twe
			addAnimation("hunt_stopped", [18, 19, 20, 21], 8);
			addAnimation("hunt_normal", [18, 22, 23, 24], 8);
			addAnimation("normal", [0, 8, 9, 10], 8);
			addAnimation("stopped", [0, 1, 2, 3, 2, 1], 5);
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
			else if (_state == WALKINGRIGHT && x >= _initX + _range && !_throw)
			{
				throwLash();
				_throw = true;
			}
			else if (_state == WALKINGRIGHT && x >= _initX + _range)
			{
				velocity.x = 0;
				acceleration.x = 0;
				x = _initX + _range;
				facing = LEFT;
				_age = HUNT;
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
			{
				if (_age == HUNT)
					play("hunt_normal");
				else
					play("normal");
			}
			else
			{
				if (_age == HUNT)
					play("hunt_stopped");
				else
					play("stopped");
			}
		
		}
		
		private function throwLash():void
		{
			var XVelocity:Number;
			if (facing == RIGHT)
				XVelocity = 200;
			else
				XVelocity = -200;
			for (var i:uint = 0; i < _lashes.length; i++)
				if (!_lashes[i].exists)
				{
					if (facing == LEFT)
						_lashes[i].resetLash(x - 3, y + 2, XVelocity, 0, facing);
					else
						_lashes[i].resetLash(x + 3, y + 2, XVelocity, 0, facing);
					return;
				}
		
		}
	
	}

}