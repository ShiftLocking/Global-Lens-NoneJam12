/// @description Insert description here
// You can write your code in this editor

hspd = 0;
vspd = 0;
normal_spd = 4;
push_spd = 2;
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
    var _jump = input("jump", "pressed", "button");
    var _hold_jump = input("jump", "normal", "button");
    var _change = input("change", "pressed", "button");
    
    //Caso ele estiver se movendo
    if (d.Hdir != 0)
    {
        //Pega a direção para onde está se movendo
        var _direction = point_direction(0, 0, d.Hdir, 0);
        if (!global.push)
        {
            //Aplica a direção no movimento com uma velocidade
            var _movement = lengthdir_x(spd * abs(d.Hdir), _direction);
            //Aplica o movimento suavemente no HSPD
            hspd = apr(hspd, _movement, acc);
            //Define a ação
            action = run;
        }
        else 
        {
            var _dir_sign = (global.direction == 0) ? 1 : -1;

            // Só aplica se bater com d.Hdir
            if (sign(d.Hdir) == _dir_sign)
            {
                var _movement = lengthdir_x(spd * abs(d.Hdir), global.direction);
                hspd = _movement;
                action = push;
            }
        }
    }
    else //Caso não estiver 
    {
        if (!global.push)
        {
            //Zera o HSPD suavemente
    	    hspd = apr(hspd, 0, dcc);
            //Define a ação
            action = idle;
        }
        else 
        {
        	hspd = 0;
            action = idle_push;
        }
    }
    
    if (!_hold_jump && vspd < 0) //Verificando o clique no botão de pulo
    {
        //Corta o pulo pela metade dependendo do quanto o botão foi pressionado
        grv = lerp(grv, max_grv, .8);
    }
    else //Caso as condições não forem verdadeiras
    { 
        grv = normal_grv; //Deixa a gravidade normal
    }
    
    if (global.push) exit; 
    //Se ele pular, a quantidade de pulos for maior que 0 e o VSPD for igual a 0
    if (_jump && jump_count > 0 && vspd == 0)
    {
        //Define a ação
        action = jump;
    }
    
    //Se o VSPD for maior que 0
    if (vspd > 0) action = falling; //Define a ação
    //Se o VSPD for menor que 0
    if (vspd < 0) action = jump; //Define a ação
        
    
    //Se ele apertar para trocar
    if (_change) action = change; //Define a ação
}

run = function()
{
    what_state = "walk";
    set_sprite(spr_player_run);
    
    if (hspd >= 1 or hspd <= -1) 
    {
        if (!effect_done)
        {
            effect_xscale = .2;
            effect_yscale = -.2;
            effect_done = true;
        }
        image_speed = hspd / spd;
    }
    index = 0;
}

idle = function()
{
    what_state = "idle";
    set_sprite(spr_player_idle);
    image_speed = 1;
    index = 0;
}

jump = function()
{
    what_state = "jump";
    //Se a quantidade de pulo for maior que 0
    if (jump_count > 0)
    {
        coyote = 0;
        effect_xscale = .4;
        effect_yscale = -.2;
        //Aplica a força de pulo no VSPD
        vspd = jump_force;
        //Diminui a quantidade de pulos
        jump_count--;
    }
    set_sprite(spr_player_jump);
}

falling = function()
{
    what_state = "falling";
    effect_yscale = lerp(effect_yscale, .2, .2);
    set_sprite(spr_player_fall);
}

change = function()
{
    image_speed = 1;
    //Se os oculos não foram colocados
    if (!global.lens)
    {
        if (!global.inside_object)
        {
            set_sprite(spr_player_activating);
            //Variavel que pega a quantidade de frames da sprite atual
            var _image_amount = sprite_get_number(sprite_index) - 1;
            //Ativa a variavel responsavel por parar o player
            global.stopped = true;
            global.activate_collision = true;
            what_state = "activating";
            
            if (!instance_exists(obj_lens_effect))
            {
                instance_create_layer(0, 0, "Lens_Effect", obj_lens_effect);
            }
            
            //Se a imagem atual do sprite for maior que a imagem total da sprite
            if (image_index > _image_amount)
            {
                //Os oculos são colocados
                global.lens = true; 
                //Desativa a variavel responsavel por parar o player
                global.stopped = false;
                //Ativa o efeito do oculos
                global.lens_effect = true;
                //Reseta a ação
                action = reset;
            }
        }
        else 
        {
            if (!instance_exists(obj_inside_object))
            {
                var _toast = instance_create_layer(x, y, layer, obj_inside_object);
                _toast.instance = id;
                _toast.position = sprite_height;
            }
            //Desativa a variavel responsavel por parar o player
            global.stopped = false;
        	//Reseta a ação
            action = reset;
        }
    }
    else //Se os oculos foram colocados
    {
        set_sprite(spr_player_disabling);
        //Variavel que pega a quantidade de frames da sprite atual
        var _image_amount = sprite_get_number(sprite_index) - 1;
        //Ativa a variavel responsavel por parar o player
        global.stopped = true;
        global.activate_collision = false;
        what_state = "disabling";
        //Se a imagem atual do sprite for maior que a imagem total da sprite
    	if (image_index > _image_amount)
        {
            //Os oculos são colocados
            global.lens = false;
            //Desativa a variavel responsavel por parar o player
            global.stopped = false;
            //Desativa o efeito do oculos
            global.lens_effect = false;
            //Reseta a ação
            action = reset;
        }
    }
}

push = function()
{
    what_state = "push";
    set_sprite(spr_player_push, index);
    image_speed = 1;
    if (instance_exists(obj_box))
    {
        var _nereast = instance_nearest(x, y, obj_box);
        //Se o modo de empurrar estiver ativado
        if (global.push)
        {
            if (place_meeting(x + sign(hspd), y, _nereast))
            {
                _nereast.hspd = hspd;
            }
            
            with (_nereast)
            {
                var _next = instance_place(x + sign(other.hspd), y, obj_box);
                
                if (_next != noone)
                {
                    _next.hspd = other.hspd;
                }
            }
        }
    }
}

idle_push = function()
{
    what_state = "idle_push";
    
    set_sprite(spr_player_push, index);
    image_speed = 0;
    index = image_index;
    
    if (instance_exists(obj_box))
    {
        var _nereast = instance_nearest(x, y, obj_box);
        //Se o modo de empurrar estiver ativado
        if (global.push)
        {
            _nereast.hspd = hspd;
        }
        else 
        {
        	_nereast.hspd = 0;
        }
    }
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
        
        if (atual_action == falling)
        {
            if (!effect_done)
            {
                effect_xscale = .4;
                effect_yscale = -.1;
                effect_done = true;
            }
        }
    }
    
    //Limitando VSPD
    vspd = clamp(vspd, -max_vspd, max_vspd);
}

stopped = function()
{
    //Zerando suavemente o HSPD
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
            if (global.push) break;
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