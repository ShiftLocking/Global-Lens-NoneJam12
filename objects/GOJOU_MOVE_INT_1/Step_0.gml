/// @description Insert description here
// You can write your code in this editor

var _paused = get_in_pause();

if (_paused)
{
    paused();
}
else 
{
    move();
    gravity_system();
    
    if (!is_undefined(action))
    {
        action();
    }
    else 
    {
    	what_state = "";
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
}