--highScores
local startapp = require( "plugin.startapp" )

-- Initialize the StartApp plugin
startapp.init( adListener, { appId="204663446", enableReturnAds = true } )

-- Show banner ad. no need to pre-load banner
startapp.show( "banner" , {
adTag = "menu bottom banner",
yAlign = "bottom",
bannerType = "standard"
} )

local composer = require( "composer" )
local widget = require "widget"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local json = require( "json" )

local scoresTable = {}

local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

local function loadScores()
 
    local file = io.open( filePath, "r" )
 
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end
 
    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end
end

local function saveScores()
 
    for i = #scoresTable, 11, -1 do
        table.remove( scoresTable, i )
    end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end

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

    loadScores()
     
    -- Insert the saved score from the last game into the table, then reset it
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    local function compare( a, b )
        return a > b
    end
    table.sort( scoresTable, compare )

    saveScores()
     
    local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, 250, "BebasNeue Regular", 100 )

    bg = display.newImage("bg.png")
    bg.width = display.contentWidth
    bg.height = display.contentHeight
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

    sceneGroup:insert(bg)
    sceneGroup:insert(bak)
    sceneGroup:insert(menuBtn)
    sceneGroup:insert(highScoresHeader)

    for i = 1, 10 do
        if ( scoresTable[i] ) then
            local yPos = 350 + ( i * 80 )

            local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX-50, yPos, "BebasNeue Regular", 60 )
            rankNum:setFillColor( 0.8 )
            rankNum.anchorX = 1
 
            local thisScore = display.newText( sceneGroup, scoresTable[i], display.contentCenterX-30, yPos, "BebasNeue Regular", 60)
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