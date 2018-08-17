-----------------------------------------------------------------------------------------
--
-- level2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
physics.start()

physics.setGravity(0, 30)

--------------------------------------------


local popSound
score2 = 0
local back
local rect
local scorebrd
local board
local scoreText
local paint
local startX = math.random(100, 600)
local randomSize = math.random(50, 80)
local pipeTimer = 2000
local cloud1
local cloud2
local cloud3
local cloudtime1 = math.random(15000,20000)
local cloudtime2 = math.random(20000,40000)
local cloudtime3 = math.random(40000,50000)
local pipey = 1400
local pipex = display.contentWidth * 0.5;
local pipeWidth = 200
local sideSpace = (pipeWidth * 0.5) - 2
local pipeHeight = 400

local function follboard(event)
	board.x,board.y = event.x, event.y - 150
end

--Crate Respawn and Score2
local boing = 0.65
local spawnTime = 5000
local spawnTable = {}
local pipeTable = {}
local gameLoopTimer
local crates = 0
local pipes = 0

local function endGame()
	composer.setVariable("finalScore2", score2)
	composer.removeScene("gameover2")
	composer.removeScene("level2")
	composer.gotoScene("gameover2", "fromTop", 500)
end

local function cloudMove()
	transition.moveTo(cloud1, {x = 1100, time = cloudtime1})
	transition.moveTo(cloud2, {x = 1100, time = cloudtime2})
	transition.moveTo(cloud3, {x = 1100, time = cloudtime3})

	if (cloud1.x == 1100) then
		cloud1.x = -100
	end
end

local function addCrate()

    startX = math.random(display.contentWidth * 0.1, display.contentWidth * 0.9)
    --Crate
    local crate = display.newImage("crate.png", startX, -100)
    local randomSize = math.random(50,80)
    crate.width = randomSize
    crate.height = randomSize
    crate.type = "crate"
    physics.addBody( crate, "dynamic", {bounce = 0.75} )
    crate:applyTorque(-2,2)
    table.insert(spawnTable, crate)

    --Collision
    crate.collision = function(self, event)
        if (event.phase == "began" and event.other.type == "scorer") then
            display.remove(self)
            spawnTable[self] = nil
            score2 = score2 + 1
            scoreText.text = score2
            audio.play(popSound)
            table.remove(spawnTable, 1)
        end
        --Game Over
        if (event.phase == "began" and event.other.type == "border") then
            display.remove(self)
            spawnTable[self] = nil
            display.remove(board)
            timer.performWithDelay(300, physics.pause(), 0)
            composer.removeScene("level2")
            composer.gotoScene("gameover2", "fade", 500)
            timer.cancel(gameLoopTimer)

            for i = #spawnTable, 1, -1 do 
            	local thisCrate = spawnTable[i]

            	if (thisCrate.y < 1800) then
            		display.remove(thisCrate)
            		table.remove( spawnTable, i)
            	end
            end
        end
    end
    crate:addEventListener( "collision", crate)
end 

local function gameLoop()
	addCrate()
	timer.performWithDelay(pipeTimer, pipe:toFront(),0)
end

-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	local sceneGroup = self.view

	physics.pause()

	popSound = audio.loadSound("pop.mp3")

	scorebrd = display.newRect( display.contentCenterX, 40, display.contentWidth, 80)
	scorebrd.fill = {0,0,0, 0.2}

	back = display.newImage("bgN.png")
	back.x = display.contentCenterX
	back.y = display.contentCenterY
	back.width = 920
	back.height = 1640

	--board
	board = display.newImage("board.png")
	board.height = 25; board.width = 150;
	physics.addBody(board, "static",{density = 1, bounce = 0.5, friction = 1})



	scoreText = display.newText(score2, 40, 40, "BebasNeue Regular", 50)

	cloud1 = display.newImage("cloud.png")
	cloud1.x = math.random(100, 900); cloud1.y = 250
	cloud1.width = 300 cloud1.height = 175

	cloud2 = display.newImage("cloudblur1.png")
	cloud2.x = math.random(100, 900); cloud2.y = 600
	cloud2.width = 300 cloud2.height = 175

	cloud3 = display.newImage("cloudblur2.png")
	cloud3.x = math.random(100, 900); cloud3.y = 900
	cloud3.width = 150 cloud3.height = 90

	--borders of the pipe
	local side = display.newImage("button.png")
	side.height = pipeHeight; side.width = 3;
	side.x = pipex - sideSpace; side.y = pipey;
	physics.addBody(side, "static",{density = 1, friction = 1})

	local side1 = display.newImage("button.png")
	side1.height = pipeHeight; side1.width = 3;
	side1.x = pipex + sideSpace; side1.y = pipey;
	physics.addBody(side1, "static",{density = 1, friction = 1})

	--Game Borders
	local left = display.newImage("button.png")
	left.height = 2000; left.width = 10
	left.x = -80; left.y = 1000
	physics.addBody(left, "static",{density = 1, friction = 1})
	left.type = "border"

	local right = display.newImage("button.png")
	right.height = 2000; right.width = 10
	right.x = 980; right.y = 1000
	physics.addBody(right, "static",{density = 1, friction = 1})
	right.type = "border"

	local bottom = display.newImage("button.png")
	bottom.height = 10; bottom.width = 900
	bottom.x = display.contentCenterX; bottom.y = 1700
	physics.addBody(bottom, "static",{density = 1, friction = 1})
	bottom.type = "border"

	--Score2r and pipe
	local scorer = display.newImage("button.png")
	scorer.height = 10; scorer.width = 180
	scorer.x = pipex; scorer.y = 1650
	physics.addBody(scorer, "static",{friction = 100})
	scorer.type = "scorer"

	pipe = display.newImage("pipe.png")
	pipe.height = pipeHeight; pipe.width = pipeWidth;
	pipe.x = pipex; pipe.y = pipey;

	bak = display.newRect( display.contentCenterX, 800, display.contentWidth, 2345)
	bak.fill = {0,0,0, 0.2}

	sceneGroup:insert( back)
	sceneGroup:insert( cloud1)
	sceneGroup:insert( cloud2 )
	sceneGroup:insert( cloud3 )
	sceneGroup:insert( bak )
	sceneGroup:insert( scorebrd)
	sceneGroup:insert( board )
	sceneGroup:insert( scoreText )
	sceneGroup:insert(scorer)
	sceneGroup:insert(bottom)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(side1)
	sceneGroup:insert(side)
	sceneGroup:insert(pipe)

end


function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		cloudMove()
		back:addEventListener('touch', follboard)
		gameLoopTimer = timer.performWithDelay(spawnTime, gameLoop, 0)
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		crate:removeEventListener("collision",crate)
		Runtime:removeEventListener('touch',follboard)
		timer.cancel(gameLoopTimer)
		physics.pause()


		
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene