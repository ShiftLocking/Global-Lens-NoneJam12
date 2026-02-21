global.bind_icons = {
    keyboard : {
        keys : [ 
            ord("A"), ord("B"), ord("C"), ord("D"), ord("E"),
            ord("F"), ord("G"), ord("H"), ord("I"), ord("J"),
            ord("K"), ord("L"), ord("M"), ord("N"), ord("O"),
            ord("P"), ord("Q"), ord("R"), ord("S"), ord("T"),
            ord("U"), ord("V"), ord("W"), ord("X"), ord("Y"),
            ord("Z"), vk_shift, vk_control, vk_alt, vk_space,
            mb_left, mb_right, mb_middle
        ],
        subming: [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
            15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
            28, 29, 30, 31, 32
        ]
    },
    joystick : {
        keys : [
            gp_face1, gp_face2, gp_face3, gp_face4, gp_shoulderlb,
            gp_shoulderrb, gp_shoulderl, gp_shoulderr, gp_select, gp_start
            ],
        subming : [
            0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        ],
        axis : [
            gp_stickl, gp_stickr
        ],
        axis_sprite : [
            Joyaxispressed, Joyaxispressed
        ],
        d_pad : [
            gp_padd, gp_padl, gp_padr, gp_padu
        ],
        d_pad_sprite : [
            Joybindsdown, Joybindsleft, Joybindsright, Joybindsup
        ]
    }
}

/// @desc Essa função irá retornar a sprite da tecla colocada
/// @param {Constant.VirtualKey or Constant.GamepadButton} _button Tecla que aparecerá
function detection(_button)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "d"))
    {
        d = detection_create();
    }
    

    //Variavel que decide se vai pegar do teclado ou do controle
    var _data = global.use_joystick ? global.bind_icons.joystick : global.bind_icons.keyboard;
    
    //Se estiver usando o controle
    if (global.use_joystick)
    {
        //Laço de repetição pegando a quantidade de teclas que tem no controle
        for (var i = 0; i < array_length(_data.keys); i++)
        {
            //Se algumas dessas teclas for igual a tecla dada
            if (_data.keys[i] == _button)
            {
                //Define a sprite
                d.sprite = Joybinds;
                //Para o laço
                break;
            }
        }
        
        //Laço de repetição pegando a quantidade de axis que tem no controle
        for (var i = 0; i < array_length(_data.axis); i++)
        {
            //Caso algumas dessas axis for igual a tecla dada
            if (_data.axis[i] == _button)
            {
                //Define a sprite
                d.sprite = _data.axis_sprite[i];
                //Para o laço
                break;
            }
        }
        
        //Laço de repetição pegando a quantidade de d-pads que tem no controle
        for (var i = 0; i < array_length(_data.d_pad); i++)
        {
            //Se algumas dessas d-pads for igual a tecla dada
            if (_data.d_pad[i] == _button)
            {
                //Define a sprite
                d.sprite = _data.d_pad_sprite[i];
                //Para o laço
                break;
            }
        }
    }
    else //Caso não estiver usando controle
    {
        //Caso a tecla dada estiver no formato correto
        if (_button > 1)
        {
            //Define a sprite
            d.sprite = Keybinds;
        }
    }
    
    //Caso a sprite for diferente dos botões do controle e teclado
    if (d.sprite != Keybinds && d.sprite != Joybinds)
    {
        //Anima ele de acordo com a velocidade do sprite dividindo por 1 segundo
        d.subming += sprite_get_speed(d.sprite) / 120;
    }
    else //Caso não for
    {
        //Laço de repetição pegando a quantidade de teclas que tem no teclado
    	for (var i = 0; i < array_length(_data.keys); i++)
        {
            //Se alguma dessas teclas for igual a tecla dada
            if (_data.keys[i] == _button)
            {
                //Define a posição da tecla na sprite
                d.subming = _data.subming[i];
                //Para o laço
                break;
            }
        }
    }
    
    //Se a sprite não for mudada
    if (d.sprite == BindError)
    {
        //Mostra mensagem de erro
        show_debug_message("ATIVE O '_INPUT' NA FUNÇÃO DE INPUT");
    }
    
    return
    {
        sprite : d.sprite,
        subming : d.subming
    };
}

function detection_create()
{
    return
    {
        sprite: BindError,
        subming: 0
    };
}