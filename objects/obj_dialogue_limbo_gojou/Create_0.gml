/// @description Insert description here
// You can write your code in this editor

//Pega o arquivo de texto
arquive_text = buffer_load("gojou_dialogue_limbo.json");
json = buffer_read(arquive_text, buffer_string);
buffer_delete(arquive_text);
data = json_parse(json);
text = data.dialogue1;

target = obj_gojou_section_2;