/// @description Insert description here
// You can write your code in this editor

//Se o contorno estiver ativado
if (outline)
{
    //Inicia o contorno
    outline_start(2, c_white, sprite_index, image_index);
}

system();

//Desenha a sprite
draw_sprite_ext(sprite_index, image_index, x, y + f, image_xscale, image_yscale, image_angle, image_blend, alpha);

//Termina o contorno
outline_end();