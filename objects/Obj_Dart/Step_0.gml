/// @description Movement

if gamepad_is_connected(4)
{
	/// Variables
	gamepad_set_axis_deadzone(4, .15);
	
	var haxis = gamepad_axis_value(4, gp_axislh);
	var vaxis = gamepad_axis_value(4, gp_axislv);
	direction = point_direction(0,0,haxis,0);
	speed = point_distance(0,0,haxis,0);
	///
	
	//Moving Right
	if haxis != 0 || vaxis != 0
	{
		if (direction == 0)
		{
			if (speed < .75 && speed > .1)
			{
				sprite_index = Spr_Dart_Walk;
				image_xscale = 3.5;
				x = x + (speed * 8);
			}
			else if (speed >= .75)
			{
				sprite_index = Spr_Dart_Run;
				image_xscale = 3.5;
				x = x + (speed * 12);
			}
			else if (vaxis > .4)
			{
				sprite_index = Spr_Dart_Duck;
			}
			else
			{
				sprite_index = Spr_Dart_Idle;
			}
		}
		//Moving Left
		else if (direction == 180)
		{
			if (speed < .75 && speed > .1)
			{
				sprite_index = Spr_Dart_Walk;
				image_xscale = -3.5;
				x = x - (speed * 8);
			}
			else if (speed >= .75)
			{
				sprite_index = Spr_Dart_Run;
				image_xscale = -3.5;
				x = x - (speed * 12);
			}
			else
			{
				sprite_index = Spr_Dart_Idle;
			}
		}
	}
	else
	{
		//Moving Left
		if gamepad_button_check(4,gp_padl)&& !gamepad_button_check(4,gp_padr)
		{
			sprite_index = Spr_Dart_Run;
			image_xscale = -3.5;
			x = x - runSpeed;
		}
		//Moving Right
		else if gamepad_button_check(4,gp_padr) && !gamepad_button_check(4,gp_padl)
		{
			sprite_index = Spr_Dart_Run;
			image_xscale = 3.5;
			x = x + runSpeed;
		}
		else if gamepad_button_check(4,gp_padd)
		{
			sprite_index = Spr_Dart_Duck;
		}
		else
		{
			sprite_index = Spr_Dart_Idle;
		}
	}
}
else
{
	//Moving Left
	if keyboard_check(vk_left) && !keyboard_check(vk_right)
	{
		sprite_index = Spr_Dart_Run;
		image_xscale = -3.5;
		x = x - runSpeed;
	}
	//Moving Right
	else if keyboard_check(vk_right) && !keyboard_check(vk_left)
	{
		sprite_index = Spr_Dart_Run;
		image_xscale = 3.5;
		x = x + runSpeed;
	}
	else if keyboard_check(vk_down)
	{
		sprite_index = Spr_Dart_Duck;
	}
	else
	{
		sprite_index = Spr_Dart_Idle;
	}
}