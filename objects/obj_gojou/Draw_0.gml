/// @description Insert description here
// You can write your code in this editor

if (global.visible_objects_lens)
{
    see = true;
}
else 
{
	see = false;
}

if (see)
{
    draw_self();
    if (instance_exists(target) && global.basement_dialogue)
    {
        var _distance = point_distance(x, 0, target.x, 0);
        var _input = input("interact", , , , true);
        var _input2 = input("interact", "pressed", "button");
        interact(_input, x, y - sprite_height, id, target, 64, .5, .5, true);
         
        if (_distance <= 64)
        {
            outline_start(2, c_white, sprite_index, image_index);
            
            if (_input2)
            {
                var _d = instance_create_layer(x, y, layer, obj_dialogue_gojou);
                global.basement_dialogue = false;
            }
        }
    }
    
    draw_self();
    
    outline_end();
}