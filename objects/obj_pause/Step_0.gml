/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_graficos) or instance_exists(obj_controles)) exit;

var _input = input("select", "pressed", "button");

if (surface_exists(surface))
{
    surface_set_target(surface);
    draw_clear_alpha(c_black, .8);
    
    var _sprite_width = sprite_get_width(spr_pause);
    var _sprite_height = sprite_get_height(spr_pause);
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 2, 2, 1.8, 0, c_white, 1);
    
    draw_set_halign(1);
    draw_set_valign(1);
    draw_set_font(fnt_pause);
    
    var _c = make_colour_rgb(252, 87, 87), _c0 = c_white, _c1 = c_white, _c2 = c_white, _c3 = c_white, _c4 = c_white, _c5 = c_white;
    
    switch (index) 
    {
    	case 0:
            _c0 = _c;
            if (_input)
            {
                global.paused = false;
                destroy = true;
            }
        break;
        
        case 1:
            _c1 = _c;
            if (_input)
            {
                if (instance_exists(obj_reset)) obj_reset.run = true;
                global.paused = false;
                destroy = true;
            }
        break;
        
        case 2:
            _c2 = _c;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_graficos);
            }
        break;
        
        case 3:
            _c3 = _c;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_controles);
            }
        break;

        case 4:
            _c4 = _c;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_sons);
            }
        break;

        case 5:
            _c5 = _c;
            if (_input)
            {
                create_transition(rm_menu, "Transitions", 2, , , .1);
                global.paused = false;
            }
        break;
    }
    
    vel1 += sprite_get_speed(Joybindsupdown) / game_get_speed(gamespeed_fps);
    
    if (global.use_joystick)
    { 
        draw_sprite(Joybindsupdown, vel1, width / 2, height / 2 - _sprite_height - 8)
    }
    else 
    {
        draw_sprite(VerArrows, vel1, width / 2, height / 2 - _sprite_height - 8)
    }
    
    draw_text(width / 2 - _sprite_width / 2, height / 2 + _sprite_height + 16, "Selecionar:");
    var _i = input("select",,,,true);
    var s1 = detection(_i);
    draw_sprite_ext(s1.sprite, s1.subming, width / 2 + _sprite_width, height / 2 + _sprite_height + sprite_get_height(s1.sprite) / 2, .8, .8, 0, c_white, 1);
    
    draw_text_colour(width / 2, height / 2 - (_sprite_height / 1.5), "Continuar", _c0, _c0, _c0, _c0, 1);
    
    if (instance_exists(obj_reset))
    {
        draw_text_colour(width / 2, height / 2 - (_sprite_height / 2.2), "Resetar", _c1, _c1, _c1, _c1, 1);
    }
    
    draw_text_colour(width / 2, height / 2 - (_sprite_height / 4.2), "Graficos", _c2, _c2, _c2, _c2, 1);
    draw_text_colour(width / 2, height / 2, "Controles", _c3, _c3, _c3, _c3, 1);
    draw_text_colour(width / 2, height / 2 + (_sprite_height / 4.2), "Sons", _c4, _c4, _c4, _c4, 1);
    draw_text_colour(width / 2, height / 2 + (_sprite_height / 2.2), "Voltar", _c5, _c5, _c5, _c5, 1);
    
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
    
    surface_reset_target();
}

var _up = input("up", "pressed", "button");
var _down = input("down", "pressed", "button");

if (_down)
{
    if (index < 5) index++;
        
    if (!instance_exists(obj_reset))
    {
        if (index == 1) index = 2;
    }
}

if (_up)
{
     if (index > 0) index--;
        
    if (!instance_exists(obj_reset))
    {
        if (index == 1) index = 0;
    }
}

save_configs();

if (destroy) instance_destroy();

gamepad_check();