global.DIALOGUE = false;

/// @desc Essa função irá criar um toast caso você chegar perto ou interagir com o objeto
/// @param {Asset.GMSprite} _sprite Sprite que será utilizado pelo toast
/// @param {String} _text Texto a ser usado
/// @param {String} _font Fonte a ser usada (DEVE SER EM TEXTO)
/// @param {String or Id.Layer} _layer Layer onde será criado o toast
/// @param {Real} _posy Posição vertical do toast
/// @param {Asset.GMObject} _object Objeto que secundario da interação
/// @param {Real} _distance Distancia máxima para o toast poder aparecer
/// @param {Real} _sound Som da maquina de escrever
/// @param {Real} _pitchmin Variação minima do som (MIN: 0.5)
/// @param {Real} _pitchmax Variação maxima do som (MAX: 2)
/// @param {Real} _gain Volume do som (MIN: 0, MAX: 1)
/// @param {Boll} _interact Se o toast irá aparecer com uma interação ou não
/// @param {Constant.VirtualKey or Constant.GamepadButton} _button Tecla que será usada na interação (A VARIAVEL _INPUT DEVE ESTAR VERDADEIRA)
/// @param {Real} _interactposy Posição vertical do botão de interação
/// @param {Constant.VirtualKey or Constant.GamepadButton} _skip_button Tecla que será usada para pular dialogo (A VARIAVEL _INPUT DEVE ESTAR VERDADEIRA)
function create_toast(_sprite, _text, _font, _layer, _posy, _object, _distance, _sound = undefined, _pitchmin = 0, _pitchmax = 0, _gain = 0, _interact = false, _button = undefined, _interactposy = 0, _skip_button = undefined)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "t"))
    {
        t = toast_create();
    }
    
    //Caso não for interagivel
    if (!_interact)
    {
        //Se o toast estiver aparecendo
        if (t.show_toast)
        {
            //Se o toast ainda não existe
            if (!instance_exists(toast))
            {
                //Cria o toast
                t.new_toast = instance_create_layer(x, y - (sprite_height / 2), _layer, toast);
                //Define a sprite
                t.new_toast.sprite = _sprite;
                //Define o texto
                t.new_toast.text = _text;
                //Define a posição vertical
                t.new_toast.finy = _posy;
                //Define a fonte
                t.new_toast.font = _font;
                if (!is_undefined(_sound))
                {
                    t.new_toast.sound = _sound;
                    t.new_toast.pitch_max = _pitchmax;
                    t.new_toast.pitch_min = _pitchmin;
                    t.new_toast.gain = _gain;
                }
            }
        }
        else //Caso não estiver mostrando
        {
            //Se a variavel não estiver indefinida
        	if (!is_undefined(t.new_toast))
            {
                //Caso o toast ainda existir
                if (instance_exists(t.new_toast))
                {
                    //Fecha ele
                    t.new_toast.visible_toast = false;
                }
            }
        }
        
        //Variavel que pega a distancia do objeto base em relação ao objeto secundario
        var _object_distance = point_distance(x, y, _object.x, _object.y);
        
        //Caso a distancia for menor ou igual a distancia definida
        if (_object_distance <= _distance) t.show_toast = true; //Mostra o toast
        else t.show_toast = false; //Caso não for, fecha o toast
    }
    else //Caso for interagivel
    { 
        //Mostra o botão de interação
        interact(_button, x, _interactposy, id, _object, _distance);
        
        //Converte a tecla dada em input
        var _b = get_bind_name_from_key(_button);
        //Pega o input corretamente
        var _input = input(_b, "pressed", "button");
        
        //Caso estiver mostrando o toast
        if (t.show_toast)
        {
            //Caso ele apertar a tecla
            if (_input)
            {
                //Caso o toast ainda não existir
                if (!instance_exists(toast))
                {
                    //Cria o toast
                    t.new_toast = instance_create_layer(x, y - (sprite_height / 2), _layer, toast);
                    //Define a sprite
                    t.new_toast.sprite = _sprite;
                    //Define o texto
                    t.new_toast.text = _text;
                    //Define a posição vertical
                    t.new_toast.finy = _posy;
                    //Define a fonte
                    t.new_toast.font = _font;
                    //Faz ele ser interagivel
                    t.new_toast.interact_toast = _interact;
                    
                    if (!is_undefined(_sound))
                    {
                        t.new_toast.sound = _sound;
                        t.new_toast.pitch_max = _pitchmax;
                        t.new_toast.pitch_min = _pitchmin;
                        t.new_toast.gain = _gain;
                    }
                }
            }
        }
        
        if (!is_undefined(t.new_toast))
        {
            if (instance_exists(t.new_toast))
            {
                //Define a tecla de skip
                t.new_toast.skip_input = _skip_button;
            }
        }
        
        //Variavel que pega a distancia do objeto base em relação ao objeto secundario
        var _object_distance = point_distance(x, y, _object.x, _object.y);
        
        //Caso a distancia for menor ou igual a distancia definida
        if (_object_distance <= _distance) t.show_toast = true; //Mostra o toast
        else t.show_toast = false; //Caso não for, fecha o toast
    }
}

/// @desc Essa função irá criar uma caixa de texto caso você chegar perto ou interagir com o objeto
/// @param {Asset.GMSprite} _sprite Sprite que será utilizado pela box
/// @param {String} _text Texto a ser usado
/// @param {String} _font Fonte a ser usada (DEVE SER EM TEXTO)
/// @param {String or Id.Layer} _layer Layer onde será criado a caixa de texto
/// @param {Asset.GMObject} _object Objeto que secundario da interação
/// @param {Real} _distance Distancia máxima para o toast poder aparecer
/// @param {Constant.VirtualKey or Constant.GamepadButton} _skip_button Tecla que será usada para pular dialogo (A VARIAVEL _INPUT DEVE ESTAR VERDADEIRA)
/// @param {Real} _sound Som da maquina de escrever
/// @param {Real} _pitchmin Variação minima do som (MIN: 0.5)
/// @param {Real} _pitchmax Variação maxima do som (MAX: 2)
/// @param {Real} _gain Volume do som (MIN: 0, MAX: 1)
/// @param {Boll} _interact Se o toast irá aparecer com uma interação ou não
/// @param {Constant.VirtualKey or Constant.GamepadButton} _button Tecla que será usada na interação (A VARIAVEL _INPUT DEVE ESTAR VERDADEIRA)
/// @param {Real} _interactposy Posição vertical do botão de interação
function create_box(_sprite, _text, _font, _layer, _object, _distance, _skip_button, _sound = undefined, _pitchmin = 0, _pitchmax = 0, _gain = 0, _interact = false, _button = undefined, _interactposy = 0)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "b"))
    {
        b = box_create();
    }
    
    //Caso não for interagivel
    if (!_interact)
    {
        //Se a caixa estiver aparecendo
        if (b.show_box)
        {
            //Se a caixa ainda não existe
            if (!instance_exists(box) && !b.to_new_box)
            {
                //Cria o toast
                b.new_box = instance_create_layer(0, 0, _layer, box);
                //Define a sprite
                b.new_box.sprite = _sprite;
                //Define o texto
                b.new_box.text = _text;
                //Define a fonte
                b.new_box.font = _font;
                if (!is_undefined(_sound))
                {
                    b.new_box.sound = _sound;
                    b.new_box.pitch_max = _pitchmax;
                    b.new_box.pitch_min = _pitchmin;
                    b.new_box.gain = _gain;
                }
            }
            b.to_new_box = true;
        }
        else 
        {
        	if (!is_undefined(b.new_box))
            {
                if (!instance_exists(b.new_box))
                {
                    b.to_new_box = false;
                }
            }
        }
        
        if (!is_undefined(b.new_box))
        {
            if (instance_exists(b.new_box))
            {
                //Define a tecla de skip
                b.new_box.skip_button = _skip_button;
            }
        }
        
        //Variavel que pega a distancia do objeto base em relação ao objeto secundario
        var _object_distance = point_distance(x, y, _object.x, _object.y);
        
        //Caso a distancia for menor ou igual a distancia definida
        if (_object_distance <= _distance) b.show_box = true; //Mostra a caixa
        else b.show_box = false; //Caso não for, fecha a caixa
    }
    else //Caso for interagivel
    { 
        //Mostra o botão de interação
        interact(_button, x, _interactposy, id, _object, _distance);
        
        //Converte a tecla dada em input
        var _b = get_bind_name_from_key(_button);
        //Pega o input corretamente
        var _input = input(_b, "pressed", "button");
        
        //Caso estiver mostrando o toast
        if (b.show_box)
        {
            //Caso ele apertar a tecla
            if (_input)
            {
                //Caso o toast ainda não existir
                if (!instance_exists(box))
                {
                    //Cria o toast
                    b.new_box = instance_create_layer(0, 0, "Text", box);
                    //Define a sprite
                    b.new_box.sprite = _sprite;
                    //Define o texto
                    b.new_box.text = _text;
                    //Define a fonte
                    b.new_box.font = _font;
                    if (!is_undefined(_sound))
                    {
                        b.new_box.sound = _sound;
                        b.new_box.pitch_max = _pitchmax;
                        b.new_box.pitch_min = _pitchmin;
                        b.new_box.gain = _gain;
                    }
                }
            }
        }
        
        if (!is_undefined(b.new_box))
        {
            if (instance_exists(b.new_box))
            {
                //Define a tecla de skip
                b.new_box.skip_button = _skip_button;
            }
        }
        
        //Variavel que pega a distancia do objeto base em relação ao objeto secundario
        var _object_distance = point_distance(x, y, _object.x, _object.y);
        
        //Caso a distancia for menor ou igual a distancia definida
        if (_object_distance <= _distance) b.show_box = true; //Mostra o toast
        else b.show_box = false; //Caso não for, fecha o toast
    }
}

/// @desc Essa função irá criar uma caixa de aviso por um tempo determinado
/// @param {Asset.GMSprite} _sprite Sprite que será utilizado pela caixa de aviso
/// @param {String} _text Texto a ser usado
/// @param {String} _font Fonte a ser usada (DEVE SER EM TEXTO)
/// @param {String} _layer Layer onde será criado o aviso
/// @param {Real} _time Tempo de exibição da caixa de aviso (DEVE SER EM SEGUNDOS)
/// @param {Constant.Color} _type_color Cor do texto de aviso
/// @param {Real} _qtd Quantidade de avisos a serem criados
function create_warn(_sprite, _text, _font, _layer, _time, _type_color = undefined, _qtd = 0)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "w"))
    {
        w = warn_create();
    }
    
    if (_qtd != 0)
    {
        if (w.qtd < _qtd)
        {
            w.new_warn = instance_create_layer(0, 0, _layer, warn);
            w.new_warn.sprite = _sprite;
            w.new_warn.text = _text;
            w.new_warn.font = _font;
            w.new_warn.time = _time;
            w.new_warn.position = instance_number(warn);
            if (!is_undefined(_type_color))
            {
                w.new_warn.color = _type_color;
            }
        }
        w.qtd = instance_number(w.new_warn);
    }
    else 
    {
    	w.new_warn = instance_create_layer(0, 0, _layer, warn);
        w.new_warn.sprite = _sprite;
        w.new_warn.text = _text;
        w.new_warn.font = _font;
        w.new_warn.time = _time;
        w.new_warn.position = instance_number(warn);
        if (!is_undefined(_type_color))
        {
            w.new_warn.color = _type_color;
        }
    }
}

/// @desc Essa função irá verificar se algum dialogo está ativo
function get_in_dialogue()
{
    if (global.DIALOGUE)
    {
        return true;
    }
    
    return false;
}

function toast_create()
{
    return
    {
        new_toast: undefined,
        show_toast: false,
        interaction: undefined,
    };
}

function box_create()
{
    return
    {
        new_box: undefined,
        show_box: false,
        interaction: undefined,
        to_new_box: false
    };
}

function warn_create()
{
    return
    {
        new_warn: undefined,
        show_warn: false,
        qtd: 0
    }
}