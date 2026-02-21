/// @description Insert description here
// You can write your code in this editor

initial_distance = 128;
instance_target = obj_player;
hspd = 0;
vspd = 0;
grv = .4;
max_grv = 15;
outline = false;
can_push = false;

outline_init();

push_system = function()
{
    var _push = input("push", "normal", "button");
    if (instance_exists(instance_target))
    {
        var _player_dist = point_distance(x, 0, instance_target.x, 0);
        var _player_vertical_dist = point_distance(0, y, 0, instance_target.y);
        
        if (_player_dist <= initial_distance)
        { 
            if (_player_vertical_dist == 0)
            {
                var dx = instance_target.x - x;
                
                if (dx > 0) global.direction = 180;
                if (dx < 0) global.direction = 0;
                
                if (place_meeting(x + sign(dx), y, instance_target))
                {
                    can_push = true;
                }
                else 
                {
                	can_push = false;
                }
                
                show_debug_message(sign(dx));
                
                if (_push) global.push = true;
                else global.push = false;
                    
                
                if (!global.push)
                {
                    outline = true;
                }
                else 
                {
                	outline = false;
                }
            }
            else 
            {
            	outline = false;
            }
        }
        else 
        {
        	outline = false;
        }
        
        if (global.push)
        {
            if (can_push)
            {
                hspd = instance_target.hspd;
            }
            else 
            {
            	hspd = 0;
            }
        }
        else 
        {
        	hspd = 0;
        }
    }
}

gravity_system = function()
{
    //Se o objeto não estiver colidindo 1 pixel abaixo
    if (!place_meeting(x, y + 1, obj_collision))
    {
        //Aplica gravidade no vspd
        vspd += grv;
    }
    
    //Limitando VSPD
    vspd = clamp(vspd, -max_grv, max_grv);
}

collision = function()
{
    //Laço de repetição do número positivo do hspd
    repeat(abs(hspd))
    {
        //Caso colidir na horizontal
        if (place_meeting(x + sign(hspd), y, obj_collision))
        {
            //Vai zerar o hspd
            hspd = 0;
            break; //E parar o código
        }
        else //Caso não colidir
        {
            //Vai adicionar no X, 1 do hspd
            x += sign(hspd);
        }
    }
    //Laço de repetição do número positivo do vspd
    repeat(abs(vspd))
    {
        //Caso colidir na vertical
        if (place_meeting(x, y + sign(vspd), obj_collision))
        {
            //Vai zerar o hspd
            vspd = 0;
            break; //E parar o código
        }
        else //Caso não colidir
        {
            //Vai adicionar no Y, 1 do vspd
            y += sign(vspd);
        }
    }
}