global.default_keyboard = ds_map_create();
global.additional_keyboard = ds_map_create();

global.default_joystick = ds_map_create();
global.additional_joystick = ds_map_create();

global.joysticks = [];
global.use_joystick = false;

/// @desc Checa se um controle foi conectado
function gamepad_check()
{
    //Variavel que pega todos os controles conectados
    var _maxgp = gamepad_get_device_count();
    //Laço de repetição envolvendo a variavel
    for (var i = 0; i < _maxgp; i++)
    {
        //Adiciona os controles que estão conectados na variavel global
        global.joysticks[i] = gamepad_is_connected(i);
    }
    
    //Caso qualquer botão do controle for apertada
    if (gamepad_any_input(0))
    {
        //Variavel global para usar o controle fica verdadeira
        global.use_joystick = true;
    }
    
    //Caso qualquer botão do teclado for apertada
    if (keyboard_key or mouse_button)
    {
        //Variavel global para usar o controle fica falso
        global.use_joystick = false;
    }
    
    gamepad_set_axis_deadzone(0, .1);
    
}

function gamepad_any_input(_device)
{
    // BOTÕES
    //Variavel que pega a quantidade de botões do controle
    var bc = gamepad_button_count(_device);
    //Laço de repetição envolvendo os botões
    for (var i = 0; i < bc; i++)
    {
        //Caso qualquer um dos botões for pressionado
        if (gamepad_button_check(_device, i))
        {
            return true; //Retorna verdadeiro
        }
    }

    // ANALÓGICOS
    //Variavel que pega a quantidade de eixos do controle
    var ac = gamepad_axis_count(_device);
    //Laço de repetição envolvendo os eixos
    for (var i = 0; i < ac; i++)
    {
        //Caso qualquer um dos eixos for movido
        if (abs(gamepad_axis_value(_device, i)) > 0.25)
        {
            return true; //Retorna verdadeiro
        }
    }

    //Caso não for apertada, retorna falso
    return false;
}

/// @desc Adiciona um valor padrão que não será mudado
/// @param {string} _name Nome desse input
/// @param {Constant.VirtualKey or Real} _inputkeyboard Valor do teclado
/// @param {Constant.GamepadButton} _inputjoystick Valor do controle
function add_default_input(_name, _inputkeyboard, _inputjoystick)
{
    if (!is_undefined(_inputkeyboard)) ds_map_add(global.default_keyboard, _name, _inputkeyboard);
    if (!is_undefined(_inputjoystick)) ds_map_add(global.default_joystick, _name, _inputjoystick);
}

/// @desc Adiciona um valor adicional que pode ser mudado
/// @param {string} _name Nome desse input
/// @param {Constant.VirtualKey or Real} _inputkeyboard Valor do teclado
/// @param {Constant.GamepadButton} _inputjoystick Valor do controle
function add_additional_inputs(_name, _inputkeyboard, _inputjoystick)
{
    if (!is_undefined(_inputkeyboard)) ds_map_add(global.additional_keyboard, _name, _inputkeyboard);
    if (!is_undefined(_inputjoystick)) ds_map_add(global.additional_joystick, _name, _inputjoystick);
}

/// @desc Pega o valor da lista de acordo com o nome
/// @param {string} _index Nome a se procurar na lista
/// @param {string} _status Estado ("normal", "pressed", "released")
/// @param {string} _type Caso estiver no controle ("button", "axis")
/// @param {Boll} _source Verdadeiro para mouse e Falso para teclado
/// @param {Boll} _input Verdadeiro para ativar o retorno da tecla e Falso para não
function input(_index, _status = "normal", _type = "", _source = false, _input = false)
{
    find = 0;
    
    if (!global.use_joystick)
    {
        //Caso o nome dado não existir nessa lista
        if (!ds_map_exists(global.default_keyboard, _index))
        {
            //Caso o nome dado não estiver nessa lista também
            if (!ds_map_exists(global.additional_keyboard, _index))
            {
                //Mostra uma mensagem de erro
                show_message("O index fornecido não existe: " + _index);
                //E retorna falso
                return false;
            }
            else //Caso o valor dado estiver nessa lista
            {
                //Pega o valor do nome e define na variavel
            	find = global.additional_keyboard[? _index];
            }
        }
        else //Caso o valor dado estiver nessa lista
        {
            //Pega o valor do nome e define na variavel
        	find = global.default_keyboard[? _index];
        }
        
        if (_input) return find;
        
        switch (_status)
        {
            case "normal" :
                //Retorna a variavel
                if (_source)
                {
                    return mouse_check_button(find);
                }
                else 
                {
                	return keyboard_check(find);
                }
        
            case "pressed" :
                //Retorna a variavel
                if (_source)
                {
                    return mouse_check_button_pressed(find);
                }
                else 
                {
                	return keyboard_check_pressed(find);
                }

            case "released" :
                //Retorna a variavel
                if (_source)
                {
                    return mouse_check_button_released(find);
                }
                else 
                {
                	return keyboard_check_released(find);
                }
        }
    }
    else 
    {
    	//Caso o nome dado não existir nessa lista
        if (!ds_map_exists(global.default_joystick, _index))
        {
            //Caso o nome dado não estiver nessa lista também
            if (!ds_map_exists(global.additional_joystick, _index))
            {
                //Mostra uma mensagem de erro
                show_message("O index fornecido não existe: " + _index);
                //E retorna falso
                return false;
            }
            else //Caso o valor dado estiver nessa lista
            {
                //Pega o valor do nome e define na variavel
            	find = global.additional_joystick[? _index];
            }
        }
        else //Caso o valor dado estiver nessa lista
        {
            //Pega o valor do nome e define na variavel
        	find = global.default_joystick[? _index];
        }
        
        if (_input) return find;
        
        if (_type == "button")
        {
            switch (_status)
            { 
                case "normal" : 
                    //Retorna a variavel
                    return gamepad_button_check(0, find);
                    
                  case "pressed" :
                      //Retorna a variavel
                      return gamepad_button_check_pressed(0, find);
      
                  case "released" :
                      //Retorna a variavel
                      return gamepad_button_check_released(0, find);
            }
        }
        else if (_type == "axis")
        {
            return gamepad_axis_value(0, find);
        }
        else 
        {
        	return false;
        }
    }
}

global.force = 0;
global.time = 0;
global.mode = "";
global.variable = 0;

/// @desc Seta uma força de vibração do controle, sendo possivel mudar entre modos
function joystick_vibration()
{
    if (!global.use_joystick) 
    {
        //Para a vibração
        gamepad_set_vibration(0, 0, 0);
        exit;
    }
    
    //Variaveis estaticas
    static _variabletime = -1;
    static _active = true;
    
    //Delta time
    var _dt = delta_time / 1000000;
    
    //Caso o tempo for maior que zero
    if (global.time > 0)
    {
        //Diminui o tempo
        global.time -= _dt;
    
        //Switch do modo
        switch (global.mode)
        {
            //Caso for continuo
            case "continue":
                //Seta a vibração até o tempo acabar
                gamepad_set_vibration(0, global.force, global.force);
            break;
    
            //Caso for variavel
            case "variable":
                
                //Se o tempo de variação for menor que 0
                if (_variabletime < 0)
                {
                    //Define o tempo de variação
                    _variabletime = global.variable;
                    _active = true; // começa vibrando
                }
    
                //Caso a vibração estiver ativa
                if (_active)
                    //Vibra o controle
                    gamepad_set_vibration(0, global.force, global.force);
                else //Caso não estiver
                    gamepad_set_vibration(0, 0, 0); //Zera a vibração
    
                //Diminui o tempo de variação
                _variabletime -= _dt;
    
                //Caso o tempo de variação for menor ou igual a 0
                if (_variabletime <= 0)
                {
                    //Define o tempo de variação
                    _variabletime = global.variable;
                    //Alterna entre ativo e desativado
                    _active = !_active;
                    //Adiciona mais força na vibração
                    global.force += global.variable;
                }
            break;
        }
    }
    else //Caso o tempo acabar
    {
        //Para a vibração
        gamepad_set_vibration(0, 0, 0);
    }
}

function get_bind_name_from_key(_keycode)
{
    var _keysK = ds_map_keys_to_array(global.additional_keyboard);
    var _keysJ = ds_map_keys_to_array(global.additional_joystick);
    
    for (var i = 0; i < array_length(_keysK); i++)
    {
        var _name = _keysK[i];
        var _value = global.additional_keyboard[? _name];
        
        if (_value == _keycode)
        {
            return _name; // "interact", "jump", etc
        }
    }
    
    for (var i = 0; i < array_length(_keysJ); i++)
    {
        var _name = _keysJ[i];
        var _value = global.additional_joystick[? _name];
        
        if (_value == _keycode)
        {
            return _name; // "interact", "jump", etc
        }
    }
    
    return ""; // não achou
}

function movement()
{
    //Variaveis estaticas de direção
    static Hdir = 0;
    static Vdir = 0;
    
    //Se a variavel global de uso do controle estiver verdadeiro
    if (global.use_joystick)
    {
        //Define a direção com base nos controles
        Hdir = input("horizontal", "normal","axis");
        Vdir = input("vertical", "normal","axis");
    }
    else 
    {
        //Define a direção com base nos teclados
    	Hdir = input("right") - input("left");
    	Vdir = input("down") - input("up");
    }
    
    gamepad_check();
    
    //Retorna as variaveis estaticas
    return
    {
        Hdir,
        Vdir
    }
}

adding_patterns = function()
{
    add_default_input("right", RIGHT);
    add_default_input("left", LEFT);
    add_default_input("up", UP);
    add_default_input("down", DOWN);
    add_default_input("horizontal", undefined, HORIZONTAL);
    add_default_input("vertical", undefined, VERTICAL);
}

adding_patterns();

function debug(_map)
{
    var _keys = ds_map_keys_to_array(_map);

    show_debug_message("=== INPUT MAP " + string(_map) + " ===");

    for (var i = 0; i < array_length(_keys); i++)
    {
        var _k = _keys[i];
        show_debug_message(_k + ": " + string(_map[? _k]));
    }

    show_debug_message("=================");
}



