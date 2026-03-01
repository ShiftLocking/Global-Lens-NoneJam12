/// @description Insert description here
// You can write your code in this editor

//Se os objetos podem ser vistos
if (global.visible_objects_lens)
{
    //Aumenta a transparencia suavemente
    alpha = lerp(alpha, 1, .1);
    see = true;
}
else //Se os objetos não podem ser vistos
{
    //Diminui a trasparencia suavemente
	alpha = lerp(alpha, 0, .8);
    see = false;
}