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

show_debug_message("Lens " + string(global.lens));
show_debug_message("Stopped " + string(global.stopped));