local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local timer = 1000
local cloudtime1 = math.random(15000,20000)
local cloudtime2 = math.random(20000,40000)
local cloudtime3 = math.random(40000,50000)

local function gotogame()
	composer.removeScene("loading")
	composer.removeScene("level1")
	composer.gotoScene("level1", "fade", 200)
end

local function cloudMove()
	transition.moveTo(cloud1, {x = 1100, time = cloudtime1})
	transition.moveTo(cloud2, {x = 1100, time = cloudtime2})
	transition.moveTo(cloud3, {x = 1100, time = cloudtime3})
end
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )
 
	local sceneGroup = self.view

	local bg = display.newImage("bg.png")
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY
	bg.height = display.contentHeight + 20
	bg.width = display.contentWidth + 30

	local bak = display.newRect( display.contentCenterX, 800, display.contentWidth, 2345)
	bak.fill = {0,0,0, 0.4}

	local loadingBtn = display.newImage("loading.png")
	loadingBtn.x = display.contentCenterX
	loadingBtn.y = display.contentCenterY
	loadingBtn.width = 400
	loadingBtn.height = 80

	local cloud1 = display.newImage("cloud.png")
	cloud1.x = math.random(100, 900); cloud1.y = 250
	cloud1.width = 300 cloud1.height = 175

	local cloud2 = display.newImage("cloudblur1.png")
	cloud2.x = math.random(100, 900); cloud2.y = 600
	cloud2.width = 300 cloud2.height = 175

	local cloud3 = display.newImage("cloudblur2.png")
	cloud3.x = math.random(100, 900); cloud3.y = 900
	cloud3.width = 150 cloud3.height = 90

	sceneGroup:insert(bg)
	sceneGroup:insert(cloud1)
	sceneGroup:insert(cloud2)
	sceneGroup:insert(cloud3)
	sceneGroup:insert(bak)
	sceneGroup:insert(loadingBtn)

 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        physics.start()
        cloudMove()
        gotogame()
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
 