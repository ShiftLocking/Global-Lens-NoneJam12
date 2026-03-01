/// @description Insert description here
// You can write your code in this editor

if (surface_exists(surface))
{
    surface_set_target(surface);
    draw_clear_alpha(c_black, alpha);
    
    draw_sprite_ext(spr_paper_gojou, 0, width / 2, height / 2 + y_pos, .7, .7, 0, c_white, 1);
    
    y_pos = lerp(y_pos, y_pos_fin, .1);
    
    if (y_pos_fin == 0)
    {
        if (y_pos <= 200)
        {
            alpha = lerp(alpha, .9, .1);
            global.DIALOGUE = true;
        }
    }
    else 
    {
        if (y_pos >= y_pos_ini - 100)
        {
            alpha = lerp(alpha, 0, .1);
        }
    }
    
    if (alpha >= .8)
    {
        sprite_alpha = lerp(sprite_alpha, 1, .1);
        if (instance_exists(obj_world_door))
        {
            obj_world_door.can_appear = true;
        }
        
        var _i = input("skip", "pressed", "button");
        if (_i)
        {
            y_pos_fin = y_pos_ini;
        }
    }
    else 
    {
    	sprite_alpha = lerp(sprite_alpha, 0, .1);
    }
    
    draw_set_halign(2);
    draw_set_valign(2);
    draw_set_font(fnt_warn);
    draw_set_alpha(sprite_alpha);
    
    var _input = input("skip", , , , true);
    var s = detection(_input);
    
    draw_text(width - sprite_get_width(s.sprite), height - sprite_get_height(s.sprite) / 4, "Aperte ");
    draw_sprite_ext(s.sprite, s.subming, width - sprite_get_width(s.sprite) / 2, height - 8, .8, .8, 0, c_white, sprite_alpha);
    
    draw_set_halign(-1);
    draw_set_valign(-1);
    draw_set_font(-1);
    draw_set_alpha(1);
    
    surface_reset_target();
    
    if (y_pos_fin != 0)
    {
        if (alpha <= .01)
        {
            instance_create_layer(obj_player.x, obj_player.y, layer, obj_dialogue_afterpaper);
            global.DIALOGUE = false;
            instance_destroy();
        }
    }
}