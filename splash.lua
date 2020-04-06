local composer = require( "composer" )

local scene = composer.newScene()

function goMen()
composer.gotoScene("menu", "fade", 300)
end

bean = timer.performWithDelay(3000, goMen, 1)


--[[ {local options = {
        appPermission = "Calendars",
    }
native.showPopup( "requestAppPermission", options )
 
--]]

 
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local brand = display.newImage("header1.png")
    brand.x = display.contentCenterX
    brand.y = display.contentCenterY * 0.8
    brand.height = 400
    brand.width = 420

    local text = display.newText("Made by Gigabro", display.contentCenterX, display.actualContentHeight * 0.70, "bnmachine", 84)

    local text1 = display.newText("Made by Gigabro", display.contentCenterX, display.actualContentHeight * 0.705, "bnmachine", 84)
    text1.fill = {100, 100, 100, 0.4}

    sceneGroup:insert(text1)
    sceneGroup:insert(text)
    sceneGroup:insert(brand)
 
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
