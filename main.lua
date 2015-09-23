require("AnAL")
local function collision( a_X , a_Y , b_X , b_Y , object_a , object_b )
	flag = 0
	--left collide
	if (   b_X <= (a_X + object_a:getWidth())-20 and b_X >= a_X-20   ) and (  b_Y >= a_Y-20 and b_Y <= a_Y + object_a:getWidth()-50   ) then
		flag=1
		return flag
	end
		
	return flag
end

function love.load()
	r , g, b = 0 , 0 , 0
	--flags for BackgroundColor 
	flag_r = 0
	flag_g = 0
	flag_b = 0
	
	--load the joystick name
	joysticks = love.joystick.getJoysticks( )
	
	--destroyed objects 
	eagle_1=0
	eagle_2=0
	eagle_3=0
	eagle_4=0
	eagle_5=0
	eagle_6=0
	eagle_7=0
	eagle_8=0
	eagle_9=0
	eagle_10=0
	flag_character=0
	
	--eagles X Values random numbers 
	eagle_good_X={
		love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
	}
	eagle_good_Y={
		love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
	}
	eagle_bad_X={
		love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
		,love.math.random( 850, 1500 )
	}
	eagle_bad_Y={
		love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
		,love.math.random( 50, 470 )
	}
	
	--load the cloud position 
	xCloude_1 = 0
	xCloude_2 = -300
	xCloude_3 = -700
	xCloude_4 = -500
	Xgrass_1 = 800
	Xgrass_2 = 1600
	Xgrass_3 = 2400
	YBird = 300
	XBird = 50
	moving_bird=0
	gamespeed =3
	Game_over=0
	score=0
	game_x=250
	game_y=150
	
	
 	--load the images 
	imageCloude = love.graphics.newImage('textures/cloude.png')	
	point = love.graphics.newImage('textures/point.png')
	grass = love.graphics.newImage('textures/grass.png')
	grass_2 = love.graphics.newImage('textures/grass_2.png')
	game_over = love.graphics.newImage('textures/game_over.png')
	play_again = love.graphics.newImage('textures/play_again.png')
	out= love.graphics.newImage('textures/exit.png')
	
	--load the animation character ninja 
	local img  = love.graphics.newImage("textures/eagle_good.png")
    eagle_good = newAnimation(img, 50,51.66666666 ,0.06 , 6)
	
	--load the animation character ninja 
	local img  = love.graphics.newImage("textures/eagle_bad.png")
    eagle_bad = newAnimation(img, 50,51.66666666 ,0.06 , 6)
	
	
	--load the animation player character  
	local img  = love.graphics.newImage("textures/fly.png")
    bird = newAnimation(img, 140,128.6666666 ,0.03 , 0)
	
	--load the second flay
	local img  = love.graphics.newImage("textures/fly_2.png")
	bird_1 = newAnimation(img, 60,55.33333333,0.05 , 0)
	
	--define the particle 
	psystem = love.graphics.newParticleSystem(point, 1000000)
	psystem:setParticleLifetime(10000, 100000) -- Particles live at least 2s and at most 5s.
	psystem:setEmissionRate(10)
	psystem:setSizeVariation(0.7)
	psystem:setLinearAcceleration(-10, -10, 10, 10) -- Random movement in all directions.
	psystem:setColors(255, 255, 255, 255, 255, 255, 255, 255) -- Fade to transparency.
		
	--load the audio file 
	background = love.audio.newSource("Audio/1.ogg", "stream")
	sky = love.audio.newSource("Audio/2.ogg", "static")
	
end 

function love.draw()
	
	--draw the backgroud 
	if r == 255 and g == 255 and b == 255 then
		flag_r=1
		flag_g=1
		flag_b=1
	end
	
	if r== 0 and g == 0 and b == 0 then  
		flag_r=0
		flag_g=0
		flag_b=0
	end

	love.graphics.setBackgroundColor(r, g , b )
	--end drawing ---
	 
	 -- Draw the particle system at the center of the game window.
	love.graphics.draw(psystem, 150, 550)
	love.graphics.draw(psystem, 350, 550)
	love.graphics.draw(psystem, 550, 550)
	love.graphics.draw(psystem, 700, 560)
	
	-- draw(image to draw,posX , posY , angle , scaleX ,scaleY , offsetX , offsetY) 
	love.graphics.draw(imageCloude , xCloude_1 -50 ,150 , 0 , 1,1,0,0) 
	love.graphics.draw(imageCloude , xCloude_2 -150 ,120 , 5 , 1,1,0,0)
	love.graphics.draw(imageCloude , xCloude_3 -250 ,300 , 0 , 1,1,0,0)
	love.graphics.draw(imageCloude , xCloude_4 -350 ,70 , 5 , 1,1,0,0)
	bird_1:draw(moving_bird, 150)
	
	--draw the grass 
	love.graphics.draw(grass , 0 ,500 , 0 , 1,1,0,0) 
	love.graphics.draw(grass_2 , Xgrass_1 ,500 , 0 , 1,1,0,0)
	love.graphics.draw(grass_2 , Xgrass_2 ,500 , 0 , 1,1,0,0)
	love.graphics.draw(grass_2 , Xgrass_3 ,500 , 0 , 1,1,0,0)
	love.graphics.print( "Score : "..score, 10, 10, 0, 3, 3, 0, 0 )
	love.graphics.draw(imageCloude , xCloude_3 -700 ,200 , 0 , 0.3,0.3,0,0)
	love.graphics.draw(imageCloude , xCloude_3 -600 ,350 , 0 , 0.5,0.5,0,0)
	love.graphics.draw(imageCloude , xCloude_3 -600 ,150 , 0 , 0.5,0.5,0,0)
	
	eagle_good:draw(eagle_good_X[1], eagle_good_Y[1])
	eagle_good:draw(eagle_good_X[2], eagle_good_Y[2])
	eagle_good:draw(eagle_good_X[3], eagle_good_Y[3])
	eagle_good:draw(eagle_good_X[4], eagle_good_Y[4])
	eagle_good:draw(eagle_good_X[5], eagle_good_Y[5])
	eagle_bad:draw(eagle_bad_X[1], eagle_bad_Y[1])
	eagle_bad:draw(eagle_bad_X[3], eagle_bad_Y[3])
	eagle_bad:draw(eagle_bad_X[2], eagle_bad_Y[2])
	eagle_bad:draw(eagle_bad_X[4], eagle_bad_Y[4])
	eagle_bad:draw(eagle_bad_X[5], eagle_bad_Y[5])
	
	--detect collison with the bird and store the animation  
	if eagle_1 == 1 then
		explode_X_1 = eagle_good_X[1]
		explode_Y_1 = eagle_good_Y[1]	
		eagle_good_X[1] = love.math.random( 800, 1500 )
		eagle_good_Y[1] = love.math.random( 50, 470 )
		eagle_1=0
	end 
	if eagle_2 == 1 then
		eagle_good_X[2] = love.math.random( 800, 1500 )
		eagle_good_Y[2] = love.math.random( 50, 470 )
		eagle_2=0
	end
	if eagle_3 == 1 then
		eagle_good_X[3] = love.math.random( 800, 1500 )
		eagle_good_Y[3] = love.math.random( 50, 470 )	
		eagle_3=0
	end 
	if eagle_4 == 1 then
		eagle_good_X[4] = love.math.random( 800, 1500 )
		eagle_good_Y[4] = love.math.random( 50, 470 )
		eagle_4=0
	end 
	if eagle_5 == 1 then
		eagle_good_X[5] = love.math.random( 800, 1500 )
		eagle_good_Y[5] = love.math.random( 50, 470 )	
		eagle_5=0
	end 
	if eagle_6 == 1 then
		eagle_bad_X[1] = love.math.random( 800, 1500 )
		eagle_bad_Y[1] = love.math.random( 50, 470 )	
		eagle_6=0
	end 
	if eagle_7 == 1 then
		eagle_bad_X[2] = love.math.random( 800, 1500 )
		eagle_bad_Y[2] = love.math.random( 50, 470 )	
		eagle_7=0
	end 
	if eagle_8 == 1 then
		eagle_bad_X[3] = love.math.random( 800, 1500 )
		eagle_bad_Y[3] = love.math.random( 50, 470 )	
		eagle_8=0
	end 
	if eagle_9 == 1 then
		eagle_bad_X[4] = love.math.random( 800, 1500 )
		eagle_bad_Y[4] = love.math.random( 50, 470 )	
		eagle_9=0
	end 
	if eagle_10 == 1 then
		eagle_bad_X[5] = love.math.random( 800, 1500 )
		eagle_bad_Y[5] = love.math.random( 50, 470 )	
		eagle_10=0
	end

	if Game_over == 0 then
		--draw the charcter
		bird:draw(XBird, YBird) 
		love.audio.play(background)
	else 
		love.graphics.draw(game_over , game_x , game_y , 0 , 1,1)
		love.graphics.print( "SCORE: "..score, game_x+80, game_y+250, 0, 2, 2, 0, 0)
		love.graphics.draw(out , game_x+90 , game_y+300 , 0 , 1,1)
		love.graphics.draw(play_again , game_x+150 , game_y+300 , 0 , 1,1)
	end	
end

function love.update(dt) 
	if Game_over == 0 then
		--collistion 
		if collision(XBird,YBird,eagle_good_X[1],eagle_good_Y[1],bird,eagle_good) == 1 then
			love.audio.play(sky);
			eagle_1 = 1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end 
		end
		if collision(XBird,YBird,eagle_good_X[2],eagle_good_Y[2],bird,eagle_good) == 1 then
			love.audio.play(sky);
			eagle_2=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_good_X[3],eagle_good_Y[3],bird,eagle_good) == 1 then
			love.audio.play(sky);
			eagle_3=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_good_X[4],eagle_good_Y[4],bird,eagle_good) == 1 then
			love.audio.play(sky);
			eagle_4=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_good_X[5],eagle_good_Y[5],bird,eagle_good) == 1 then
			love.audio.play(sky);
			eagle_5=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
	
		--eagle bad 
		if collision(XBird,YBird,eagle_bad_X[1],eagle_bad_Y[1],bird,eagle_bad) == 1 then
			love.audio.play(sky);
			eagle_6=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_bad_X[2],eagle_bad_Y[2],bird,eagle_bad) == 1 then
			love.audio.play(sky);
			eagle_7=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_bad_X[3],eagle_bad_Y[3],bird,eagle_bad) == 1 then
			love.audio.play(sky);
			eagle_8=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_bad_X[4],eagle_bad_Y[4],bird,eagle_bad) == 1 then
			love.audio.play(sky);
			eagle_9=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		if collision(XBird,YBird,eagle_bad_X[5],eagle_bad_Y[5],bird,eagle_bad) == 1 then
			love.audio.play(sky);
			eagle_10=1
			score = score +1
			if gamespeed >= 6 then
				gamespeed =gamespeed
			else
				gamespeed = gamespeed + 0.1
			end
		end
		
		--update the character
		bird:update(dt)
		
		if flag_character ==0 then 
		YBird = YBird+gamespeed
	else
		YBird = YBird-gamespeed
	end
	
	if YBird <=10 then
		Game_over=1
		game_x=250
		game_y=150
	end
	if YBird >=450 then
		Game_over=1
		game_x=250
		game_y=150
	end
	
	-----------------
	-----------------
	--control the player   
	if love.keyboard.isDown( "left" ) or love.keyboard.isDown( "a" )  then
		if XBird <=-10 then
			XBird = XBird
		else
			XBird = XBird -2
		end else
	end
   
	if love.keyboard.isDown( "right" ) or love.keyboard.isDown( "d" ) then
		if XBird >=610 then
			XBird = XBird
		else
		XBird = XBird +2
		end 
	end
		
		
	end 
	
	psystem:update(dt)
	--update the background color every frame 
	if flag_r == 0 or flag_g == 0 or flag_b == 0 then
		r=r+0.5
		g=g+0.5
		b=b+0.5
	end 
	if flag_r == 1 or flag_g == 1 or flag_b == 1 then
		r=r-0.5
		g=g-0.5
		b=b-0.5
	end
	--end updating

	

	--update the cloude position 
	xCloude_1 = xCloude_1 + 32*dt
	if xCloude_1 >= 800+500 then 
		xCloude_1 = -800 
	end
	
	--update the cloude position 
	xCloude_2 = xCloude_2 + 32*dt
	if xCloude_2 >= 800+500 then 
		xCloude_2 = -800 
	end
	
	--update the cloude position 
	xCloude_3 = xCloude_3 + 32*dt
	if xCloude_3 >= 800+1000 then 
		xCloude_3 = -800 
	end
	
	--update the cloude position 
	xCloude_4 = xCloude_4 + 32*dt
	if xCloude_4 >= 800+500 then 
		xCloude_4 = -800 
	end
	
	--move the grass
	Xgrass_1 = Xgrass_1 - gamespeed
	if Xgrass_1 <= -800 then 
		Xgrass_1 =  800
	end

	--move the grass
	Xgrass_2 = Xgrass_2 - gamespeed
	if Xgrass_2 <= -800 then 
		Xgrass_2 =  800
	end
	
	--move the grass
	Xgrass_3 = Xgrass_3 - gamespeed
	if Xgrass_3 <= -800 then 
		Xgrass_3 =  800
	end
	
	
	--update the bird
	bird_1:update(dt)  
	
	
	--move & update the bird
	moving_bird = moving_bird + gamespeed
	if moving_bird >= 800 then 
		moving_bird =  0
	end
	
	eagle_good:update(dt)
	eagle_bad:update(dt)
	
	--control the enemy 
	--update the cloude position 
	eagle_good_X[1] = eagle_good_X[1] - gamespeed
	if eagle_good_X[1] <= -50 then 
		eagle_good_X[1] = love.math.random( 800, 1500 )
		eagle_good_Y[1] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_good_X[2] = eagle_good_X[2] - gamespeed
	if eagle_good_X[2] <= -50 then 
		eagle_good_X[2] = love.math.random( 800, 1500 )
		eagle_good_Y[2] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_good_X[3] = eagle_good_X[3] - gamespeed
	if eagle_good_X[3] <= -50 then 
		eagle_good_X[3] = love.math.random( 800, 1500 )
		eagle_good_Y[3] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_good_X[4] = eagle_good_X[4] - gamespeed
	if eagle_good_X[4] <= -50 then 
		eagle_good_X[4] = love.math.random( 800, 1500 )
		eagle_good_Y[4] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_good_X[5] = eagle_good_X[5] - gamespeed
	if eagle_good_X[5] <= -50 then 
		eagle_good_X[5] = love.math.random( 800, 1500 )
		eagle_good_Y[5] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_bad_X[1] = eagle_bad_X[1] - gamespeed
	if eagle_bad_X[1] <= -50 then 
		eagle_bad_X[1] = love.math.random( 800, 1500 )
		eagle_bad_Y[1] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_bad_X[2] = eagle_bad_X[2] - gamespeed
	if eagle_bad_X[2] <= -50 then 
		eagle_bad_X[2] = love.math.random( 800, 1500 )
		eagle_bad_Y[2] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_bad_X[3] = eagle_bad_X[3] - gamespeed
	if eagle_bad_X[3] <= -50 then 
		eagle_bad_X[3] = love.math.random( 800, 1500 )
		eagle_bad_Y[3] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_bad_X[4] = eagle_bad_X[4] - gamespeed
	if eagle_bad_X[4] <= -50 then 
		eagle_bad_X[4] = love.math.random( 800, 1500 )
		eagle_bad_Y[4] = love.math.random( 50, 470 )
	end
	--update the cloude position 
	eagle_bad_X[5] = eagle_bad_X[5] - gamespeed
	if eagle_bad_X[5] <= -50 then 
		eagle_bad_X[5] = love.math.random( 800, 1500 )
		eagle_bad_Y[5] = love.math.random( 50, 470 )
	end
	
end

function love.focus(bool)
		
end

function love.keypressed( key , unicode )
	if key == "escape" then
      love.event.quit()
   end
    
   if key == " " then
	if flag_character ==0 then 
		flag_character=1
	else
		flag_character=0
	end
	
   end
end

function love.keyreleased(key , unicode)

end

function love.mousepressed( x, y, button)
	if x>340 and x<390 and y>450 and y<500 and button=="l" then
		love.event.quit()
	end
	if x>400 and x<450 and y>450 and y<500 and button=="l" then 
		YBird = 300
		XBird = 50
		Game_over=0
		score=0
		game_x=-1000
		game_y=-1000
		gamespeed =3
	end
end

function love.mousereleased(x, y, button)
end

function love.quit()
end