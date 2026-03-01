/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
128, false, spr_textboxbottom, snd_ramon_song, .8, 1.1, .06 * global.additional_voice, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    global.shake_width = 5;
    global.shake_height = -5;
    audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx, 0, 1);
    audio_play_sound(snd_breaking_door, 1, true, .1 * global.additional_sfx);
    instance_create_layer(room_width - 32, y - sprite_height/2, layer, obj_dialogue_rent);
	instance_destroy();
}