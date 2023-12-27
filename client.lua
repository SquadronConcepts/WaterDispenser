
local IsAnimated = false

local target = true --dont change this

local dispensorprops = { --config dispensers
    "prop_vend_water_01",
    "prop_watercooler_dark",
    "prop_watercooler"
}

ESX = exports["es_extended"]:getSharedObject()


if target then
    exports.ox_target:addModel(dispensorprops, {
         {
             distance = 1,
             onSelect = function()
                 TriggerEvent('Squadron_waterdispenser:drink')
             end,
             icon = "fa-solid fa-glass-water", -- <i class="fa-solid fa-glass-water"></i>
             label = "Drink water",
         },
     })
end

RegisterNetEvent('Squadron_waterdispenser:drink')
AddEventHandler('Squadron_waterdispenser:drink', function()
    if not IsAnimated then
        prop_name = prop_name or 'prop_cs_paper_cup'
        IsAnimated = true

        TriggerServerEvent('Squadron_waterdispenser:refillThirst')

        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
            local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
            local boneIndex = GetPedBoneIndex(playerPed, 18905)
            AttachEntityToEntity(prop, playerPed, boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
                    
            ESX.Streaming.RequestAnimDict('mp_player_intdrink', function()
                TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)

                Citizen.Wait(3000)
                IsAnimated = false
                ClearPedSecondaryTask(playerPed)
                DeleteObject(prop)
            end)
        end)
    end
end)
