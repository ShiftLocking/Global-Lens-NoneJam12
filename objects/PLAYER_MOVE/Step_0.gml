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

if (hspd != 0)
{
    dir = sign(hspd);
}

effect_xscale = lerp(effect_xscale, 0, .1);
effect_yscale = lerp(effect_yscale, 0, .1);

if (atual_action != action)
{
    effect_done = false;
    atual_action = action;
}

/*
show_debug_message("Lens " + string(global.lens));
show_debug_message("Stopped " + string(global.stopped));
show_debug_message("Effect " + string(global.lens_effect));
show_debug_message("Push " + string(global.push));
show_debug_message("Inside " + string(global.inside_object));