package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class Rat extends FlxSprite
	{
		[Embed(source='../assets/rat.png')]
		private var RatImg:Class;
		
		private var _startY:Number;
		private var _startX:Number;
		private var _finalX:Number;
		private var _incrementY:Number;
		private var _incrementToFinalX:Number;
		private var _maxRange:Number;
		private static const maxTimer:Number = 5;
		private static const IDDLE:Number = 1;
		private static const MOVINGAWAY:Number = 2;
		private static const MOVINGBACK:Number = 3;
		private var _distance:Number;
		private var _iddleTime:Number;
		private var _state:Number = IDDLE;
		
		public function Rat(x:Number, y:Number, range:Number)
		{
			
			super(x, y);
			maxVelocity.x = 7;
			_startY = y;
			if (Math.random() < 0.5)
				facing = LEFT;
			else
				facing = RIGHT
			loadGraphic(RatImg, true, true, 8, 10);
			_startX = x;
			_maxRange = range;
			
			addAnimation("iddle", [0, 1, 2, 3], 2);
			addAnimation("moving", [4, 5, 6, 7], 3);
			width = 8;
			_iddleTime = Math.random() * maxTimer + 1;
		
		}
		
		override public function update():void
		{
			super.update();
			if (y > _startY)
				y = _startY;
			if (_state == IDDLE)
			{
				_iddleTime -= FlxG.elapsed;
			}
			else
			{
				velocity.x = maxVelocity.x * _incrementToFinalX;
			}
			
			if (_state == IDDLE && _iddleTime <= 0)
			{
				_iddleTime = 0;
				_state = MOVINGAWAY;
				if (facing == LEFT)
				{
					_finalX = _startX - _maxRange * Math.random();
					_incrementToFinalX = -1;
				}
				else
				{
					_finalX = _startX + _maxRange * Math.random();
					_incrementToFinalX = 1;
				}
			}
			else if (_state == MOVINGAWAY && (((x <= _finalX) && (_finalX <= _startX)) || ((x >= _finalX) && (_finalX >= _startX))))
			{
				_state = MOVINGBACK;
				velocity.x = 0;
				if (facing == LEFT)
				{
					facing = RIGHT;
					_incrementToFinalX = -1;
				}
				else
				{
					facing = LEFT;
					_incrementToFinalX = 1;
				}
			}
			else if (_state == MOVINGBACK && (x >= _startX - 1 || x <= _startX + 1))
			{
				_state = IDDLE;
				velocity.x = 0;
				_iddleTime = Math.random() * maxTimer + 1;
			}
			
			if (_state == MOVINGAWAY || _state == MOVINGBACK)
				play("moving");
			else
				play("iddle");
		}
	}

}