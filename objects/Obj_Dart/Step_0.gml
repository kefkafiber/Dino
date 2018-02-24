/// @description Update

//Get Controller Connection
pad_num = 4;
pad_on = gamepad_is_connected(pad_num);

//Get Controller Input
pad_left = gamepad_button_check(pad_num,gp_padl);
pad_right = gamepad_button_check(pad_num,gp_padr);
pad_down = gamepad_button_check(pad_num,gp_padd);
pad_jump = gamepad_button_check(pad_num,gp_face1);

//Get Keyboard Input
key_left = keyboard_check(vk_left);
key_right = keyboard_check(vk_right);
key_down = keyboard_check(vk_down);
key_jump = keyboard_check_pressed(vk_space);


//Calculate Movement
if pad_on
{
	var move = pad_right - pad_left;
	horSpeed = move * runSpeed;
	
	gamepad_set_axis_deadzone(4, .15);
	
	var haxis = gamepad_axis_value(4, gp_axislh);
	var vaxis = gamepad_axis_value(4, gp_axislv);
	direction = point_direction(0,0,haxis,0);
	speed = point_distance(0,0,haxis,0);
	
	var Walking = speed <.75 && speed >.1;
	var Running = speed >= .75;
	
	if direction == 0
	{
		if Walking horSpeed = speed * walkSpeed;
		else if Running horSpeed = speed * runSpeed;
	}
	else if direction == 180
	{
		if Walking horSpeed = -(speed * walkSpeed);
		else if Running horSpeed = -(speed * runSpeed);
	}
	
}
else
{
	var move = key_right - key_left;

	horSpeed = move * runSpeed;
}


if pad_on
{
	if (move != 0 || Walking || Running) sprite_index = Spr_Dart_Run;
	if(move == 1 || haxis > 0.1) image_xscale = 3.5;
	else if(move == -1 || haxis < -0.1) image_xscale = -3.5;
	else if (pad_down || vaxis > 0.1) sprite_index = Spr_Dart_Duck;
	else sprite_index = Spr_Dart_Idle;
	x = x + horSpeed;
}
else
{
	
	if move != 0 sprite_index = Spr_Dart_Run;
	if(move == 1) image_xscale = 3.5;
	else if(move == -1) image_xscale = -3.5;
	else if key_down sprite_index = Spr_Dart_Duck;
	else sprite_index = Spr_Dart_Idle;
    x = x + horSpeed;
}

// Horizontal Collsion
if (place_meeting(x+horSpeed,y,Obj_Wall))