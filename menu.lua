-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local physics = require "physics"

----Ads-------------------------------------
local appodeal = require( "plugin.appodeal" )

appodeal.show( "banner", { yAlign="bottom" } )

--------------------------------------------


physics.start()

--------------------------------------------

-- forward declarations and other locals
local playBtn
local howToBtn
local background
local title
local cloud1
local cloud2
local cloud3
local bak
local brand
local cloudtime1 = math.random(15000,20000)
local cloudtime2 = math.random(20000,40000)
local cloudtime3 = math.random(40000,50000)

local function gotoGame()
	appodeal.hide( "banner" )
	audio.play(popSound)
	composer.removeScene("menu")
	composer.removeScene("loading")
	composer.gotoScene("loading", "fade" , 100)

	return true
end

local function gotohighScores()
	appodeal.hide( "banner" )
	audio.play(popSound)
	composer.removeScene("highScores")
	composer.removeScene("menu")
	composer.gotoScene("highScores", "fade", 100)
	return true
end

local function onShopBtnRelease()
	appodeal.hide( "banner" )
	audio.play(popSound)
	composer.removeScene("crateShop")
	composer.removeScene("menu")
	composer.gotoScene("crateShop", "fade", 100)
	return true
end

local function onTutorialRelease()
	appodeal.hide( "banner" )
	audio.play(popSound)
	composer.removeScene("tutorial")
	composer.removeScene("menu")
	composer.gotoScene("tutorial", "fade", 100)
end

local function cloudMove()
	transition.moveTo(cloud1, {x = 2000, time = cloudtime1})
	transition.moveTo(cloud2, {x = 2000, time = cloudtime2})
	transition.moveTo(cloud3, {x = 2000, time = cloudtime3})
end

local function moveBack()
	if (cloud1.x == 1100) then
		transition.moveTo(cloud1, {x = 100, time = 0})
	end
end

function scene:create( event )
	local sceneGroup = self.view

	popSound = audio.loadSound("pop.mp3")

	background = display.newImage( "bg.png")
	background.width = display.actualContentWidth + 90
	background.height = display.actualContentHeight + 160
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	title = display.newImage( "texts/title.png")
	title.x = display.contentCenterX
	title.y = display.actualContentHeight * 0.2
	title.width = 800; title.height = 600

	brand = display.newImage( "header.png")
	brand.x = display.contentWidth * 0.9
	brand.y = display.actualContentHeight * 0.95
	brand.height = 100
	brand.width = 100
	brand.alpha = 0.3

	bak = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth + 500, 2341)
	bak.fill = {0,0,0, 0.4}

	playBtn = widget.newButton{

		defaultFile = "texts/playBtn.png",
		overFile = "texts/playBtnOver.png",
		width=300, height=150,
		onRelease = gotoGame	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.actualContentHeight * 0.45

	hiScoresBtn = widget.newButton{

		defaultFile = "texts/HiScores.png",
		overFile = "texts/HiScoresOver.png",
		width=500, height=120,
		onRelease = gotohighScores
	}

	hiScoresBtn.x = display.contentCenterX
	hiScoresBtn.y = display.actualContentHeight * 0.55

	local shopBtn = widget.newButton{
		defaultFile = "texts/shopBtn.png",
		overFile = "texts/shopBtnOver.png",
        width = 240, height = 100,
        onRelease = onShopBtnRelease
	}

	shopBtn.x = display.contentCenterX
	shopBtn.y = display.actualContentHeight * 0.65

	local tutBtn = widget.newButton{
		defaultFile = "texts/howtoBtn.png",
		overFile = "texts/howtoBtnOver.png",
		width = 100, height = 100,
		onRelease = onTutorialRelease
	}

	tutBtn.x = display.contentCenterX
	tutBtn.y = display.actualContentHeight * 0.75

	cloud1 = display.newImage("gameassets/cloud.png")
	cloud1.x = math.random(100, 900); cloud1.y = 250
	cloud1.width = 300 cloud1.height = 175

	cloud2 = display.newImage("gameassets/cloudblur1.png")
	cloud2.x = math.random(100, 900); cloud2.y = 600
	cloud2.width = 300 cloud2.height = 175

	cloud3 = display.newImage("gameassets/cloudblur2.png")
	cloud3.x = math.random(100, 900); cloud3.y = 900
	cloud3.width = 150 cloud3.height = 90

	made = display.newText("Made by Gigabro", display.contentCenterX, display.actualContentHeight * 0.95, "bnmachine", 50)
	made.alpha = 0.4

	
	sceneGroup:insert( background )
	sceneGroup:insert( cloud1 )
	sceneGroup:insert( cloud2 )
	sceneGroup:insert( cloud3 )
	sceneGroup:insert( bak )
	sceneGroup:insert( title )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( hiScoresBtn)
	sceneGroup:insert( brand )
	sceneGroup:insert( shopBtn )
	sceneGroup:insert( tutBtn )
	sceneGroup:insert( made )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
		physics.start()
		cloudMove()
		
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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end

	if howToBtn then
		howToBtn:removeSelf()
		howToBtn = nil
	end

	if settingsBtn then
		settingsBtn:removeSelf()	
		settingsBtn = nil
	end

	if shopBtn then
		shopBtn:removeSelf()
		shopBtn = nil
	end

	if tutBtn then
		tutBtn:removeScene()
		tutBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene