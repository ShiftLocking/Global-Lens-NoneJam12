/// @description Insert description here
// You can write your code in this editor


if (time_dialogue > 0)
{
    time_dialogue -= delta_time / 1000000;
}
else 
{
    if (instance_exists(obj_paper) && !see)
    {
        obj_paper.image_alpha = lerp(obj_paper.image_alpha, 1, .05);
        if (obj_paper.image_alpha >= 1)
        {
            see = true;
            time_dialogue = 5;
        }
    }
    else 
    {
    	var _layer = layer_get_id("paper1");
        layer_set_visible(_layer, false);
        obj_paper.image_alpha = lerp(obj_paper.image_alpha, 0, .05);
        
        if (obj_paper.image_alpha <= .01)
        {
            if (!instance_exists(obj_final_phrase))
            {
                instance_create_layer(0, 0, layer, obj_final_phrase);
            }
        }
    }
}
