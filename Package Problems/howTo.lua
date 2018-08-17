local composer = require( "composer" )
 
local scene = composer.newScene()

local widget = require "widget"
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
local function onmenuBtnrelease()
    audio.play(popSound)
    composer.removeScene("menu")
    composer.removeScene("howTo")
    composer.gotoScene("menu", "fade", 200 )
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    popSound = audio.loadSound("pop.mp3")

    local bg = display.newImage("howtoScrn.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg.height = 1600
    bg.width = 900

    menuBtn = widget.newButton{

        defaultFile = "menuBtn.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = 765
    menuBtn.y = 50

    sceneGroup:insert(bg)
    sceneGroup:insert(menuBtn)

 
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