global.interact = false;

/// @desc Essa função vai desenhar um sprite na posição que desejar com base na distancia de um objeto
/// @param {Constant.VirtualKey or Constant.GamepadButton} _button Tecla que aparecerá
/// @param {Real} _positionx Posição horizontal da sprite a ser desenhada
/// @param {Real} _positiony Posição vertical da sprite a ser desenhada
/// @param {Id.Instance} _id Objeto primario que será usado na distancia
/// @param {Asset.GMSprite} _object Objeto secundario que será usado na distancia
/// @param {Real} _distance Distancia minima para que o sprite possa ser desenhado
function interact(_button, _positionx, _positiony, _id, _object, _distance, _xscale = 1, _yscale = 1, _justhorizontal = false)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "interact_state"))
    {
        interact_state = interact_create();
    }
    
    //Pegando a sprite do botão
    var _interact_bind = detection(_button);
    
    if (!_justhorizontal)
    {
        //Pegando a distancia do objeto base em relação ao objeto secundario
        interact_state.dist = point_distance(_id.x, _id.y, _object.x, _object.y);
    }
    else 
    {
    	//Pegando a distancia do objeto base em relação ao objeto secundario
        interact_state.dist = point_distance(_id.x, 0, _object.x, 0);
    }
    
    //Desenhando a sprite do botão
    draw_sprite_ext(_interact_bind.sprite, _interact_bind.subming, _positionx, interact_state.posy, _xscale, _yscale, 0, c_white, interact_state.blend);
    
    //Caso a distancia for menor que a distancia dada
    if (interact_state.dist <= _distance)
    {
        //Aumenta suavemente a posição vertical
        interact_state.posy = lerp(interact_state.posy, _positiony, .2);
        //Caso o dialogo não aparecer ainda
        if (!global.DIALOGUE)
        {
            //Aumenta a transparencia
            interact_state.blend = lerp(interact_state.blend, 1, .2);
            //Coloca o efeito de flutuamento
            interact_state.float_number -= 2 * (delta_time / 1000000);
            interact_state.posy += .5 * sin(interact_state.float_number);
        }
        else //Caso o dialogo estiver aparecendo
        {
            //Fica transparente
        	interact_state.blend = lerp(interact_state.blend, 0, .2);
            //E para de flutuar
            interact_state.float_number = 0;
        }
    }
    else //Caso for maior
    {
        //Diminui a transparencia
        interact_state.blend = lerp(interact_state.blend, 0, .4);
        //Zera o flutuamento
        interact_state.float_number = 0;
        
        //Caso ele estiver totalmente transparente
        if (interact_state.blend <= 0) 
        {
            //Reseta a posição dele
            interact_state.posy = y - sprite_height / 2;
        }
    }
}

function interact_create()
{
    return {
        posy: y - sprite_height / 2,
        blend: 0,
        show: false,
        dist: 0,
        float_number: 0
    };
}
