/// @description Insert description here
// You can write your code in this editor

var dx = 16;
var dy = display_get_gui_height() / 2;
var lh = 16;

draw_set_color(c_white);

// FPS
draw_text(dx, dy, "FPS: " + string(fps)); dy += lh;
draw_text(dx, dy, "FPS REAL: " + string(fps_real)); dy += lh;

// Engine
draw_text(dx, dy, "Room Speed: " + string(room_speed)); dy += lh;
draw_text(dx, dy, "Game Speed: " + string(game_get_speed(gamespeed_fps))); dy += lh;

// Display
draw_text(dx, dy, "Display: " + string(display_get_width()) + "x" + string(display_get_height())); dy += lh;
draw_text(dx, dy, "Window: " + string(window_get_width()) + "x" + string(window_get_height())); dy += lh;
draw_text(dx, dy, "Room: " + string(room_width) + "x" + string(room_height)); dy += lh;

// Instâncias
draw_text(dx, dy, "Instâncias: " + string(instance_number(all))); dy += lh;

if (!instance_exists(PLAYER_MOVE)) exit;
draw_text(dx, dy, "HSPD: " + string(PLAYER_MOVE.hspd)); dy += lh;
draw_text(dx, dy, "VSPD: " + string(PLAYER_MOVE.vspd)); dy += lh;
