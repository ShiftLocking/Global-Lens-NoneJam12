/// @description Insert description here
// You can write your code in this editor

if (!global.stopped)
{
    move();
}
else 
{
	stopped();
}

gravity_system();

if (!is_undefined(action))
{
    action();
}
else 
{
	what_state = "";
}

if (global.push)
{
    spd = push_spd;
}
else 
{
	spd = normal_spd;
}

show_debug_message("Lens " + string(global.lens));
show_debug_message("Stopped " + string(global.stopped));
show_debug_message("Effect " + string(global.lens_effect));
show_debug_message("Push " + string(global.push));