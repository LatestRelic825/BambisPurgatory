package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	public var isAnim:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		offset.set(Std.int(FlxMath.bound(width - 150,0)),Std.int(FlxMath.bound(height - 150,0))); // this is for the dnb bounce to work properly //
		if(this.char == 'bambiGod2d') {
			//fuckin offsets
			switch(animation.curAnim.name) {
				case 'neutral':
					offset.y += 140;
				case 'defeat':
					offset.x += 50;
					offset.y += 115;
				case 'winning':
					offset.x += -50;
					offset.y += 130;
			}
			offset.x += FlxG.random.int(-2, 2);
			offset.y += FlxG.random.int(-2, 2);
			angle = FlxG.random.int(-2, 2);
		}

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			switch(char) {
				case 'bambiGod2d':
					var name:String = 'icons/icon-bambiGod2d';
					frames = Paths.getSparrowAtlas(name);
					scale.set(0.5, 0.5);

					animation.addByPrefix('neutral', 'Neutral', 12, true, isPlayer);
					animation.addByPrefix('defeat', 'Defeat', 12, true, isPlayer);
					animation.addByPrefix('winning', 'Winning', 12, true, isPlayer);
					animation.play('neutral');

					updateHitbox();
					offset.set(Std.int(FlxMath.bound(width - 150,0)),175);
					this.isAnim = true;	
				default:
					var name:String = 'icons/' + char;
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
					if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
					var file:Dynamic = Paths.image(name);

					loadGraphic(file); //Load stupidly first for getting the file size
					loadGraphic(file, true, Math.floor(width / 3), Math.floor(height)); //Then load it fr
					iconOffsets[0] = (width - 150) / 2;
					iconOffsets[1] = (width - 150) / 2;
					iconOffsets[2] = (width - 150) / 2;
					updateHitbox();

					animation.add(char, [0, 1, 2], 0, false, isPlayer);
					animation.play(char);
					this.isAnim = false;
			}
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	public function changeIconStatus(status:Int) {
		if(!this.isAnim) {
			animation.curAnim.curFrame = status;
		} else {
			switch(status) {
				case 1:
					animation.play('defeat', false);
				case 2:
					animation.play('winning', false);
				default:
					animation.play('neutral', false);
			}
		}
	}

	public function updateHitboxPE()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
