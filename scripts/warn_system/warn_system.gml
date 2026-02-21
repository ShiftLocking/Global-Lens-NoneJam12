function draw_warn(_ballonsprite, _text, _font, _color)
{
    //Criando as variaveis no objeto
    if (!variable_instance_exists(id, "d"))
    {
        d = draw_warn_create();
    }
    
    if (change_position)
    {
        position--;
        global.P = false;
        change_position = false;
    }
    
    change_position = global.P;
    
    //Caso for visivel
    if (visible_warn)
    {
        //Executa o código de abrir
        open_warn();
    }
    else //Caso não for
    {
        //Executa o código de fechar
        close_warn();
    }
    
    var _data_font = asset_get_index(_font);
    draw_set_font(_data_font);
    draw_set_halign(1);
    draw_set_valign(1);
    
    var _text_width = string_width(_text);
    var _sprite_height = sprite_get_height(_ballonsprite);
    var _sprite_width = sprite_get_width(_ballonsprite);
    var _margin = 16;
    d.width = (_text_width + _margin) / _sprite_width;
    d.posyfin = (_sprite_height + _margin) * position;
    var _posx = display_get_gui_width() / 2;
    draw_sprite_ext(_ballonsprite, 0, _posx, d.posy, d.xscale, d.yscale, 0, c_white, 1);
    
    draw_text_transformed_colour(_posx, d.posy - _sprite_height / 2, _text, d.text_xscale, 1, 0, _color, _color, _color, _color, 1);
    
    draw_set_font(-1);
    draw_set_halign(-1);
    draw_set_valign(-1);
}

function open_warn()
{
    var _xscale = d.width;
    var _yscale = d.height;
    
    d.xscale = lerp(d.xscale, _xscale, .4);
    d.yscale = _yscale;
    d.text_xscale = lerp(d.text_xscale, 1, .4);
    
    d.posy = lerp(d.posy, d.posyfin, .1);
    
    time -= delta_time / 1000000;
    if (time <= 0)
    {
        visible_warn = false;
    }
}

function close_warn()
{
    d.posy = lerp(d.posy, d.posyini, .4);
    d.xscale = lerp(d.xscale, 0, .2);
    d.text_xscale = lerp(d.text_xscale, 0, .2);
    
    if (d.posy <= .1)
    {
        instance_destroy();
    }
}

function draw_warn_create()
{
    return
    {
        xscale: 0,
        yscale: 0,
        text_xscale: 0,
        width: 1,
        height: 1,
        posy: 0,
        posyini: 0,
        posyfin: 0
    };
}