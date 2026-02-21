function draw_box(_ballonsprite, _text, _font, _character_panel = false)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "d"))
    {
        d = draw_box_create();
    }
    
    if (visible_box)
    {
        global.DIALOGUE = true;
        open_box();
    }
    else 
    {
        global.DIALOGUE = false;
    	close_box();
    }
    
    var _posx = display_get_gui_width() / 2;
    var _posy = display_get_gui_height() / 3;
    
    var _Wwidth = display_get_gui_width();
    var _Hheight = display_get_gui_height();
    var _margin = 64;
    var _sprite_width = sprite_get_width(_ballonsprite);
    var _sprite_height = sprite_get_height(_ballonsprite);
    d.width = (_Wwidth - _margin) / _sprite_width;
    d.height = (_posy - _margin / 4) / _sprite_height;
    draw_sprite_ext(_ballonsprite, 0, _posx, _posy, d.xscale, d.yscale, 0, c_white, d.alpha);
    
    if (!_character_panel)
    {
        //Converte a fonte em um asset
        var _index = asset_get_index(_font)
        
        var _text_margin = 16;
        var _textx = (_posx - d.width) / _sprite_width + _margin / 2 + _text_margin;
        var _texty = (_posy - d.height) / _sprite_height + _margin / 4 + _text_margin;
        var _wrap = d.width * _sprite_width - _margin / 2 - _text_margin;
        
        if (is_array(_text))
        {
            array = true;
            lenght = array_length(_text) - 1;
            
            var _write = scribble(_text[number_array]).starting_format(_font, c_white);
            //Desenhando o texto dentro da caixa
            _write.draw(_textx, _texty, write_machine);
            _write.wrap(_wrap);
            _write.blend(c_white, d.text_alpha);
        }
        else 
        {
            var _write = scribble(_text).starting_format(_font, c_white);
            //Desenhando o texto dentro da caixa
            _write.draw(_textx, _texty, write_machine);
            _write.wrap(_wrap);
            _write.blend(c_white, d.text_alpha);
        }
    }
    
    var s = detection(skip_button);
    var _skip_marginx = 32;
    var _skip_marginy = 8;
    if (global.DIALOGUE)
    {
        skip_x = _posx + (d.width * _sprite_width) / 2 - _skip_marginx;
        skip_y = _posy - _skip_marginy;
    }
    
    if (skip_alpha >= .9)
    {
        if (skiped)
        {
            outline_start(2, c_white, s.sprite, s.subming);
        }
    }
    
    draw_sprite_ext(s.sprite, s.subming, skip_x, skip_y, skip_scalex, skip_scaley, 0, c_white, skip_alpha);
    outline_end();
    
    if (!is_undefined(sound))
    {
        write_machine.sound_per_char(sound, pitch_min, pitch_max, , gain);
    }
}

function open_box()
{
    var _xscale = d.width;
    var _yscale = d.height;
    
    d.xscale = lerp(d.xscale, _xscale, .2);
    d.yscale = _yscale;
    d.alpha = lerp(d.alpha, 2, .1);
    
    skip_scalex = lerp(skip_scalex, skip_scalemin, .1);
    skip_scaley = lerp(skip_scaley, skip_scalemin, .1);
    
    if (_xscale != 0 && d.xscale >= _xscale-.1)
    {
        skip_alpha = lerp(skip_alpha, 1, .2);
        write_machine.unpause();
        var _skip = write_machine.get_state();
        var _input_name = get_bind_name_from_key(skip_button);
        var _input = input(_input_name, "pressed", "button");
        if (_input)
        {
            write_machine.skip();
            if (_skip == 1)
            {
                skip_scalex = skip_scaleclick;
                skip_scaley = skip_scaleclick;
                //Caso o texto for um array
                if (array)
                {
                    //Se o array for menor que o tamanho maximo do array
                    if (number_array < lenght)
                    {
                        //Aumenta o numero do array
                        number_array++;
                        //Reseta a maquina de escrever
                        write_machine.reset();
                    }
                    else //Caso for igual
                    {
                        //Fecha a caixa
                        visible_box = false;
                    }
                }
                else //Caso não for um array
                {
                    //Fecha a caixa
                    visible_box = false;
                }
            }
            else 
            {
                skip_scalex = skip_scaleclick;
                skip_scaley = skip_scaleclick;
            }
        }
        
        //Caso estiver terminado o texto
        if (_skip == 1)
        {
            skiped = true;
        }
        else 
        {
            skiped = false;
        }
    }
    else 
    {
    	write_machine.pause();
    }
}

function close_box()
{
    d.text_alpha = 0;
    d.xscale = lerp(d.xscale, 0, .2);
    d.alpha = lerp(d.alpha, 0, .1);
    
    skip_alpha = lerp(skip_alpha, 0, .2);
    skip_scalex = lerp(skip_scalex, skip_scalemax, .1)
    skip_scaley = lerp(skip_scaley, skip_scalemax, .1)
    
    if (d.alpha <= .1)
    {
        instance_destroy();
    }
}

function draw_box_create()
{
    return
    {
        xscale: 0,
        yscale: 0,
        width: 0,
        height: 0,
        alpha: 0,
        text_alpha: 1,
    };
}