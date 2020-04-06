--Settings

local composer = require( "composer" )
 
local scene = composer.newScene()
 
local widget = require "widget"

local bg
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
local function onmenuBtnrelease()
	audio.play(popSound)
    composer.removeScene("menu")
    composer.removeScene("howTo")
    composer.gotoScene("menu", "fade", 200 )
end

local function onsoundOnrelease()
	audio.play(popSound)
	audio.setVolume( 1, { channel=1 } )
end

local function onsoundOffrelease()
	audio.stop()
end


-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    popSound = audio.loadSound("pop.mp3")
 
 	bg = display.newImage("bg.png")
 	bg.width = display.contentWidth + 20
	bg.height = display.actualContentHeight + 20
	bg.x = display.contentCenterX
	bg.y = display.contentCenterY

	bak = display.newRect( display.contentCenterX, 800, display.contentWidth, 2345)
	bak.fill = {0,0,0, 0.4}

 	menuBtn = widget.newButton{

        defaultFile = "menuBtn.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = display.contentWidth - 135
    menuBtn.y = 50

    soundOn = widget.newButton{

    	defaultFile = "soundOn.png",
    	width = 210, height = 200,
    	onRelease = onsoundOnrelease
	}

	soundOn.x = display.contentCenterX - 150
	soundOn.y = display.contentCenterY

	soundOff = widget.newButton{

    	defaultFile = "soundOff.png",
    	width = 230, height = 200,
    	onRelease = onsoundOffrelease
	}

	soundOff.x = display.contentCenterX + 150
	soundOff.y = display.contentCenterY


    sceneGroup:insert(bg)
    sceneGroup:insert(bak)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(soundOn)
    sceneGroup:insert(soundOff)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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
	if menuBtn then
        menuBtn:removeSelf()    -- widgets must be manually removed
        menuBtn = nil
    end

    if soundOn then
    	soundOn:removeSelf()
    	soundOn = nil
    end

    if soundOff then
    	soundOff:removeSelf()
    	soundOn = nil
    end
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