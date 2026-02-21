/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;
spd = 4;
acc = .6;
dcc = .4;

grv = .4;
max_grv = 16;
jump_force = -8;
jump_amount = 1;
jump_count = jump_amount;

what_state = "";

move = function()
{
    var d = movement();
    var _jump = input("jump", "pressed", "button");
    var _change = input("change", "pressed", "button");
    
    if (d.Hdir != 0)
    {
        var _direction = point_direction(0, 0, d.Hdir, 0);
        var _movement = lengthdir_x(spd, _direction);
        hspd = apr(hspd, _movement, acc);
        action = walk;
    }
    else 
    {
    	hspd = apr(hspd, 0, dcc);
        action = idle;
    }
    
    if (_jump && jump_count > 0 && vspd == 0)
    {
        action = jump;
    }
    
    if (vspd > 0) action = falling;
    if (vspd < 0) action = jump;
    
    if (_change) action = change;
}

walk = function()
{
    what_state = "walk";
}

idle = function()
{
    set_sprite(spr_player);
    what_state = "idle";
}

jump = function()
{
    what_state = "jump";
    if (jump_count > 0)
    {
        vspd = jump_force;
        jump_count--;
    }
}

falling = function()
{
    what_state = "falling";
}

change = function()
{
    if (!global.lens)
    {
        set_sprite(spr_player_activating);
        var _image_amount = sprite_get_number(sprite_index) - 1;
        global.stopped = true;
        what_state = "activating";
        if (image_index > _image_amount)
        {
            global.lens = true; 
            global.stopped = false;
            action = reset;
        }
    }
    else 
    {
        set_sprite(spr_player_disabling);
        var _image_amount = sprite_get_number(sprite_index) - 1;
        global.stopped = true;
        what_state = "disabling";
    	if (image_index > _image_amount)
        {
            global.lens = false;
            global.stopped = false;
            action = reset;
        }
    }
}

gravity_system = function()
{
    if (!place_meeting(x, y + 1, obj_collision))
    {
        vspd += grv;
    }
    else 
    {
    	jump_count = jump_amount;
    }
    
    vspd = clamp(vspd, -max_grv, max_grv);
}

stopped = function()
{
    hspd = apr(hspd, 0, dcc);
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

reset = undefined;
action = reset;