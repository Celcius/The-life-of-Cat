package life.com.life
{
	import org.flixel.FlxSprite;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class SheCat extends FlxSprite implements CatListener
	{
		[Embed(source='../assets/she_cat_1.png')]
		private var SheCatImg1:Class;
		[Embed(source='../assets/she_cat_2.png')]
		private var SheCatImg2:Class;
		private const WAIT:Number = 0;
		private const QUEST:Number = 1;
		private const LOVE:Number = 2;
		private var _state:Number = 1;
		private var catNumber:Number;
		private var catHas:Number;
		private var fadeStartTime:Number = -1; //serving both as a flag and in calculations
		private var fadeTime:Number = 1000; //time in miliseconds that you want the fade to take
		
		public function SheCat(x:Number, y:Number, Img:Number)
		{
			super(x, y);
			if (Img == 1)
			{
				loadGraphic(SheCatImg1, true, true, 28, 39);
				facing = RIGHT;
			}
			else
			{
				loadGraphic(SheCatImg2, true, true, 28, 39);
				facing = RIGHT;
			}
			addAnimation("wait", [0, 1, 2, 3, 4], 5);
			addAnimation("quest", [10, 11, 12, 13, 14], 5);
			addAnimation("fuming", [15, 16, 17, 18, 19], 8);
			addAnimation("love", [5, 6, 7, 8, 9], 3);
			catNumber = Img;
			catHas = 0;
		}
		
		override public function update():void
		{
			if (fadeStartTime == -1)
			{
				if (_state == WAIT)
					play("wait");
				else if (_state == QUEST)
					play("quest");
				else if (_state == LOVE)
					play("love");
			}
			else
				play("fuming");
			//if (fadeStartTime > 0)
				//this.alpha = (getTimer() - fadeStartTime) / fadeTime;
		}
		
		public function changedPos(xPlayer:Number, yPlayer:Number):Boolean
		{
			if ((y >= yPlayer - 30 && y <= yPlayer + 30) && (xPlayer >= x - 20 && xPlayer <= x + 20) && catHas == catNumber)
			{
				_state = LOVE;
				return true;
			}
			if (xPlayer >= x - 50 && yPlayer >= y - 50 && yPlayer <= y + 50)
			{
				if (xPlayer < x)
				{
					facing = RIGHT;
					offset.x = -7;
				}
				else
				{
					facing = LEFT;
					offset.x = 7;
				}
			}
			return false;
		}
		
		public function hunted(Type:uint):void
		{
			catHas = Type;
			if (Type != catNumber)
				fadeStartTime = getTimer();
		}
	
	}

}