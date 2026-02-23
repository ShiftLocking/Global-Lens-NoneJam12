/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;
normal_spd = 2;
spd = normal_spd;
acc = .6;
dcc = .4;

normal_grv = .4;
max_grv = 1.4;
grv = normal_grv;
max_vspd = 16;
jump_force = -8;
jump_amount = 1;
jump_count = jump_amount;
coyote_time = .08;
coyote = coyote_time;

what_state = "";
index = 0;
dir = 1;

effect_xscale = 0;
effect_yscale = 0;
effect_done = false;

atual_action = undefined;

move = function()
{
    //Pegando os inputs
    var d = movement();
    
    if (!global.cutscene)
    {
        //Caso ele estiver se movendo
        if (d.Hdir != 0)
        {
            //Pega a direção para onde está se movendo
            var _direction = point_direction(0, 0, d.Hdir, 0);
            //Aplica a direção no movimento com uma velocidade
            var _movement = lengthdir_x(spd * abs(d.Hdir), _direction);
            //Aplica o movimento suavemente no HSPD
            hspd = apr(hspd, _movement, acc);
        }
        else //Caso não estiver 
        {
            //Zera o HSPD suavemente
            hspd = apr(hspd, 0, dcc);
        }
    }
    
    //Define a ação
    if (hspd != 0) action = walk;
    
    //Define a ação
    if (hspd == 0) action = idle;
}

walk = function()
{
    what_state = "walk";
    set_sprite(spr_player_walk);
    
    if (hspd >= 1 or hspd <= -1) 
    {
        if (!effect_done)
        {
            effect_xscale = .2;
            effect_yscale = -.1;
            effect_done = true;
        }
        image_speed = hspd / spd;
    }
}

idle = function()
{
    what_state = "idle";
    set_sprite(spr_player_idle);
    image_speed = 1;
}

gravity_system = function()
{
    //Se o objeto não estiver colidindo 1 pixel abaixo
    if (!place_meeting(x, y + 1, obj_collision))
    {
        if (coyote > 0)
        {
            vspd = 0;
            coyote -= delta_time / 1000000;
        }
        else 
        {
            //Aplica gravidade no vspd
            vspd += grv;
        }
    }
    else //Se o objeto estiver colidindo
    {
        //Reseta a quantidade de pulos
    	jump_count = jump_amount;
        coyote = coyote_time;
    }
    
    //Limitando VSPD
    vspd = clamp(vspd, -max_vspd, max_vspd);
}

stopped = function()
{
    //Zerando suavemente o HSPD
    hspd = apr(hspd, 0, dcc);
	
	if (hspd == 0)
	{
		action = idle;
	}
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