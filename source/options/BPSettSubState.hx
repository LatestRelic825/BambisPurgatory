package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class BPSettSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = "Bambi's Purgatory options";
		rpcTitle = "Bambi's Purgatory mod options"; //for Discord Rich Presence

		var option:Option = new Option('Camera follows note',
			"If checked, the camera will move according to the note.\n(Script by stilic)",
			'follownote',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Judgement Counter',
			"Shows a judgement counter at the left of the screen (Example: Sicks: 93,\nGoods:0, Bads: 1, 'Shits: 0)",
			'judgementCounter',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Sections Note Combo',
			"Shows the notes combo",
			'noteCombo',
			'bool',
			true);
		addOption(option);

	    var option:Option = new Option('Ratings and Combo in the Hud',
			'Enable this to have the Ratings and Combo in the HUD camera.',
			'ratingsinHUD',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Enable Lane Underlay',
			"Enables a black underlay behind the notes\nfor better reading!\n(Similar to Funky Friday's Scroll Underlay or osu!mania's underlay)",
			'laneunderlay',
			'bool',
			true);
		addOption(option);
		
		var option:Option = new Option('Lane Underlay Transparency',
			'Set the Lane Underlay Transparency (Lane Underlay must be enabled)',
			'laneTransparency',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);

		super();
	}
}