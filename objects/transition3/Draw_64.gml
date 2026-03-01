/// @description Insert description here
// You can write your code in this editor

// DRAW GUI
draw_set_colour(c_black);
draw_set_alpha(alpha);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);
draw_set_colour(c_white);

if (starting)
{
    // FADE-IN
    alpha += fade_spd;

    if (alpha >= 1)
    {
        alpha = 1;
        room_goto(next_room);
        starting = false;
    }
}
else
{
    // FADE-OUT
    alpha -= fade_spd;

    if (alpha <= 0)
    {
        alpha = 0;
        instance_destroy();
    }
}