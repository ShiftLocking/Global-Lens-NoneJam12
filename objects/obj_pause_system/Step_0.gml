/// @description Insert description here
// You can write your code in this editor

var _input = input("pause",,,,true);

pause(_input, "Pause");

var _paused = get_in_pause();

if (_paused)
{
    audio_pause_all();
}
else 
{
	audio_resume_all();
}