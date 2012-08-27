package life.com.life
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class Bird extends FlxSprite
	{
		[Embed(source='../assets/bird.png')]
		private var BirdImg:Class;
		
		private var _startX:Number;
		private var _startY:Number;
		private var _finalY:Number;
		private var _finalX:Number;
		private var _incrementY:Number;
		private var _incrementToFinalX:Number;
		private var _incrementToHalfX:Number;
		private static const HEIGHT:Number = 75 * Math.sqrt(2 / 3);
		private static const WIDTH:Number = 75;
		private static const GOINGFINALX:Number = 1;
		private static const GOINGFINALY:Number = 2;
		private static const GOINGBASE:Number = 3;
		private var _state:Number = GOINGFINALX;
		
		public function Bird(x:Number, y:Number, left:Boolean)
		{
			
			super(x, y);
			maxVelocity.x = 25;
			maxVelocity.y = 40;
			loadGraphic(BirdImg, true, true, 16, 16);
			_startX = x;
			_startY = y
			_finalY = y + HEIGHT;
			
			if (left)
			{
				_finalX = x - WIDTH;
				facing = LEFT;
			}
			else
			{
				_finalX = x + WIDTH;
				facing = RIGHT;
			}
			
			_incrementToFinalX = (_finalX - _startX) / 10;
			_incrementToHalfX = (_startX - _finalX) / 2 / 10
			_incrementY = (_finalY - _startY) / 10;
			addAnimation("flying", [0, 1, 2], 3);
			addAnimation("descending", [0], 15);
		
		}
		
		override public function update():void
		{
			super.update();
			
			if (_state == GOINGFINALX)
			{
				velocity.x += _incrementToFinalX;
			}
			else if (_state == GOINGFINALY)
			{
				velocity.x += _incrementToHalfX;
				velocity.y += _incrementY;
			}
			if (_state == GOINGBASE)
			{
				velocity.x += _incrementToHalfX;
				velocity.y -= _incrementY;
			}
			
			if (_state == GOINGFINALX && ((_finalX < _startX && x <= _finalX) || (_finalX > _startX && x >= _finalX)))
			{
				_state = GOINGFINALY;
				velocity.x = 0;
				if (facing == LEFT)
					facing = RIGHT;
				else
					facing = LEFT;
				
			}
			else if (_state == GOINGFINALY && y >= _finalY)
			{
				velocity.y = 0;
				velocity.x = 0;
				
				_state = GOINGBASE;
			}
			if (_state == GOINGBASE && y <= _startY)
			{
				velocity.x = 0;
				velocity.y = 0;
				
				_state = GOINGFINALX;
				if (facing == LEFT)
					facing = RIGHT;
				else
					facing = LEFT;
			}
			
			if (_state == GOINGFINALX || _state == GOINGBASE)
				play("flying");
			else
				play("descending");
		}
	}

}