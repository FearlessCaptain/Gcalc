// lua/autorun/client/cl_gcalc.lua 

-- ClosePosX = (ScrH()/2)-100
-- ClosePosY = (ScrW()/2)-57



local function DrawCalc()

	-- local ClosePosX = gui.MouseX() -100
	-- local ClosePosY = gui.MouseY() -57
	-- print( "DrawCalc ran")
	
	local frame = vgui.Create( "DFrame" )
	frame:Center()
	-- frame:SetPos( (ScrW()/2)-57, (ScrH()/2)-100 )
	if closed then frame:SetPos( ClosePosX - 110, ClosePosY - 5 ) end 
	frame:SetSize( 115, 245 )
	frame:MakePopup()
	frame:ShowCloseButton( false )
	frame:SetTitle( "GCalc v0.06" )
	
	
	local label = vgui.Create( "DLabel", frame )
	label:SetPos( 6, 227 )
	label:SetText( "2016 FearlessCaptain" )
	label:SizeToContents()
	
	local close_but = vgui.Create( "DButton", frame )
	close_but:SetPos( 95, 0 )
	close_but:SetSize( 20, 20 )
	close_but:SetText( "X" )
	close_but.DoClick = function()
		ClosePosX = gui.MouseX()
		ClosePosY = gui.MouseY()
		-- print( ClosePosX, ClosePosY )
		frame:Close()
		closed = true
	end

 	local txt_entry = vgui.Create( "DTextEntry", frame )
	txt_entry:SetSize( 95, 20 )
	txt_entry:SetPos( 10, 30 )
	txt_entry:SetEditable( false )
	function txt_entry:OnChange()
		-- print( txt_entry:GetFloat() )
	end  
	
	-- number buttons
	local num = 0
	local memoryplus = 0
	local memorymin = 0 
	local memory = 0
	local memcheck = 0
	local check = 0 
	local operation = ""
	local value2 = 0
	local value1 = 0
	local posx = 10
	local posy = 180
	txt_entry:SetValue( "0" )
	for i = 1, 9 do
		-- print( "Building button " .. i )
		local calc_but = vgui.Create( "DButton", frame )
		calc_but:SetSize( 20, 20 )
		calc_but:SetPos( posx, posy )
		calc_but:SetText( i )
		calc_but.DoClick = function()
			memcheck = 0
			if check == 1 then check = 0 txt_entry:SetValue( 0 ) end
			num = txt_entry:GetValue()
			if num == "0" then
				txt_entry:SetValue( i )
			else
				txt_entry:SetValue( num .. i )
			end
			-- print( "value 2 " .. value )
		end
		
		posx = posx + 25
		if posx > 75 then
			posx = 10
		end
		
		if i == 3 then 
			posy = 155
		elseif i == 6 then
			posy = 130
		end
	end
	
	local zero_but = vgui.Create( "DButton", frame )
	zero_but:SetSize( 45, 20 )
	zero_but:SetPos( 10, 205 )
	zero_but:SetText( 0 )
	zero_but.DoClick = function()
		memcheck = 0
		if check == 1 then check = 0 txt_entry:SetValue( 0 ) end
		num = txt_entry:GetValue()
		-- print( "value " .. value )
		-- print( "num " .. num )
		-- print( "i " .. 0 ) 
		if num == "0" then
			txt_entry:SetValue( 0 )
		else
			txt_entry:SetValue( num .. 0 )
		end
	end
	
	
	-- memory function buttons 
	
	local mshow_but = vgui.Create( "DButton", frame )
	mshow_but:SetSize( 20, 20 )
	mshow_but:SetPos( 10, 55 )
	mshow_but:SetText( "MR" )
	mshow_but.DoClick = function()
		if tonumber( memory ) == 0 then	 -- set memory value
			if isnumber( tonumber( txt_entry:GetValue())) == true then
				memory = tonumber( txt_entry:GetValue() )
			else
				memory = 0 
			end
			print( "Added " .. memory .. " to memory" )
		else
			if memcheck == 1 then 	-- clear memory
				print( "Cleared calc memory!" )
				txt_entry:SetValue( 0 )
				num = 0
				memory = 0 
				memcheck = 0
				memorymin = 0 
				memoryplus = 0
			elseif memcheck == 0 then 	-- set text to value
				txt_entry:SetValue( memory )
				memcheck = 1
			end
		end
	end
	
	local mplus_but = vgui.Create( "DButton", frame )
	mplus_but:SetSize( 20, 20 )
	mplus_but:SetPos( 35, 55 )
	mplus_but:SetText( "M+" )
	mplus_but.DoClick = function()
		memcheck = 0
		if txt_entry:GetValue() == 0 or txt_entry:GetValue() == "0" then
		//pass
		else
			if memoryplus == 0 then 
				if isnumber(tonumber( txt_entry:GetValue() )) == true then
					num = tonumber( txt_entry:GetValue() )
				else
					num = 0 
				end
				memoryplus = num
			else 
				num = memoryplus
			end
		end
		-- if isstring( memory ) == true then memory = 0 end
		memory = memory + num 
		txt_entry:SetValue( memory )
	end
	
	local mmin_but = vgui.Create( "DButton", frame )
	mmin_but:SetSize( 20, 20 )
	mmin_but:SetPos( 60, 55 )
	mmin_but:SetText( "M-" )
	mmin_but.DoClick = function()
		memcheck = 0
		if txt_entry:GetValue() == 0 or txt_entry:GetValue() == "0" then
		//pass
		else
			if memorymin == 0 then 
				if isnumber(tonumber( txt_entry:GetValue() )) == true then
					num = tonumber( txt_entry:GetValue() )
				else
					num = 0 
				end
				memorymin = num
			else 
				num = memorymin
			end
		end
		
		memory = memory - num 
		txt_entry:SetValue( memory )
		-- end
	end
	
	// special function buttons now with more filler 
	
	
	
	local rad_but = vgui.Create( "DButton", frame )
	rad_but:SetSize( 20, 20 )
	rad_but:SetPos( 85, 80 )
	rad_but:SetText( "√" )
	rad_but.DoClick = function()
		if check == 1 then check = 0 txt_entry:SetValue( 0 ) end
		memcheck = 0
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( math.sqrt( value1 ) )
		check = 1
	end
	
	local exp_but = vgui.Create( "DButton", frame )
	exp_but:SetSize( 20, 20 )
	exp_but:SetPos( 10, 105 )
	exp_but:SetText( "^" )
	exp_but.DoClick = function()
		memcheck = 0
		operation = "^"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	
	
	
	
	
	
	// function buttons
	local clear_but = vgui.Create( "DButton", frame )
	clear_but:SetSize( 45, 20 )
	clear_but:SetPos( 10, 80 )
	clear_but:SetText( "C" )
	clear_but.DoClick = function()
		memcheck = 0
		memorymin = 0 
		memoryplus = 0
		value = 0
		operation = ""
		value1 = 0
		value2 = 0 
		txt_entry:SetValue( 0 )
	end
	
	local plus_but = vgui.Create( "DButton", frame )
	plus_but:SetSize( 20, 45 )
	plus_but:SetPos( 85, 130 )
	plus_but:SetText( "+" )
	plus_but.DoClick = function()
		memcheck = 0
		operation = "+"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local sub_but = vgui.Create( "DButton", frame )
	sub_but:SetSize( 20, 20 )
	sub_but:SetPos( 85, 105 )
	sub_but:SetText( "-" )
	sub_but.DoClick = function()
		memcheck = 0
		operation = "-"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local div_but = vgui.Create( "DButton", frame )
	div_but:SetSize( 20, 20 )
	div_but:SetPos( 35, 105 )
	div_but:SetText( "÷" )
	div_but.DoClick = function()
		memcheck = 0
		operation = "/"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local multi_but = vgui.Create( "DButton", frame )
	multi_but:SetSize( 20, 20 )
	multi_but:SetPos( 60, 105 )
	multi_but:SetText( "x" )
	multi_but.DoClick = function()
		memcheck = 0
		operation = "*"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	// this used to be the pi button but I thought that a % function would be more useful.
	local pi_but = vgui.Create( "DButton", frame )
	pi_but:SetSize( 20, 20 )
	pi_but:SetPos( 60, 80 )
	pi_but:SetText( "%" )
	pi_but.DoClick = function()
		memcheck = 0
		operation = "%"
		value1 = txt_entry:GetFloat()
		txt_entry:SetValue( 0 )
	end
	
	local dot_but = vgui.Create( "DButton", frame )
	dot_but:SetSize( 20, 20 )
	dot_but:SetPos( 60, 205 )
	dot_but:SetText( "." )
	dot_but.DoClick = function()
		memcheck = 0
		num = txt_entry:GetValue()
		txt_entry:SetValue( num .. "." )
	end
	
	local negpos_but = vgui.Create( "DButton", frame )
	negpos_but:SetSize( 20, 20 )
	negpos_but:SetPos( 85, 55 )
	negpos_but:SetText( "+/-" )
	negpos_but.DoClick = function()
		memcheck = 0
		num = txt_entry:GetValue()
		if isnumber( tonumber( txt_entry:GetValue())) == true then
			num = tonumber( txt_entry:GetValue() )
		else
			num = 0 
		end
		txt_entry:SetValue( num * -1 )
	end
	
	local equal_but = vgui.Create( "DButton", frame )
	equal_but:SetSize( 20, 45 )
	equal_but:SetPos( 85, 180 )
	equal_but:SetText( "=" )
	equal_but.DoClick = function()
		memcheck = 0
		
		value2 = txt_entry:GetFloat()
		
		-- checks to make sure values are valid
		if value1 == nil or isstring( value1 ) == true then value1 = 0 end
		if value2 == nil or isstring( value2 ) == true then value2 = 0 end
		
		if operation == "+" then
			txt_entry:SetValue( tonumber( value1 ) + tonumber( value2 ) )
		elseif operation == "-" then
			txt_entry:SetValue( tonumber( value1 ) - tonumber( value2 ) )
		elseif operation == "/" then
			txt_entry:SetValue( tonumber( value1 ) / tonumber( value2 ) )
		elseif operation == "*" then
			txt_entry:SetValue( tonumber( value1 ) * tonumber( value2 ) )
		elseif operation == "^" then
			txt_entry:SetValue( math.pow( tonumber( value1 ), tonumber( value2 ) ) )
		elseif operation == "%" then
			txt_entry:SetValue( ( tonumber( value2 ) / 100 ) * tonumber( value1 ) )
		else
			txt_entry:SetValue( 0 )

		end
		check = 1
	end
	
end




local function GCalcHelp()

	
	local frame = vgui.Create( "DFrame" )
	frame:Center()
	-- frame:SetPos( (ScrW()/2)-57, (ScrH()/2)-100 )
	if closed then frame:SetPos( ClosePosX - 110, ClosePosY - 5 ) end 
	frame:SetSize( 200, 245 )
	frame:MakePopup()
	frame:ShowCloseButton( false )
	frame:SetTitle( "GCalc Help" )
	
	local label = vgui.Create( "DLabel", frame )
	label:SetPos( 10, 35 )
	label:SetText( "You can't use a calculator? What did\nthey teach you in school? Type into\nGoogle, 'how to use a calculator' and\nyou will find the help you need there.\n\nThe only thing that might be different\nis the Percentage function. It works\na little easier then on a regular calcu-\nlator but those are dumb anyway. For\nthis calculator enter the number you\nwant a percentage of, eg. 395 then\nhit '%' and then enter what percen-\ntage of it you want, like 7. Then hit\nenter and there you are. 7% of 395." )
	label:SizeToContents() 
	
	local label = vgui.Create( "DLabel", frame )
	label:SetPos( 62, 227 )
	label:SetText( "Steam Edition!" )
	label:SetTextColor( Color( 146, 146, 146, 255 ) )
	label:SizeToContents()
	
	local close_but = vgui.Create( "DButton", frame )
	close_but:SetPos( 180, 0 )
	close_but:SetSize( 20, 20 )
	close_but:SetText( "X" )
	close_but.DoClick = function()
		ClosePosX = gui.MouseX()
		ClosePosY = gui.MouseY()
		-- print( ClosePosX, ClosePosY )
		frame:Close()
		closed = true
	end

end

// This is a nice way to make client side chat commands. They have low overhead
// and are easy to copypaste because you don't have to count ant characters.

hook.Add( "OnPlayerChat", "CreateGCalc", function( ply, text, team )
	if ply == LocalPlayer() and text:lower():match("!gcalc$") then
		DrawCalc()
		return ""
	end
end )

hook.Add( "OnPlayerChat", "CreateGCalcHelp", function( ply, text, team )
	if ply == LocalPlayer() and text:lower():match("!gcalchelp$") then
		GCalcHelp()
		return ""
	end
end )

