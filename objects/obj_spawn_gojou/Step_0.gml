/// @description Insert description here
// You can write your code in this editor

if (instance_exists(target))
{
    var _distance = point_distance(x, 0, target.x, 0);
    
    if (_distance <= 500)
    {
        instance_create_layer(x, y, layer, obj_gojou_introduction_1);
        instance_destroy();
    }
}