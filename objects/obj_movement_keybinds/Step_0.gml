/// @description Insert description here
// You can write your code in this editor

if (instance_exists(instance_target))
{
    if (time_to_appear <= 0)
    {
        if (instance_target.hspd != 0)
        {
            can_desappear = true;
        }
        
        if (can_desappear)
        {
            if (time_to_desappear > 0)
            {
                time_to_desappear -= delta_time / 1000000;
            }
            else 
            {
            	alpha = lerp(alpha, 0, .1);
                if (alpha <= .01)
                {
                    instance_destroy();
                }
            }
        }
        
        if (time_to_desappear > 0) alpha = lerp(alpha, 1, .1);
    }
    else 
    {
    	time_to_appear -= delta_time / 1000000;
    }
}

show_debug_message(alpha);