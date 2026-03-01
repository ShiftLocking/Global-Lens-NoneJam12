/// @description Insert description here
// You can write your code in this editor

if (instance_exists(obj_graficos) or instance_exists(obj_controles) or instance_exists(obj_sons)) exit;

var _input = input("select", "pressed", "button");
var _defined = has_last_room();

if (surface_exists(surface))
{
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    
    var _sprite_width = sprite_get_width(spr_pause);
    var _sprite_height = sprite_get_height(spr_pause);
    
    draw_set_halign(1);
    draw_set_valign(1);
    draw_set_font(fnt_pause);
    
    var _s = .1, _s0 = 0, _s1 = 0, _s2 = 0, _s3 = 0, _s4 = 0, _s5 = 0;
    
    switch (index) 
    {
    	case 0:
            _s0 = _s;
            if (_input)
            {
                create_transition(rm_introduction_1, "Transitions", 2);
                audio_stop_all();
                dont_create = true;
                instance_destroy(obj_menu_ost);
                audio_play_sound(snd_buttons_select, 1, false, .04 * global.additional_sfx);
                reset_last_room();
            }
        break;
        
        case 1:
            _s1 = _s;
            if (_input)
            {
                audio_stop_all();
                dont_create = true;
                instance_destroy(obj_menu_ost);
                audio_play_sound(snd_buttons_select, 1, false, .04 * global.additional_sfx);
                var _room = load_room();
                create_transition(_room, "Transitions", 2);
            }
        break;
        
        case 2:
            _s2 = _s;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_graficos);
            }
        break;
        
        case 3:
            _s3 = _s;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_controles);
            }
        break;

        case 4:
            _s4 = _s;
            if (_input)
            {
                instance_create_layer(0, 0, layer, obj_sons);
            }
        break;

        case 5:
            _s5 = _s;
            if (_input)
            {
                game_end();
            }
        break;
    }
    
    
    vel1 += sprite_get_speed(Joybindsupdown) / game_get_speed(gamespeed_fps);
    
    if (global.use_joystick)
    { 
        draw_sprite(Joybindsupdown, vel1, width / 2, height / 4)
    }
    else 
    {
        draw_sprite(VerArrows, vel1, width / 2, height / 4)
    }
    
    draw_text(width - 128, height - 90, "Selecionar:    ");
    var _i = input("select",,,,true);
    var s1 = detection(_i);
    draw_sprite_ext(s1.sprite, s1.subming, width - sprite_get_width(s1.sprite), height - sprite_get_height(s1.sprite) - 8, .8, .8, 0, c_white, 1);
    
    if (!instance_exists(obj_back))
    {
        instance_create_layer(0, 0, layer, obj_back);
    }
    else 
    {
        with (obj_back)
        {
            var _target;
            if (instance_exists(obj_menu)) _target = obj_menu;
            if (instance_exists(obj_pause)) _target = obj_pause;
            
            if (surface_exists(_target.surface))
            {
                surface_set_target(_target.surface);
           	    draw_text(other.width - 128, other.height - 32, "Voltar:");
                var _i2 = input("back",,,,true);
                var s2 = detection(_i2);
                draw_sprite_ext(s2.sprite, s2.subming, other.width - sprite_get_width(s2.sprite), other.height - 16, .8, .8, 0, c_white, 1);
                surface_reset_target();
            }
        }
    } 
    
    var _height = 0;
    var _sep = (_sprite_height * .8) + 4;
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s0, .8 + _s0, 0, c_white, 1);
    draw_text_transformed(width / 2, height / 3 + _height, "Começar", 1 + _s0, 1 + _s0, 0);
    _height += _sep;
    
    if (_defined)
    {
        draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s1, .8 + _s1, 0, c_white, 1);
        draw_text_transformed(width / 2, height / 3 + _height, "Continuar", 1 + _s1, 1 + _s1, 0);
        _height += _sep;
    }
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s2, .8 + _s2, 0, c_white, 1); 
    draw_text_transformed(width / 2, height / 3 + _height, "Graficos", 1 + _s2, 1 + _s2, 0);
    _height += _sep;
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s3, .8 + _s3, 0, c_white, 1); 
    draw_text_transformed(width / 2, height / 3 + _height, "Controles", 1 + _s3, 1 + _s3, 0);
    _height += _sep;
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s4, .8 + _s4, 0, c_white, 1); 
    draw_text_transformed(width / 2, height / 3 + _height, "Sons", 1 + _s4, 1 + _s4, 0);
    _height += _sep;
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 3 + _height, 2.5 + _s5, .8 + _s5, 0, c_white, 1);
    draw_text_transformed(width / 2, height / 3 + _height, "Sair", 1 + _s5, 1 + _s5, 0);
    
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
    
    surface_reset_target();
}

var _up = input("up", "pressed", "button");
var _down = input("down", "pressed", "button");

var pitch = 1;

if (_down)
{
    if (index < 5) 
    {
        index++;
        pitch = random_range(1, 1.1);
        audio_stop_sound(snd_buttons_navegate);
        audio_play_sound(snd_buttons_navegate, 1, false, .01 * global.additional_sfx, undefined, pitch);
        
        if (!_defined)
        {
            if (index == 1) index = 2;
        }
    }
}

if (_up)
{
     if (index > 0) 
    {
        index--;
        pitch = random_range(1, 1.1);
        audio_stop_sound(snd_buttons_navegate);
        audio_play_sound(snd_buttons_navegate, 1, false, .01 * global.additional_sfx, undefined, pitch);
        
        if (!_defined)
        {
            if (index == 1) index = 0;
        }
    }
}

if (!instance_exists(obj_menu_ost) && !dont_create) instance_create_layer(0, 0, layer, obj_menu_ost);

save_configs();

if (destroy) instance_destroy();

gamepad_check();