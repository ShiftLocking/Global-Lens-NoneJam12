/// @description Insert description here
// You can write your code in this editor

if (instance_exists(toast))
{
    toast.finy = final_position;
    toast.iniy = instance.y;
    toast.inix = instance.x;
    toast.toastx = instance.x;
    
    var _finished = get_toast_finished();

    if (_finished)
    {
        if (time_to_destroy > 0)
        {
            time_to_destroy -= delta_time / 1000000;
        }
        else 
        {
        	toast.visible_toast = false;
        }
    }
}
else 
{
	if (time_to_destroy <= 0)
    {
        instance_destroy();
    }
}

final_position = instance.y - position;