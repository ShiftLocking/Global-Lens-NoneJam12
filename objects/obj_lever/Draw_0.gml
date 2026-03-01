/// @description Insert description here
// You can write your code in this editor

if (global.visible_objects_lens)
{
    see = true;
}
else 
{
	see = false;
}

if (see)
{
    if (instance_exists(target) && !global.energy)
    {
        var _distance = point_distance(x, 0, target.x, 0);
        var _distancey = point_distance(0, y, 0, target.y);
        var _input = input("interact", , , , true);
        var _input2 = input("interact", "pressed", "button");
        interact(_input, x, y - sprite_height, id, target, 64, .5, .5, true);
        
        if (_distance <= 64)
        {
            outline_start(2, c_white, sprite_index, image_index);
            
            if (_input2)
            {
                if (target.vspd == 0)
                {
                    if (_distancey <= 32)
                    {
                        global.energy = true;
                        global.shake_width = -2;
                        global.shake_height = -2;
                        audio_stop_sound(snd_shake_impact);
                        audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx);
                        instance_create_layer(target.x, target.y, layer, obj_dialogue_basement7);
                        global.panel = true;
                        global.change = false;
                        image_index = 1;
                    }
                    else 
                    {
                        if (!instance_exists(obj_tutorial_push)) instance_create_layer(0, 0, "Inputs", obj_tutorial_push);
                    	instance_create_layer(target.x, target.y, layer, obj_dialogue_basement6);
                    }
                }
            }
        }
    }
    
    draw_self();
}

outline_end();