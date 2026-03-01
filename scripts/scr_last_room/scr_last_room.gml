function load_room()
{
    return global.last_room;
}

function has_last_room()
{
    return global.last_room != undefined;
}

function save_room(_room)
{
    var data = {
        last_room : _room
    };

    var json = json_stringify(data);
    var file = file_text_open_write("Rooms.room");
    file_text_write_string(file, json);
    file_text_close(file);
}

function load_last_room()
{
    if (!file_exists("Rooms.room"))
    {
        global.last_room = undefined;
        return;
    }

    var file = file_text_open_read("Rooms.room");
    var json = "";
    
    while (!file_text_eof(file))
    {
        json += file_text_read_string(file);
        file_text_readln(file);
    }
    file_text_close(file);

    var data = json_parse(json);
    global.last_room = data.last_room;
}

function reset_last_room()
{
    global.last_room = undefined;
    save_room(global.last_room);
}