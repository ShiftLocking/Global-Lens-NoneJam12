/// @description Insert description here
// You can write your code in this editor

if (instance_exists(target))
{
    x = target.x;
    y = target.y;
    var _input = input("push", , , , true);
    
    var _nereast = instance_nearest(target.x, target.y, obj_box);
    var _distance = point_distance(target.x, 0, _nereast.x, 0);
    
    if (_distance <= 130) interact(_input, target.x, target.y - target.sprite_height, id, target, 1, .8, .8);
}