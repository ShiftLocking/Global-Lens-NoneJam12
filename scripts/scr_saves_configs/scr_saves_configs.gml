function save_configs()
{
    var data = {
        additional_sfx        : global.additional_sfx,
        additional_voice      : global.additional_voice,
        additional_music      : global.additional_music,
        fullscreen            : global.fullscreen,
        borderless_fullscreen : global.borderless_fullscreen
    };

    var json = json_stringify(data);
    var file = file_text_open_write("configs.figs");
    file_text_write_string(file, json);
    file_text_close(file);
}

function load_configs()
{
    if (!file_exists("configs.figs"))
    {
        // defaults
        global.additional_sfx = 1;
        global.additional_voice = 1;
        global.additional_music = 1;
        global.fullscreen = true;
        global.borderless_fullscreen = true;
        save_configs(); // já cria o arquivo bonitinho
        return;
    }

    var file = file_text_open_read("configs.figs");
    var json = "";
    
    while (!file_text_eof(file))
    {
        json += file_text_read_string(file);
        file_text_readln(file);
    }
    file_text_close(file);

    var data = json_parse(json);

    global.additional_sfx        = data.additional_sfx        ?? 1;
    global.additional_voice      = data.additional_voice      ?? 1;
    global.additional_music      = data.additional_music      ?? 1;
    global.fullscreen            = data.fullscreen            ?? true;
    global.borderless_fullscreen = data.borderless_fullscreen ?? true;
}