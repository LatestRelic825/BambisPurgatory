package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			You can disable them in options.\n
			Press ENTER to continue!",
			32);
		warnText.setFormat("Comic Sans MS Bold", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			if (controls.ACCEPT || controls.BACK) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;

					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
					#if (desktop && !mac) //thx delta
					if(ClientPrefs.framerate <= 144) { // makes your fps 144 if you had it below 144 previously so shit doesnt break (cry about it reg)
						ClientPrefs.framerate = 144;
						ClientPrefs.saveSettings(); 
						updateFramerate();
					}
					#elseif mac
					if(ClientPrefs.framerate <= 120) { // makes your fps 120 if you had it below 120 previously so shit doesnt break (cry about it reg)
						// 144 looks lagged af on mac but its prob my old ass 2012 mac
						ClientPrefs.framerate = 120;
						ClientPrefs.saveSettings(); 
						updateFramerate();
					}
					#end
			}
		}
		super.update(elapsed);
	}

	function updateFramerate()
	{
		if(ClientPrefs.framerate > FlxG.drawFramerate)
		{
			FlxG.updateFramerate = ClientPrefs.framerate;
			FlxG.drawFramerate = ClientPrefs.framerate;
		}
		else
		{
			FlxG.drawFramerate = ClientPrefs.framerate;
			FlxG.updateFramerate = ClientPrefs.framerate;
		}
	}
}