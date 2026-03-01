/// @description Insert description here
// You can write your code in this editor


if (surface_exists(surface))
{
    surface_set_target(surface);
    draw_clear_alpha(c_black, .9);
    
    var _target = obj_light;
    if (instance_exists(_target))
    {
        gpu_set_blendmode(bm_subtract);
    
        with (_target)
        {
            draw_sprite_ext(spr_light, 0, x, y - sprite_height / 2, 8, 8, 0, c_white, 1);
        }
    
        gpu_set_blendmode(bm_normal);
    }
    var _target2 = obj_player;
    if (instance_exists(_target2))
    {
        gpu_set_blendmode(bm_subtract);
        
        draw_sprite_ext(spr_light, 0, _target2.x, _target2.y - _target2.sprite_height / 2, 4, 4, 0, c_white, 1);
        
        gpu_set_blendmode(bm_normal);
    }
    var _target3 = obj_gojou;
    if (instance_exists(_target3))
    {
        if (_target3.see)
        {
            gpu_set_blendmode(bm_subtract);
            
            draw_sprite_ext(spr_light, 0, _target3.x, _target3.y - _target3.sprite_height / 2, 2, 2, 0, c_white, 1);
            
            gpu_set_blendmode(bm_normal);
        }
    }
    
    var _target4 = obj_panel;
    if (instance_exists(_target4))
    {
        gpu_set_blendmode(bm_subtract);
        
        draw_sprite_ext(spr_light, 0, _target4.x, _target4.y - _target4.sprite_height / 2, 6, 6, 0, c_white, 1);
        
        gpu_set_blendmode(bm_normal);
    }
    
    var _target5 = obj_lever;
    if (instance_exists(_target5))
    {
        if (_target5.see)
        {
            gpu_set_blendmode(bm_subtract);
            
            draw_sprite_ext(spr_light, 0, _target5.x, _target5.y - _target5.sprite_height / 2, 6, 6, 0, c_white, 1);
            
            gpu_set_blendmode(bm_normal);
        }
    }
    
    surface_reset_target();
    
    
}