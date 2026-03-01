global.stopped = false;
global.lens = false;
global.lens_effect = false;
global.push = false;
global.direction = 0;
global.visible_objects_lens = false;
global.inside_object = false;
global.activate_collision = false;
global.change = true;

global.cutscene = false;
global.cutscene_actions = [];
global.cutscene_atual_action = 0;

global.resolution_width_no_fullscreen = (display_get_width() * 85) / 100;
global.resolution_height_no_fullscreen = (display_get_height() * 85) / 100;

global.resolution_width_fullscreen = display_get_width();
global.resolution_height_fullscreen = display_get_height();

global.resolution_width = global.resolution_width_no_fullscreen;
global.resolution_height = global.resolution_height_no_fullscreen;

global.fullscreen = true;
global.borderless_fullscreen = true;
global.resolution_base = 480;

global.resolution_scale = global.resolution_height / global.resolution_base;

global.shake_width = 0;
global.shake_height = 0;

global.additional_sfx = 1;
global.additional_voice = 1;
global.additional_music = 1;

global.last_room = undefined;

global.basement_dialogue = true;
global.panel = false;

load_configs();
load_last_room();