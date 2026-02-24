/// @description Insert description here
// You can write your code in this editor

randomize();

if (time_to_text > 0)
{
    time_to_text -= delta_time / 1000000;
    alpha = lerp(alpha, 1, .5);
}
else 
{
    if (alpha <= .01)
    {
        text_position = random_range(0, array_length(text) - 1);
    	time_to_text = random(.2);
    }
    else
    {
        alpha = lerp(alpha, 0, .1);
    }
}

if (time_to_effect > 0)
{
    time_to_effect -= delta_time / 1000000;
}
else 
{
    xscale = random_range(-.1, .1);
    yscale = random_range(-.1, -.1);
	time_to_effect = 1;
}

xscale = lerp(xscale, 0, .1);
yscale = lerp(yscale, 0, .1);

if (global.cutscene && instance_exists(obj_lens_effect))
{
    image_alpha = lerp(image_alpha, 0, .1);
    alpha = 0;
    audio_stop_sound(snd_peoples);
}
else 
{
	image_alpha = lerp(image_alpha, 1, .1);
}