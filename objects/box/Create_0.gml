/// @description Insert description here
// You can write your code in this editor

sprite = undefined;
text = "";
font = "";
visible_box = true;
skip_button = undefined;

skip_alpha = 0;
skip_scalemin = .8;
skip_scaleclick = .7;
skip_scalex = skip_scalemin;
skip_scaley = skip_scalemin;
skip_scalemax = 1;
skip_x = 0;
skip_y = 0;
skiped = false;
number_array = 0;
array = false;
lenght = 0;
sound = undefined;
pitch_min = 0;
pitch_max = 0;
gain = 0;

outline_init();
write_machine = scribble_typist();

write_machine.in(.5, 5);

write_machine.character_delay_add(".", END_STOP);
write_machine.character_delay_add(",", COMMA);
write_machine.character_delay_add("!", EXCLAMATION_MARK);
write_machine.character_delay_add("?", QUESTION_MARK);

