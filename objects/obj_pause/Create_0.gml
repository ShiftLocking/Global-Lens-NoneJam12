/// @description Insert description here
// You can write your code in this editor

surface = noone;

width = display_get_gui_width();
height = display_get_gui_height();

ini = function()
{
    if (!surface_exists(surface))
    {
        surface = surface_create(width, height);
        
        surface_set_target(surface);
        
        draw_clear_alpha(c_black, 0);
        
        surface_reset_target();
    }
    else 
    {
        draw_surface(surface, 0, 0);
    }
}

index = 0;
destroy = false;

vel1 = 0;