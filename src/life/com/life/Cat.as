package life.com.life
{
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	import org.flixel.*;
	
	public class Cat extends FlxSprite
	{
		[Embed(source='../assets/cat_adult.png')]
		private var AdultPlayer:Class;
		[Embed(source='../assets/cat_baby.png')]
		private var BabyPlayer:Class;
		[Embed(source='../assets/cat_child.png')]
		private var ChildPlayer:Class;
		[Embed(source='../assets/cat_old.png')]
		private var OldPlayer:Class;
		[Embed(source='../assets/sound/noisecollector__cat2_edited.mp3')]
		private var CatSound:Class;
		[Embed(source='../assets/sound/lorenzosu__grass-steps.mp3')]
		private var CatSteps:Class;
		[Embed(source='../assets/sound/inchadney__craw_edited.mp3')]
		private var BirdDeath:Class;
		[Embed(source='../assets/sound/gelo-papas__rusty-metal-squeak-goose_edited.mp3')]
		private var RatDeath:Class;
		
		public static const BABY:int = 1;
		public static const CHILD:int = 2;
		public static const TEEN:int = 3;
		public static const ADULT:int = 4;
		public static const HUNT = 5;
		public static const LOVE:int = 6;
		public static const OLD:int = 7;
		
		public static const SWITCH1:int = 560;
		public static const SWITCH2:int = 1140;
		public static const SWITCH3:int = 1460;
		public static const SWITCH5:int = 628;
		public static const SWITCH6:int = 500;
		
		private var _age:int;
		private var _max_health:int = 10;
		private var _hurt_counter:Number = 0;
		private var _move_speed:int = 400;
		private var _jump_power:int = 800;
		private var _can_jump:Boolean;
		private var _can_attack:Boolean;
		private var _lashes:Array;
		private var _attack_counter:Number = 0;
		private var _leftOffset:Number = 0;
		private var _rightOffset:Number = 0;
		private var _sparks:FlxEmitter;
		private var _SheCats:Array;
		private var _informed:Boolean = false;
		private var _loveCounter = 0;
		private var dead:Boolean = false;
		private var deathCounter = -1;
		
		public function Cat(X:Number, Y:Number, Lashes:Array, SheCats:Array):void
		{
			super(X, Y);
			_SheCats = SheCats;
			//Max speeds
			maxVelocity.x = 400;
			maxVelocity.y = 200;
			//Set the player health
			health = 10;
			//Gravity
			acceleration.y = 420;
			//Friction
			drag.x = 300;
			//bounding box tweaks
			width = 8;
			height = 14;
			
			_lashes = Lashes;
			
			addAnimation("normal", [0, 8, 9, 10], 8);
			addAnimation("jump", [5, 6, 7, 7, 7, 7,], 3);
			addAnimation("stopped", [0, 1, 2, 3, 2, 1], 5);
			addAnimation("attack", [12, 13, 14], 7);
			addAnimation("hurt", [10, 11], 8);
			
			addAnimation("dead", [7, 7, 7], 5);
			addAnimation("baby_normal", [4, 4, 5, 5, 6, 0], 8);
			addAnimation("baby_stopped", [0, 1, 2, 3, 2, 1], 5);
			addAnimation("baby_hurt", [6, 7], 8);
			addAnimation("old_normal", [8, 9, 10], 5);
			addAnimation("hunt_jump", [15, 16, 17], 3);
			addAnimation("hunt_stopped", [18, 19, 20, 21], 8);
			addAnimation("hunt_normal", [18, 22, 23, 24], 8);
			addAnimation("hunt_love", [25, 26, 27, 28], 3);
			addAnimation("death", [0, 1, 2, 3, 2, 1, 12, 13, 14, 15, 15, 15, 15, 15, 15], 3, false);
			turnBaby();
		
		}
		
		override public function update():void
		{
			
			super.update();
			
			if (!dead)
			{
				for (var i:Number = 0; i < _SheCats.length; i++)
				{
					var temp:SheCat = _SheCats[i];
					if (temp.changedPos(x, y) && _age != LOVE)
						turnLove();
				}
				
				if (_age != LOVE)
				{
					if (_hurt_counter > 0)
					{
						_hurt_counter -= FlxG.elapsed * 3;
					}
					if (_attack_counter > 0)
					{
						_attack_counter -= FlxG.elapsed * 3
					}
					if (FlxG.keys.LEFT && _hurt_counter <= 0)
					{
						facing = LEFT;
						velocity.x = -maxVelocity.x;
					}
					else if (FlxG.keys.RIGHT && _hurt_counter <= 0)
					{
						facing = RIGHT;
						velocity.x = maxVelocity.x;
					}
					if (FlxG.keys.justPressed("X") && velocity.y == 0 && _can_jump)
					{
						velocity.y = -_jump_power;
						
					}
					if (_can_attack && FlxG.keys.justPressed("C"))
					{
						
						_attack_counter = 1;
						throwLash(facing);
						FlxG.play(CatSound, 0.2, false, true);
					}
					if (_attack_counter > 0)
					{
						play("attack");
					}
					else if (_hurt_counter > 0)
					{
						if (_age == BABY)
						{
							play("baby_hurt");
						}
						else
						{
							play("hurt");
						}
					}
					else
					{
						if (velocity.y != 0)
						{
							if (_age == HUNT)
								play("hunt_jump");
							else
								play("jump");
						}
						else
						{
							if (velocity.x == 0)
							{
								if (_age == BABY)
									play("baby_stopped");
								else if (_age == HUNT)
									play("hunt_stopped");
								else
									play("stopped");
							}
							else
							{
								if (_age == BABY)
									play("baby_normal");
								else if (_age == OLD)
									play("old_normal");
								else if (_age == HUNT)
									play("hunt_normal");
								else
									play("normal");
								
								//	FlxG.play(CatSteps, 0.2, false, true);
							}
						}
					}
					if (_age == BABY && x > SWITCH1)
					{
						PlayState.changeState();
						
					}
					if (_age == CHILD && x > SWITCH2)
					{
						PlayState2.changeState();
					}
					else if (_age == TEEN && x > SWITCH3)
					{
						PlayState3.changeState();
					}
					else if (_age == OLD && x > SWITCH5)
					{
						play("death");
						dead = true;
						deathCounter = 5;
					}
					else if (_age == OLD && x > SWITCH6)
					{
						_can_jump = false;
					}
					
				}
				else
				{
					play("hunt_love");
					if (_loveCounter <= 0)
						PlayState4.changeState();
					else
						_loveCounter -= FlxG.elapsed * 5;
				}
			}
			if (dead && deathCounter <= 0)
			{
				PlayState5.changeState();
			}
			else
			{
				deathCounter -= FlxG.elapsed;
			}
		}
		
		override public function hurt(Damage:Number):void
		{
			_hurt_counter = 1;
			return super.hurt(Damage);
		}
		
		private function throwLash(dir:uint):void
		{
			var XVelocity:Number;
			if (dir == RIGHT)
				XVelocity = 200;
			else
				XVelocity = -200;
			for (var i:uint = 0; i < _lashes.length; i++)
				if (!_lashes[i].exists)
				{
					if (facing == LEFT)
						_lashes[i].resetLash(x - 3, y + 2, XVelocity, 0, dir);
					else
						_lashes[i].resetLash(x + 3, y + 2, XVelocity, 0, dir);
					return;
				}
		
		}
		
		public function informSheCats(type:Number)
		{
			if (!_informed)
			{
				for (var i:Number = 0; i < _SheCats.length; i++)
				{
					var temp:SheCat = _SheCats[i];
					temp.hunted(type)
				}
				_informed = true;
			}
		}
		
		public function turnBaby():void
		{
			loadGraphic(BabyPlayer, true, true, 9, 8);
			maxVelocity.x = 25;
			_jump_power = 30;
			_can_jump = false;
			_can_attack = false;
			_age = BABY;
		}
		
		public function turnChild():void
		{
			loadGraphic(ChildPlayer, true, true, 12, 12);
			maxVelocity.x = 45;
			_jump_power = 500;
			_can_jump = true;
			_can_attack = false;
			_age = CHILD;
		}
		
		public function turnTeen():void
		{
			loadGraphic(ChildPlayer, true, true, 12, 12);
			maxVelocity.x = 55;
			_jump_power = 500;
			_can_jump = true;
			_can_attack = true;
			_age = TEEN;
		}
		
		public function turnAdult():void
		{
			loadGraphic(AdultPlayer, true, true, 15, 13);
			maxVelocity.x = 80;
			_jump_power = 500;
			_can_jump = true;
			_can_attack = true;
			_age = ADULT;
		}
		
		public function turnHunt():void
		{
			loadGraphic(AdultPlayer, true, true, 15, 13);
			maxVelocity.x = 80;
			_jump_power = 500;
			_can_jump = true;
			_can_attack = false;
			_age = HUNT;
		}
		
		public function turnOld():void
		{
			loadGraphic(OldPlayer, true, true, 15, 12);
			maxVelocity.x = 15;
			_jump_power = 170;
			_can_jump = true;
			_can_attack = false;
			_age = OLD;
		}
		
		public function turnLove():void
		{
			loadGraphic(AdultPlayer, true, true, 15, 13);
			maxVelocity.x = 0;
			_jump_power = 0;
			_can_jump = false;
			_can_attack = false;
			_age = LOVE;
			_loveCounter = 3;
		}
		
		public function killedRat():void
		{
			FlxG.play(RatDeath, 0.2, false, true);
			if (_age == ADULT)
				turnHunt();
		}
		
		public function killedBird():void
		{
			FlxG.play(BirdDeath, 0.2, false, true);
			if (_age == ADULT)
				turnHunt();
		}
		
		public function jumpBack()
		{
			if (facing == LEFT)
				velocity.x = maxVelocity.x * 10;
			else
				velocity.x = -maxVelocity.x * 10;
		
		}
		
		public function isDead():Boolean
		{
			return dead;
		}
	}

}