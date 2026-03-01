/// @description Insert description here
// You can write your code in this editor

if (time > 0)
{
    alpha = lerp(alpha, 1, .1);
    time -= delta_time / 1000000;
}
else
{
    alpha = lerp(alpha, 0, .1);
    if (alpha <= .01) game_end();
}

draw_set_halign(1);
draw_set_valign(1);
draw_set_font(fnt_introduction);
draw_set_alpha(alpha);

draw_text_ext(width / 2, height / 2, "Nem tudo precisa de uma explicação. Às vezes, a explicação é só uma forma de sobreviver", 32, 400);

draw_set_alpha(1);
draw_set_halign(-1);
draw_set_valign(-1);
draw_set_font(-1);
