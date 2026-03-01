function get_in_pause()
{
    if (global.paused)
    {
        return true;
    }
    
    return false;
}

function pause(_input, _layer)
{
    var _i = get_bind_name_from_key(_input)
    var _back = input("back", "pressed", "button");
    if (input(_i, "pressed", "button"))
    {
        if (!global.paused)
        {
            instance_create_layer(0, 0, _layer, obj_pause);
            global.paused = true;
        }
        else
        {
            if (instance_exists(obj_graficos) or instance_exists(obj_controles)) exit;
            instance_destroy(obj_pause);
            global.paused = false;
            
        }
    }
}