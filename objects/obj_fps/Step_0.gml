/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_reset))
{
    if (input("reset", "pressed", "button"))
    {
        global.stopped = false;
        global.lens = false;
        global.lens_effect = false;
        global.push = false;
        global.direction = 0;
        global.visible_objects_lens = false;
        global.inside_object = false;
        game_restart();
    }
}