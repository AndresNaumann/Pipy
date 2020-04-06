local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"

tt = 1
peri = display.newGroup()

local function follboard(event)
	board.x,board.y = event.x, event.y - 150
end

local function onmenuBtnrelease()
    audio.play(popSound)
    composer.removeScene("menu")
    composer.removeScene("tutorial")
    composer.gotoScene("menu", "fade", 100 )
end

function nextTutorial()
    audio.play(popSound)
    tt = tt + 1
    if tt == 2 then
        transition.to(tutorial2, {x = display.contentCenterX, time = 300})
        transition.to(blaq2, {x = display.contentCenterX, time = 300})
    elseif tt == 3 then
        transition.to(tutorial3, {x = display.contentCenterX, time = 300})
        transition.to(blaq3, {x = display.contentCenterX, time = 300})
    elseif tt == 4 then
        transition.to(tutorial4, {x = display.contentCenterX, time = 300})
        transition.to(blaq4, {x = display.contentCenterX, time = 300})
        board = display.newImage("gameassets/board.png")
        board.x = display.contentCenterX * 0.68; board.y = display.contentCenterY
        board.height = 50; board.width = 260;


        board.alpha = 0


        transition.to(board, {alpha = 1, time = 1000})

        peri:insert(board)
    elseif tt == 5 then
        display.remove(peri)
        transition.to(tutorial5, {x = display.contentCenterX, time = 300})
        transition.to(blaq5, {x = display.contentCenterX, time = 300})
    elseif tt == 6 then
        tutorialDone = true
        saveTutorial()
        
        composer.removeScene("tutorial")
        composer.removeScene("loading")
        composer.gotoScene("loading", "fade", 100)
    end
end

 
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

    popSound = audio.loadSound("pop.mp3")

    blaq = display.newImage("blaq.png")
    blaq.x = display.contentCenterX
    blaq.y = display.contentCenterY
    blaq.height = display.actualContentHeight * 0.9
    blaq.width = display.actualContentWidth

    bg = display.newImage("bgblur.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    bg.height = display.actualContentHeight
    bg.width = display.actualContentWidth
    bg.alpha = 0.4
    
    tutorial1 = display.newImage("tutorials/tutorial1.png")
    tutorial1.x = display.contentCenterX
    tutorial1.y = display.contentCenterY
    tutorial1.height = display.contentHeight
    tutorial1.width = display.actualContentWidth

    tutorial2 = display.newImage("tutorials/tutorial2.png")
    tutorial2.x = display.contentCenterX * 4
    tutorial2.y = display.contentCenterY
    tutorial2.height = display.contentHeight
    tutorial2.width = display.actualContentWidth

    blaq2 = display.newImage("slack.png")
    blaq2.x = display.contentCenterX * 3.8
    blaq2.y = display.contentCenterY
    blaq2.height = display.contentHeight
    blaq2.width = display.actualContentWidth

    tutorial3 = display.newImage("tutorials/tutorial3.png")
    tutorial3.x = display.contentCenterX * 4
    tutorial3.y = display.contentCenterY
    tutorial3.height = display.contentHeight
    tutorial3.width = display.actualContentWidth

    blaq3 = display.newImage("slack.png")
    blaq3.x = display.contentCenterX * 3.5
    blaq3.y = display.contentCenterY
    blaq3.height = display.contentHeight
    blaq3.width = display.actualContentWidth

    tutorial4 = display.newImage("tutorials/tutorial4.png")
    tutorial4.x = display.contentCenterX * 4
    tutorial4.y = display.contentCenterY
    tutorial4.height = display.contentHeight
    tutorial4.width = display.actualContentWidth

    blaq4 = display.newImage("slack.png")
    blaq4.x = display.contentCenterX * 3.5
    blaq4.y = display.contentCenterY
    blaq4.height = display.contentHeight
    blaq4.width = display.actualContentWidth

    tutorial5 = display.newImage("tutorials/tutorial5.png")
    tutorial5.x = display.contentCenterX * 4
    tutorial5.y = display.contentCenterY
    tutorial5.height = display.contentHeight
    tutorial5.width = display.actualContentWidth

    blaq5 = display.newImage("slack.png")
    blaq5.x = display.contentCenterX * 3.5
    blaq5.y = display.contentCenterY
    blaq5.height = display.contentHeight
    blaq5.width = display.actualContentWidth

    menuBtn = widget.newButton{

        defaultFile = "texts/menuBtn.png",
        overFile ="texts/menuBtnOver.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = display.actualContentWidth * 0.76
    menuBtn.y = display.actualContentHeight * 0.06

    nextBtn = widget.newButton {
        defaultFile = "texts/nextBtn.png",
        overFile = "texts/nextBtnOver.png",
        width = 200, height = 75,
        onRelease = nextTutorial
    }

    nextBtn.x = display.actualContentWidth * 0.8
    nextBtn.y = display.contentHeight * 0.85


    sceneGroup:insert(bg)
    sceneGroup:insert(blaq)
    sceneGroup:insert(tutorial1)
    sceneGroup:insert(blaq2)
    sceneGroup:insert(tutorial2)
    sceneGroup:insert(blaq3)
    sceneGroup:insert(tutorial3)
    sceneGroup:insert(blaq4)
    sceneGroup:insert(tutorial4)
    sceneGroup:insert(blaq5)
    sceneGroup:insert(tutorial5)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(nextBtn)

 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
        tutorial4:addEventListener('touch', follboard)
 
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
    
    if menuBtn then
        menuBtn:removeSelf()
        menuBtn = nil
    end

    if nextBtn then
        nextBtn:removeSelf()
        nextBtn = nil
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