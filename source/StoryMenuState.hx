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

class StoryMenuState extends MusicBeatState
{
	var lol:Bool = false;
	var lol2:Bool = false;
	var bg:FlxSprite;
	var week1:FlxSprite;
	var week2:FlxSprite;
	var o:FlxSprite;
	var sex:FlxSprite;
	var canExit:Bool = true;
	var week1text:FlxText;
	var week2text:FlxText;
	var arrowshit:FlxSprite;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var text:FlxText;

	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	
	public static var bgPaths:Array<String> = 
	[
		'backgrounds/darlyboxman',
		'backgrounds/isaaclul',
		'backgrounds/osp',
		'backgrounds/slushX',
		'backgrounds/voltrex',
	];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In Menu", null);
		#end

		#if android
		addVirtualPad(FULL, A_B_X_Y);
		addPadCamera();
		#end
		
		super.create();

		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(randomizeBG());
		bg.scrollFactor.set();
		bg.updateHitbox();
		bg.screenCenter();
		bg.color = 0xFF738BFF;
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		bg.alpha = 1;
		add(bg);
		
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);
		
		week1 = new FlxSprite(100, 70).loadGraphic(Paths.image('purgatoryweeks/story2'));
		week1.scale.set(0.8, 0.8);
		week1.updateHitbox();
		week1.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(week1);
		
		week1text = new FlxText(165, 525, 400, "Rage Week");
		week1text.setFormat(Paths.font("comic-sans.ttf"), 60, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week1text.scrollFactor.set();
		week1text.borderSize = 3.25;
		week1text.visible = true;
		menuItems.add(week1text);

		week2 = new FlxSprite(648, 70).loadGraphic(Paths.image('purgatoryweeks/story2'));
		week2.scale.set(0.8, 0.8);
		week2.updateHitbox();
		week2.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(week2);
		
		week2text = new FlxText(560, 525, 700, "Hell Week");
		week2text.setFormat(Paths.font("comic-sans.ttf"), 65, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week2text.scrollFactor.set();
		week2text.borderSize = 3.25;
		week2text.visible = true;
		menuItems.add(week2text);
		
		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 46).makeGraphic(FlxG.width, 56, 0xFF000000);
		textBG.alpha = 0.6;
		menuItems.add(textBG);
		var leText:String = "Use your mouse to select a week.";
		text = new FlxText(textBG.x + -10, textBG.y + 3, FlxG.width, leText, 21);
		text.setFormat(Paths.font("comic-sans.ttf"), 18, FlxColor.WHITE, CENTER);
		text.scrollFactor.set();
		menuItems.add(text);
		
		/*arrowshit = new FlxSprite(-80).loadGraphic(Paths.image('stupidarrows'));
		arrowshit.setGraphicSize(Std.int(arrowshit.width * 1));
		arrowshit.updateHitbox();
		arrowshit.screenCenter();
		arrowshit.antialiasing = ClientPrefs.globalAntialiasing;
		menuItems.add(arrowshit);*/
		
	}
	  override public function update(elapsed:Float)
	  {
		var clicked = FlxG.mouse.overlaps(week1) && FlxG.mouse.justPressed && !lol;
		var clicked2 = FlxG.mouse.overlaps(week2) && FlxG.mouse.justPressed && !lol2;

		if (clicked)
		{
			lol = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			startSong('shattered/shattered-hard', 'supplanted', 'reality breaking');	
		}

		if (clicked2)
		{
			lol2 = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			startSong('rebound/rebound-hard', 'disposition-hard', 'upheaval');	
		}
		  
		/*if(controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}*/
		
		/*if (controls.UI_RIGHT_P)
		{
			openSubState(new Section2Substate());
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}*/
		
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

	
	public static function randomizeBG():flixel.system.FlxAssets.FlxGraphicAsset
	{
		var chance:Int = FlxG.random.int(0, bgPaths.length - 1);
		return Paths.image(bgPaths[chance]);
	}
}

// Sorry but Vs. Bambar was only a concept :|

/*class Section3Substate extends MusicBeatSubstate
{
	
	var arrowshitSub:FlxSprite;
	var menuItemsSub:FlxTypedGroup<FlxSprite>;
	var bgSub:FlxSprite;
	var textSub:FlxText;
	var week3:FlxSprite;
	var week3text:FlxText;

	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();
	
	public function new() {
		super();
		
		bgSub = new FlxSprite(-80).loadGraphic(Paths.image('backgrounds/purgatory/osp'));
		bgSub.scrollFactor.set();
		bgSub.updateHitbox();
		bgSub.screenCenter();
		bgSub.color = 0xFF738BFF;
		bgSub.antialiasing = ClientPrefs.globalAntialiasing;
		add(bgSub);
		
		menuItemsSub = new FlxTypedGroup<FlxSprite>();
		add(menuItemsSub);
		
		week3 = new FlxSprite(100, 70).loadGraphic(Paths.image('purgatoryweeks/story'));
		week3.scale.set(0.8, 0.8);
		week3.updateHitbox();
		week3.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(week3);
		
		week3text = new FlxText(480, 525, 320, "Vs.\n" + "Bambar\n");
		week3text.setFormat(Paths.font("comic-sans.ttf"), 65, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		week3text.scrollFactor.set();
		week3text.borderSize = 3.25;
		week3text.visible = true;
		menuItemsSub.add(week3text);
		
		var textBGSub:FlxSprite = new FlxSprite(0, FlxG.height - 46).makeGraphic(FlxG.width, 56, 0xFF000000);
		textBGSub.alpha = 0.6;
		menuItemsSub.add(textBGSub);
		
		arrowshitSub = new FlxSprite(-80).loadGraphic(Paths.image('stupidarrows'));
		arrowshitSub.setGraphicSize(Std.int(arrowshitSub.width * 1));
		arrowshitSub.updateHitbox();
		arrowshitSub.screenCenter();
		arrowshitSub.antialiasing = ClientPrefs.globalAntialiasing;
		menuItemsSub.add(arrowshitSub);
	}
	
	override function update(elapsed:Float)
	{
		if (controls.UI_LEFT_P)
		{
			close();
			openSubState(new Section2Substate());
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		
		if(controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}
		
		super.update(elapsed);
	}

	function weekIsLocked(weekNum:Int) {
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[weekNum]);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}
}*/



































/*package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.net.curl.CURLCode;
import WeekData;

using StringTools;

class StoryMenuState extends MusicBeatState
{
	// Wether you have to beat the previous week for playing this one
	// Not recommended, as people usually download your mod for, you know,
	// playing just the modded week then delete it.
	// defaults to True
	public static var weekCompleted:Map<String, Bool> = new Map<String, Bool>();

	var scoreText:FlxText;

	private static var curDifficulty:Int = 1;

	var txtWeekTitle:FlxText;
	var bgSprite:FlxSprite;
	var yellowBG:FlxSprite;

	private static var curWeek:Int = 0;

	var txtTracklist:FlxText;

	var grpWeekText:FlxTypedGroup<MenuItem>;
	var grpWeekCharacters:FlxTypedGroup<MenuCharacter>;

	var grpLocks:FlxTypedGroup<FlxSprite>;

	var difficultySelectors:FlxGroup;
	var sprDifficultyGroup:FlxTypedGroup<FlxSprite>;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	var songColors:Array<FlxColor> = [
        0xFFca1f6f, // GF
		0xFF4965FF, // DAVE
		0xFF00B515, // STUPID MR BAMBI
		0xFF00FFFF, //SPLIT THE THONNNNN
    ];

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		
		WeekData.reloadWeekFiles(true);
		if(curWeek >= WeekData.weeksList.length) curWeek = 0;
		persistentUpdate = persistentDraw = true;

		scoreText = new FlxText(10, 10, 0, "SCORE: 49324858", 36);
		scoreText.setFormat("Comic Sans MS Bold", 32);

		txtWeekTitle = new FlxText(FlxG.width * 0.7, 10, 0, "", 32);
		txtWeekTitle.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, RIGHT);
		txtWeekTitle.alpha = 0.7;

		var rankText:FlxText = new FlxText(0, 10);
		rankText.text = 'RANK: GREAT';
		rankText.setFormat(Paths.font("comic-sans.ttf"), 32);
		rankText.size = scoreText.size;
		rankText.screenCenter(X);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');
		yellowBG = new FlxSprite(0, 56).makeGraphic(FlxG.width * 2, 400, FlxColor.WHITE);
		yellowBG.color = songColors[0];
		bgSprite = new FlxSprite(0, 56);
		bgSprite.antialiasing = ClientPrefs.globalAntialiasing;

		grpWeekText = new FlxTypedGroup<MenuItem>();
		add(grpWeekText);

		var blackBarThingie:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, 56, FlxColor.BLACK);
		add(blackBarThingie);

		grpWeekCharacters = new FlxTypedGroup<MenuCharacter>();

		grpLocks = new FlxTypedGroup<FlxSprite>();
		add(grpLocks);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		for (i in 0...WeekData.weeksList.length)
		{
			WeekData.setDirectoryFromWeek(WeekData.weeksLoaded.get(WeekData.weeksList[i]));
			var weekThing:MenuItem = new MenuItem(0, bgSprite.y + 396, WeekData.weeksList[i]);
			weekThing.y += ((weekThing.height + 20) * i);
			weekThing.targetY = i;
			grpWeekText.add(weekThing);

			weekThing.screenCenter(X);
			weekThing.antialiasing = ClientPrefs.globalAntialiasing;
			// weekThing.updateHitbox();

			// Needs an offset thingie
			if (weekIsLocked(i))
			{
				var lock:FlxSprite = new FlxSprite(weekThing.width + 10 + weekThing.x);
				lock.frames = ui_tex;
				lock.animation.addByPrefix('lock', 'lock');
				lock.animation.play('lock');
				lock.ID = i;
				lock.antialiasing = ClientPrefs.globalAntialiasing;
				grpLocks.add(lock);
			}
		}

		WeekData.setDirectoryFromWeek(WeekData.weeksLoaded.get(WeekData.weeksList[0]));
		var charArray:Array<String> = WeekData.weeksLoaded.get(WeekData.weeksList[0]).weekCharacters;
		for (char in 0...3)
		{
			var weekCharacterThing:MenuCharacter = new MenuCharacter((FlxG.width * 0.25) * (1 + char) - 150, charArray[char]);
			weekCharacterThing.y += 70;
			grpWeekCharacters.add(weekCharacterThing);
		}

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(grpWeekText.members[0].x + grpWeekText.members[0].width + 10, grpWeekText.members[0].y + 10);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		leftArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(leftArrow);

		sprDifficultyGroup = new FlxTypedGroup<FlxSprite>();
		add(sprDifficultyGroup);


		for (i in 0...CoolUtil.difficultyStuff.length) {
			var sprDifficulty:FlxSprite = new FlxSprite(leftArrow.x + 60, leftArrow.y).loadGraphic(Paths.image('menudifficulties/' + CoolUtil.difficultyStuff[i][0].toLowerCase()));
			sprDifficulty.x += (308 - sprDifficulty.width) / 2;
			sprDifficulty.ID = i;
			sprDifficulty.antialiasing = ClientPrefs.globalAntialiasing;
			sprDifficultyGroup.add(sprDifficulty);
		}
		changeDifficulty();

		difficultySelectors.add(sprDifficultyGroup);

		rightArrow = new FlxSprite(leftArrow.x + 376, leftArrow.y);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		rightArrow.antialiasing = ClientPrefs.globalAntialiasing;
		difficultySelectors.add(rightArrow);

		add(yellowBG);
		add(bgSprite);
		add(grpWeekCharacters);

		var tracksSprite:FlxSprite = new FlxSprite(FlxG.width * 0.07, bgSprite.y + 425).loadGraphic(Paths.image('Menu_Tracks'));
		tracksSprite.antialiasing = ClientPrefs.globalAntialiasing;
		add(tracksSprite);

		txtTracklist = new FlxText(FlxG.width * 0.05, tracksSprite.y + 60, 0, "", 32);
		txtTracklist.alignment = CENTER;
		txtTracklist.font = rankText.font;
		txtTracklist.color = 0xFFFFFFFF;
		add(txtTracklist);
		// add(rankText);
		add(scoreText);
		add(txtWeekTitle);

		changeWeek();

		#if android
		addVirtualPad(FULL, A_B_X_Y);
		addPadCamera();
		#end

		super.create();
	}

	override function closeSubState() {
		persistentUpdate = true;
		changeWeek();
		super.closeSubState();
	}

	override function update(elapsed:Float)
	{
		// scoreText.setFormat('VCR OSD Mono', 32);
		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, CoolUtil.boundTo(elapsed * 30, 0, 1)));
		if(Math.abs(intendedScore - lerpScore) < 10) lerpScore = intendedScore;

		scoreText.text = "WEEK SCORE:" + lerpScore;

		// FlxG.watch.addQuick('font', scoreText.font);

		difficultySelectors.visible = !weekIsLocked(curWeek);

		if (!movedBack && !selectedWeek)
		{
			if (controls.UI_UP_P)
			{
				changeWeek(-1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.UI_DOWN_P)
			{
				changeWeek(1);
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}

			if (controls.UI_RIGHT)
				rightArrow.animation.play('press')
			else
				rightArrow.animation.play('idle');

			if (controls.UI_LEFT)
				leftArrow.animation.play('press');
			else
				leftArrow.animation.play('idle');

			if (controls.UI_RIGHT_P)
				changeDifficulty(1);
			if (controls.UI_LEFT_P)
				changeDifficulty(-1);

			if (controls.ACCEPT)
			{
				selectWeek();
			}
			else if(controls.RESET #if android || _virtualpad.buttonY.justPressed #end)
			{
				persistentUpdate = false;
				openSubState(new ResetScoreSubState('', curDifficulty, '', curWeek));
				FlxG.sound.play(Paths.sound('scrollMenu'));
			}
		}

		if (controls.BACK && !movedBack && !selectedWeek)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			movedBack = true;
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);

		grpLocks.forEach(function(lock:FlxSprite)
		{
			lock.y = grpWeekText.members[lock.ID].y;
		});
	}

	var movedBack:Bool = false;
	var selectedWeek:Bool = false;
	var stopspamming:Bool = false;

	function selectWeek()
	{
		if (!weekIsLocked(curWeek))
		{
			if (stopspamming == false)
			{
				FlxG.sound.play(Paths.sound('confirmMenu'));

				if(ClientPrefs.flashing) grpWeekText.members[curWeek].startFlashing();
				if(ClientPrefs.flashing) if(grpWeekCharacters.members[1].character != '') grpWeekCharacters.members[1].animation.play('confirm');
				stopspamming = true;
			}

			// We can't use Dynamic Array .copy() because that crashes HTML5, here's a workaround.
			var songArray:Array<String> = [];
			var leWeek:Array<Dynamic> = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]).songs;
			for (i in 0...leWeek.length) {
				songArray.push(leWeek[i][0]);
			}

			// Nevermind that's stupid lmao
			PlayState.storyPlaylist = songArray;
			PlayState.isStoryMode = true;
			PlayState.isFreeplay = false;
			selectedWeek = true;

			var diffic = CoolUtil.difficultyStuff[curDifficulty][1];
			if(diffic == null) diffic = '';

			switch (curDifficulty)
			{
				case 0:
					diffic = '-easy';
				case 2:
					diffic = '-hard';
			}

			PlayState.storyDifficulty = curDifficulty;

			PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + diffic, PlayState.storyPlaylist[0].toLowerCase());
			PlayState.storyWeek = curWeek;
			PlayState.campaignScore = 0;
			PlayState.campaignMisses = 0;
			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				LoadingState.loadAndSwitchState(new PlayState(), true);
				//destroyFreeplayVocals();
			});
		} else {
			FlxG.sound.play(Paths.sound('cancelMenu'));
		}
	}

	function updateDifficultySprite() // updates the difficulty text and yeah
	{
		sprDifficultyGroup.forEach(function(spr:FlxSprite) {
			spr.visible = false;
			if(curDifficulty == spr.ID) {
				spr.visible = true;
				spr.alpha = 0;
				spr.y = leftArrow.y - 15;
				FlxTween.tween(spr, {y: leftArrow.y + 15, alpha: 1}, 0.07);
			}
		});
	}

	function changeDifficulty(change:Int = 0):Void
	{
		curDifficulty += change;

		if (curDifficulty < 0)
			curDifficulty = CoolUtil.difficultyStuff.length-1;
		if (curDifficulty >= CoolUtil.difficultyStuff.length)
			curDifficulty = 0;
		else
		{
			if (curDifficulty < 0)
				curDifficulty = 2;
			if (curDifficulty > 2)
				curDifficulty = 0;
		}
		if (curWeek == 3)
		{
			curDifficulty = 3;
		}
		if (curWeek == 4 || curWeek == 5 || curWeek == 6 || curWeek == 7 || curWeek == 8)
		{
			curDifficulty = 2;
		}

		sprDifficultyGroup.forEach(function(spr:FlxSprite) {
			spr.visible = false;
			if(curDifficulty == spr.ID) {
				spr.visible = true;
				spr.alpha = 0;
				spr.y = leftArrow.y - 15;
				FlxTween.tween(spr, {y: leftArrow.y + 15, alpha: 1}, 0.07);
			}
		});

		#if !switch
		intendedScore = Highscore.getWeekScore(WeekData.weeksList[curWeek], curDifficulty);
		#end
	}

	var lerpScore:Int = 0;
	var intendedScore:Int = 0;

	function changeWeek(change:Int = 0):Void
	{
		curWeek += change;

		if (curWeek >= WeekData.weeksList.length)
			curWeek = 0;
    		leftArrow.visible = true;
	    	rightArrow.visible = true;
		if (curWeek < 0)
			curWeek = WeekData.weeksList.length - 1;
	    	leftArrow.visible = true;
     		rightArrow.visible = true;
		if (curWeek == 3)
			{
				curDifficulty = 3;
				updateDifficultySprite();
				leftArrow.visible = false;
				rightArrow.visible = false;
			}
			if (curWeek == 4 || curWeek == 5 || curWeek == 6 || curWeek == 7 || curWeek == 8)
				{
					curDifficulty = 2;
					updateDifficultySprite();
					leftArrow.visible = false;
					rightArrow.visible = false;
				}
		if (curWeek == 0 || curWeek == 2) //updates the difficulty sprite when changing the week
			{
				curDifficulty = 2;
				updateDifficultySprite();
			}
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]);
		WeekData.setDirectoryFromWeek(leWeek);

		var leName:String = leWeek.storyName;
		txtWeekTitle.text = leName.toUpperCase();
		txtWeekTitle.x = FlxG.width - (txtWeekTitle.width + 10);

		var bullShit:Int = 0;

		for (item in grpWeekText.members)
		{
			item.targetY = bullShit - curWeek;
			if (item.targetY == Std.int(0) && !weekIsLocked(curWeek))
				item.alpha = 1;
			else
				item.alpha = 0.6;
			bullShit++;
		}

		bgSprite.visible = true;
		var assetName:String = leWeek.weekBackground;
		if(assetName == null || assetName.length < 1) {
			bgSprite.visible = false;
		} else {
			bgSprite.loadGraphic(Paths.image('menubackgrounds/menu_' + assetName));
		}
		updateText();

		if(curWeek >= 4) // if its higher than the splitathon week this will be the color (the yellowish one from fnf)
    		FlxTween.color(yellowBG, 0.25, yellowBG.color, 0xFFF9CF51);
	    else
			FlxTween.color(yellowBG, 0.25, yellowBG.color, songColors[curWeek]);
	}

	function weekIsLocked(weekNum:Int) {
		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[weekNum]);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!weekCompleted.exists(leWeek.weekBefore) || !weekCompleted.get(leWeek.weekBefore)));
	}

	function updateText()
	{
		var weekArray:Array<String> = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]).weekCharacters;
		for (i in 0...grpWeekCharacters.length) {
			grpWeekCharacters.members[i].changeCharacter(weekArray[i]);
		}

		var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[curWeek]);
		var stringThing:Array<String> = [];
		for (i in 0...leWeek.songs.length) {
			stringThing.push(leWeek.songs[i][0]);
		}

		txtTracklist.text = '';
		for (i in 0...stringThing.length)
		{
			txtTracklist.text += stringThing[i] + '\n';
		}

		txtTracklist.text = txtTracklist.text.toUpperCase();

		txtTracklist.screenCenter(X);
		txtTracklist.x -= FlxG.width * 0.35;

		#if !switch
		intendedScore = Highscore.getWeekScore(WeekData.weeksList[curWeek], curDifficulty);
		#end
	}
}*/