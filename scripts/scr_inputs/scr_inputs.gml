add_additional_inputs("jump", ord("X"), gp_face1);
add_additional_inputs("change", ord("C"), gp_face2);
add_additional_inputs("push", ord("Z"), gp_shoulderrb);
add_additional_inputs("skip", ord("E"), gp_face1);
add_additional_inputs("interact", ord("E"), gp_face3);

add_additional_inputs("reset", ord("R"), gp_shoulderl);
add_additional_inputs("pause", vk_escape, gp_start);

add_additional_inputs("down", vk_down, gp_padd);
add_additional_inputs("up", vk_up, gp_padu);
add_additional_inputs("select", vk_enter, gp_face1);
add_additional_inputs("back", vk_escape, gp_face2);

add_additional_inputs("right", vk_right, gp_padr);
add_additional_inputs("left", vk_left, gp_padl);

load_mapping();
save_mapping();