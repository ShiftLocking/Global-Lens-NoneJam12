/// @description Insert description here
// You can write your code in this editor

//Se a lente estiver ativa
if (global.lens)
{
    //Roda os sistemas
    push_system();
}

//Se os objetos podem ser vistos
if (global.visible_objects_lens)
{
    //Aumenta a transparencia suavemente
    alpha = lerp(alpha, 1, .1);
    //Define a colisão
    mask_index = sprite_index;
    gravity_system();
}
else //Se os objetos não podem ser vistos
{
    //Diminui a trasparencia suavemente
	alpha = lerp(alpha, 0, .8);
    //Reseta a colisão
    mask_index = spr_nocollision;
    
    //Variaveis de distancia
    var _nereast = instance_nearest(instance_target.x, instance_target.y, object_index);
    var _player_dist_horizontal = point_distance(_nereast.x, 0, instance_target.x, 0);
    var _player_dist_vertical = point_distance(0, _nereast.y, 0, instance_target.y);
    
    if (_player_dist_horizontal <= sprite_width / 1.5 && _player_dist_vertical <= sprite_height)
    {
        global.inside_object = true;
    }
    else
    {
        global.inside_object = false;
    }
}
