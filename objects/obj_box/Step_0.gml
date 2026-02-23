/// @description Insert description here
// You can write your code in this editor

//Se a lente estiver ativa
if (global.lens)
{
    //Roda os sistemas
    push_system();
}

if (global.activate_collision)
{
    //Define a colisão
    mask_index = sprite_index;
}

//Se os objetos podem ser vistos
if (global.visible_objects_lens)
{
    //Aumenta a transparencia suavemente
    alpha = lerp(alpha, 1, .1);
    gravity_system();
}
else //Se os objetos não podem ser vistos
{
    //Diminui a trasparencia suavemente
	alpha = lerp(alpha, 0, .8);
    
    if (!global.activate_collision)
    {
        //Reseta a colisão
        mask_index = spr_nocollision;
    }
    
    //Variaveis de distancia
    var _nearest = instance_nearest(instance_target.x, instance_target.y, object_index);
    
    if (_nearest != noone)
    {
        // sprite ORIGINAL do objeto (não da instância)
        var _spr = _nearest.object_index.sprite_index;
    
        // posição do sprite no mundo
        var _x = _nearest.x - sprite_get_xoffset(_spr);
        var _y = _nearest.y - sprite_get_yoffset(_spr);
    
        var _w = sprite_get_width(_spr);
        var _h = sprite_get_height(_spr);
    
        // colisão pixel-perfect real
        if (collision_rectangle(_x, _y, _x + _w, _y + _h, instance_target, false, true))
        {
            global.inside_object = true;
        }
        else
        {
            global.inside_object = false;
        }
    }
    else
    {
        global.inside_object = false;
    }
}
