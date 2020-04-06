-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

spawnTime = 5000
totalScore = 0
isSoundOn = true

---init Crate Skins and set their names as strings (Lua makes this so easy) ----------------------------------------------

basicCrate = "skins/crate.png"
seasonCrate = "skins/giftCrate.png"
seasonCrate1 = "skins/gigastone.JPG"
spot1 = "skins/gucciCrate.png"
spot2 = "skins/goldCrate.png"
spot3 = "skins/cratePupreme.png"

---Create the variables that will need a save file----------------------------------------------

purchasedTable = {false, false, false, false , false, false }
gameCrate = basicCrate
tutorialDone = false
scoresTable = {}
totalScoreTable = {}

---Ads--------------------------------------------------

local appodeal = require( "plugin.appodeal" )
 
local function adListener( event )
 
	if ( event.phase == "init" ) then  -- Successful initialization
        print( event.isError )
	
	elseif ( event.phase == "failed" ) then  -- The ad failed to load
		print( event.type )
		print( event.isError )
		print( event.response )
	end
end
 
-- Initialize the Appodeal plugin
appodeal.init( adListener, { appKey="c8593213a99ab689b4a5724336aaa078f8d95c003ed7cf29", hasUserConsent = false, childDirectedTreatment = true, supportedAdTypes = {"banner"} } )

--------------------------------------------------------


-- include the Corona "composer" module
-- I Dont think that this needs to be here but I am scared to remove it-----------------
local composer = require "composer"
--this needs to be here tho in order to use the JSON library--------
local json = require( "json" )

--Create variables for where the above info will be stored---------------------------------------------

filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )
filePathT = system.pathForFile( "totalScores.json", system.DocumentsDirectory )
filePathP = system.pathForFile( "purchasedCrates.json", system.DocumentsDirectory )
filePathC = system.pathForFile( "crates.json", system.DocumentsDirectory )
filePathTu = system.pathForFile( "tutorialDone.json", system.DocumentsDirectory )

--Load Functions------You call this first to load all of the saved Vairables-------------------------

function loadScores()
    file = io.open( filePath, "r" )
 
    if file then
        contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end
 
    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
    end

end

function loadTotalScores()
    fileT = io.open( filePathT, "r" )

    if fileT then
        contentsT = fileT:read( "*a" )
        io.close( fileT )
        totalScoreTable = json.decode( contentsT )
    end

    if ( totalScoreTable == nil or #totalScoreTable == 0 ) then
        totalScoreTable = { 0 }
    end
end

function loadPurchased()
    fileP = io.open( filePathP, "r" )

    if fileP then
        contentsP = fileP:read( "*a" )
        io.close(fileP)
        purchasedTable = json.decode( contentsP )
    end

    if (purchasedTable == nil or #purchasedTable == false ) then
        purchasedTable = {false, false, false, false, false, false}
    end
end

function loadCrate()
    fileC = io.open( filePathC, "r" )

    if fileC then
        contentsC = fileC:read("*a")
        io.close(fileC)
        gameCrate = json.decode( contentsC )
    end
end

function loadTutorial()
    fileTu = io.open(filePathTu, "r")

    if fileTu then
        contentsTu = fileTu:read("*a")
        io.close(fileTu)
        tutorialDone = json.decode( contentsTu )
    end
end

--Save Functions---------------You call this whenever a variable is changed that you want to save----------------------


function saveScores()
 
    for i = #scoresTable, 11, -1 do
        table.remove( scoresTable, i )
    end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end

function saveTotalScores()

    for i = #totalScoreTable, 2, -1 do
        table.remove( totalScoreTable, i)
    end

    local fileT = io.open( filePathT, "w" )

    if fileT then
        fileT:write( json.encode( totalScoreTable ) )
        io.close( fileT )
    end
end

function savePurchased()
    local fileP = io.open(filePathP, "w")

    if fileP then
        fileP:write(json.encode( purchasedTable))
        io.close(fileP)
    end
end

function saveCrate()
    local fileC = io.open(filePathC, "w")

    if fileC then
        fileC:write(json.encode( gameCrate ))
        io.close(fileC)
    end
end

function saveTutorial()
    local fileTu = io.open(filePathTu, "w")

    if fileTu then
        fileTu:write(json.encode( tutorialDone ))
        io.close(fileTu)
    end
end

function compare( a, b )
	return a > b
end

----Load everything that you want to load--------

loadTotalScores()
table.insert( totalScoreTable, totalScore)
table.sort(totalScoreTable, compare)
saveTotalScores()

totalScore = totalScoreTable[1]

loadPurchased()

loadCrate()

loadTutorial()


-- load menu screen
composer.gotoScene( "splash" )