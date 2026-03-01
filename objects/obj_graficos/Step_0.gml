/// @description Insert description here
// You can write your code in this editor

var _target;

if (instance_exists(obj_menu)) _target = obj_menu;
if (instance_exists(obj_pause)) _target = obj_pause;

if (surface_exists(_target.surface))
{
    surface_set_target(_target.surface);
    draw_clear_alpha(c_black, .8);
    
    var _scale = 4;
    
    var _sprite_width = sprite_get_width(spr_pause) * _scale;
    var _sprite_height = sprite_get_height(spr_pause) * _scale;
    
    draw_sprite_ext(spr_pause, 0, width / 2, height / 2, _scale, _scale, 0, c_white, 1);
    
    draw_set_halign(1);
    draw_set_valign(1);
    draw_set_font(fnt_pause);
    
    var _c = make_colour_rgb(252, 87, 87), _c0 = c_white, _c1 = c_white;
    
    var _select = input("select", "pressed", "button");
    
    switch (index) 
    {
    	case 0:
            _c0 = _c;
            if (_select)
            {
                i1 = !i1;
                uptade_cam();
                global.fullscreen = i1;
            }
        break;
        
        case 1:
            _c1 = _c;
            if (_select)
            {
                i2 = !i2;
                global.borderless_fullscreen = i2;
            }
        break;
    }
    
    vel1 += sprite_get_speed(Joybindsupdown) / game_get_speed(gamespeed_fps);
    
    if (global.use_joystick)
    { 
        draw_sprite(Joybindsupdown, vel1, width / 2, height / 2 - _sprite_height / 2 - 8)
    }
    else 
    {
        draw_sprite(VerArrows, vel1, width / 2, height / 2 - _sprite_height / 2 - 8)
    }
    
    draw_text(width / 2 - _sprite_width / 8, height / 2 + _sprite_height / 2 + 16, "Selecionar:");
    var _i = input("select",,,,true);
    var s1 = detection(_i);
    draw_sprite_ext(s1.sprite, s1.subming, width / 2 + _sprite_width / 4, height / 2 + _sprite_height / 2 + sprite_get_height(s1.sprite) / 2, .8, .8, 0, c_white, 1);
    
    if (!instance_exists(obj_back))
    {
        instance_create_layer(0, 0, layer, obj_back);
    }
    else 
    {
        with (obj_back)
        {
            var _target1;
            if (instance_exists(obj_menu)) _target1 = obj_menu;
            if (instance_exists(obj_pause)) _target1 = obj_pause;
            
            if (surface_exists(_target1.surface))
            {
                surface_set_target(_target1.surface);
           	    draw_text(other.width - 128, other.height - 32, "Voltar:");
                var _i2 = input("back",,,,true);
                var s2 = detection(_i2);
                draw_sprite_ext(s2.sprite, s2.subming, other.width - sprite_get_width(s2.sprite), other.height - 16, .8, .8, 0, c_white, 1);
                surface_reset_target();
            }
        }
    } 
    
    draw_text_colour(width / 2, height / 2 - _sprite_height / 8, "Tela cheia", _c0, _c0, _c0, _c0, 1);
    
    draw_sprite(spr_selectbox, i1, width / 2, height / 2);
    
    draw_text_colour(width / 2, height / 2 + _sprite_height / 8, "Sem bordas", _c1, _c1, _c1, _c1, 1);
    
    draw_sprite(spr_selectbox, i2, width / 2, height / 2 + _sprite_height / 4);
    
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
    
    surface_reset_target();
}

var _up = input("up", "pressed", "button");
var _down = input("down", "pressed", "button");
var _back = input("back", "pressed", "button");

if (_back)
{
    instance_destroy();
}

if (_down)
{
    if (index < 1) index++;
}

if (_up)
{
     if (index > 0) index--;
        
}

gamepad_check();