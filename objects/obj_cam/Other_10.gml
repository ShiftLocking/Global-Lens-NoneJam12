/// @description Insert description here
// You can write your code in this editor

global.width = global.resolution_width / global.resolution_scale;
global.height = global.resolution_height / global.resolution_scale;
camera_set_view_size(view_camera[0], global.width, global.height);
window_set_size(global.width * global.resolution_scale, global.height * global.resolution_scale);
window_center();