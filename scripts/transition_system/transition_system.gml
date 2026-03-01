/// @desc Esta função irá criar um efeito de transição
/// @param {Asset.GMRoom} _room Sala para qual a transição levará
/// @param {String} _layer Layer onde será criada a transição
/// @param {Constant.Color} _color Cor da transição
/// @param {Asset.GMSprite} _sprite Sprite da transição (A SPRITE DEVE TER A VELOCIDADE MINIMA DE 120 FPS)

function create_transition(_room, _layer, _type = 1, _colour = c_black, _sprite = rectangle, _vel = undefined)
{
    if (!instance_exists(transition) && _type == 1)
    {
        var _transition = instance_create_layer(0, 0, _layer, transition);
        _transition.sprite = _sprite;
        _transition.colour = _colour;
        _transition.next_room = _room;
    }
    
    if (_type == 2)
    {
        var _transition = instance_create_layer(0, 0, _layer, transition2);
        _transition.sprite = _sprite;
        _transition.colour = _colour;
        _transition.next_room = _room;
        if (_vel != undefined) _transition.fade_spd = _vel;
    }
    
    if (!instance_exists(transition3) && _type == 3)
    {
        var _transition = instance_create_layer(0, 0, _layer, transition3);
        _transition.sprite = _sprite;
        _transition.colour = _colour;
        _transition.next_room = _room;
        if (_vel != undefined) _transition.fade_spd = _vel;
    }
}