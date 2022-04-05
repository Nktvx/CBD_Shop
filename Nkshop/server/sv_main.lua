TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Shop:BuyItem')
AddEventHandler('Shop:BuyItem', function(item , price)
  local src = source 
  local xPlayer = ESX.GetPlayerFromId(src)
  
  
  if xPlayer.getAccount('cash').money >= price then
    xPlayer.removeAccountMoney('cash', price)
    xPlayer.addInventoryItem(item, 1)
    TriggerClientEvent('::{korioz#0110}::esx:showNotification', src , 'Merci de l\'achat')
  end
end)
