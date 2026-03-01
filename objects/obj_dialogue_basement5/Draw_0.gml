/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
128, false, spr_textboxbottom, snd_ramon_song, .8, 1.1, .06 * global.additional_voice, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    create_warn(spr_textwarn, "Encontre a alavanca de ativação", "fnt_warn", "Dialogues", 5);
	instance_destroy();
}