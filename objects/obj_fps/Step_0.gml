/// @description Insert description here
// You can write your code in this editor

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

if (keyboard_check_pressed(vk_f11))
{
    if (!full)
    {
        global.resolution_width = global.resolution_width_fullscreen;
        global.resolution_height = global.resolution_height_fullscreen;
        full = true;
    }
    else 
    {
    	global.resolution_width = global.resolution_width_no_fullscreen;
        global.resolution_height = global.resolution_height_no_fullscreen;
        full = false;
    }
}

window_enable_borderless_fullscreen(full);
window_set_fullscreen(full);