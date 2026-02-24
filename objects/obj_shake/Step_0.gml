/// @description Insert description here
// You can write your code in this editor

if (shake_timer > 0)
{
    shake_timer -= delta_time / 1000000;
}
else 
{
    shake_amount++;
    global.shake_width = random_range(-.8, .8) * shake_amount;
    global.shake_height = random_range(-.8, .8) * shake_amount;
    shake_timer = 1 / shake_amount;
    
    if (shake_amount >= 30)
    {
        global.cutscene = false;
        global.cutscene_actions = [];
        global.cutscene_atual_action = 0;
        global.lens = false;
        global.lens_effect = false;
        room_goto(rm_teste);
    }
}

show_debug_message(shake_amount);

if (global.shake_width != clamp(global.shake_width, -.4, .4))
{
    if (shake_amount < 29)
    {
        gamepad_set_vibration(0, 1, 1);
    }
    else 
    {
    	gamepad_set_vibration(0, 0, 0);
    }
}
else 
{
	gamepad_set_vibration(0, 0, 0);
}