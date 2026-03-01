/// @description Insert description here
// You can write your code in this editor

alpha = 0;
initial_distance = 64;
instance_target = obj_player;
outline = false;
f = 0;

see = false;

outline_init();

system = function()
{
    if (see)
    {
        var _input = input("interact", , , , true);
        var _input2 = input("interact", "pressed", "button");
        if (instance_exists(instance_target))
        {
            var _distance = point_distance(x, 0, instance_target.x, 0);
            
            interact(_input, x, y - sprite_height, id, instance_target, initial_distance, .5, .5, true);
            if (_distance <= initial_distance) 
            {
            	outline = true;
                if (_input2)
                {
                    instance_create_layer(instance_target.x, instance_target.y, "Dialogues", obj_dialogue_paper);
                    instance_destroy();
                }
            }
            else 
            {
            	outline = false;
            }
        }
    }
    else 
    {
    	outline = false;
    }
}

floating = function()
{
    static _f = 0;
    //Coloca o efeito de flutuamento
    _f -= 1.5 * (delta_time / 1000000);
    f += .1 * sin(_f);
}