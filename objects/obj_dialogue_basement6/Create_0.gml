/// @description Insert description here
// You can write your code in this editor

//Pega o arquivo de texto
arquive_text = buffer_load("player_dialogue_basement.json");
json = buffer_read(arquive_text, buffer_string);
buffer_delete(arquive_text);
data = json_parse(json);
text = data.dialogue6;

target = obj_player;