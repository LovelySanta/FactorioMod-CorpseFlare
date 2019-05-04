
CorpseFlare = {}
local flare_duration = 60 * 60 * 2 -- in ticks

function CorpseFlare.Init(self)
  if not global.BZ_flare then
    global.BZ_flare = {}
    -- Becose i'm to lazy to give myself a corpse flare each time while testing
    --game.players['lovely_santa'].get_main_inventory().insert{name='corpse-flare',count=1}
  end
end



function CorpseFlare.OnPrePlayerDied(self, playerIndex)
  local player = game.players[playerIndex]

  local playerInventory = player.get_main_inventory()
  if playerInventory then
    local playerInventoryContent = playerInventory.get_contents()

    if playerInventoryContent and playerInventoryContent["corpse-flare"] and playerInventoryContent["corpse-flare"] > 0 then
      -- Remove a flare from the inventory
      playerInventory.remove{name="corpse-flare", count=1}
      -- Create a flare entity
      self:CreateNewFlare(playerIndex)
      -- No need to look further, we can quit this function
      return
    end
  end
end



function CorpseFlare.CreateNewFlare(_, playerIndex)
  local player = game.players[playerIndex]

  local flare = player.surface.create_entity{
    name='flare-cloud',
    position = {
      x = player.position.x + 3.25,
      y = player.position.y - 2.5
    },
    force = 'enemy',
    -- target = player.character,
    speed = 0.15
  }
  global.BZ_flare[playerIndex] = flare

  -- also create a light source
  local id        = rendering.draw_light{
    sprite        = "utility/light_small",
    color         = {224/255, 11/255, 199/255},
    scale         = 1.5,
    target        = flare,
    target_offset = {x = -3.25, y = 2.5},
    surface       = flare.surface,
    --time_to_live  = flare_duration + 2 * 60,
    visible = true,
  }
end
