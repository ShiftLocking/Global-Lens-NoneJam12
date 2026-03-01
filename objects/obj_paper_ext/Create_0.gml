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

alpha = 0;
sprite_alpha = 0;
var _height = sprite_get_height(spr_paper_gojou);
y_pos_ini = _height * 1.5;
y_pos_fin = 0;
y_pos = y_pos_ini;