/// @description Insert description here
// You can write your code in this editor

//Pega o arquivo de texto
arquive_text = buffer_load("gojou_dialogue_int_1.json");
json = buffer_read(arquive_text, buffer_string);
buffer_delete(arquive_text);
data = json_parse(json);
text = data.dialogue;

target = obj_gojou_introduction_1;