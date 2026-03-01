/// @description Insert description here
// You can write your code in this editor

//Pega o arquivo de texto
arquive_text = buffer_load("mrstomach_dialogue_bedroom.json");
json = buffer_read(arquive_text, buffer_string);
buffer_delete(arquive_text);
data = json_parse(json);
text = data.dialogue;

target = obj_player;
if (instance_exists(obj_cam))
{
    obj_cam.view_target = id;
}