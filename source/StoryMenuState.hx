package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import flixel.group.FlxSpriteGroup;
import openfl.Lib;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import WeekData;
import flixel.addons.display.FlxBackdrop;

class StoryMenuState extends MusicBeatState
{
	var week1:FlxSprite;
	var o:FlxSprite;
	var lol:Bool = false;
	var lol2:Bool = false;
	var lol3:Bool = false;
	var canExit:Bool = true;
	var week1text:FlxText;
	var week2text:FlxText;
	var week2:FlxSprite;
	var week3:FlxSprite;
	var week3text:FlxText;
	var arrowshit:FlxSprite;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var text:FlxText;

	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Story Menu", null);
		#end

		#if android
		addVirtualPad(FULL, A_B_X_Y);
		addPadCamera();
		#end
		
		super.create();

		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bofa'));
		add(bg);

		var slider2:FlxBackdrop;
		#if (flixel  < "5.0.0")
		slider2 = new FlxBackdrop(Paths.image('hahaslider'),1,0,true,false);
		#else
		slider2 = new FlxBackdrop(Paths.image('hahaslider'),XY);
		#end
		slider2.velocity.set(-14,0);
		slider2.x = -20;
		slider2.y = 350;
		slider2.setGraphicSize(Std.int(slider2.width * 0.65));
		add(slider2); // i borrowed this from tricky hhehehehehe
		
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		
		week1 = new FlxSprite(100, 70).loadGraphic(Paths.image('purgatoryweeks/story1'));
		week1.scale.set(0.8, 0.8);
		week1.updateHitbox();
		week1.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(week1);

		week1text = new FlxText(80, 480, 320, "Rage\n" + "Week\n");
		week1text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week1text.scrollFactor.set();
		week1text.borderSize = 3.25;
		week1text.visible = true;
		menuItems.add(week1text);

		week2 = new FlxSprite(500, 70).loadGraphic(Paths.image('purgatoryweeks/story2'));
		week2.scale.set(0.8, 0.8);
		week2.updateHitbox();
		week2.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(week2);

		week2text = new FlxText(480, 480, 320, "Hell\n" + "Week\n");
		week2text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week2text.scrollFactor.set();
		week2text.borderSize = 3.25;
		week2text.visible = true;
		menuItems.add(week2text);

		week3 = new FlxSprite(900, 70).loadGraphic(Paths.image('purgatoryweeks/story3'));
		week3.scale.set(0.8, 0.8);
		week3.updateHitbox();
		week3.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(week3);
		
		week3text = new FlxText(880, 480, 320, "Dave's\n" + "Rematch\n");
		week3text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week3text.scrollFactor.set();
		week3text.borderSize = 3.25;
		week3text.visible = true;
		menuItems.add(week3text);
		
		
		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 46).makeGraphic(FlxG.width, 56, 0xFF000000);
		textBG.alpha = 0.6;
		menuItems.add(textBG);
		var leText:String = "Use your mouse to select a week.";
		text = new FlxText(textBG.x + -10, textBG.y + 3, FlxG.width, leText, 21);
		text.setFormat(Paths.font("comic-sans.ttf"), 18, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		menuItems.add(text);
		
		arrowshit = new FlxSprite(-80).loadGraphic(Paths.image('stupidarrowsright'));
		arrowshit.setGraphicSize(Std.int(arrowshit.width * 1));
		arrowshit.updateHitbox();
		arrowshit.screenCenter();
		arrowshit.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(arrowshit);
		
	}
	  override public function update(elapsed:Float)
	  {
		var clicked = FlxG.mouse.overlaps(week1) && FlxG.mouse.justPressed && !lol;
		var clicked2 = FlxG.mouse.overlaps(week2) && FlxG.mouse.justPressed && !lol2;
		var clicked3 = FlxG.mouse.overlaps(week3) && FlxG.mouse.justPressed && !lol3;

		if (clicked)
		{
			lol = true;
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			startSong('shattered/shattered-hard', 'reality breaking', 'rebound');	
		}

		if (clicked2)
		{
			lol2 = true;
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			startSong2('rebound/rebound-hard', 'disposition', 'upheaval');	
		}

		
		if (clicked3)
		{
			lol3 = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.mouse.visible = false;
			startSong3('roundabout/roundabout-hard', 'rascal', 'triple threat');	
		}
		  
		if(controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		
		if(FlxG.keys.justPressed.CONTROL)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		
		if (controls.UI_RIGHT_P)
		{
			openSubState(new Section2Substate());
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
			
		
		super.update(elapsed);
	  }
	  
    function startSong(songName1:String, songName2:String, songName3:String)
    {
	   FlxFlicker.flicker(week1, 1, 0.06, false, false, function(flick:FlxFlicker)
	   {
	    PlayState.storyPlaylist = [songName1, songName2, songName3];
		PlayState.isStoryMode = true;
	    PlayState.storyWeek = 2;
	    PlayState.storyDifficulty = 2;
	    PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
	    PlayState.campaignScore = 0;
	    PlayState.campaignMisses = 0;
	    FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
	    menuItems.forEach(function(spr:FlxSprite) {
		FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
	    FlxTween.tween(spr, {alpha: 0}, 0.4, {
	  	    ease: FlxEase.quadOut,
		    onComplete: function(twn:FlxTween)
		    {
		  	    spr.kill();
		    }
	      });
       });
	    new FlxTimer().start(1, function(tmr:FlxTimer)
	    {
		    LoadingState.loadAndSwitchState(new PlayState());
	    });
	   });
	}

	function startSong2(songName1:String, songName2:String, songName3:String)
		{
		   FlxFlicker.flicker(week2, 1, 0.06, false, false, function(flick:FlxFlicker)
		   {
			PlayState.storyPlaylist = [songName1, songName2, songName3];
			PlayState.isStoryMode = true;
			PlayState.storyWeek = 2;
			PlayState.storyDifficulty = 2;
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
			//FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
			//FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
			menuItems.forEach(function(spr:FlxSprite) {
			FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
			FlxTween.tween(spr, {alpha: 0}, 0.4, {
				  ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					  spr.kill();
				}
			  });
		   });
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
		   });
		}

		function startSong3(songName1:String, songName2:String, songName3:String)
			{
			   FlxFlicker.flicker(week3, 1, 0.06, false, false, function(flick:FlxFlicker)
			   {
				PlayState.storyPlaylist = [songName1, songName2, songName3];
				PlayState.isStoryMode = true;
				PlayState.storyWeek = 2;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
				//FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
				//FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				menuItems.forEach(function(spr:FlxSprite) {
				FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(spr, {alpha: 0}, 0.4, {
					  ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						  spr.kill();
					}
				  });
			   });
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			   });
			}

	function weekIsLocked(weekNum:Int) {
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[weekNum]);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}


}

class Section2Substate extends MusicBeatSubstate
{
	
	var arrowshitSub:FlxSprite;
	var menuItemsSub:FlxTypedGroup<FlxSprite>;
	var lol4:Bool = false;
	var lol5:Bool = false;
	var lol6:Bool = false;
	var text:FlxText;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var week4:FlxSprite;
	var week5:FlxSprite;
	var week4text:FlxText;
	var week5text:FlxText;
	var week6:FlxSprite;
	var week6text:FlxText;

	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	
	public function new() {
		super();
		
	    var bg2:FlxSprite = new FlxSprite().loadGraphic(Paths.image('bofa'));
		add(bg2);

		var slider22:FlxBackdrop;
		#if (flixel  < "5.0.0")
		slider22 = new FlxBackdrop(Paths.image('hahaslider'),1,0,true,false);
		#else
		slider22 = new FlxBackdrop(Paths.image('hahaslider'),X);
		#end
		slider22.velocity.set(-14,0);
		slider22.x = -20;
		slider22.y = 350;
		slider22.setGraphicSize(Std.int(slider22.width * 0.65));
		add(slider22); // i borrowed this from tricky hhehehehehe
		
		menuItemsSub = new FlxTypedGroup<FlxSprite>();
		add(menuItemsSub);
		
		week4 = new FlxSprite(100, 70).loadGraphic(Paths.image('purgatoryweeks/story4'));
		week4.scale.set(0.8, 0.8);
		week4.updateHitbox();
		week4.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(week4);
		
		week4text = new FlxText(80, 480, 320, "Crusti and\n" + "Bambi Minion Week\n");
		week4text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week4text.scrollFactor.set();
		week4text.borderSize = 3.25;
		week4text.visible = true;
		menuItemsSub.add(week4text);
		
		week5 = new FlxSprite(500, 70).loadGraphic(Paths.image('purgatoryweeks/story5'));
		week5.scale.set(0.8, 0.8);
		week5.updateHitbox();
		week5.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(week5);
		
		week5text = new FlxText(480, 480, 320, "The\n" + "Trio Week\n");
		week5text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week5text.scrollFactor.set();
		week5text.borderSize = 3.25;
		week5text.visible = true;
		menuItemsSub.add(week5text);
		
		week6 = new FlxSprite(900, 70).loadGraphic(Paths.image('purgatoryweeks/story6'));
		week6.scale.set(0.8, 0.8);
		week6.updateHitbox();
		week6.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(week6);
		
		week6text = new FlxText(880, 480, 320, "Vs\n" + "???\n");
		week6text.setFormat(Paths.font("comic-sans.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week6text.scrollFactor.set();
		week6text.borderSize = 3.25;
		week6text.visible = true;
		menuItemsSub.add(week6text);
		
		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 46).makeGraphic(FlxG.width, 56, 0xFF000000);
		textBG.alpha = 0.6;
		menuItemsSub.add(textBG);
		var leText:String = "Use your mouse to select a week.";
		text = new FlxText(textBG.x + -10, textBG.y + 3, FlxG.width, leText, 21);
		text.setFormat(Paths.font("comic-sans.ttf"), 18, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		menuItemsSub.add(text);
		
		arrowshitSub = new FlxSprite(-80).loadGraphic(Paths.image('stupidarrowsleft'));
		arrowshitSub.setGraphicSize(Std.int(arrowshitSub.width * 1));
		arrowshitSub.updateHitbox();
		arrowshitSub.screenCenter();
		arrowshitSub.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(arrowshitSub);
	}
	
	override function update(elapsed:Float)
	{

		var clicked4 = FlxG.mouse.overlaps(week4) && FlxG.mouse.justPressed && !lol4;
		var clicked5 = FlxG.mouse.overlaps(week5) && FlxG.mouse.justPressed && !lol5;
		var clicked6 = FlxG.mouse.overlaps(week6) && FlxG.mouse.justPressed && !lol6;
		
		if (clicked4)
		{
			lol4 = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.mouse.visible = false;
			startSong4('delivery/delivery-hard', 'acquaintance', 'Double Act');	
		}

		
		if (clicked5)
		{
			lol5 = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.mouse.visible = false;
			startSong5("beefin'/beefin-hard", 'Technology');	
		}
		
		
		if (clicked6)
		{
			lol6 = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			FlxG.mouse.visible = false;
			startSong6('Tyranny/Tyranny-hard', 'Cataclysmic', 'Antagonism');
		}

		if (controls.UI_LEFT_P)
		{
			close();
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}

		if(FlxG.keys.justPressed.CONTROL)
		{
			persistentUpdate = false;
			openSubState(new GameplayChangersSubstate());
		}
		
		if(controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.mouse.visible = false;
			MusicBeatState.switchState(new MainMenuState());
		}
		
		super.update(elapsed);
	}

	function startSong4(songName1:String, songName2:String, songName3:String)
		{
		   FlxFlicker.flicker(week4, 1, 0.06, false, false, function(flick:FlxFlicker)
		   {
			PlayState.storyPlaylist = [songName1, songName2, songName3];
			PlayState.isStoryMode = true;
			PlayState.storyWeek = 2;
			PlayState.storyDifficulty = 2;
			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
			//FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
			//FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
			menuItemsSub.forEach(function(spr:FlxSprite) {
			FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
			FlxTween.tween(spr, {alpha: 0}, 0.4, {
				  ease: FlxEase.quadOut,
				onComplete: function(twn:FlxTween)
				{
					  spr.kill();
				}
			  });
		   });
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState());
			});
		   });
		}

		function startSong5(songName1:String, songName2:String)
			{
			   FlxFlicker.flicker(week5, 1, 0.06, false, false, function(flick:FlxFlicker)
			   {
				PlayState.storyPlaylist = [songName1, songName2];
				PlayState.isStoryMode = true;
				PlayState.storyWeek = 2;
				PlayState.storyDifficulty = 2;
				PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
				PlayState.campaignScore = 0;
				PlayState.campaignMisses = 0;
				FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
				//FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
				//FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				menuItemsSub.forEach(function(spr:FlxSprite) {
				FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
				FlxTween.tween(spr, {alpha: 0}, 0.4, {
					  ease: FlxEase.quadOut,
					onComplete: function(twn:FlxTween)
					{
						  spr.kill();
					}
				  });
			   });
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					LoadingState.loadAndSwitchState(new PlayState());
				});
			   });
			}

			function startSong6(songName1:String, songName2:String, songName3:String)
				{
				   FlxFlicker.flicker(week6, 1, 0.06, false, false, function(flick:FlxFlicker)
				   {
					PlayState.storyPlaylist = [songName1, songName2, songName3];
					PlayState.isStoryMode = true;
					PlayState.storyWeek = 2;
					PlayState.storyDifficulty = 2;
					PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0], '');
					PlayState.campaignScore = 0;
					PlayState.campaignMisses = 0;
					FlxTween.tween(FlxG.camera, {zoom: 5}, 0.8, {ease: FlxEase.expoIn});
					//FlxTween.tween(bg, {angle: 45}, 0.8, {ease: FlxEase.expoIn});
					//FlxTween.tween(bg, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
					menuItemsSub.forEach(function(spr:FlxSprite) {
					FlxTween.tween(camera, {alpha: 0}, 0.8, {ease: FlxEase.expoIn});
					FlxTween.tween(spr, {alpha: 0}, 0.4, {
						  ease: FlxEase.quadOut,
						onComplete: function(twn:FlxTween)
						{
							  spr.kill();
						}
					  });
				   });
					new FlxTimer().start(1, function(tmr:FlxTimer)
					{
						LoadingState.loadAndSwitchState(new PlayState());
					});
				   });
				}

	function weekIsLocked(weekNum:Int) {
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[weekNum]);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}
}
