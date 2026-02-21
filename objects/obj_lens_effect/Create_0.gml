/// @description Insert description here
// You can write your code in this editor

surface = noone;

ini = function()
{
    if (!surface_exists(surface))
    {
        surface = surface_create(display_get_gui_width(), display_get_gui_height());
        
        surface_set_target(surface);
        
        draw_clear_alpha(c_black, 0);
        
        surface_reset_target();
    }
    else 
    {
        draw_surface(surface, 0, 0);
    }
}

close = function()
{
    instance_destroy();
}
