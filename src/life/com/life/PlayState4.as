package life.com.life
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class PlayState4 extends FlxState
	{
		[Embed(source='../assets/Tiles.png')]
		private var ImgTiles:Class;
		[Embed(source='../assets/Map4.csv',mimeType="application/octet-stream")]
		public var mapString:Class;
		[Embed(source='../assets/sound/kahvi198c_brioskj-souls.mp3')]
		private var TitleMusic:Class;
		
		private var _player:Cat;
		private var _sheCat1:SheCat;
		private var _sheCat2:SheCat;
		private var _walkKitty:WalkingKitty;
		private var _jumpKitty:JumpingKitty;
		private var _huntKitty:HuntKitty;
		private var _map:FlxTilemap;
		
		private var _text1:FlxText;
		private var _text2:FlxText;
		
		public static var lyrStage:FlxGroup;
		public static var lyrSprites:FlxGroup;
		public static var lyrHUD:FlxGroup;
		
		private var _pLashes:Array;
		private var _grp_pLashes:FlxGroup;
		protected var _grpEnemieRats:FlxGroup;
		protected var _grpEnemieBirds:FlxGroup;
		private var _SheCats:Array;
		
		public function PlayState4()
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
			;
			
			_sheCat1 = new SheCat(80, 185, 1);
			_sheCat2 = new SheCat(130, 169, 2);
			lyrSprites.add(_sheCat1);
			lyrSprites.add(_sheCat2);
			
			_SheCats = new Array;
			;
			_SheCats.push(_sheCat1);
			_SheCats.push(_sheCat2);
			
			_player = new Cat(54, 212, _pLashes, _SheCats);
			_player.turnAdult();
			lyrSprites.add(_player);
			
			for (var i:Number = 0; i < _pLashes.length; i++)
				_grp_pLashes.add(_pLashes[i]);
			
			_grpEnemieBirds.add(new Bird(225, 82, false));
			_grpEnemieRats.add(new Rat(1052, 390, 50));
			_grpEnemieRats.add(new Rat(150, 374, 50));
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
			_text1 = new FlxText(8, 110, FlxG.width, "He met other cats and felt the need to mate,");
			_text1.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text1);
			
			_text2 = new FlxText(8, 120, FlxG.width, "so he went hunting to prove his worth.");
			_text2.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text2);
			
			FlxG.playMusic(TitleMusic,0.7);
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
			_player.informSheCats(1);
		}
		
		private function LashHitsRat(colLash:FlxSprite, colEnemy:FlxSprite):void
		{
			
			colEnemy.kill();
			_player.killedRat();
			_player.informSheCats(2);
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
			FlxG.switchState(new PlayState5);
		}
	
	}

}