local composer = require( "composer" )
local scene = composer.newScene()

local widget = require ("widget")

local physics = require("physics")

----Ads-------------------------------------
local appodeal = require( "plugin.appodeal" )
appodeal.show( "banner", { yAlign="bottom" } )
--------------------------------------------

local replayBtn
local paint
local gowords
local menu

local function onreplayBtnrelease()
    appodeal.hide( "banner" )
    audio.play(popSound)
    composer.removeScene("gameover")
    composer.removeScene("level1")
    composer.gotoScene( "level1", "fade", 100 )
    physics.start()
    return true -- indicates successful touch

end 

local function onmenuBtnrelease()
    appodeal.hide( "banner" )
    audio.play(popSound)
    composer.removeScene("gameover")
    composer.removeScene("level1")
    composer.removeScene("menu")
    composer.gotoScene("menu", "fade", 100 )
    spawnTable = {}
    return true

end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    popSound = audio.loadSound("pop.mp3")

    local background = display.newImage("bgblur.png")
    background.x = display.contentCenterX
    background.y = display.contentCenterY
    background.width = display.actualContentWidth + 90
    background.height = display.actualContentHeight + 160
 
    replayBtn = widget.newButton{

        defaultFile = "texts/replay.png",
        overFile = "texts/replayOver.png",
        width=150, height=150,
        onRelease = onreplayBtnrelease    -- event listener function
    }

    replayBtn.x = display.contentCenterX
    replayBtn.y = display.actualContentHeight * 0.6

    menuBtn = widget.newButton{

        defaultFile = "texts/menuBtn.png",
        overFile = "texts/menuBtnOver.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = display.actualContentWidth * 0.76
    menuBtn.y = display.actualContentHeight * 0.06

    recentScore = display.newText(score, 100, 50, "bnmachine", 100)
    recentScore.x = display.contentCenterX - 150
    recentScore.y = display.actualContentHeight * 0.40625

    recentScore1 = display.newText(score, 100, 50, "bnmachine", 100)
    recentScore1.x = display.contentCenterX - 150
    recentScore1.y = display.actualContentHeight * 0.41
    recentScore1.fill = {0,0,0}

    gowords = display.newText("Score", 50, 50, "bnmachine", 70)
    gowords.x = display.contentCenterX - 150
    gowords.y = display.actualContentHeight * 0.3

    gowords1 = display.newText("Score", 50, 50, "bnmachine", 70)
    gowords1.x = display.contentCenterX - 150
    gowords1.y = display.actualContentHeight * 0.304
    gowords1.fill = {0,0,0}

    hiwords = display.newText("High", 50, 50, "bnmachine", 70)
    hiwords.x = display.contentCenterX + 150
    hiwords.y = display.actualContentHeight * 0.276

    hiwords1 = display.newText("High", 50, 50, "bnmachine", 70)
    hiwords1.x = display.contentCenterX + 150
    hiwords1.y = display.actualContentHeight * 0.28
    hiwords1.fill = {0,0,0}

    hiwords2 = display.newText("Score", 50, 50, "bnmachine", 70)
    hiwords2.x = display.contentCenterX + 150
    hiwords2.y = display.actualContentHeight * 0.324

    hiwords3 = display.newText("Score", 50, 50, "bnmachine", 70)
    hiwords3.x = display.contentCenterX + 150
    hiwords3.y = display.actualContentHeight * 0.328
    hiwords3.fill = {0,0,0}

    totalScoreText = display.newText(totalScore, display.contentCenterX, display.contentCenterY * 0.35, "bnmachine", 90)

    totalScoreText1 = display.newText(totalScore, display.contentCenterX, display.contentCenterY * 0.358, "bnmachine", 90)
    totalScoreText1.fill = {0,0,0}

    local backy = display.newRect(display.contentCenterX, display.contentCenterY, display.actualContentWidth * 1.1, 
    display.actualContentHeight * 1.1)
    backy.fill = {0.1, 0.1, 0.1, 0.4}

    sceneGroup:insert(background)
    sceneGroup:insert(backy)
    sceneGroup:insert(recentScore1)
    sceneGroup:insert(recentScore)
    sceneGroup:insert(gowords1)
    sceneGroup:insert(gowords)
    sceneGroup:insert(hiwords1)
    sceneGroup:insert(hiwords)
    sceneGroup:insert(hiwords3)
    sceneGroup:insert(hiwords2)
    sceneGroup:insert(replayBtn)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(totalScoreText1)
    sceneGroup:insert(totalScoreText)

    for i = 1, 1 do
        if ( scoresTable[i] ) then
            local yPos = display.actualContentHeight * 0.40625
 
            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX + 150, yPos, "bnmachine", 100)
 
        end
    end

    for i = 1, 1 do
        if ( scoresTable[i] ) then
            local yPos = display.actualContentHeight * 0.40625

            local thisScore1 = display.newText( sceneGroup, scoresTable[i], display.contentCenterX + 150, display.actualContentHeight * 0.41, "bnmachine", 100)
            thisScore1.fill = {0,0,0}
 
            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX + 150, yPos, "bnmachine", 100)
        
 
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
    if replayBtn then
        replayBtn:removeSelf()    -- widgets must be manually removed
        replayBtn = nil
    end


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