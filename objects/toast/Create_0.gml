/// @description Insert description here
// You can write your code in this editor

//Variaveis que precisam de informação
sprite = undefined;
text = "";
font = undefined;
finy = 0;
interact_toast = false;
visible_toast = true;
skip_input = undefined;

//NÃO MEXA
iniy = y;
inix = x;
toastx = inix;
toasty = iniy;
xscale = 0;
yscale = 0;
alpha = 0;
iniangle = 10;
text_angle = iniangle;
sprite_angle = iniangle;
text_scale = 1;
width = 0;
height = 0;
sprite_alpha = 0;
float_number = 0;
skip_alpha = 0;
skip_scalemin = .9;
skip_scalex = skip_scalemin;
skip_scaley = skip_scalemin;
skip_scalemax = 1.2;
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