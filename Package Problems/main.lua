-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"
local startapp = require( "plugin.startapp" )
 
-- Initialize the StartApp plugin
startapp.init( adListener, { appId="204663446", enableReturnAds = true } )

-- Show banner ad. no need to pre-load banner
startapp.show( "banner" , {
adTag = "menu bottom banner",
yAlign = "bottom",
bannerType = "standard"
} )

-- load menu screen
composer.gotoScene( "menu" )