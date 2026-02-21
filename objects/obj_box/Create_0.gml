/// @description Insert description here
// You can write your code in this editor

initial_distance = 130;
instance_target = obj_player;
hspd = 0;
vspd = 0;
grv = .4;
max_grv = 15;
outline = false;
can_push = false;

alpha = 0;

outline_init();

push_system = function()
{
    //Pegando o input
    var _push = input("push", "normal", "button");
    
    //Se a instancia alvo existir
    if (instance_exists(instance_target))
    {
        var _nereast = instance_nearest(instance_target.x, instance_target.y, object_index);
        //Pega a distancia horizontal da instancia
        var _player_dist = point_distance(x, 0, instance_target.x, 0);
        //Pega a distancia vertical da instancia
        var _player_vertical_dist = point_distance(0, y, 0, instance_target.y);
        
        //Se a distancia horizontal for menor que a distancia inicial
        if (_player_dist <= initial_distance)
        { 
            //Se a distancia vertical for igual a 0
            if (_player_vertical_dist == 0)
            {
                //Variavel que pega a direção da instancia em relação ao objeto
                var dx = instance_target.x - _nereast.x;
                
                //Se estiver para direita
                if (dx > 0) global.direction = 180; //Define a direção para esquerda
                //Se estiver para direita
                if (dx < 0) global.direction = 0; //Define a direção para direita
                
                //Se estiver colidindo em alguns dos lados
                if (place_meeting(_nereast.x + sign(dx), _nereast.y, instance_target))
                {
                    //Permite ser empurrado
                    can_push = true;
                }
                else //Se não está colidindo
                {
                    //Não permite ser empurrado
                	can_push = false;
                }
                
                //Se apertar a tecla de empurrar
                if (_push) global.push = true; //Ativa o modo de empurrar
                //Se não apertar
                else global.push = false; //Desativa o modo de empurrar
                    
                //Se o modo de empurrar estiver desativado
                if (!global.push)
                {
                    //Ativa o contorno
                    outline = true;
                    hspd = 0;
                }
                else //Se estiver ativado
                {
                    //Desativa o contorno
                	outline = false;
                }
            }
            else //Se for diferente de 0
            {
                //Desativa o contorno
            	outline = false;
                if (point_distance(0, _nereast.y, 0, instance_target.y) != 0)
                {
                    global.push = false; //Desativa o modo de empurrar
                }
            }
        }
        else //Se for maior que a distancia inicial
        {
            //Desativa o contorno
        	outline = false;
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