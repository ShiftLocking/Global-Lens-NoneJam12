/// @description Insert description here
// You can write your code in this editor

draw_self();
if (instance_exists(target) && global.panel)
{
    var _distance = point_distance(x, 0, target.x, 0);
    var _input = input("interact", , , , true);
    var _input2 = input("interact", "pressed", "button");
    interact(_input, x, y - sprite_height, id, target, 64, .5, .5, true);
    
    if (_distance <= 64)
    {
        outline_start(2, c_white, sprite_index, image_index);
        
        if (_input2)
        {
            if (!global.energy)
            {
                var _d = instance_create_layer(target.x, target.y, layer, obj_dialogue_basement5);
                global.panel = false;
            }
            else 
            {
                if (no) exit;
                audio_stop_all();
                audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx);
                instance_destroy(obj_ost);
                instance_create_layer(obj_gojou.x, obj_gojou.y, layer, obj_dialogue_gojou3);
                no = true
            	if (instance_exists(obj_darkness2)) instance_destroy(obj_darkness2);
            }
        }
    }
}

draw_self();

outline_end();
