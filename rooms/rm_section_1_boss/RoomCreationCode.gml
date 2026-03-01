global.change = true;
if (global.last_room == undefined)
{
    instance_create_layer(obj_player.x, obj_player.y, "Dialogues", obj_dialogue_basement);
}
else 
{
	instance_create_layer(obj_player.x, obj_player.y, "Inputs", obj_button_lens2);
    if (!instance_exists(obj_ost)) instance_create_layer(0, 0, "Player", obj_ost);
}

save_room(room);
global.last_room = room;    