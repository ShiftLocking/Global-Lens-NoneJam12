/// @description Insert description here
// You can write your code in this editor

if (surface_exists(surface))
{
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    draw_set_colour(c_red);
    draw_set_alpha(alpha);
    
    draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
    
    draw_set_alpha(1);
    draw_set_colour(c_white);
    surface_reset_target();
}

show_debug_message(alpha);