local playerDied = false
local diedPos = {}
local startAnimation = false
local timeLeft = 0
local canRespawn = false
local isInvincible = false
local deathCause = 0
local isDead = false
local health = 0
local deadData = {health = nil, cause = nil, source = nil, time = nil}

function drawText(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(x , y)
end

Citizen.CreateThread(function()
    while true do
            local ped = GetPlayerPed(PlayerId())
            health = GetEntityHealth(ped)
            currentHealth = health
            if IsEntityDead(ped) then
                if not isDead then
                    local deathCause = GetPedCauseOfDeath(ped)
                    local deathSource = GetPedSourceOfDeath(ped)
                    local deathTime = GetPedTimeOfDeath(ped)
                    deadData.cause = deathCause
                    deadData.source = deathSource
                    deadData.time = deathTime
                    isDead = true
                end
            else
                if isDead then
                    isDead = false
                end
            end
            if isDead then
                if not playerDied then
                    TriggerServerEvent("DRP_Core:TriggerDeathStart")
                    diedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
                    playerDied = true
                    ResetPedMovementClipset(ped, 0.0)
                end
            end
        if startAnimation then
            local ped = GetPlayerPed(PlayerId())
            SetPlayerInvincible(PlayerId(), true)
            isInvincible = true
            local dict = "combat@damage@rb_writhe"
            local anim = "rb_writhe_loop"
            while not IsEntityPlayingAnim(ped, dict, anim, 1) do
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                    Citizen.Wait(1)
                end
                TaskPlayAnim(ped, dict, anim, 8.0, -8.0, -1, 14, 1.0, 0, 0, 0)
                Citizen.Wait(0)
            end
        else
            if isInvincible then
                SetPlayerInvincible(PlayerId(), false)
                isInvincible = false
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("DRP_Core:InitDeath")
AddEventHandler("DRP_Core:InitDeath", function(time)
    local ped = GetPlayerPed(PlayerId())
    while GetEntitySpeed(ped) >= 0.33 do
        Citizen.Wait(555)
    end
    local pedPos = GetEntityCoords(ped, false)
    ResurrectPed(ped)
    SetEntityCoords(ped, pedPos.x, pedPos.y, pedPos.z, 0.0, 0.0, 0.0, 0)
    startAnimation = true
    Citizen.Wait(555)
    timeLeft = time
    for a = 1, time do
        Citizen.Wait(555)
        timeLeft = timeLeft - 1
        if timeLeft == 0 then
            canRespawn = true
            if canRespawn then
                print("you can respawn")
            end
        end
    end
end)

RegisterCommand("adminrevive", function(source, args, raw)
    if playerDied then
        TriggerEvent("DRP_Core:Revive")
    else
        print("not dead!")
    end
end, false)

RegisterNetEvent("DRP_Core:Revive")
AddEventHandler("DRP_Core:Revive", function()
    local ped = GetPlayerPed(PlayerId())
    startAnimation = false
    playerDied = false
    canRespawn = false
    timeLeft = -1
    ResurrectPed(ped)
    ClearPedTasksImmediately(GetPlayerPed(PlayerId()))
    local pedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    SetEntityCoords(GetPlayerPed(PlayerId()), pedPos.x, pedPos.y, pedPos.z + 0.3, 0.0, 0.0, 0.0, 0)
end)
