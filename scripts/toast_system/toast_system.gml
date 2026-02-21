function draw_toast(_ballonsprite, _text, _font)
{
    //Caso for visivel
    if (visible_toast)
    {
        if (interact_toast)
        {
            global.DIALOGUE = true;
        }
        //Executa o código de abrir
        open_toast();
        float();
    }
    else //Caso não for
    {
        global.DIALOGUE = false;
        //Executa o código de fechar
        close_toast();
    }
    
    //Desenha o toast
    draw_sprite_ext(_ballonsprite, 0, toastx, toasty, xscale, yscale, sprite_angle, c_white, sprite_alpha);
    
    //Converte a fonte em um asset
    var _index = asset_get_index(_font)
    
    //Define a fonte
    draw_set_font(_index);
    if (!is_array(_text))
    {
        //Variavel que pega o tamanho vertical do texto
        var _text_height = string_height_scribble(_text);
        //Variavel que pega o tamanho horizontal do texto
        var _text_width = string_width_scribble(_text);
    }
    else 
    {
    	//Variavel que pega o tamanho vertical do texto
        var _text_height = string_height_scribble(_text[number_array]);
        //Variavel que pega o tamanho horizontal do texto
        var _text_width = string_width_scribble(_text[number_array]);
    }
    //Reseta a fonte
    draw_set_font(-1);
    //Variavel que pega o tamanho horizontal da sprite do toast
    var _sprite_width = sprite_get_width(_ballonsprite);
    //Variavel que pega o tamanho vertical da sprite do toast
    var _sprite_height = sprite_get_height(_ballonsprite);
    
    //Variavel de margem
    var _margin = 32;
    
    //Calculando o tamanho horizontal do toast de acordo com o tamanho do texto
    width = (_text_width + _margin) / _sprite_width;
    //Calculando o tamanho vertical do toast de acordo com o tamanho do texto
    height = (_text_height + _margin) / _sprite_height;
    
    //Variavel que pega onde o toast começa
    var _negativelimit = toastx - (width * (_sprite_width / 2));
    //Variavel que pega onde o toast termina
    var _positivelimit = toastx + (width * (_sprite_width / 2));
    //Variavel que coloca o toast no limite esquerdo da room
    var _leftlimit = toastx + abs(_negativelimit);
    //Variavel que coloca o toast no limite direito da room
    var _rightlimit = toastx - (_positivelimit - room_width);
    
    //Caso o toast estiver passando o limite esquerdo
    if (_negativelimit < 0)
    {
        //Faz ele ir até o limite esquerdo da room
        toastx = lerp(toastx, _leftlimit, .2);
    }
    //Caso o toast estiver passando o limite direito
    if (_positivelimit > room_width)
    {
        //Faz ele ir até o limite direito da room
        toastx = lerp(toastx, _rightlimit, .2);
    }
    
    //Variavel que pega o tamanho vertical da sprite do toast e multiplica pelo tamanho atual
    var _sprite_size = sprite_get_height(_ballonsprite) * yscale;
    
    if (is_array(_text))
    {
        array = true;
        lenght = array_length(_text) - 1;
        
        //Cria a maquina de escrever usando o texto e a fonte
        var _write = scribble(_text[number_array]).starting_format(_font, c_white);
        //Alinhando o texto
        _write.align(fa_center, fa_middle);
        //Setando a escala do texto
        _write.scale(text_scale);
        //Setando o alpha do texto
        _write.blend(c_white, alpha);
        //Setando o angulo do texto
        _write.transform(text_scale, text_scale, text_angle);
        //Desenhando o texto dentro do toast
        _write.draw(toastx, toasty - (_sprite_size / 2), write_machine);
    }
    else 
    {
        //Cria a maquina de escrever usando o texto e a fonte
        var _write = scribble(_text).starting_format(_font, c_white);
        //Alinhando o texto
        _write.align(fa_center, fa_middle);
        //Setando a escala do texto
        _write.scale(text_scale);
        //Setando o alpha do texto
        _write.blend(c_white, alpha);
        //Setando o angulo do texto
        _write.transform(text_scale, text_scale, text_angle);
        //Desenhando o texto dentro do toast
        _write.draw(toastx, toasty - (_sprite_size / 2), write_machine);
    }
    
    if (interact_toast)
    {
        var s = detection(skip_input);
        var _skip_marginx = 24;
        var _skip_marginy = 12;
        if (global.DIALOGUE)
        {
            skip_x = toastx + (width * _sprite_width) / 2 - _skip_marginx;
            skip_y = toasty + _skip_marginy;
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
    }
    
    if (!is_undefined(sound))
    {
        write_machine.sound_per_char(sound, pitch_min, pitch_max, , gain);
    }
}

function open_toast()
{
    //Variavel do tamanho final do toast
    var _xscale = width;
    var _yscale = height;
    
    //Define suavemente o tamanho atual para o final
    xscale = lerp(xscale, _xscale, .2);
    yscale = lerp(yscale, _yscale, .1);
    //Aumenta o tamanho do texto
    text_scale = lerp(text_scale, 1, .1);
    //Aumenta a transparencia do toast
    sprite_alpha = lerp(sprite_alpha, 1, .1);
    //Faz o angulo do texto ficar reto suavemente
    text_angle = lerp(text_angle, 0, .2);
    //Faz o angulo do texto ficar reto suavemente
    sprite_angle = lerp(sprite_angle, 0, .2);
    
    skip_scalex = lerp(skip_scalex, skip_scalemin, .1);
    skip_scaley = lerp(skip_scaley, skip_scalemin, .1);
    
    //Caso ele estiver no tamanho final (ou quase)
    if (xscale >= _xscale-.1 && yscale >= _yscale-.1)
    {
        //Aumenta a transparencia do texto
        alpha = lerp(alpha, 1, .4);
    }
    
    //Caso a transparencia do texto for maior ou igual que a metade
    if (alpha >= .5)
    {
        //Despausa a maquina de escrever
        write_machine.unpause();
        
        if (interact_toast)
        {
            skip_alpha = lerp(skip_alpha, 1, .2);
            var _input = get_bind_name_from_key(skip_input);
            var _skip = write_machine.get_state();
            
            if (input(_input, "pressed", "button"))
            {
                write_machine.skip();
                if (_skip == 1)
                {
                    skip_scalex = .8;
                    skip_scaley = .8;
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
                            //Fecha o toast
                        	visible_toast = false;
                        }
                    }
                    else //Caso não for um array
                    {
                        //Fecha o toast
                        visible_toast = false;
                    }
                }
                else 
                {
                	skip_scalex = .8;
                    skip_scaley = .8;
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
    }
    else //Caso for menor
    {
        //Pausa a maquina de escrever
        write_machine.pause();
    }
    
    //Move suavemente a posição vertical atual do toast para a final
    toasty = lerp(toasty, finy, .1);
}

function close_toast()
{
    //Diminui suavemente a escala do toast
    xscale = lerp(xscale, 0, .2);
    yscale = lerp(yscale, 0, .1);
    //Diminui suavemente a escala do texto
    text_scale = lerp(text_scale, 0, .2);
    
    //Volta o toast para sua posição inicial
    toasty = lerp(toasty, iniy, .1);
    toastx = lerp(toastx, x, .5);
    //Diminui suavemente a transparencia do texto
    alpha = lerp(alpha, 0, .4);
    skip_alpha = lerp(skip_alpha, 0, .2);
    //Diminui suavemente a transparencia do toast
    sprite_alpha = lerp(sprite_alpha, 0, .2);
    
    //Faz o angulo do texto ficar reto suavemente
    text_angle = lerp(text_angle, iniangle, .2);
    //Faz o angulo do texto ficar reto suavemente
    sprite_angle = lerp(sprite_angle, iniangle, .2);
    
    skip_scalex = lerp(skip_scalex, skip_scalemax, .1)
    skip_scaley = lerp(skip_scaley, skip_scalemax, .1)
    
    //Se o toast estiver transparente (ou quase)
    if (sprite_alpha <= .1)
    {
        //Deleta o toast
        instance_destroy();
    }
}

function float()
{
    //Variavel que define a velocidade de flutuação
    float_number = 2 * (get_timer() / 1000000);
    //Variavel que define a distancia alteranda da flutuação
    var _float = sin(float_number) * .5;
    
    //Aplica a flutuação na disposição vertical do toast
    toasty += _float;
}
