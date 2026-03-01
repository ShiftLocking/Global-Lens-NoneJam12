/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;
normal_spd = 4;
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

target = obj_player_introduction_1;

move = function()
{
    if (instance_exists(target))
    {
        var _distance = point_distance(x, 0, target.x, 0);
        if (_distance > sprite_width * 2)
        {
            var _direction = point_direction(x, 0, target.x, 0);
            var _movement = lengthdir_x(spd, _direction);
            hspd = apr(hspd, _movement, acc);
        }
        else 
        {
        	hspd = apr(hspd, 0, dcc);
            global.cutscene = true;
            global.cutscene_actions = ["stop"];
            
            if (!instance_exists(obj_cutscene_control_int_1))
            {
                instance_create_layer(x, y, layer, obj_cutscene_control_int_1);
            }
        }
    }
    
    //Define a ação
    if (hspd != 0) action = run;
    
    //Define a ação
    if (hspd == 0) action = giving;
}

run = function()
{
    what_state = "run";
    set_sprite(spr_gojou_run);
    
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

giving = function()
{
    what_state = "giving";
    set_sprite(spr_gojou_giving);
    
    var _number = sprite_get_number(sprite_index)-1;
    
    if (image_index > _number)
    {
        image_speed = 0;
        if (!instance_exists(obj_lens))
        {
            var _lens = instance_create_layer(target.x, target.y, "Lens", obj_lens);
            _lens.target = target;
            
            target.dir = sign(target.x + x);
            
            instance_create_layer(0, 0, "Lens_Effect", obj_lens_effect);
            instance_create_layer(x, y, layer, obj_gojou_dialogue_int_1);
            //Os oculos são colocados
            global.lens = true; 
            //Ativa o efeito do oculos
            global.lens_effect = true;
            audio_stop_sound(snd_activating);
            audio_play_sound(snd_activating, 1, false, .1 * global.additional_sfx); 
        }
    }
    else 
    {
    	image_speed = 1;
    }
}

paused = function()
{
    image_speed = 0;
    hspd = 0;
    vspd = 0;
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
    vspd = clamp(vspd, -max_vspd, max_vspd);
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