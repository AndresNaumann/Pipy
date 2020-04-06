local composer = require( "composer" )
local widget = require "widget"
local scene = composer.newScene()
local json = require( "json" )

----Ads-------------------------------------
--------------------------------------------

local function onmenuBtnrelease()

    audio.play(popSound)
    composer.removeScene("menu")
    composer.removeScene("highScores")
    composer.gotoScene("menu", "fade", 100 )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    popSound = audio.loadSound("pop.mp3")

    loadScores()
     
    -- Insert the saved score from the last game into the table, then reset it
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    local function compare( a, b )
        return a > b
    end
    table.sort( scoresTable, compare )

    saveScores()
     
    local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, display.actualContentHeight * 0.23, "bnmachine", 100 )
    local highScoresHeaderR = display.newText ( sceneGroup, "High Scores", display.contentCenterX, display.actualContentHeight * 0.234, "bnmachine", 100 )
    highScoresHeaderR.fill = {0,0,0}

    bg = display.newImage("bg.png")
    bg.width = display.actualContentWidth + 90
    bg.height = display.actualContentHeight + 160
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY

    bak = display.newRect( display.contentCenterX, 800, display.actualContentWidth + 200, 2345)
	bak.fill = {0,0,0, 0.4}

    menuBtn = widget.newButton{

        defaultFile = "texts/menuBtn.png",
        overFile ="texts/menuBtnOver.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = display.actualContentWidth * 0.76
    menuBtn.y = display.actualContentHeight * 0.06

    sceneGroup:insert(bg)
    sceneGroup:insert(bak)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(highScoresHeaderR)
    sceneGroup:insert(highScoresHeader)

    for i = 1, 5 do
        if ( scoresTable[i] ) then
            local yPos = (display.actualContentWidth * 0.6) + ( i * 100 )
            local yPos1 = (display.actualContentWidth * 0.606) + ( i * 100 )

            local rankNum1 = display.newText( sceneGroup, i .. ".", display.contentCenterX-20, yPos1, "bnmachine", 75 )
            rankNum1:setFillColor( 0 )
            rankNum1.anchorX = 1

            local rankNum = display.newText( sceneGroup, i .. ".", display.contentCenterX-20, yPos, "bnmachine", 75 )
            rankNum:setFillColor( 0.8 )
            rankNum.anchorX = 1

            local thisScore1 = display.newText( sceneGroup, scoresTable[i], display.contentCenterX, yPos1, "bnmachine", 75)
            thisScore1.anchorX = 0
            thisScore1.fill = {0,0,0}

            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX, yPos, "bnmachine", 75)
            thisScore.anchorX = 0

 
        end
    end  
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
        menuBtn:removeSelf()
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