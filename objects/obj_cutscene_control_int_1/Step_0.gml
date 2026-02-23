/// @description Insert description here
// You can write your code in this editor

if (instance_exists(target) && global.cutscene)
{
    switch (global.cutscene_actions[global.cutscene_atual_action]) 
    {
    	case "right" :
            target.hspd = apr(target.hspd, 1, .6);
        break
    }
}
else 
{
	instance_destroy();
}