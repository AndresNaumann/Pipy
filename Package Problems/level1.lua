-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "physics" library
local physics = require "physics"
local startapp = require( "plugin.startapp" )

-- Initialize the StartApp plugin
startapp.init( adListener, { appId="204663446", enableReturnAds = true } )

-- Show banner ad. no need to pre-load banner
startapp.show( "banner" , {
adTag = "menu bottom banner",
yAlign = "bottom",
bannerType = "standard"
} )

physics.start()

physics.setGravity(0, 30)

--------------------------------------------


local popSound
score = 0
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
local sideSpace = (pipeWidth * 0.5)-5
local pipeHeight = 400
local sideWidth = 10
local cloudY = math.random(400, 1200)

local function follboard(event)
	board.x,board.y = event.x, event.y - 150
end

--Crate Respawn and Score
local boing = 0.65
local spawnTime = 5000
local spawnTable = {}
local gameLoopTimer
local crates = 0
local pipes = 0

local function endGame()
	composer.setVariable("finalScore", score)
	composer.removeScene("gameover")
	composer.removeScene("level1")
	composer.gotoScene("gameover", "fade", 300)
end

local function cloudMove()
	transition.moveTo(cloud1, {x = 1100, time = cloudtime1})
	transition.moveTo(cloud2, {x = 1100, time = cloudtime2})
	transition.moveTo(cloud3, {x = 1100, time = cloudtime3})

	if (cloud1.x == 1100) then
		cloud1.x = -100
	end
end

local cloudTable = {}

local function spawnCloud()
	local cloudR = math.random(1,3)
	if cloudR == 1 then
		cloudR1 = display.newImage("cloud.png")
		cloudR1.x = -200
		cloudR1.y = math.random(200,300)
		cloudR1.width = 300
		cloudR1.height = 175
		transition.moveTo(cloudR1, {x = 1100, time = cloudtime1})
		cloudR1.type = "cloud"
		table.insert(cloudTable, cloudR1)
	elseif cloudR == 2 then
		cloudR2 = display.newImage("cloudblur1.png")
		cloudR2.x = -200
		cloudR2.y = math.random(550,650)
		cloudR2.width = 300
		cloudR2.height = 175
		transition.moveTo(cloudR2, {x = 1100, time = cloudtime2})
		cloudR2.type = "cloud"
		table.insert(cloudTable, cloudR2)
	elseif cloudR == 3 then
		cloudR3 = display.newImage("cloudblur2.png")
		cloudR3.x = -200
		cloudR3.y = math.random(850,950)
		cloudR3.width = 150
		cloudR3.height = 90
		transition.moveTo(cloudR3, {x = 1100, time = cloudtime3})
		cloudR3.type = "cloud"
		table.insert(cloudTable, cloudR3)
	end
end

birdTable = {}
birdSpeed = 1000

local function spawnBird()
	local birdR = math.random(1,2)
	if birdR == 1 then
		bird1 = display.newImage("bird.png")
		bird1.x = -200
		bird1.y = math.random(100, 600)
		bird1.width = 50
		bird1.length = 10
		transition.moveTo(bird1, {x = 1100, time = birdSpeed})
		bird1.type = "bird"
		table.insert(birdTable, bird1)
	elseif birdR == 2 then
		bird2 = display.newImage("bird.png")
		bird2.xScale = -1
		bird2.x = 1100
		bird2.y = math.random(100, 600)
		bird2.width = 50
		bird2.length = 10
		transition.moveTo(bird2, {x = -200, time = birdSpeed})
		bird2.type = "bird"
		table.insert(birdTable, bird2)
	end
end

--[[
local pipey = 1400
local pipex = display.contentWidth * 0.5;
local pipeWidth = 200
local sideSpace = (pipeWidth * 0.5)-5
local pipeHeight = 400
local sideWidth = 10
--]]

local pipeTable = {}

local function spawnPipe()
	newPipe = display.newImage("pipe.png")
	newPipe.x = display.contentCenterX
	newPipe.y = 1400
	newPipe.width = 200
	newPipe.height = 400
	table.insert(pipeTable, newPipe)
end

--restart aqui

local function addCrate()

    startX = math.random(display.contentWidth * 0.1, display.contentWidth * 0.9)
    --Crate
    local crate = display.newImage("crate.png", startX, -200)
    local randomSize = math.random(50,80)
    crate.width = randomSize
    crate.height = randomSize
    crate.type = "crate"
    physics.addBody( crate, "dynamic", {bounce = 0.75} )
    crate:applyTorque(-2,2)
    table.insert(spawnTable, crate)

	crate.collision = function(self, event)
	    if (event.phase == "began" and event.other.type == "scorer") then
	        display.remove(self)
	        spawnTable[self] = nil
	        score = score + 1
	        scoreText.text = score
	        audio.play(popSound)
	        table.remove(spawnTable, 1)
	        startX = math.random(display.contentWidth * 0.1, display.contentWidth * 0.9)
	    end
	    --Game Over
	    if (event.phase == "began" and event.other.type == "border") then
	        display.remove(self)
	        spawnTable[self] = nil
	        display.remove(board)
	        timer.performWithDelay(300, physics.pause(), 0)
	        composer.removeScene("level1")
	        endGame()
	        timer.cancel(gameLoopTimer)
	        timer.cancel(cloudLoopTimer)
	        audio.pause(gamemusic)
	        audio.play(gosound)

	        for i = #spawnTable, 1, -1 do 
	        	local thisCrate = spawnTable[i]

	        	if (thisCrate.y < 1800) then
	        		display.remove(thisCrate)
	        		table.remove( spawnTable, i)
	        	end
	        end

	        for j = #cloudTable, 1, -1 do
	        	local thisCloud = cloudTable[j]

	        	if (thisCloud.y < 1800) then
	        		display.remove(thisCloud)
	        		table.remove(cloudTable, j)
	        	end
	        end

	        for l = #birdTable, 1, -1 do 
	        	local thisBird = birdTable[l]

	        	if (thisBird.y < 1800) then
	        		display.remove(thisBird)
	        		table.remove(birdTable, l)
	        	end
	        end

	        for b = #pipeTable, 1, -1 do
	        	local thisPipe = pipeTable[b]

	        	if (thisPipe.y < 2200) then
	        		display.remove(thisPipe)
	        		table.remove(pipeTable, b)
	        	end
	        end
	    end
	end
	crate:addEventListener( "collision", crate)
end


local function timeDecrease()
	if score > 10 then
		spawnTime = 4000
		return spawnTime
	elseif score > 20 then
		spawnTime = 3000
		return spawnTime
	elseif score > 30 then
		spawnTime = 2000
		return spawnTime
	end
end

local function gameLoop()
	timeDecrease()
	addCrate()
	spawnPipe()
end

local function cloudLoop()
	spawnCloud()
	spawnBird()
end
-- forward declarations and other locals
local screenW, screenH, halfW = display.actualContentWidth, display.actualContentHeight, display.contentCenterX

function scene:create( event )

	local sceneGroup = self.view

	physics.pause()

	gamemusic = audio.loadSound("gamemusic.mp3")
	gosound = audio.loadSound("go.wav")
	popSound = audio.loadSound("pop.mp3")

	audio.play(gamemusic)

	scorebrd = display.newRect( display.contentCenterX, 40, display.contentWidth, 80)
	scorebrd.fill = {0,0,0, 0.2}

	back = display.newImage("bg.png")
	back.x = display.contentCenterX
	back.y = display.contentCenterY
	back.width = display.contentWidth + 20
	back.height = display.contentHeight + 30

	--board
	board = display.newImage("board.png")
	board.height = 25; board.width = 150;
	physics.addBody(board, "static",{density = 1, bounce = 0.6, friction = 1})

	scoreText = display.newText(score, 40, 40, "BebasNeue Regular", 50)

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
	side.height = pipeHeight; side.width = sideWidth;
	side.x = pipex - sideSpace; side.y = pipey;
	physics.addBody(side, "static",{density = 1, friction = 1})

	local side1 = display.newImage("button.png")
	side1.height = pipeHeight; side1.width = sideWidth;
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
	right.x = display.contentWidth + 80; right.y = display.contentCenterY
	physics.addBody(right, "static",{density = 1, friction = 1})
	right.type = "border"

	local bottom = display.newImage("button.png")
	bottom.height = 10; bottom.width = 900
	bottom.x = display.contentCenterX; bottom.y = 1700
	physics.addBody(bottom, "static",{density = 1, friction = 1})
	bottom.type = "border"

	--Scorer and pipe
	local scorer = display.newImage("button.png")
	scorer.height = 10; scorer.width = 180
	scorer.x = pipex; scorer.y = 1650
	physics.addBody(scorer, "static",{friction = 100})
	scorer.type = "scorer"

	pipe = display.newImage("pipe.png")
	pipe.height = pipeHeight; pipe.width = pipeWidth;
	pipe.x = pipex; pipe.y = pipey;

	sceneGroup:insert( back)
	sceneGroup:insert( cloud1)
	sceneGroup:insert( cloud2 )
	sceneGroup:insert( cloud3 )
	sceneGroup:insert( scorebrd)
	sceneGroup:insert( scoreText )
	sceneGroup:insert(scorer)
	sceneGroup:insert(bottom)
	sceneGroup:insert(right)
	sceneGroup:insert(left)
	sceneGroup:insert(side1)
	sceneGroup:insert(side)
	sceneGroup:insert(pipe)
	sceneGroup:insert( board )

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
		cloudLoopTimer = timer.performWithDelay(12000, cloudLoop, 0)
		firstOne = timer.performWithDelay(1000, addCrate, 1)
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
		timer.cancel(cloudLoopTimer)
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