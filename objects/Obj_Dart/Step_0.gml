/// @description Update

//Get Controller Connection
pad_num = 4;
pad_on = gamepad_is_connected(pad_num);

//Get Controller Input
pad_left = gamepad_button_check(pad_num,gp_padl);
pad_right = gamepad_button_check(pad_num,gp_padr);
pad_down = gamepad_button_check(pad_num,gp_padd);
pad_sneak = gamepad_button_check(pad_num,gp_shoulderl);
pad_jump = gamepad_button_check_pressed(pad_num,gp_face1);

//Get Keyboard Input
key_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
key_down = keyboard_check(vk_down) || keyboard_check(ord("S"));
key_sneak = keyboard_check(vk_shift);
key_jump = keyboard_check_pressed(vk_space);


//Calculate Movement
if pad_on
{
	var move = pad_right - pad_left;
	
	vertSpeed += grav;
	
	if (move != 0) 
	{
		if (pad_sneak) 
		{
			sprite_index = Spr_Dart_Walk;
			horSpeed = move * walkSpeed;
		}
		else
		{
			sprite_index = Spr_Dart_Run;
			horSpeed = move * runSpeed;
		}
	}
	else horSpeed = 0;
	if(move == 1) image_xscale = 3.5;
	else if(move == -1) image_xscale = -3.5;
	else if (pad_down) sprite_index = Spr_Dart_Duck;
	else sprite_index = Spr_Dart_Idle;
	
	if (place_meeting(x,y+1,Obj_Wall) && pad_jump)
	{
		vertSpeed = -30;
	}
}
else
{
	var move = key_right - key_left;
	
	vertSpeed += grav;
	
	if (move != 0) 
	{
		if (key_sneak) 
		{
			sprite_index = Spr_Dart_Walk;
			horSpeed = move * walkSpeed;
		}
		else
		{
			sprite_index = Spr_Dart_Run;
			horSpeed = move * runSpeed;
		}
	}
	else horSpeed = 0;
	if(move == 1) image_xscale = 3.5;
	else if(move == -1) image_xscale = -3.5;
	else if key_down sprite_index = Spr_Dart_Duck;
	else sprite_index = Spr_Dart_Idle;
	
	if (place_meeting(x,y+1,Obj_Wall) && key_jump)
	{
		vertSpeed = -30;
	}
}


//Horizontal Collision
if (place_meeting(x+horSpeed,y,Obj_Wall))
{
	while(!place_meeting(x+sign(horSpeed),y,Obj_Wall))
	{
		x += sign(horSpeed);
	}
	horSpeed = 0;
}
x += horSpeed;
	
//Vertical Collision
if (place_meeting(x,y+vertSpeed,Obj_Wall))
{
	while(!place_meeting(x,y+sign(vertSpeed),Obj_Wall))
	{
		y += sign(vertSpeed);
	}
	vertSpeed = 0;
}
y += vertSpeed;