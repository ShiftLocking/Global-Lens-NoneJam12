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
    //Pegando os inputs
    var d = movement();
    var _jump = input("jump", "pressed", "button");
    var _change = input("change", "pressed", "button");
    
    //Caso ele estiver se movendo
    if (d.Hdir != 0)
    {
        //Pega a direção para onde está se movendo
        var _direction = point_direction(0, 0, d.Hdir, 0);
        //Aplica a direção no movimento com uma velocidade
        var _movement = lengthdir_x(spd, _direction);
        //Aplica o movimento suavemente no HSPD
        hspd = apr(hspd, _movement, acc);
        //Define a ação
        action = walk;
    }
    else //Caso não estiver 
    {
        //Zera o HSPD suavemente
    	hspd = apr(hspd, 0, dcc);
        //Define a ação
        action = idle;
    }
    
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
    //Se a quantidade de pulo for maior que 0
    if (jump_count > 0)
    {
        //Aplica a força de pulo no VSPD
        vspd = jump_force;
        //Diminui a quantidade de pulos
        jump_count--;
    }
}

falling = function()
{
    what_state = "falling";
}

change = function()
{
    //Se os oculos não foram colocados
    if (!global.lens)
    {
        set_sprite(spr_player_activating);
        //Variavel que pega a quantidade de frames da sprite atual
        var _image_amount = sprite_get_number(sprite_index) - 1;
        //Ativa a variavel responsavel por parar o player
        global.stopped = true;
        what_state = "activating";
        //Se a imagem atual do sprite for maior que a imagem total da sprite
        if (image_index > _image_amount)
        {
            //Os oculos são colocados
            global.lens = true; 
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
        what_state = "disabling";
        //Se a imagem atual do sprite for maior que a imagem total da sprite
    	if (image_index > _image_amount)
        {
            //Os oculos são colocados
            global.lens = false;
            //Desativa a variavel responsavel por parar o player
            global.stopped = false;
            //Reseta a ação
            action = reset;
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
    else //Se o objeto estiver colidindo
    {
        //Reseta a quantidade de pulos
    	jump_count = jump_amount;
    }
    
    //Limitando VSPD
    vspd = clamp(vspd, -max_grv, max_grv);
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