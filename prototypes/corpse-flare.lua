local flare_duration = 60 * 60 * 2 -- in ticks
local flare_range = 2 -- radius


data:extend({
  {
    type = "item",
    name = "corpse-flare",
    icon = "__CorpseFlare__/graphics/icons/corpse-flare.png",
    icon_size = 32,
    scale = 1,
    flags = {"goes-to-main-inventory"},
    subgroup = "tool",
    order = "z[mining]-z[shovel]",
    stack_size = 1
  },

  {
    type = "recipe",
    name = "corpse-flare",
    enabled = false,
    ingredients =
    {
      {type="item", name="electronic-circuit", amount=5},
      {type="item", name="small-lamp", amount=5},
      {type="item", name="grenade", amount=1}
    },
    energy_required = 5,
    result= "corpse-flare",
    result_count = 1
  },

  {
    type = "technology",
    name = "corpse-flare",
    prerequisites = {"military-2"},
    icon = "__CorpseFlare__/graphics/technology/corpse-flare.png",
    icon_size = 64,
    unit =
    {
      count = 100,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"military-science-pack", 1},
      },
      time = 20
    },
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "corpse-flare"
      }
    },
    order = "b-d"
  },

  {
    type = "smoke-with-trigger",
    name = "flare-cloud",
    flags = {"not-on-map", "placeable-off-grid", },
    show_when_smoke_off = true,
    animation =
    {
      filename = "__CorpseFlare__/graphics/entity/corpse-flare.png",
      flags = { "compressed" },
      priority = "low",
      width = 256,
      height = 256,
      frame_count = 4,
      animation_speed = 0.1,
      line_length = 4,
      scale = 1,
    },
    slow_down_factor = 0,
    affected_by_wind = false,
    cyclic = true,
    duration = flare_duration,
    fade_away_duration = 2 * 60,
    spread_duration = 10,
    --color = { r = 0.675, g = 0.078, b = 0.455 },
    color = { r = 0.824, g = 0.496, b = 0.703 },
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "nested-result",
          action =
          {
            type = "area",
            radius = 0,
            action_delivery =
            {
              type = "instant",
              target_effects =
              {
                type = "damage",
                damage = { amount = 0, type = "physical"}
              }
            }
          }
        }
      }
    },
    action_cooldown = flare_duration + 2 * 60,
  },
})
