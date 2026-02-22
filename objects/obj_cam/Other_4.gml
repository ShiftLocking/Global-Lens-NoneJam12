/// @description Insert description here
// You can write your code in this editor

view_enabled = true;
view_visible[0] = true;
global.width = global.resolution_width / global.resolution_scale;
global.height = global.resolution_height / global.resolution_scale;
camera_set_view_size(view_camera[0], global.width, global.height);
window_set_size(global.width * global.resolution_scale, global.height * global.resolution_scale);
surface_resize(application_surface, global.width * global.resolution_scale, global.height * global.resolution_scale);
display_set_gui_size(global.width, global.height);
window_center();
if (instance_exists(view_target))
{
	_x_to = view_target.x - global.width / 2;
	_y_to = view_target.y - global.height / 2;
	_x_to = clamp(_x_to, 0, room_width - global.width);
	_y_to = clamp(_y_to, 0, room_height - global.height);
	camera_set_view_pos(view_camera[0], _x_to, _y_to);
}
