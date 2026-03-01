/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
128, false, spr_textboxbottom, snd_gojou_song, .8, 1.1, .04 * global.additional_voice, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    global.shake_width = -2;
    global.shake_height = -2;
    audio_stop_sound(snd_shake_impact);
    audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx);
    room_goto(rm_section_1_backboss);
	instance_destroy();
}