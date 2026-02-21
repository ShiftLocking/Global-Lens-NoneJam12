/// @description Insert description here
// You can write your code in this editor

var size = sprite_get_width(sprite);
var coll = ceil(display_get_gui_width() / size);
var lines = ceil(display_get_gui_height() / size);

var image_spd = sprite_get_speed(sprite) / game_get_speed(gamespeed_fps);
var image_nmb = sprite_get_number(sprite)-1;

if (image_spd < 2)
{
    show_debug_message("A VELOCIDADE DA SPRITE DEVE NO MINIMO 120 FPS");
    exit;
}

for (var i = 0; i < lines; i++)
{
    for (var j = 0; j < coll; j++)
    {
        var _image;
        
        if (starting)
        {
            // DIAGONAL ENTRANDO (canto superior esquerdo → inferior direito)
            _image = min(max(0, image - (j + i)), image_nmb);
        }
        else 
        {
            // DIAGONAL VOLTANDO (frames voltam, mas mesma diagonal)
            _image = min(max(0, image - ((coll + lines) - (j + i))), image_nmb);
        }
        
        draw_sprite_ext(sprite, _image, j * size, i * size, 1, 1, 0, colour, 1);
    }
}

if (starting)
{ 
    image += image_spd;
    
    if (image - image_nmb > coll + image_nmb / 2)
    {
        room_goto(next_room);
        starting = false;
    }
}
else 
{ 
    image -= image_spd;
    
    if (image < 0)
    {
        instance_destroy();
    }
}