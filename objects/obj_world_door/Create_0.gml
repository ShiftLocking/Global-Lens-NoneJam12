/// @description Insert description here
// You can write your code in this editor

alpha = 0;

can_appear = false;

initial_distance = 64;
instance_target = obj_player;
outline = false;
dialogue = true;
global.can_next = false;
outline_init();

system = function()
{
    var _input = input("interact", , , , true);
    var _input2 = input("interact", "pressed", "button");
    if (instance_exists(instance_target))
    {
        var _distance = point_distance(x, 0, instance_target.x, 0);
        
        interact(_input, x, y - sprite_height, id, instance_target, initial_distance, .8, .8, true);
        if (_distance <= initial_distance) 
        {
            outline = true;
            if (_input2)
            {
                if (!instance_exists(obj_dialogue_door) && dialogue)
                {
                    instance_create_layer(instance_target.x, instance_target.y, layer, obj_dialogue_door);
                    dialogue = false;
                }
                else 
                {
                	if (global.can_next)
                    {
                        create_transition(rm_section_1_basement, "Transitions");
                        audio_stop_all();
                        reset_globals();
                        global.can_next = false;
                    }
                }
            }
        }
        else 
        {
            outline = false;
        }
    }
}