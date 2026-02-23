/// @description Insert description here
// You can write your code in this editor

var _distance = point_distance(x, 0, instance_target.x, 0);

if (_distance <= minimal_distance)
{
    global.cutscene = false;
    instance_create_layer(x, y, layer, obj_cutscene_dialogue_int_1);
    instance_destroy();
}

show_debug_message(_distance);