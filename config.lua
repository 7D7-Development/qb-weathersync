Config = {}
Config.DynamicWeather = true -- Set this to false if you don't want the weather to change automatically every 10 minutes.
-- On server start
Config.StartWeather = 'EXTRASUNNY' -- Default weather                                     -- Default: 'EXTRASUNNY'
Config.BaseTime = 8 -- Time                                                               -- Default: 8
Config.TimeOffset = 0 -- Time offset                                                      -- Default: 0
Config.FreezeTime = false -- freeze time                                                  -- Default: false
Config.Blackout = false -- Set blackout                                                   -- Default: false
Config.BlackoutVehicle = false -- Set blackout affects vehicles                           -- Default: false
Config.NewWeatherTimer = 10 -- Time (in minutes) between each weather change              -- Default: 10
Config.Disabled = false -- Set weather disabled                                           -- Default: false
Config.RealTimeSync = false -- Activate realtime synchronization                          -- Default: false
Config.OnlySnowInDecember = true -- Enable Xmas Weather in December Automatically         -- Default: true
Config.EnableExtraSnowVFX = true -- Enable Extra Snow Visual FX                           -- Default: true
Config.EnableExtraSnowSFX = true -- Enable Extra Snow Sound FX                            -- Default: true
Config.EnableXmasExtraVehicleDirtLevel = true -- Add Extra Snow on Player Vehicles        -- Default: true
Config.XmasExtraVehicleDirtLevelWaitTime = 2300 -- How often Extra Snow is Applied in MS  -- Default: 2300 (2.3 Seconds)
Config.EnableIceInWater = true -- Enable Ice In All Water                                 -- Default: true
Config.UseFrozenLake = false -- Enable if using a Frozen Lake Resource                    -- Default: false
Config.FrozenLakeResourceName = '' -- Name of Frozen Lake Resource                        -- Default: 'your_frozen_lake_resourcename'
Config.FrozenLakeIPLName = '' -- Name of Frozen Lake IPL                                  -- Default: 'your_frozen_ipl_name'

Config.AvailableWeatherTypes = { -- DON'T TOUCH EXCEPT IF YOU KNOW WHAT YOU ARE DOING
    'EXTRASUNNY',
    'CLEAR',
    'NEUTRAL',
    'SMOG',
    'FOGGY',
    'OVERCAST',
    'CLOUDS',
    'CLEARING',
    'RAIN',
    'THUNDER',
    'SNOW',
    'BLIZZARD',
    'SNOWLIGHT',
    'XMAS',
    'HALLOWEEN',
    'RAIN_HALLOWEEN',
    'SNOW_HALLOWEEN',
}
