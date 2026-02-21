/// @desc Essa função irá mudar a sprite e resetar os frames
/// @param {Asset.GMSprite} _spr Sprite para ser mudada
function set_sprite(_spr)
{
    if (sprite_index != _spr)
    {
        sprite_index = _spr;
        image_index = 0;
    }
}