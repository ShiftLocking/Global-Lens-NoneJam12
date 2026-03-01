/// @description Insert description here
// You can write your code in this editor

global.resolution_base = lerp(global.resolution_base, 480, .5);

if (global.resolution_base == 480) instance_destroy();