local currentDateMonth = GetClockMonth()
if Config.OnlySnowInDecember then
    if (currentDateMonth == 10) then
        startUpWeather = 'XMAS'
    else
        startUpWeather = Config.StartWeather
    end
else
    startUpWeather = Config.StartWeather
end
local CurrentWeather = startUpWeather
local lastWeather = CurrentWeather
local baseTime = Config.BaseTime
local timeOffset = Config.TimeOffset
local freezeTime = Config.FreezeTime
local blackout = Config.Blackout
local blackoutVehicle = Config.BlackoutVehicle
local disable = Config.Disabled
local xmasVFXAssetName = 'core_snow'
local xmasAudioBank = xmasVFXAssetName
local xmasAudioBankIceSteps = 'ICE_FOOTSTEPS'
local xmasAudioBankSnowSteps = 'SNOW_FOOTSTEPS'

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    disable = Config.Disabled
    TriggerServerEvent('qb-weathersync:server:RequestStateSync')
end)

RegisterNetEvent('qb-weathersync:client:EnableSync', function()
    disable = false
    TriggerServerEvent('qb-weathersync:server:RequestStateSync')
end)

RegisterNetEvent('qb-weathersync:client:DisableSync', function()
    disable = true
    SetRainLevel(0.0)
    SetWeatherTypePersist('CLEAR')
    SetWeatherTypeNow('CLEAR')
    SetWeatherTypeNowPersist('CLEAR')
    NetworkOverrideClockTime(18, 0, 0)
end)

RegisterNetEvent('qb-weathersync:client:SyncWeather', function(NewWeather, newblackout)
    CurrentWeather = NewWeather
    blackout = newblackout
end)

RegisterNetEvent('qb-weathersync:client:SyncTime', function(base, offset, freeze)
    freezeTime = freeze
    timeOffset = offset
    baseTime = base
end)

CreateThread(function()
    while true do
        if not disable then
            if (lastWeather ~= CurrentWeather) then
                lastWeather = CurrentWeather
                SetWeatherTypeOverTime(CurrentWeather, 15.0)
                Wait(15000)
            end
            Wait(100)
            SetArtificialLightsState(blackout)
            SetArtificialLightsStateAffectsVehicles(blackoutVehicle)
            ClearOverrideWeather()
            ClearWeatherTypePersist()
            SetWeatherTypePersist(lastWeather)
            SetWeatherTypeNow(lastWeather)
            SetWeatherTypeNowPersist(lastWeather)
            if (lastWeather == 'XMAS') then
                if Config.EnableExtraSnowSFX then
                    RequestScriptAudioBank(xmasAudioBank, true, 0)
                    RequestScriptAudioBank(xmasAudioBankIceSteps, true, 0)
                    RequestScriptAudioBank(xmasAudioBankSnowSteps, true, 0)
                end
                if Config.EnableExtraSnowVFX then
                    RequestNamedPtfxAsset(xmasVFXAssetName)
                    Wait(100)
                    UseParticleFxAsset(xmasVFXAssetName)
                    ForceSnowPass(true)
                end
                SetForceVehicleTrails(true)
                SetForcePedFootstepsTracks(true)
                if Config.EnableXmasExtraVehicleDirtLevel then
                    local xmasPlayer = PlayerPedId()
                    local xmasVehicle = GetVehiclePedIsIn(xmasPlayer, false)
                    local xmasVehicleStopped = IsVehicleStopped(xmasVehicle)
                    local xmasVehicleDirtLevel = GetVehicleDirtLevel(xmasVehicle)
                    local xmasVehicleSubmergedLevel = GetEntitySubmergedLevel(xmasVehicle)
                    if (GetInteriorFromEntity(xmasVehicle) == 0) then
                        if (xmasVehicleDirtLevel ~= 15.0) then
                            if IsPedInAnyVehicle(xmasPlayer, false) then
                                if DoesEntityExist(xmasVehicle) then
                                    if xmasVehicleStopped then
                                        if (xmasVehicleSubmergedLevel >= 0.2) then
                                            Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 2))
                                            newXmasVehicleDirtLevel = (xmasVehicleDirtLevel - 0.3)
                                            if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                                newXmasVehicleDirtLevel = 14.9
                                            elseif (newXmasVehicleDirtLevel <= 0.0) then
                                                newXmasVehicleDirtLevel = 0.1
                                            end
                                            if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                                SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                            end
                                        else
                                            Wait(Config.XmasExtraVehicleDirtLevelWaitTime)
                                            newXmasVehicleDirtLevel = (xmasVehicleDirtLevel + 0.1)
                                            if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                                newXmasVehicleDirtLevel = 15.0
                                            elseif (newXmasVehicleDirtLevel <= 0.0) then
                                                newXmasVehicleDirtLevel = 0.1
                                            end
                                            if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                                SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                            end
                                        end
                                    else
                                        if (xmasVehicleSubmergedLevel >= 0.2) then
                                            Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 4))
                                            newXmasVehicleDirtLevel = (xmasVehicleDirtLevel - 0.3)
                                            if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                                newXmasVehicleDirtLevel = 14.9
                                            elseif (newXmasVehicleDirtLevel <= 0.0) then
                                                newXmasVehicleDirtLevel = 0.1
                                            end
                                            if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                                SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                            end
                                        else
                                            Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 1.5))
                                            newXmasVehicleDirtLevel = (xmasVehicleDirtLevel + 0.2)
                                            if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                                newXmasVehicleDirtLevel = 15.0
                                            elseif (newXmasVehicleDirtLevel <= 0.0) then
                                                newXmasVehicleDirtLevel = 0.1
                                            end
                                            if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                                SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                            end
                                        end
                                    end
                                end
                            end
                        elseif (xmasVehicleDirtLevel == 15.0) then
                            if (xmasVehicleSubmergedLevel >= 0.2) then
                                if xmasVehicleStopped then
                                    Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 2))
                                    newXmasVehicleDirtLevel = (xmasVehicleDirtLevel - 0.3)
                                    if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                        newXmasVehicleDirtLevel = 14.9
                                    elseif (newXmasVehicleDirtLevel <= 0.0) then
                                        newXmasVehicleDirtLevel = 0.1
                                    end
                                    if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                        SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                    end
                                else
                                    Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 4))
                                    newXmasVehicleDirtLevel = (xmasVehicleDirtLevel - 0.3)
                                    if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                                        newXmasVehicleDirtLevel = 14.9
                                    elseif (newXmasVehicleDirtLevel <= 0.0) then
                                        newXmasVehicleDirtLevel = 0.1
                                    end
                                    if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 0.0)) then
                                        SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                                    end
                                end
                            end
                        end
                    else
                        if ((xmasVehicleDirtLevel < 3.6) or (xmasVehicleDirtLevel <= 0.0)) then end
                        Wait((Config.XmasExtraVehicleDirtLevelWaitTime / 2))
                        newXmasVehicleDirtLevel = (xmasVehicleDirtLevel - 0.1)
                        if ((newXmasVehicleDirtLevel < 3.6) or (newXmasVehicleDirtLevel <= 0.0)) then end
                        if ((newXmasVehicleDirtLevel >= 15.1) or (newXmasVehicleDirtLevel == 15.0)) then
                            newXmasVehicleDirtLevel = 14.9
                        end
                        if ((newXmasVehicleDirtLevel < 15.1) and not (newXmasVehicleDirtLevel <= 3.5) and not (newXmasVehicleDirtLevel <= 0.0)) then
                            SetVehicleDirtLevel(xmasVehicle, newXmasVehicleDirtLevel)
                        end
                    end
                end
                if Config.EnableIceInWater then
                    N_0xc54a08c85ae4d410(3.0)
                end
                if Config.UseFrozenLake then
                    if (GetResourceState(Config.FrozenLakeResourceName) ~= 'missing') then
                        RequestIpl(Config.FrozenLakeIPLName)
                    end
                end
            else
                if Config.EnableExtraSnowVFX then
                    RemoveNamedPtfxAsset(xmasVFXAssetName)
                    ForceSnowPass(false)
                end
                SetForceVehicleTrails(false)
                SetForcePedFootstepsTracks(false)
                if Config.EnableExtraSnowSFX then
                    ReleaseNamedScriptAudioBank(xmasAudioBank)
                    ReleaseNamedScriptAudioBank(xmasAudioBankIceSteps)
                    ReleaseNamedScriptAudioBank(xmasAudioBankSnowSteps)
                end
                if Config.EnableIceInWater then
                    N_0xc54a08c85ae4d410(0.0)
                end
                if Config.UseFrozenLake then
                    if IsIplActive(Config.FrozenLakeIPLName) then
                        RemoveIpl(Config.FrozenLakeIPLName)
                    end
                end
            end
            if (lastWeather == 'RAIN') then
                SetRainLevel(0.3)
            elseif (lastWeather == 'THUNDER') then
                SetRainLevel(0.5)
            else
                SetRainLevel(0.0)
            end
        else
            Wait(1000)
        end
    end
end)

CreateThread(function()
    local hour
    local minute = 0
    local second = 0        --Add seconds for shadow smoothness
    local timeIncrement = Config.RealTimeSync and 0.25 or 1
    local tick = GetGameTimer()
    
    while true do
        if not disable then
            Wait(0)
            local _, _, _, hours, minutes, _ = GetLocalTime()
            local newBaseTime = baseTime
            if tick - (Config.RealTimeSync and 500 or 22) > tick then
                second = second + timeIncrement
                tick = GetGameTimer()
            end
            if freezeTime then
                timeOffset = timeOffset + baseTime - newBaseTime
                second = 0
            end
            baseTime = newBaseTime
            if Config.RealTimeSync then
                hour = hours
                minute = minutes
            else
                hour = math.floor(((baseTime+timeOffset)/60)%24)
                if minute ~= math.floor((baseTime+timeOffset)%60) then  --Reset seconds to 0 when new minute
                    minute = math.floor((baseTime+timeOffset)%60)
                    second = 0
                end
            end
            NetworkOverrideClockTime(hour, minute, second) --Send hour included seconds to network clock time
        else
            Wait(1000)
        end
    end
end)
