/// @description Insert description here
// You can write your code in this editor

var _input = input("reset", "pressed", "button");

if (_input or run)
{
    global.stopped = false;
    global.lens = false;
    global.lens_effect = false;
    global.push = false;
    global.direction = 0;
    global.visible_objects_lens = false;
    global.inside_object = false;
    global.activate_collision = false;
    create_transition(room, "Transitions");
}