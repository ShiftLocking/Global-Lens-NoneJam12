/// @description Insert description here
// You can write your code in this editor

if (instance_exists(target))
{
    x = target.x;
    y = target.y;
    var _input = input("change", , , , true);
    var _input2 = input("change", "pressed", "button");
    
    interact(_input, target.x, target.y - target.sprite_height, id, target, 1, .8, .8);
    
    if (!active)
    {
        global.change = false;
        instance_destroy();
    }
    
    if (_input2)
    {
        active = false;
    }
}