-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()
local json = require( "json" )
local widget = require "widget"

-- include Corona's "physics" library
local physics = require "physics"

system.activate( "multitouch" )

----Ads-------------------------------------

--------------------------------------------

physics.start()

physics.setGravity(0.1, 30)

--------------------------------------------

local popSound
score = 0
local lives = 3
local back
local rect
local scorebrd
local board
local scoreText
local paint
local randomSize = math.random(50, 80)
local pipeTimer = 2000
local cloud1
local cloud2
local cloud3
local cloudtime1 = math.random(15000,20000)
local cloudtime2 = math.random(20000,40000)
local cloudtime3 = math.random(40000,50000)
local pipey = 1400
local pipex = display.contentWidth * 0.5
local pipeWidth = display.contentWidth * 0.222
local sideSpace = (pipeWidth * 0.5)-5
local pipeHeight = display.actualContentHeight * 0.25
local sideWidth = 10
local cloudY = math.random(400, 1200)

physics.setDrawMode( "normal" )

local function follboard(event)
	boardEnd1.x, boardEnd1.y = event.x - 90, event.y - 150
	boardEnd2.x, boardEnd2.y = event.x + 90, event.y - 150
	board.x,board.y = event.x, event.y - 150
end

cheesy = display.newGroup()

local function tuText()

	cheese = display.newText("Now for real!", display.contentCenterX, display.actualContentHeight * 0.4, "bnmachine", 100)
	cheese1 = display.newText("Now for real!", display.contentCenterX, display.actualContentHeight * 0.404, "bnmachine", 100)
	cheese1.fill = {0,0,0,1}

	cheesy:insert(cheese1)
	cheesy:insert(cheese)

	function moveCheese()
		transition.to(cheese, {y = display.actualContentHeight * -0.2, alpha = 0, time = 2000})
		transition.to(cheese1, {y = display.actualContentHeight * -0.2, alpha = 0, time = 2000})
	end

	goof = timer.performWithDelay(1000, moveCheese, 1)
end

if tutorialDone == false then
	tuText()
end


--Crate Respawn and Score
local boing = 0.65
local crates = 0
local pipes = 0

function onmenuBtnrelease()
	--appodeal.hide( "banner" )
	audio.play(popSound)
	spawnTime = 5000

	display.remove(boards)
	display.remove(clouds)

	composer.removeScene("menu")
	composer.removeScene("level1")
	composer.gotoScene("menu", "fade", 100 )
	return true

end

pause = display.newGroup()

function onPauseBtnRelease()
	screenCap = display.newImage("bg.png")
	screenCap.x = display.contentCenterX
	screenCap.y = display.contentCenterY
	screenCap.width = display.actualContentWidth * 1.1
	screenCap.height = display.actualContentHeight * 1.1
	screenCap.alpha = 0
	screenCap.fill.effect = "filter.blurGaussian"

	screenCap.fill.effect.horizontal.blurSize = 150
	screenCap.fill.effect.horizontal.sigma = 20
	screenCap.fill.effect.vertical.blurSize = 150
	screenCap.fill.effect.vertical.sigma = 20

	pause:insert(screenCap)

	transition.to(screenCap, {alpha = 1, time = 500})

	blaqqer = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth * 1.2, display.actualContentHeight * 1.2)
	blaqqer.fill = {0,0,0}
	blaqqer.alpha = 0

	transition.to(blaqqer, {alpha = 0.4, time = 500})
	
	timer.cancel(crateTimer)
	if isSoundOn == true then
		audio.setVolume(0.5)
	end
	audio.play(popsound)
	physics.pause()

	resumeBtn = widget.newButton{
		defaultFile = "texts/resumeBtn.png",
		height = 150, width = 150,
		onRelease = onResume
	}


	menbtn = widget.newButton{
		defaultFile = "texts/menuBtn.png",
		overFile = "texts/menuBtnOver.png",
		width=250, height=75,
		onRelease = onmenuBtnrelease
	}

	menbtn.x = display.actualContentWidth * 0.76
    menbtn.y = display.actualContentHeight * 0.06

	soundTxt = display.newImage("texts/sound.png")
	soundTxt.x = display.contentCenterX
	soundTxt.y = display.contentCenterY * 0.7
	soundTxt.alpha = 0

	transition.to(soundTxt, {alpha = 1, time = 500})

	local function soundOn()
		audio.setVolume( 1 )
		offBtn.alpha = 0.6
		onBtn.alpha = 1
		isSoundOn = true
		audio.play(popSound)
	end

	local function soundOff()
		audio.setVolume( 0 )
		onBtn.alpha = 0.6
		offBtn.alpha = 1
		isSoundOn = false
	end

	onBtn = widget.newButton{
		defaultFile = "texts/onBtn.png",
		height = 150, width = 150,
		onRelease = soundOn
	}

	onBtn.x = display.contentCenterX * 0.65
	onBtn.y = display.contentCenterY * 1.05
	onBtn.alpha = 0


	offBtn = widget.newButton{
		defaultFile = "texts/offBtn.png",
		height = 150, width = 200,
		onRelease = soundOff
	}

	offBtn.x = display.contentCenterX * 1.35
	offBtn.y = display.contentCenterY * 1.05
	offBtn.alpha = 0

	if isSoundOn == true then
		transition.to(onBtn, {alpha = 1, time = 500})
		transition.to(offBtn, {alpha = 0.6, time = 500})
	end

	if isSoundOn == false then
		transition.to(onBtn, {alpha = 0.6, time = 500})
		transition.to(offBtn, {alpha = 1, time = 500})
	end

	resumeBtn.x = display.contentCenterX
	resumeBtn.y = display.actualContentHeight * 0.175
	resumeBtn.alpha = 0

	transition.to(resumeBtn, {alpha = 1, time = 500})

	
end

function onResume()
	physics.start()

	if isSoundOn == true then
		audio.setVolume(1)
	end

	crateTimer = timer.performWithDelay(spawnTime, addCrate, 0)
	resumeBtn:removeSelf()
	resumeBtn = nil
	screenCap:removeSelf()
	soundTxt:removeSelf()
	onBtn:removeSelf()
	offBtn:removeSelf()
	blaqqer:removeSelf()
end

local function endGame()
	--appodeal.hide( "banner" )
	spawnTime = 5000
	display.remove(boards)
	display.remove(clouds)
	composer.setVariable("finalScore", score)


	loadScores()
     
    -- Insert the saved score from the last game into the table, then reset it
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    function compare( a, b )
        return a > b
    end
    table.sort( scoresTable, compare )

	saveScores()

	composer.removeScene("gameover")
	composer.removeScene("level1")
	composer.gotoScene("gameover", "fade", 200)
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
local clouds = display.newGroup()

local function spawnCloud()
	local cloudR = math.random(1,3)
	local destinationC = display.actualContentWidth * 1.5
	if cloudR == 1 then
		cloudR1 = display.newImage("gameassets/cloud.png")
		cloudR1.x = -200
		cloudR1.y = math.random(200,300)
		cloudR1.width = 300
		cloudR1.height = 175
		cloudR1.alpha = 0.7
		transition.moveTo(cloudR1, {x = destinationC, time = cloudtime1})
		cloudR1.type = "cloud"
		table.insert(cloudTable, cloudR1)
		clouds:insert(cloudR1)
	elseif cloudR == 2 then
		cloudR2 = display.newImage("gameassets/cloudblur1.png")
		cloudR2.x = -200
		cloudR2.y = math.random(550,650)
		cloudR2.width = 300
		cloudR2.height = 175
		cloudR2.alpha = 0.7
		transition.moveTo(cloudR2, {x = destinationC, time = cloudtime2})
		cloudR2.type = "cloud"
		table.insert(cloudTable, cloudR2)
		clouds:insert(cloudR2)
	elseif cloudR == 3 then
		cloudR3 = display.newImage("gameassets/cloudblur2.png")
		cloudR3.x = -200
		cloudR3.y = math.random(850,950)
		cloudR3.width = 150
		cloudR3.height = 90
		cloudR3.alpha = 0.7
		transition.moveTo(cloudR3, {x = destinationC, time = cloudtime3})
		cloudR3.type = "cloud"
		table.insert(cloudTable, cloudR3)
		clouds:insert(cloudR3)
	end
end

cloudLoopTimer = timer.performWithDelay(12000, cloudLoop, 0)

birdTable = {}
birdSpeed = 1000

local function spawnBird()
	local birdR = math.random(1,2)
	local destination = display.actualContentWidth * 1.5
	local ndestination = display.actualContentWidth * -0.1
	if birdR == 1 then
		bird1 = display.newImage("gameassets/birdright.png")
		bird1.x = -200
		bird1.y = math.random(100, 600)
		bird1.width = 34
		bird1.height = 22
		transition.moveTo(bird1, {x = destination, time = birdSpeed})
		bird1.type = "bird"
		table.insert(birdTable, bird1)
	elseif birdR == 2 then
		bird2 = display.newImage("gameassets/birdleft.png")
		bird2.xScale = -1
		bird2.x = 1100
		bird2.y = math.random(100, 600)
		bird2.width = 34
		bird2.height = 22
		transition.moveTo(bird2, {x = ndestination, time = birdSpeed})
		bird2.type = "bird"
		table.insert(birdTable, bird2)
	end
end

local pipey = display.actualContentHeight * 0.9
local pipex = display.contentWidth * 0.5;
local pipeWidth = 200
local sideSpace = (pipeWidth * 0.5)-5
local pipeHeight = 400
local sideWidth = 10

--restart aqui

local spawnTable = {}

--Display Groups

local crates = display.newGroup()

local borders = display.newGroup()

--Game Borders

local left = display.newImage("button.png")
left.height = display.actualContentHeight + 1000; left.width = 10
left.x = display.actualContentWidth * -0.1 ; left.y = display.contentCenterY
physics.addBody(left, "static",{density = 1, friction = 1})
left.type = "border"
left.fill = {0,0,0, 0}

local right = display.newImage("button.png")
right.height = display.actualContentHeight + 1000; right.width = 10
right.x = display.actualContentWidth * 1.1; right.y = display.contentCenterY
physics.addBody(right, "static",{density = 1, friction = 1})
right.type = "border"
right.fill = {0,0,0, 0}


local bottom = display.newImage("button.png")
bottom.height = 10
bottom.width = display.actualContentWidth * 1.9
bottom.x = display.contentCenterX
bottom.y = display.actualContentHeight * 1.3
physics.addBody(bottom, "static")
bottom.type = "border"


--Scorer and pipe
local scorer = display.newImage("button.png")
scorer.height = 10; scorer.width = 200
scorer.x = pipex; scorer.y = display.actualContentHeight * 0.9
physics.addBody(scorer, "static",{bounce = 1})
scorer.type = "scorer"

local pipe = display.newImage("gameassets/pipe.png")
pipe.height = pipeHeight; pipe.width = pipeWidth;
pipe.x = pipex; pipe.y = pipey;

boards = display.newGroup()

--board
board = display.newImage("gameassets/board.png")
board.x = display.contentCenterX; board.y = display.contentCenterY
board.height = 35; board.width = 200;
boardShape = {-100,-17, 100,-17, 100, 30, -100, 30 }
physics.addBody(board, "static",{density = 1, bounce = 0.6, friction = 1, shape = boardShape})

boardEnd1 = display.newImage("gameassets/boardEnd.png")
boardEnd1.x = display.contentCenterX - 90; boardEnd1.y = display.contentCenterY
boardEnd1.height = 25; boardEnd1.width = 25
physics.addBody(boardEnd1, "static", {density = 1, bounce = 0.6, friction = 1, radius = 15})
boardEnd1.alpha = 0

boardEnd2 = display.newImage("gameassets/boardEnd.png")
boardEnd2.x = display.contentCenterX + 90; boardEnd2.y = display.contentCenterY
boardEnd2.height = 25; boardEnd2.width = 25
boardEnd2.xScale = -1
physics.addBody(boardEnd2, "static", {density = 1, bounce = 0.6, friction = 1, radius = 15})
boardEnd2.alpha = 0

borders:insert(left)
borders:insert(right)
borders:insert(bottom)
borders:insert(scorer)
boards:insert(board)
boards:insert(boardEnd1)
boards:insert(boardEnd2)
borders:insert(pipe)

brick = {}

for brickCounter = 0,8 do
	brick[brickCounter] = display.newImage(boards, "gameassets/sideBrick.png")
	brick[brickCounter].x = display.actualContentWidth * -0.1
	brick[brickCounter].y = (brickCounter * 295)
	brick[brickCounter].height = 300
	brick[brickCounter].width = 130
	brick[brickCounter].type = "wall"
	brick[brickCounter].id = "id"
	physics.addBody(brick[brickCounter], "static")
	local function slide()
		transition.to(brick[brickCounter], {time = 120 * brickCounter, x = display.actualContentWidth * -0.04})
	end
	slide1 = timer.performWithDelay(800, slide)
end


brick2 = {}

for j = 0,8 do
	brick2[j] = display.newImage(boards, "gameassets/sideBrick2.png")
	brick2[j].x = display.contentWidth * 1.1
	brick2[j].y = (j * -295) + display.actualContentHeight
	brick2[j].height = 300
	brick2[j].width = 130
	brick2[j].type = "wall1"
	brick2[j].id = "0"
	physics.addBody(brick2[j], "static")
	local function slide()
		transition.to(brick2[j], {time = 120 * j, x = display.contentWidth * 1.04})
	end
	slide2 = timer.performWithDelay(1200, slide)

end

borders.alpha = 0.0;
boards.alpha = 0.0;
transition.to(boards, {time = 400, delay = 300, alpha = 1.0})
transition.to(borders, {time = 400, delay = 300, alpha = 1.0})

crate = {}
cCounter = 1

function addCrate()
	local startX = math.random(100, 800)
	backSpace = 200
	crate = display.newImage(gameCrate)
	crate.x = startX
	crate.y = -200
	crate.height = 80
	crate.width = 80
	crate.type = "crate"
	crates:insert(crate)
	physics.addBody( crate, "dynamic", {bounce = 0.75})
	crate:applyTorque(-2,2)
	cCounter = cCounter + 1
	crate.collision = function(self, event)
		if (event.phase == "began" and event.other.type == "wall") then
			transition.to(event.other, {x = event.other.x - backSpace, time = 400})
		end

		if (event.phase == "began" and event.other.type == "wall1") then
			transition.to(event.other, {x = event.other.x + backSpace, time = 400})
		end
	end
	crate:addEventListener("collision", crate)
end

local function onCollision(event)
	if (event.phase == "began") then
		if (event.target.type == "scorer" and event.other.type == "crate") then
			score = score + 1
			totalScore = totalScore + 1

			totalScoreTable[1] = totalScoreTable[1] + 1
			totalScore = totalScoreTable[1]

			saveTotalScores()

			scoreTextR.text = score
			scoreText.text = score
			audio.play(popSound)
			event.other:removeSelf()

			return true

		end
	end


	if (event.phase == "began") then
		if (event.target.type == "border" and event.other.type == "crate") then

			lives = lives - 1

			audio.play(loselife)

			livest.text = lives
			livest1.text = lives

			event.other:removeSelf()

			local function endit()
			
				display.remove(borders)
				display.remove(board)
				timer.performWithDelay(300, physics.pause(), 0)
				composer.removeScene("level1")

				endGame()
				timer.cancel(crateTimer)
				timer.cancel(updateTimer)
				timer.cancel(cloudLoopTimer)
				audio.pause(gamemusic)
				audio.play(gosound)

				display.remove(crates)

				crates = nil

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
				
				return true
			end

			if (lives == 0) then
				endit()
			end

		end

	end
end

left:addEventListener("collision", onCollision)
right:addEventListener("collision", onCollision)
bottom:addEventListener("collision", onCollision)
scorer:addEventListener("collision", onCollision)

firstOne = timer.performWithDelay(1000, addCrate, 1)

local update = function()
	if (score >= 5) then
		spawnTime = 4250
		crateTimer._delay = spawnTime
	end
	if (score >= 10) then
		spawnTime = 3600
		crateTimer._delay = spawnTime
	end
	if (score >= 15) then
		spawnTime = 3000
		crateTimer._delay = spawnTime
	end
	if (score >= 20 ) then
		spawnTime = 2550
		crateTimer._delay = spawnTime
	end
	if (score >= 25 ) then
		spawnTime = 2167
		crateTimer._delay = spawnTime
	end
end

crateTimer = timer.performWithDelay(spawnTime, addCrate, 0)
updateTimer = timer.performWithDelay(50, update, 0)

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
	gosound = audio.loadSound("go.mp3")
	popSound = audio.loadSound("pop.mp3")
	loselife = audio.loadSound("loselife.mp3")

	audio.play(gamemusic)

	back = display.newImage("bg.png")
	back.x = display.contentCenterX
	back.y = display.contentCenterY
	back.width = display.actualContentWidth * 1.1
	back.height = display.actualContentHeight * 1.1

	scoreText = display.newText(score, display.contentCenterX, display.actualContentHeight * 0.12, "bnmachine", 100)
	scoreTextR = display.newText( score, display.contentCenterX, display.actualContentHeight * 0.124, "bnmachine",100)
	scoreTextR.fill = {0,0,0}

	cloud1 = display.newImage("gameassets/cloud.png")
	cloud1.x = math.random(100, 900); cloud1.y = 250
	cloud1.width = 300 cloud1.height = 175
	cloud1.alpha = 0.7

	cloud2 = display.newImage("gameassets/cloudblur1.png")
	cloud2.x = math.random(100, 900); cloud2.y = display.actualContentHeight * 0.375
	cloud2.width = 300 cloud2.height = 175
	cloud2.alpha = 0.7

	cloud3 = display.newImage("gameassets/cloudblur2.png")
	cloud3.x = math.random(100, 900); cloud3.y = display.actualContentHeight * 0.5625
	cloud3.width = 150 cloud3.height = 90
	cloud3.alpha = 0.7

	--borders of the pipe
	side = display.newImage("button.png")
	side.height = pipeHeight; side.width = sideWidth;
	side.x = pipex - sideSpace; side.y = pipey;
	physics.addBody(side, "static",{density = 1, friction = 1})
	side.alpha = 0

	side1 = display.newImage("button.png")
	side1.height = pipeHeight; side1.width = sideWidth;
	side1.x = pipex + sideSpace; side1.y = pipey;
	physics.addBody(side1, "static",{density = 1, friction = 1})
	side1.alpha = 0

	pauseBtn = widget.newButton{
		defaultFile = "texts/pauseBtn.png",
		height = 75, width = 75,
		onRelease = onPauseBtnRelease
	}

	pauseBtn.x = display.actualContentWidth * 0.86
	pauseBtn.y = display.actualContentHeight * 0.12

	livesText = display.newText("Lives: ", display.actualContentWidth * 0.2, display.actualContentHeight * 0.12, "bnmachine", 75)
	livesText1 = display.newText("Lives: ", display.actualContentWidth * 0.2, display.actualContentHeight * 0.124, "bnmachine", 75)
	livesText1.fill = {0,0,0}

	livest = display.newText(lives, display.actualContentWidth * 0.35, display.actualContentHeight * 0.12, "bnmachine", 75)
	livest1 = display.newText(lives, display.actualContentWidth * 0.35, display.actualContentHeight * 0.124, "bnmachine", 75)
	livest1.fill = {0,0,0}

	sceneGroup:insert( back )
	sceneGroup:insert( cloud1 )
	sceneGroup:insert( cloud2 )
	sceneGroup:insert( cloud3 )
	sceneGroup:insert( scoreTextR )
	sceneGroup:insert( scoreText )
	sceneGroup:insert( side1 )
	sceneGroup:insert( side )
	sceneGroup:insert( pauseBtn )
	sceneGroup:insert( livesText1 )
	sceneGroup:insert( livesText )
	sceneGroup:insert( livest1 )
	sceneGroup:insert( livest )

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
		cloudLoopTimer = timer.performWithDelay(12000, cloudLoop, 0)
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
		crate:removeEventListener("collision", crate)
		timer.cancel(gameLoopTimer)
		timer.cancel(cloudLoopTimer)
		physics.removeBody(brick[brickCounter])
		physics.removeBody(brick2[j])
		physics.hide()

	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )

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