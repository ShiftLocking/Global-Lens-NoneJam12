/// @description Insert description here
// You can write your code in this editor

if (instance_exists(view_target))
{
	_x_to = view_target.x - global.width / 2;
	_y_to = view_target.y - global.height / 2;
	
	_x_to = clamp(_x_to, 0, room_width - global.width);
	_y_to = clamp(_y_to, 0, room_height - global.height);
	
	var _p_x = camera_get_view_x(view_camera[0]);
	var _p_y = camera_get_view_y(view_camera[0]);
	
	camera_set_view_pos(view_camera[0], lerp(_p_x, _x_to, view_speed), lerp(_p_y, _y_to, view_speed));
}

