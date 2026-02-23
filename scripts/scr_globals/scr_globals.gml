global.stopped = false;
global.lens = false;
global.lens_effect = false;
global.push = false;
global.direction = 0;
global.visible_objects_lens = false;
global.inside_object = false;
global.activate_collision = false;

global.cutscene = false;
global.cutscene_actions = [];
global.cutscene_atual_action = 0;

global.resolution_width_no_fullscreen = (display_get_width() * 85) / 100;
global.resolution_height_no_fullscreen = (display_get_height() * 85) / 100;

global.resolution_width_fullscreen = display_get_width();
global.resolution_height_fullscreen = display_get_height();

global.resolution_width = global.resolution_width_no_fullscreen;
global.resolution_height = global.resolution_height_no_fullscreen;

global.fullscreen = false;
global.actually_fullscren = false;
global.resolution_base = 480;

global.resolution_scale = global.resolution_height / resolution_base;