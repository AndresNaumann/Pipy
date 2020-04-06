local composer = require( "composer" )
local widget = require "widget"
local scene = composer.newScene()

----Ads-------------------------------------
--------------------------------------------

equipSlot = basicCrate
buySlot = basicCrate
selectedPrice = 0

loadPurchased()
loadTotalScores()

-- ScrollView listener
local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end

backGroundGroup = display.newGroup()

local scrollHeight = 500

local scrollView = widget.newScrollView(
    {
        x = display.contentCenterX,
        y = display.contentHeight * 0.5,
        hideBackground = true,
        width = display.actualContentWidth,
        height = 500,
        scrollWidth = display.contentWidth * 4,
        verticalScrollDisabled = true,
        horizontalScrollDisabled = false,
        listener = scrollListener,
    }
)
scrollView.alpha = 0

transition.to(scrollView, {alpha = 1, time = 300})

--button Functions-------------------
local function onmenuBtnrelease()
    
    audio.play(popSound)
    display.remove(scrollView)
    display.remove(backGroundGroup)
    display.remove(equipCrates)
    composer.removeScene("menu")
    composer.removeScene("level1")
    composer.gotoScene("menu", "fade", 100 )

    return true
end

function equipBtnReleased()
    gameCrate = equipSlot
    saveCrate()
    audio.play(popSound)
end

function onBuyBtnRelease()
    if totalScore >= selectedPrice then
        totalScore = totalScore - selectedPrice
        totalScoreTable[1] = totalScore
        totalText1.text = totalScore
        totalText.text = totalScore

        if buySlot == seasonCrate then
            purchasedTable[1] = true
            crate1.alpha = 1
            buyBtn.alpha = 0.4
            equipSlot = seasonCrate

        elseif buySlot == seasonCrate1 then
            purchasedTable[2] = true
            crate15.alpha = 1
            buyBtn.alpha = 0.4
            equipSlot = seasonCrate1

        elseif buySlot == spot1 then
            purchasedTable[3] = true
            crate2.alpha = 1
            buyBtn.alpha = 0.4
            equipSlot = spot1

        elseif buySlot == spot2 then
            purchasedTable[4] = true
            crate3.alpha = 1
            buyBtn.alpha = 0.4
            equipSlot = spot2
            
        elseif buySlot == spot3 then
            purchasedTable[5] = true
            crate4.alpha = 1
            buyBtn.alpha = 0.4
            equipSlot = spot3

        end

        equipBtn:setEnabled(true)
        equipBtn.alpha = 1
        
        saveTotalScores()
        savePurchased()
    end
end

function onDefaultRelease()
    gameCrate = basicCrate
    saveCrate()
    audio.play(popSound)
end
 
 
--crate buttons-----------------------

function onCrate1Release()
    if purchasedTable[1] == true then
        equipSlot = seasonCrate
        equipBtn.alpha = 1
        equipBtn:setEnabled(true)
        buyBtn.alpha = 0.4
        audio.play(popSound)
    elseif purchasedTable[1] == false then
        selectedPrice = 50
        equipBtn.alpha = 0.4
        if totalScore >= selectedPrice then
            buySlot = seasonCrate
            audio.play(popSound)
            buyBtn.alpha = 1
            buyBtn:setEnabled(true)
        elseif totalScore < selectedPrice then
            buyBtn.alpha = 0.4
        end
    end
end

function onCrate15Release()
    if purchasedTable[2] == true then
        equipSlot = seasonCrate1
        equipBtn.alpha = 1
        equipBtn:setEnabled(true)
        buyBtn.alpha = 0.4
        audio.play(popSound)
    elseif purchasedTable[2] == false then
        selectedPrice = 100
        equipBtn.alpha = 0.4
        if totalScore >= selectedPrice then
            buySlot = seasonCrate1
            audio.play(popSound)
            buyBtn.alpha = 1
            buyBtn:setEnabled(true)
        elseif totalScore < selectedPrice then
            buyBtn.alpha = 0.4
        end
    end
end

function onCrate2Release()
    if purchasedTable[3] == true then
        equipSlot = spot1
        equipBtn.alpha = 1
        equipBtn:setEnabled(true)
        buyBtn.alpha = 0.4
        audio.play(popSound)
    elseif purchasedTable[3] == false then
        selectedPrice = 150
        equipBtn.alpha = 0.4
        if totalScore >= selectedPrice then
            buySlot = spot1
            audio.play(popSound)
            buyBtn.alpha = 1
            buyBtn:setEnabled(true)
        elseif totalScore < selectedPrice then
            buyBtn.alpha = 0.4
        end
    end
end

function onCrate3Release()
    if purchasedTable[4] == true then
        equipSlot = spot2
        equipBtn.alpha = 1
        equipBtn:setEnabled(true)
        buyBtn.alpha = 0.4
        audio.play(popSound)
    elseif purchasedTable[4] == false then
        selectedPrice = 200
        equipBtn.alpha = 0.4
        if totalScore >= selectedPrice then
            buySlot = spot2
            audio.play(popSound)
            buyBtn.alpha = 1
            buyBtn:setEnabled(true)
        elseif totalScore < selectedPrice then
            buyBtn.alpha = 0.4
        end
    end
end

function onCrate4Release()
    if purchasedTable[5] == true then
        equipSlot = spot3
        equipBtn.alpha = 1
        equipBtn:setEnabled(true)
        buyBtn.alpha = 0.4
        audio.play(popSound)
    elseif purchasedTable[5] == false then
        selectedPrice = 250
        equipBtn.alpha = 0.4
        if totalScore >= selectedPrice then
            buySlot = spot3
            audio.play(popSound)
            buyBtn.alpha = 1
            buyBtn:setEnabled(true)
        elseif totalScore < selectedPrice then
            buyBtn.alpha = 0.4
        end
    end
end


--Views and stuff--------------

bak2 = display.newRect(display.contentCenterX , display.contentCenterY * 0.5, display.actualContentWidth * 1.4 , display.actualContentHeight)
bak2.fill = {0,0,0,0.0}

scrollView:insert(bak2)

hw = display.actualContentWidth * 0.2

local ypos = scrollHeight * 0.35

crate1 = widget.newButton{
    defaultFile = seasonCrate,
    height = hw, width = hw,
    onRelease = onCrate1Release
}

crate1.x = display.contentCenterX * 0.75
crate1.y = ypos
scrollView:insert(crate1)

if purchasedTable[1] == false then
    crate1.alpha = 0.4
else
    crate1.alpha = 1

end

crate15 = widget.newButton{
    defaultFile = seasonCrate1,
    height = hw, width = hw,
    onRelease = onCrate15Release
}

crate15.x = display.contentCenterX * 1.5
crate15.y = ypos
scrollView:insert(crate15)

if purchasedTable[2] == false then
    crate15.alpha = 0.4
else
    crate15.alpha = 1

end

crate2 = widget.newButton{
    defaultFile = spot1,
    height = hw, width = hw,
    onRelease = onCrate2Release
}

crate2.x = display.contentCenterX * 2.25
crate2.y = ypos
scrollView:insert(crate2)

if purchasedTable[3] == false then
    crate2.alpha = 0.4
else
    crate2.alpha = 1
end

crate3 = widget.newButton{
    defaultFile = spot2,
    height = hw, width = hw,
    onRelease = onCrate3Release
}

crate3.x = display.contentCenterX * 3
crate3.y = ypos
scrollView:insert(crate3)

if purchasedTable[4] == false then
    crate3.alpha = 0.4
else
    crate3.alpha = 1

end

crate4 = widget.newButton{
    defaultFile = spot3,
    height = hw, width = hw,
    onRelease = onCrate4Release
}

crate4.x = display.contentCenterX * 3.75
crate4.y = ypos
scrollView:insert(crate4)

if purchasedTable[5] == false then
    crate4.alpha = 0.4
else
    crate4.alpha = 1
end

---------------------------------

yp = scrollHeight * 0.7
yp8 = scrollHeight * 0.71

price1 = display.newText("50", display.contentCenterX * 0.75, yp, "bnmachine", 80)

price11 = display.newText("50", display.contentCenterX * 0.75, yp8, "bnmachine", 80)
price11.fill = {0,0,0}


price2 = display.newText("100", display.contentCenterX * 1.5, yp, "bnmachine", 80)

price21 = display.newText("100", display.contentCenterX * 1.5, yp8, "bnmachine", 80)
price21.fill = {0,0,0}


price3 = display.newText("150", display.contentCenterX * 2.25, yp, "bnmachine", 80)

price31 = display.newText("150", display.contentCenterX * 2.25, yp8, "bnmachine", 80)
price31.fill = {0,0,0}


price4 = display.newText("200", display.contentCenterX * 3, yp, "bnmachine", 80)

price41 = display.newText("200", display.contentCenterX * 3, yp8, "bnmachine", 80)
price41.fill = {0,0,0}


price5 = display.newText("250", display.contentCenterX * 3.75, yp, "bnmachine", 80)

price51 = display.newText("250", display.contentCenterX * 3.75, yp8, "bnmachine", 80)
price51.fill = {0,0,0}

scrollView:insert(price11)
scrollView:insert(price1)
scrollView:insert(price21)
scrollView:insert(price2)
scrollView:insert(price31)
scrollView:insert(price3)
scrollView:insert(price41)
scrollView:insert(price4)
scrollView:insert(price51)
scrollView:insert(price5)


 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    
    popSound = audio.loadSound("pop.mp3")

    local bg = display.newImage("bgblur.png")
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY 
    bg.height = display.actualContentHeight * 1.1
    bg.width = display.actualContentWidth * 1.1

    local bak = display.newRect(display.contentCenterX,display.contentCenterY,display.actualContentWidth * 1.1,display.actualContentHeight)
    bak.fill = {0,0,0,0.4}

    menuBtn = widget.newButton{

        defaultFile = "texts/menuBtn.png",
        overFile = "texts/menuBtnOver.png",
        width=250, height=75,
        onRelease = onmenuBtnrelease    -- event listener function
    }
    
    menuBtn.x = display.actualContentWidth * 0.76
    menuBtn.y = display.actualContentHeight * 0.06
    
    equipBtn = widget.newButton{
        isEnabled = false,
        defaultFile = "texts/equipBtn.png",
        overFile = "texts/equipBtnOver.png",
        height = 100, width = 225,
        onRelease = equipBtnReleased
    }
    
    equipBtn.x = display.contentCenterX * 1.3
    equipBtn.y = display.contentHeight * 0.8
    equipBtn.alpha = 0.4
    
    buyBtn = widget.newButton{
        isEnabled = false,
        defaultFile = "texts/buyBtn.png",
        overFile = "texts/buyBtnOver.png",
        height = 100, width = 180,
        onRelease = onBuyBtnRelease
    }

    buyBtn.x = display.contentCenterX * 0.7
    buyBtn.y = display.contentHeight * 0.8
    buyBtn.alpha = 0.4

    defaultBtn = widget.newButton{
        defaultFile = "texts/defaultBtn.png",
        overFile = "texts/defaultBtnOver.png",
        height = 100, width = 280,
        onRelease = onDefaultRelease
    }

    defaultBtn.x = display.contentCenterX
    defaultBtn.y = display.contentHeight * 0.9

    ---------------------------------------------------------------

    totalText = display.newText(totalScore, display.contentCenterX, display.actualContentHeight * 0.135, "bnmachine", 85)

    totalText1 = display.newText(totalScore, display.contentCenterX, display.actualContentHeight * 0.139, "bnmachine", 85)
    totalText1.fill = {0,0,0}

    ---------------------------------------------------------------

    shoppy = display.newImage("shoppy.png")
    shoppy.x = display.contentCenterX
    shoppy.y = display.contentCenterY 
    shoppy.height = display.actualContentHeight * 0.45
    shoppy.width = display.actualContentWidth * 1.4
    shoppy.alpha = 0.7

    sceneGroup:insert(bg)
    sceneGroup:insert(bak)
    sceneGroup:insert(shoppy)

    sceneGroup:insert(menuBtn)
    sceneGroup:insert(equipBtn)
    sceneGroup:insert(buyBtn)
    sceneGroup:insert(defaultBtn)

    sceneGroup:insert(totalText1)
    sceneGroup:insert(totalText)

 
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

    if equipBtn then
        equipBtn:removeSelf()
        equipBtn = nil
    end

    if crate1 then
        crate1:removeSelf()
        crate1 = nil
    end

    if crate15 then
        crate15:removeSelf()
        crate15 = nil
    end

    if crate2 then
        crate2:removeSelf()
        crate2 = nil
    end

    if crate3 then
        crate3:removeSelf()
        crate3 = nil
    end

    if crate4 then
        crate4:removeSelf()
        crate4 = nil
    end


    if buyBtn then
        buyBtn:removeSelf()
        buyBtn = nil
    end

    if defaultBtn then
        defaultBtn:removeSelf()
        defaultBtn = nil
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