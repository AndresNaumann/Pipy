--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	showRuntimeErrors = false,
	--[[
	license =
	{
		google = 
		{
			key = "beans",
			policy = "serverManaged",
		}
	}
	--]]
	content =
	{
		width = 900,
		height = 1600, 
		scale = "letterbox",
		fps = 60,
		
		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
			    ["@4x"] = 4,
		},
		--]]
	},
}
