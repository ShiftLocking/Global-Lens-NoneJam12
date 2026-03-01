/// @description Insert description here
// You can write your code in this editor

player = obj_player;
gojou = obj_gojou_section_2;
global.stopped = true;

if (instance_exists(player)) player.image_alpha = 0;
    
if (instance_exists(gojou)) gojou.image_alpha = 0;

var _layer = layer_get_id("Background");
var element = layer_background_get_id(_layer);
layer_background_alpha(element, 0);

time_dialogue = 1;

finished = false;

no = false;