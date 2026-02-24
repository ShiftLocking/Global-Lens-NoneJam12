/// @description Insert description here
// You can write your code in this editor

if (instance_exists(instance_target))
{
    var _x = instance_target.x;
    var _y = instance_target.y - instance_target.sprite_height;
    var s = detection(0, true, "horizontal", "left");
    
    draw_sprite_ext(s.sprite, s.subming, _x, _y, 1, 1, 0, c_white, alpha);
}