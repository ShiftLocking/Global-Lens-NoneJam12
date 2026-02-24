/// @description Insert description here
// You can write your code in this editor

randomise();

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale + xscale, image_yscale + yscale, image_angle, image_blend, image_alpha);

if (time_to_text <= 0)
{
    if (alpha <= .01)
    {
        random_x = irandom_range(x - sprite_width / 2, x + sprite_width / 2);
        random_angle = irandom_range(-15, 15);
    }
}

draw_set_halign(1);
draw_set_valign(1);
draw_set_alpha(alpha);
draw_set_font(fnt_peoples);
draw_text_transformed(random_x, y - sprite_height, text[text_position], 1, 1, random_angle);
draw_set_font(-1);
draw_set_alpha(1);
draw_set_halign(-1);
draw_set_valign(-1);