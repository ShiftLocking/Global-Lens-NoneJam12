/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
999, false, spr_textboxbottom, snd_mrstomach_song, .8, 1.1, .02 * global.additional_voice, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    obj_cam.view_target = obj_player;
    instance_create_layer(0, 0, layer, obj_resolve_resolution);
    create_warn(spr_textwarn, "Entre na porta!", "fnt_warn", "Dialogues", 5);
    audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx, 0, 1);
    global.can_next = true;
	instance_destroy();
}
else 
{
	global.resolution_base = lerp(global.resolution_base, 360, .5);
}