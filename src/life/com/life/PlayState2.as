package life.com.life
{
	import org.flixel.*;
	import org.flixel.system.FlxTile;
	
	/**
	 * ...
	 * @author Celcius & ssandraa
	 */
	public class PlayState2 extends FlxState
	{
		[Embed(source='../assets/Tiles.png')]
		private var ImgTiles:Class;
		[Embed(source='../assets/Map2.csv',mimeType="application/octet-stream")]
		public var mapString:Class;
		[Embed(source='../assets/sound/kahvi198i_brioskj-escape_from_the_city.mp3')]
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
		private var _text3:FlxText;
		
		public static var lyrStage:FlxGroup;
		public static var lyrSprites:FlxGroup;
		public static var lyrHUD:FlxGroup;
		
		private var _pLashes:Array;
		private var _grp_pLashes:FlxGroup;
		protected var _grpEnemieRats:FlxGroup;
		protected var _grpEnemieBirds:FlxGroup;
		private var _SheCats:Array;
		
		public function PlayState2()
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
			
			_player = new Cat(54, 372, _pLashes, _SheCats);
			_player.turnChild();
			lyrSprites.add(_player);
			
			for (var i:Number = 0; i < _pLashes.length; i++)
				_grp_pLashes.add(_pLashes[i]);
			
			_grpEnemieBirds.add(new Bird(934, 153, true));
			_grpEnemieBirds.add(new Bird(338, 179, false));
			_grpEnemieRats.add(new Rat(537, 374, 20));
			_grpEnemieRats.add(new Rat(881, 374, 10));
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
			_text1 = new FlxText(8, 190, FlxG.width, "He became aware he could jump high");
			_text1.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text1);
			
			_text2 = new FlxText(8, 200, FlxG.width, "and overcome obstacles.");
			_text2.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text2);
			
			_text3 = new FlxText(8, 220, FlxG.width, "Press X to Jump");
			_text3.setFormat(null, 8, 0xFF111111, "left");
            this.add(_text3);
			
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
			FlxG.switchState(new PlayState3);
		}
		
	}

}