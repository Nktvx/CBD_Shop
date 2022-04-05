TriggerEvent('::{korioz#0110}::esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
  for k,v in pairs (ZONES.pos) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipSprite(blip, 140)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 1.0)
    SetBlipColour(blip, 69)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Vendeur De CBD')
    EndTextCommandSetBlipName(blip)
  end
end)

Citizen.CreateThread(function()
  while true do 
    local wait = 700
    for k in pairs (ZONES.pos) do
      local pos =  ZONES.pos
      local player = GetEntityCoords(PlayerPedId())
      local dist = GetDistanceBetweenCoords(player, pos[k], true)
      local interval = 1

      if dist > 10 then 
        interval = 200
      else
        interval = 1
        

        if dist < 1 then
          RageUI.Text({ message=" appuyer sur \'E\' pour parler au vendeur ", time_display = 1 })
          if IsControlJustPressed(1, 38) then
            vendeur()
          end
        end
      end
    end
    Wait(interval)
  end
end)



Citizen.CreateThread(function()
  Citizen.Wait(750)
  for _, v in pairs(Config.npc) do
    RequestModel(GetHashKey(v.model))
    while not HasModelLoaded(GetHashKey(v.model)) do Wait(10) end
      npc = CreatePed(4, v.model, v.coords, v.heading, false, true)
      SetEntityInvincible(npc, true)
      FreezeEntityPosition(npc, true)
  end
end)



function vendeur()
  RMenu.Add('Shop', 'main', RageUI.CreateMenu("Vendeur de CBD", "Achat de CBD"))
    if open then
      open = false 
      RageUI.Visible(RMenu:Get('Shop', 'main'), false)
    else
      open = true
      RageUI.Visible(RMenu:Get('Shop', 'main'), true)
      Citizen.CreateThread(function()
        while open do 
          RageUI.IsVisible(RMenu:Get('Shop', 'main'), true, true, true, function()
            RageUI.ButtonWithStyle("Acheter de l'huile de CBD", "Huile de CBD A forte dose ", {RightLabel = "~b~Acheter ici", RightBadge = RageUI.BadgeStyle.Weed}, true, function(h,a,s)
            if s then
              local price = 230
              local item = 'weed'
              TriggerServerEvent('Shop:BuyItem', item, price)
              RageUI.CloseAll()
            end
          end)
          RageUI.ButtonWithStyle("Acheter des Joint", "Joint a bases de CBD ", {RightLabel = "~b~Acheter ici", RightBadge = RageUI.BadgeStyle.Weed}, true, function(h,a,s)
            if s then
              local price = 110
              local item = 'meth'
              TriggerServerEvent('Shop:BuyItem', item, price)
              RageUI.CloseAll()
            end
          end)
        end , function()end, 1)
        Citizen.Wait(0)
        if not RageUI.Visible(RMenu:Get('Shop', 'main')) then
          open = false
        end 
      end
    end)
  end
end


    