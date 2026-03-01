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
    
    pitch = random_range(.9, 1.1);
    
    audio_stop_sound(snd_shake_impact);
    audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx, 0, pitch);
    
    if (shake_amount == 1)
    {
        instance_create_layer(random_range(x - 640 / 2, x + 640 / 2), random_range(y - 360, y - 128), "Lens_Effect", obj_wakeup);
        audio_play_sound(snd_tension_transition, 2, false, .06 * global.additional_sfx);
    }
    
    else if (shake_amount == 5)
    {
        var _wakeup = instance_create_layer(random_range(x - 854 / 2, x + 854 / 2), random_range(y - 480, y - 128), "Lens_Effect", obj_wakeup);
        _wakeup.text = "Nada é real!";
    }
    else if (shake_amount == 10)
    {
        var _wakeup = instance_create_layer(random_range(x - 854 / 2, x + 854 / 2), random_range(y - 480, y - 128), "Lens_Effect", obj_wakeup);
        _wakeup.text = "Isso não existe!";
    }
    else if (shake_amount == 20)
    {
    	var _wakeup = instance_create_layer(random_range(x - 854 / 2, x + 854 / 2), random_range(y - 480, y - 128), "Lens_Effect", obj_wakeup);
    }
    
    if (shake_amount >= 30)
    {
        global.cutscene = false;
        global.cutscene_actions = [];
        global.cutscene_atual_action = 0;
        global.lens = false;
        global.lens_effect = false;
        global.visible_objects_lens = false;
        audio_stop_all();
        audio_play_sound(snd_shake_impact, 1, false, .01 * global.additional_sfx, 0, pitch);
        room_goto(rm_section_1_bedroom);
    }
}

show_debug_message(shake_amount);

if (global.shake_width != clamp(global.shake_width, -.4, .4))
{
    if (global.use_joystick)
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
}
else 
{
	gamepad_set_vibration(0, 0, 0);
}