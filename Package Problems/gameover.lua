local composer = require( "composer" )
local startapp = require( "plugin.startapp" )

-- Initialize the StartApp plugin
startapp.init( adListener, { appId="204663446", enableReturnAds = true } )

-- StartApp listener function
local function adListener( event )
    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
        startapp.load( "video" )
    elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        print( event.type )
    elseif ( event.phase == "failed" ) then  -- The ad failed to load
        print( event.type )
        print( event.isError )
        print( event.response )
    elseif ( event.phase == "displayed" ) then  -- The ad was displayed/played
        print( event.type )
    elseif ( event.phase == "hidden" ) then  -- The ad was closed/hidden
        print( event.type )
    elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
        print( event.type )
    end
end

-- Show banner ad. no need to pre-load banner
startapp.show( "banner" , {
adTag = "menu bottom banner",
yAlign = "bottom",
bannerType = "standard"
} )
 
local scene = composer.newScene()

local widget = require ("widget")

local physics = require("physics")

local startapp = require( "plugin.startapp" )

-- StartApp listener function
local function adListener( event )
    if ( event.phase == "init" ) then  -- Successful initialization
        print( event.provider )
        startapp.load( "video" )
    elseif ( event.phase == "loaded" ) then  -- The ad was successfully loaded
        print( event.type )
    elseif ( event.phase == "failed" ) then  -- The ad failed to load
        print( event.type )
        print( event.isError )
        print( event.response )
    elseif ( event.phase == "displayed" ) then  -- The ad was displayed/played
        print( event.type )
    elseif ( event.phase == "hidden" ) then  -- The ad was closed/hidden
        print( event.type )
    elseif ( event.phase == "clicked" ) then  -- The ad was clicked/tapped
        print( event.type )
    end
end
 
-- Initialize the StartApp plugin
startapp.init( adListener, { appId="204663446", enableReturnAds = true } )

-- Show banner ad. no need to pre-load banner
startapp.show( "banner" , {
adTag = "menu bottom banner",
yAlign = "bottom",
bannerType = "standard"
} )

startapp.hide()


local replayBtn
local paint
local gowords
local menu

local function onreplayBtnrelease()
    audio.play(popSound)
    composer.removeScene("gameover")
    composer.removeScene("level1")
    composer.gotoScene( "level1", "fade", 200 )
    physics.start()
    return true -- indicates successful touch

end 

local function onmenuBtnrelease()
    audio.play(popSound)
    composer.removeScene("gameover")
    composer.removeScene("level1")
    composer.removeScene("menu")
    composer.gotoScene("menu", "fade", 200 )
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
    background.width = 900
    background.height = 1600
 
    replayBtn = widget.newButton{

        defaultFile = "replay.png",
        width=150, height=150,
        onRelease = onreplayBtnrelease    -- event listener function
    }

    replayBtn.x = display.contentCenterX
    replayBtn.y = display.contentCenterY + 150

    menuBtn = widget.newButton{

        defaultFile = "menuBtn.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }

    menuBtn.x = 765
    menuBtn.y = 50

    recentScore = display.newText(score, 100, 50, "BebasNeue Regular", 100)

    recentScore.x = display.contentCenterX
    recentScore.y = 650

    gowords = display.newText("Score", 50, 50, "BebasNeue Regular", 100)

    gowords.x = display.contentCenterX
    gowords.y = 400

    sceneGroup:insert(background)
    sceneGroup:insert(recentScore)
    sceneGroup:insert(gowords)
    sceneGroup:insert(replayBtn)
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