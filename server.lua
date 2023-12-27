ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('Squadron_waterdispenser:refillThirst')
AddEventHandler('Squadron_waterdispenser:refillThirst', function()
	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
end)
