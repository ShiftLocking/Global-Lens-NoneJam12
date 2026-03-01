/// @desc Essa função irá mudar a sprite e resetar os frames
/// @param {Asset.GMSprite} _spr Sprite para ser mudada
function set_sprite(_spr, _index = 0)
{
    if (sprite_index != _spr)
    {
        sprite_index = _spr;
        image_index = _index;
    }
}

function uptade_scale_resolution()
{
    global.resolution_scale = global.resolution_height / global.resolution_base;
}

function uptade_cam()
{
    global.width = global.resolution_width / global.resolution_scale;
    global.height = global.resolution_height / global.resolution_scale;
    camera_set_view_size(view_camera[0], global.width, global.height);
    window_set_size(global.width * global.resolution_scale, global.height * global.resolution_scale);
    surface_resize(application_surface, global.width * global.resolution_scale, global.height * global.resolution_scale);
    display_set_gui_size(global.width, global.height);
    window_center();
}

function reset_globals()
{
    global.stopped = false;
    global.lens = false;
    global.lens_effect = false;
    global.push = false;
    global.direction = 0;
    global.visible_objects_lens = false;
    global.inside_object = false;
    global.activate_collision = false;
}