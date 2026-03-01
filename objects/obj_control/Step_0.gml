/// @description Insert description here
// You can write your code in this editor

if (instance_exists(player) && instance_exists(gojou))
{
    if (time_dialogue > 0)
    {
        time_dialogue -= delta_time / 1000000;
    }
    else 
    {
        if (!finished)
        {
            if (!instance_exists(obj_limbo_dialogue))
            {
                instance_create_layer(player.x, player.y, layer, obj_limbo_dialogue);
            }
        }
        else 
        {
            var _layer = layer_get_id("Background");
            var element = layer_background_get_id(_layer);
            var a = layer_background_get_alpha(element);
            layer_background_alpha(element, lerp(a, 1, 0.1));
            if (!no)
            {
                gojou.image_alpha = lerp(gojou.image_alpha, 1, .1);
            }
            else 
            {
            	gojou.image_alpha = lerp(gojou.image_alpha, 0, .1);
                if (gojou.image_alpha <= 0)
                {
                    create_transition(rm_section_2_paper, "Transitions", 3);
                }
            }
            player.image_alpha = lerp(player.image_alpha, 1, .1);
            if (!instance_exists(obj_menu_ost)) instance_create_layer(0, 0, layer, obj_menu_ost);
            global.stopped = false;
        }
    }
}