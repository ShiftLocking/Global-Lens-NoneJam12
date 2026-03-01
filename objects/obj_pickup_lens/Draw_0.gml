/// @description Insert description here
// You can write your code in this editor

if (instance_exists(target))
{
    var _distance = point_distance(x, y, target.x, target.y);
    var _input = input("interact", , , , true);
    var _input2 = input("interact", "pressed", "button");
    interact(_input, x, y - sprite_height, id, target, 90, .5, .5);
     
    if (_distance <= 90)
    {
        outline_start(2, c_white, sprite_index, image_index);
        
        if (_input2)
        {
            create_warn(spr_textwarn, "Oculos coletado!", "fnt_warn", "Dialogues", 5);
            instance_create_layer(target.x, target.y, layer, obj_dialogue_lens);
            instance_destroy();
        }
    }
}

draw_self();

outline_end();