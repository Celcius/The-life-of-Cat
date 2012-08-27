package life.com.life
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class PlayState extends FlxState
	{
		[Embed(source='../assets/Tiles.png')]
		private var ImgTiles:Class;
		[Embed(source='../assets/Map1.csv',mimeType="application/octet-stream")]
		public var mapString:Class;
		
		
		private var _player:Cat;
		private var _sheCat1:SheCat;
		private var _sheCat2:SheCat;
		private var _walkKitty:WalkingKitty;
		private var _jumpKitty:JumpingKitty;
		private var _huntKitty:HuntKitty;
		private var _map:FlxTilemap;
		
		private var _text1:FlxText;
		private var _text2:FlxText;
		private var _text3:FlxText;
		
		public static var lyrStage:FlxGroup;
		public static var lyrSprites:FlxGroup;
		public static var lyrHUD:FlxGroup;
		
		private var _pLashes:Array;
		private var _grp_pLashes:FlxGroup;
		protected var _grpEnemieRats:FlxGroup;
		protected var _grpEnemieBirds:FlxGroup;
		private var _SheCats:Array;
		
		public function PlayState()
		{
			super();
			lyrStage = new FlxGroup;
			lyrSprites = new FlxGroup;
			lyrHUD = new FlxGroup;
			_grpEnemieRats = new FlxGroup;
			_grpEnemieBirds = new FlxGroup;
			
			_pLashes = new Array;
			_pLashes.push(new Lash(0, 0, 0, 0));
			_grp_pLashes = new FlxGroup();
			lyrSprites.add(_pLashes[0]);
			_SheCats = new Array;
			
			_player = new Cat(80, 280, _pLashes, _SheCats);
			_player.turnBaby();
			lyrSprites.add(_player);
			
			for (var i:Number = 0; i < _pLashes.length; i++)
				_grp_pLashes.add(_pLashes[i]);
			
			_grpEnemieBirds.add(new Bird(207, 215, false));
			_grpEnemieBirds.add(new Bird(343, 215, true));
			_grpEnemieBirds.add(new Bird(483, 241, false));
			//_grpEnemieRats.add(new Rat (138, 182,64));
			lyrSprites.add(_grpEnemieBirds);
			lyrSprites.add(_grpEnemieRats);
			
			_map = new FlxTilemap;
			_map.loadMap(new mapString, ImgTiles, 16, 16, 0, 0, 0, 8);
			
			lyrStage.add(_map);
			
			this.add(lyrStage);
			this.add(lyrSprites);
			this.add(lyrHUD);
			
			
		
		}
		
		override public function create():void {
			_text1 = new FlxText(8, 170, FlxG.width, "Cat first learned that");
			_text1.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text1);
			
			_text2 = new FlxText(8, 180, FlxG.width, "he needed to run to survive.");
			_text2.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text2);
			
			_text3 = new FlxText(8, 200, FlxG.width, "Press <- -> to Run");
			_text3.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text3);
			
	
		}
		override public function update():void
		{
			
			super.update();
			FlxG.collide(_map, _grp_pLashes);
			
			for (var i:Number = 0; i < _grpEnemieBirds.length; i++)
			{
				FlxG.collide(_pLashes[0], _grpEnemieBirds.members[i], LashHitsBird);
				FlxG.collide(_player, _grpEnemieBirds.members[i], PlayerHurt);
			}
			for (var i:Number = 0; i < _grpEnemieRats.length; i++)
			{
				FlxG.collide(_pLashes[0], _grpEnemieRats.members[i], LashHitsRat);
				FlxG.collide(_player, _grpEnemieRats.members[i], PlayerHurt);
			}
			FlxG.collide(_map, _player);
			FlxG.camera.follow(_player);
			_map.follow(FlxG.camera);
		
		}
		
		private function LashHitsBird(colLash:FlxSprite, colEnemy:FlxSprite):void
		{
			
			colEnemy.kill();
			_player.killedBird();
		}
		
		private function LashHitsRat(colLash:FlxSprite, colEnemy:FlxSprite):void
		{
			
			colEnemy.kill();
			_player.killedBird();
		}
		
		private function PlayerHurt(p:FlxSprite, colEnemy:FlxSprite)
		{
			_player.hurt(0);
			_player.jumpBack();
		
		}
		public static function changeState():void {
			FlxG.camera.fade(0xff00000000, 3, on_fade_completed);
			FlxG.music.fadeOut(3);
		}
		public static function on_fade_completed():void {
			
			FlxG.switchState(new PlayState2);
		}
	
	}

}