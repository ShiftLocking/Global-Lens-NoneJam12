/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_graficos) or instance_exists(obj_controles) or instance_exists(obj_sons)) exit;

var _input = input("select", "pressed", "button");

if (surface_exists(surface))
{
    surface_set_target(surface);
    var _colour = make_colour_rgb(22, 37, 74);
    draw_clear_alpha(_colour, alpha);
    
    draw_set_halign(1);
    draw_set_valign(1);
    draw_set_font(fnt_introduction);
    draw_set_alpha(alpha);
    
    vel1 += sprite_get_speed(Axislefthor) / game_get_speed(gamespeed_fps);
    
    draw_text_ext(width / 2, height / 2, "Use controle para uma melhor experiência", 32, 400);
    draw_sprite(Axislefthor, vel1, width / 2, height / 1.5);
    
    draw_set_font(fnt_peoples);
    
    draw_text(width - 112, height - 16, "Feito por Shift_Locking");
    
    draw_set_alpha(1);
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
    
    surface_reset_target();
}

if (destroy) instance_destroy();

gamepad_check();

alpha = lerp(alpha, 1, .1);
if (alpha >= 1)
{
    if (time > 0)
    {
        time -= delta_time / 1000000;
    }
    else 
    {
    	create_transition(rm_menu, "Transitions", 3);
    }
}

if (keyboard_key or gamepad_any_input(0))
{
    time = 0;
}