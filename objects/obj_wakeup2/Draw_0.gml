/// @description Insert description here
// You can write your code in this editor

if (global.visible_objects_lens)
{
    draw_set_halign(1);
    draw_set_valign(1);
    draw_set_font(fnt_wall_phrases);
    draw_text_transformed(x, y, text, xscale, yscale, angle);
    draw_set_font(-1);
    draw_set_halign(-1);
    draw_set_valign(-1);
}