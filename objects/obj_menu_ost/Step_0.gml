/// @description Insert description here
// You can write your code in this editor

alpha = lerp(alpha, 1, .1);

audio_sound_gain(snd_menu_ost, global.additional_music * alpha);