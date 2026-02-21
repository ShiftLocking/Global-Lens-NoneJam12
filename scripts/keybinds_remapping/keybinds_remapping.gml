/// @desc Salva o mapeamento do controle ou teclado
function save_mapping()
{
    //Arrays
    var _keybindsK = [];
    var _keybindsJ = [];
    //Transformando as chaves dos ds_maps em array
    var _keys = ds_map_keys_to_array(global.additional_keyboard);
    var _keysj = ds_map_keys_to_array(global.additional_joystick);
    //Laço de repetição de acordo com o tamanho do array do teclado
    for (var i = 0; i < array_length(_keys); i++)
    {
        //Variavel que passa pelos nomes do array
        var _k = _keys[i];
        //Coloca os valores do ds_map nesse array
        array_push(_keybindsK, global.additional_keyboard[? _k]);
    }
    
    //Laço de repetição de acordo com o tamanho do array do controle
    for (var i = 0; i < array_length(_keysj); i++)
    {
        //Variavel que passa pelos nomes do array
        var _k = _keysj[i];
        //Coloca os valores do ds_map nesse array
        array_push(_keybindsJ, global.additional_joystick[? _k]);
    }
    
    //Salva os valores nessa estrutura de dados
    _data = 
    {
        //Teclado
        keyboard : {binds : _keybindsK},
        //Controle
        joystick : {binds : _keybindsJ}
    };
    
    //Converte em string
    var _string = json_stringify(_data);
    //Cria a variavel de locação
    var _save = buffer_create(0, buffer_grow, 1);
    //Escreve as informações nele como string
    buffer_write(_save, buffer_string, _string);
    //Salva no arquivo
    buffer_save(_save, "Mapping.map");
    //Deleta a locação
    buffer_delete(_save);
}

/// @desc Carrega o mapeamento salvo do controle ou teclado
function load_mapping()
{
    //Carrega os controles salvos
    var _data = buffer_load("Mapping.map");
    
    //Caso não existir, para o código
    if (_data == -1) exit;
    
    //Pega os textos do arquivo
    var _string = buffer_read(_data, buffer_text);
    
    //Transforma em variaveis
    var _struct = json_parse(_string);
    
    //Pega a ordem das teclas (TECLADO E CONTROLE)
    var _orderK = ds_map_keys_to_array(global.additional_keyboard);
    var _orderJ = ds_map_keys_to_array(global.additional_joystick);
    
    //Pega as informações uteis do arquivo
    var _bindsK = _struct.keyboard.binds;
    var _bindsJ = _struct.joystick.binds;
    
    //Só executa o código se as teclas adicionadas forem as mesmas salvas
    if (array_length(_bindsK) == array_length(_orderK))
    {
        //Laço de repetição do tamanho do array do teclado
        for (var i = 0; i < array_length(_bindsK); i++)
        {
            //Variavel que pega o nome exato da ordem do teclado
            var _action = _orderK[i];
            //Substitui as teclas atuais pela dos arquivos
            global.additional_keyboard[? _action] = _bindsK[i];
        }
    }
    
    //Só executa o código se as teclas adicionadas forem as mesmas salvas
    if (array_length(_bindsJ) == array_length(_orderJ))
    {
        //Laço de repetição do tamanho do array do controle
        for (var i = 0; i < array_length(_bindsJ); i++)
        {
            //Variavel que pega o nome exato da ordem do teclado
            var _action = _orderJ[i];
            //Substitui as teclas atuais pela dos arquivos
            global.additional_joystick[? _action] = _bindsJ[i];
        }
    }
    
    //Deleta a locação
    buffer_delete(_data);
}

global.rebinding = false;
global.rebind_target = "";

/// @desc Salva o mapeamento do controle ou teclado
/// @param {Struct} _binds Teclas com o index de cada uma (DEVE SER UMA STRUCT)
/// @param {Asset.GMFont} _font Fonte a ser usada nos textos
/// @param {Real} _initialX Posição horizontal inicial
/// @param {Real} _initialY Posição vertical inicial
/// @param {Real} _Hsep Separação entre o texto e a tecla
function load_options_keybinds(_binds, _font, _initialX, _initialY, _Hsep)
{  
    var _binds_array = struct_get_names(_binds);
    var _array_lenght = array_length(_binds_array);
    var _sep = 0;
    
    static _position = 0;
    var _scale = 1;
    
    if (!global.use_joystick)
    {
        if (!global.rebinding)
        { 
            if (keyboard_check_pressed(vk_up))
            {
                if (_position > 0) _position--;
            }
            else if (keyboard_check_pressed(vk_down))
            {
                if (_position < _array_lenght - 1) _position++;
            }
        }
    }
    else 
    {
        if (!global.rebinding)
        { 
            if (gamepad_button_check_pressed(0, gp_padu))
            {
                if (_position > 0) _position--;
            }
            else if (gamepad_button_check_pressed(0, gp_padd))
            {
                if (_position < _array_lenght - 1) _position++;
            }
        }
    }
    
    if (!global.rebinding)
    {
        if (!global.use_joystick)
        {
            if (keyboard_check_pressed(vk_enter))
            {
                global.rebind_target = _binds_array[_position];
                global.rebinding = true;
            }
        }
        else 
        {
        	if (gamepad_button_check_pressed(0, gp_face1))
            {
                global.rebind_target = _binds_array[_position];
                global.rebinding = true;
            }
        }
    }
    else 
    {
        if (!global.use_joystick)
        {
            var _lastkey = 0;
            
            if (keyboard_key)
            {
       	        _lastkey = keyboard_lastkey;
            }
            else if (mouse_button)
            {
                _lastkey = mouse_lastbutton;
            }
            var _allow = key_is_allowed(_lastkey);
            if (_allow)
            {
                var _hash = variable_get_hash(global.rebind_target);
                var _key = struct_get_from_hash(_binds, _hash);
                
                if (_lastkey != 0)
                {
                    if (!keyboard_bind_exists(_binds, _lastkey, global.rebind_target))
                    {
                        global.additional_keyboard[? _key] = _lastkey;
                        save_mapping();
                        global.rebinding = false;
                    }
                    else 
                    {
                    	create_warn(spr_textbox, "Esta tecla já está em uso", "fnt_menu", "Warn", 2, c_red, 1);
                    }
                }
            }
        }
        else 
        {
            var btn = get_pressed_gamepad_button(0);
        
            if (btn != -1)
            {
                var _hash = variable_get_hash(global.rebind_target);
                var _key  = struct_get_from_hash(_binds, _hash);
        
                if (!joystick_bind_exists(_binds, btn, global.rebind_target))
                {
                    global.additional_joystick[? _key] = btn;
                    save_mapping();
                    global.rebinding = false;
                }
                else
                {
                    create_warn(spr_textbox, "Este botão já está em uso", "fnt_menu", "Warn", 2, c_red, 1);
                }
            }
        }
    }
    
    for (var i = 0; i < _array_lenght; i++)
    {
        draw_set_halign(1);
        draw_set_valign(1);
        draw_set_font(_font);
        var _hashs = variable_get_hash(_binds_array[i]);
        var _index = struct_get_from_hash(_binds, _hashs);
        
        if (_position == i)
        {
            _scale = 1.2;
        }
        else 
        {
        	_scale = 1;
        }
        
        draw_text_transformed(_initialX, _initialY + _sep, _binds_array[i], _scale, _scale, 0);
        
        var _input = input(_index, , , , true);
        var s = detection(_input);
        
        var _label = "<PRESS KEY>";
        
        if (global.rebinding && global.rebind_target == _binds_array[i])
        {
            draw_text_transformed(_initialX + _Hsep, _initialY + _sep, _label, _scale, _scale, 1);
        }
        else 
        {
        	draw_sprite_ext(s.sprite, s.subming, _initialX + _Hsep, (_initialY + sprite_get_height(s.sprite) / 4) + _sep, _scale, _scale, 0, c_white, 1);
        }
        
        _sep += sprite_get_height(s.sprite) + string_height(_hashs);
        
        draw_set_halign(-1);
        draw_set_valign(-1);
        draw_set_font(-1);
    }
    //
    //show_debug_message(
    //{
        //rebind : global.rebinding,
        //target : global.rebind_target
    //}
    //)
}

function key_is_allowed(_key)
{
    // Letras A-Z
    if (_key >= ord("A") && _key <= ord("Z"))
    {
        // Bloquear WASD se forem macros de movimento
        if (_key == RIGHT && RIGHT == ord("D")) return false;
        if (_key == LEFT  && LEFT  == ord("A")) return false;
        if (_key == UP    && UP    == ord("W")) return false;
        if (_key == DOWN  && DOWN  == ord("S")) return false;
    
        return true;
    }
    
    // Teclas especiais permitidas
    if (_key == vk_shift)   return true;
    if (_key == vk_control) return true;
    if (_key == vk_alt)     return true;
    if (_key == vk_space)   return true;
        
    if (_key == mb_left) return true;
    if (_key == mb_right) return true;
    if (_key == mb_middle) return true;
    
    return false;
}

function get_pressed_gamepad_button(_pad)
{
    // face
    if (gamepad_button_check_pressed(_pad, gp_face1)) return gp_face1; // A
    if (gamepad_button_check_pressed(_pad, gp_face2)) return gp_face2; // B
    if (gamepad_button_check_pressed(_pad, gp_face3)) return gp_face3; // X
    if (gamepad_button_check_pressed(_pad, gp_face4)) return gp_face4; // Y

    // shoulders
    if (gamepad_button_check_pressed(_pad, gp_shoulderl)) return gp_shoulderl;
    if (gamepad_button_check_pressed(_pad, gp_shoulderr)) return gp_shoulderr;

    // triggers digitais (se existirem)
    if (gamepad_button_check_pressed(_pad, gp_shoulderlb)) return gp_shoulderlb;
    if (gamepad_button_check_pressed(_pad, gp_shoulderrb)) return gp_shoulderrb;

    // system
    if (gamepad_button_check_pressed(_pad, gp_start))  return gp_start;
    if (gamepad_button_check_pressed(_pad, gp_select)) return gp_select;

    return -1;
}

function keyboard_bind_exists(_binds_struct, _new_key, _ignore_action)
{
    var names = struct_get_names(_binds_struct);
    var len = array_length(names);

    for (var i = 0; i < len; i++)
    {
        var action = names[i];

        // ignora a própria ação que está sendo remapeada
        if (action == _ignore_action) continue;

        var hash = variable_get_hash(action);
        var base_key = struct_get_from_hash(_binds_struct, hash);

        var final_key = base_key;

        // se tem override no global, usa ele
        if (ds_map_exists(global.additional_keyboard, base_key))
        {
            final_key = global.additional_keyboard[? base_key];
        }

        if (final_key == _new_key)
        {
            return true; // já existe
        }
    }

    return false;
}

function joystick_bind_exists(_binds_struct, _new_btn, _ignore_action)
{
    var names = struct_get_names(_binds_struct);
    var len = array_length(names);

    for (var i = 0; i < len; i++)
    {
        var action = names[i];

        if (action == _ignore_action) continue;

        var hash = variable_get_hash(action);
        var base_btn = struct_get_from_hash(_binds_struct, hash);

        var final_btn = base_btn;

        if (ds_map_exists(global.additional_joystick, base_btn))
        {
            final_btn = global.additional_joystick[? base_btn];
        }

        if (final_btn == _new_btn)
        {
            return true;
        }
    }

    return false;
}




