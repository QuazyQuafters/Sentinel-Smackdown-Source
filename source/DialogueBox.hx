package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;
	var portraitDead:FlxSprite;
	var portraitShock:FlxSprite;
	var portraitConfused:FlxSprite;
	var portraitAngry:FlxSprite;
	var bfConfused:FlxSprite;
	var portraitSynapse:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			new FlxTimer().start(0.83, function(tmr:FlxTimer)
			{
				bgFade.alpha += (1 / 5) * 0.7;
				if (bgFade.alpha > 0.7)
					bgFade.alpha = 0.7;
			}, 5);
		}
		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);
			case 'roses':
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

			case 'thorns':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb//pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('bootleg'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);
			case 'permafreshie':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('funkin_ashiin_speech_bubble');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 415;
			case 'gripped':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('funkin_ashiin_speech_bubble');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 415;
			case 'synapse':
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('funkin_ashiin_speech_bubble');
				box.animation.addByPrefix('normalOpen', 'speech bubble normal', 24, false);
				box.animation.addByIndices('normal', 'speech bubble normal', [4], "", 24);
				box.width = 200;
				box.height = 200;
				box.x = -100;
				box.y = 415;
		}
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);


		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;

		if (PlayState.SONG.song.toLowerCase() == 'permafreshie' || PlayState.SONG.song.toLowerCase() == 'gripped' || PlayState.SONG.song.toLowerCase() == 'synapse' || PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft = new FlxSprite(0, 0);
			portraitLeft.frames = Paths.getSparrowAtlas('portraits/ashiinportrait');
			portraitLeft.animation.addByPrefix('enter', 'bf', 24, false);
			portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.15));
			portraitLeft.x = 135;
			portraitLeft.y = 297;
			portraitLeft.scrollFactor.set();
			add(portraitLeft);
			portraitLeft.visible = false;

			portraitConfused = new FlxSprite(0, 40);
			portraitConfused.frames = Paths.getSparrowAtlas('portraits/ashiinconfused');
			portraitConfused.animation.addByPrefix('enter', 'bf', 24, false);
			portraitConfused.setGraphicSize(Std.int(portraitConfused.width * PlayState.daPixelZoom * 0.15));
			portraitConfused.x = 135;
			portraitConfused.y = 297;
			portraitConfused.scrollFactor.set();
			add(portraitConfused);
			portraitConfused.visible = false;

			portraitAngry = new FlxSprite(0, 0);
			portraitAngry.frames = Paths.getSparrowAtlas('portraits/ashiinangry');
			portraitAngry.animation.addByPrefix('enter', 'bf', 24, false);
			portraitAngry.setGraphicSize(Std.int(portraitAngry.width * PlayState.daPixelZoom * 0.15));
			portraitAngry.x = 135;
			portraitAngry.y = 297;
			portraitAngry.scrollFactor.set();
			add(portraitAngry);
			portraitAngry.visible = false;

			portraitSynapse = new FlxSprite(0, 0);
			portraitSynapse.frames = Paths.getSparrowAtlas('portraits/ashiinsynapse');
			portraitSynapse.animation.addByPrefix('enter', 'bf', 24, false);
			portraitSynapse.setGraphicSize(Std.int(portraitSynapse.width * PlayState.daPixelZoom * 0.15));
			portraitSynapse.x = 135;
			portraitSynapse.y = 297;
			portraitSynapse.scrollFactor.set();
			add(portraitSynapse);
			portraitSynapse.visible = false;
		}

		if (PlayState.SONG.song.toLowerCase() == 'permafreshie' || PlayState.SONG.song.toLowerCase() == 'gripped' || PlayState.SONG.song.toLowerCase() == 'synapse' || PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitRight = new FlxSprite(0, 0);
			portraitRight.frames = Paths.getSparrowAtlas('portraits/bfPortraits');
			portraitRight.animation.addByPrefix('enter', 'bf', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.15));
			portraitRight.x = 150;
			portraitRight.y = 300;
			portraitRight.scrollFactor.set();
			add(portraitRight);
			portraitRight.visible = false;

			portraitShock = new FlxSprite(0, 0);
			portraitShock.frames = Paths.getSparrowAtlas('portraits/bfshock');
			portraitShock.animation.addByPrefix('enter', 'bf', 24, false);
			portraitRight.setGraphicSize(Std.int(portraitShock.width * PlayState.daPixelZoom * 0.15));
			portraitShock.x = 150;
			portraitShock.y = 300;
			portraitShock.scrollFactor.set();
			add(portraitShock);
			portraitShock.visible = false;

			portraitDead = new FlxSprite(0, 0);
			portraitDead.frames = Paths.getSparrowAtlas('portraits/bfdead');
			portraitDead.animation.addByPrefix('enter', 'bf', 24, false);
			portraitDead.setGraphicSize(Std.int(portraitDead.width * PlayState.daPixelZoom * 0.15));
			portraitDead.x = 150;
			portraitDead.y = 300;
			portraitDead.scrollFactor.set();
			add(portraitDead);
			portraitDead.visible = false;

			bfConfused = new FlxSprite(0, 0);
			bfConfused.frames = Paths.getSparrowAtlas('portraits/bfconfused');
			bfConfused.animation.addByPrefix('enter', 'bf', 24, false);
			bfConfused.setGraphicSize(Std.int(bfConfused.width * PlayState.daPixelZoom * 0.15));
			bfConfused.x = 150;
			bfConfused.y = 300;
			bfConfused.scrollFactor.set();
			add(bfConfused);
			bfConfused.visible = false;
		}
	
		box.screenCenter(X);

		

		if (PlayState.SONG.song.toLowerCase() == 'permafreshie' || PlayState.SONG.song.toLowerCase() == 'gripped' || PlayState.SONG.song.toLowerCase() == 'synapse')
		{
			handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('quazysCoolHandPointerThing'));
			handSelect.x -= 1000;
			handSelect.y = 575;
		}

		if (!talkingRight)
		{
			// box.flipX = true;
		}
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Pixel Arial 11 Bold';
			dropText.color = 0xFFD89494;
			add(dropText);
		}
		else if (PlayState.SONG.song.toLowerCase() == 'permafreshie' || PlayState.SONG.song.toLowerCase() == 'gripped' || PlayState.SONG.song.toLowerCase() == 'synapse')
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 2), "", 32);
			dropText.font = 'Source Sans Pro SemiBold';
			dropText.color = 0xFF000000;
			// i woulda put this here me and sleepy were talking about it and we decided only the name needed a black LOL hi thanks for reading my shite code
		}
		if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'roses' || PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
			swagDialogue.font = 'Pixel Arial 11 Bold';
			swagDialogue.color = 0xFF3F2021;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
		}
		else if (PlayState.SONG.song.toLowerCase() == 'permafreshie' || PlayState.SONG.song.toLowerCase() == 'gripped' || PlayState.SONG.song.toLowerCase() == 'synapse')
		{
			swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 2), "", 32);
			swagDialogue.font = 'Source Sans Pro SemiBold';
			swagDialogue.color = 0xFFe8e8e8;
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
			add(swagDialogue);
		}
		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			dropText.color = FlxColor.BLACK;
		}

		dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (PlayerSettings.player1.controls.ACCEPT && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('pixelText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'dad':
				portraitDead.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitConfused.visible = false;
				portraitAngry.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitLeft.visible)
				{
					portraitLeft.visible = true;
					portraitLeft.animation.play('enter');
				}
			case 'dadconfused':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitDead.visible = false;
				portraitAngry.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitConfused.visible)
				{
					portraitConfused.visible = true;
					portraitConfused.animation.play('enter');
				}
			case 'bfconfused':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitDead.visible = false;
				portraitAngry.visible = false;
				portraitConfused.visible = false;
				portraitSynapse.visible = false;
				if (!bfConfused.visible)
				{
					bfConfused.visible = true;
					bfConfused.animation.play('enter');
				}
			case 'dadangry':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitConfused.visible = false;
				portraitDead.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitAngry.visible)
				{
					portraitAngry.visible = true;
					portraitAngry.animation.play('enter');
				}
			case 'synapse':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitConfused.visible = false;
				portraitDead.visible = false;
				bfConfused.visible = false;
				portraitAngry.visible = false;
				if (!portraitAngry.visible)
				{
					portraitSynapse.visible = true;
					portraitSynapse.animation.play('enter');
				}
			case 'bf':
				portraitLeft.visible = false;
				portraitDead.visible = false;
				portraitShock.visible = false;
				portraitConfused.visible = false;
				portraitAngry.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitRight.visible)
				{
					portraitRight.visible = true;
					portraitRight.animation.play('enter');
				}
			case 'bfshock':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitDead.visible = false;
				portraitConfused.visible = false;
				portraitAngry.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitShock.visible)
				{
					portraitShock.visible = true;
					portraitShock.animation.play('enter');
				}
			case 'bfdead':
				portraitLeft.visible = false;
				portraitRight.visible = false;
				portraitShock.visible = false;
				portraitConfused.visible = false;
				portraitAngry.visible = false;
				bfConfused.visible = false;
				portraitSynapse.visible = false;
				if (!portraitDead.visible)
				{
					portraitDead.visible = true;
					portraitDead.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
