/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
128, false, spr_textboxbottom, snd_gojou_song, .8, 1.1, .04 * global.additional_voice, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    if (instance_exists(obj_control)) 
    {
        obj_control.no = true;
        obj_control.time_dialogue = .5;
    }
	instance_destroy();
}