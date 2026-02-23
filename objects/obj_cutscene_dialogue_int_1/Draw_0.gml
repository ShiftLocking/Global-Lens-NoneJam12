/// @description Insert description here
// You can write your code in this editor

var _input = input("skip", , , , true);
create_toast(spr_textbox, text, "fnt_dialogue", "Dialogues", 
target.y - target.sprite_height, target, 
128, false, , , , , false, , , _input);

var _finished = get_toast_finished();

if (_finished)
{
	instance_destroy();
}

var s = detection(0, true, "horizontal", "left");

draw_sprite(s.sprite, s.subming, x, y);