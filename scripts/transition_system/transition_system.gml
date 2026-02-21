/// @desc Esta função irá criar um efeito de transição
/// @param {Asset.GMRoom} _room Sala para qual a transição levará
/// @param {String} _layer Layer onde será criada a transição
/// @param {Constant.Color} _color Cor da transição
/// @param {Asset.GMSprite} _sprite Sprite da transição (A SPRITE DEVE TER A VELOCIDADE MINIMA DE 120 FPS)

function create_transition(_room, _layer, _colour = c_black, _sprite = rectangle)
{
    if (!instance_exists(transition))
    {
        var _transition = instance_create_layer(0, 0, _layer, transition);
        _transition.sprite = _sprite;
        _transition.colour = _colour;
        _transition.next_room = _room;
    }
}