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
	audio.play(popSound)
	composer.removeScene("menu")
	composer.removeScene("loading")
	composer.gotoScene("loading", "fade" , 200)
	return true
end

local function gotoHT()
	audio.play(popSound)
	composer.removeScene("howTo")
	composer.removeScene("menu")
	composer.gotoScene("howTo", "fade", 200)
	return true
end

local function gotohighScores()
	audio.play(popSound)
	composer.removeScene("highScores")
	composer.removeScene("menu")
	composer.gotoScene("highScores", "fade", 200)
	return true
end

--local function gotoSettings()
	--audio.play(popSound)
	--composer.removeScene("settings")
	--composer.removeScene("menu")
	--composer.gotoScene("settings", "fade", 200)
	--return true
--end

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
	background.width = display.contentWidth + 20
	background.height = display.contentHeight + 20
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	title = display.newImage( "title.png")
	title.x = display.contentCenterX
	title.y = 400
	title.width = 800; title.height = 600

	brand = display.newImage( "Brand.png")
	brand.x = 100
	brand.y = display.contentHeight - 100
	brand.height = 150
	brand.width = 150

	bak = display.newRect( display.contentCenterX, 800, display.contentWidth, 2345)
	bak.fill = {0,0,0, 0.4}

	
	playBtn = widget.newButton{

		defaultFile = "playBtn.png",
		width=300, height=150,
		onRelease = gotoGame	-- event listener function
	}
	playBtn.x = display.contentCenterX
	playBtn.y = display.contentCenterY

	howToBtn = widget.newButton{

		defaultFile = "howtoBtn.png",
		width=100, height= 100,
		onRelease = gotoHT
	}

	howToBtn.x = display.contentCenterX
	howToBtn.y = display.contentCenterY + 500

	hiScoresBtn = widget.newButton{

		defaultFile = "HiScores.png",
		width=420, height=100,
		onRelease = gotohighScores
	}

	hiScoresBtn.x = display.contentCenterX
	hiScoresBtn.y = display.contentCenterY + 250

	--settingsBtn = widget.newButton{

		--defaultFile = "settings.png",
		--width=100, height= 100,
		--onRelease = gotoSettings
	--}

	--settingsBtn.x = display.contentWidth - 75
	--settingsBtn.y = 75

	cloud1 = display.newImage("cloud.png")
	cloud1.x = math.random(100, 900); cloud1.y = 250
	cloud1.width = 300 cloud1.height = 175

	cloud2 = display.newImage("cloudblur1.png")
	cloud2.x = math.random(100, 900); cloud2.y = 600
	cloud2.width = 300 cloud2.height = 175

	cloud3 = display.newImage("cloudblur2.png")
	cloud3.x = math.random(100, 900); cloud3.y = 900
	cloud3.width = 150 cloud3.height = 90
	
	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( cloud1 )
	sceneGroup:insert( cloud2 )
	sceneGroup:insert( cloud3 )
	sceneGroup:insert( bak )
	sceneGroup:insert( title )
	sceneGroup:insert( playBtn )
	sceneGroup:insert( howToBtn )
	sceneGroup:insert( hiScoresBtn)
	--sceneGroup:insert( settingsBtn)
	sceneGroup:insert( brand )
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
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene