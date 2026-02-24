/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues",
target.y - target.sprite_height, target,
128, false, spr_textboxbottom, snd_ramon_song, .8, 1.1, .04, false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
    instance_create_layer(x, y, "Inputs", obj_movement_keybinds);
	instance_destroy();
}