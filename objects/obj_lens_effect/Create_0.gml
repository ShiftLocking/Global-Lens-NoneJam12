/// @description Insert description here
// You can write your code in this editor

surface = noone;
alpha = 0;

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
    
    alpha = lerp(alpha, .5, .1);
    
    if (alpha >= .4)
    {
        global.visible_objects_lens = true;
    }
}

close = function()
{
    if (surface_exists(surface))
    {
        draw_surface(surface, 0, 0);
    }
    alpha = lerp(alpha, 0, .05);
    global.visible_objects_lens = false;
    
    if (alpha <= .01) 
    {
        instance_destroy();
    }
}
