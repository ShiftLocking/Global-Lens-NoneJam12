/// @description Insert description here
// You can write your code in this editor

var _amount = sprite_get_number(sprite_index)-1;

gamepad_check();

if (image_index > _amount)
{
    image_speed = 0;
    if (time_to_dialogue > 0)
    {
        time_to_dialogue -= delta_time / 1000000;
    }
    else 
    {
    	if (!instance_exists(obj_dialogue_bedroom))
        {
            if (!finished) instance_create_layer(x, y, layer, obj_dialogue_bedroom);
        }
        if (finished)
        {
            if (time_to_destroy > 0)
            {
                time_to_destroy -= delta_time / 1000000;
            }
            else 
            {
            	instance_destroy();
            }
        }
    }
}