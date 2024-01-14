local jetpack_fast = minetest.settings:get_bool("jetpack.fast", false)
local jetpack_crafts = minetest.settings:get_bool("jetpack.crafts", true)
local jetpack_time = tonumber(minetest.settings:get("jetpack.time")) or 7
local jetpack_time_bronze = tonumber(minetest.settings:get("jetpack.time_bronze")) or 15
local jetpack_time_gold = tonumber(minetest.settings:get("jetpack.time_gold")) or 30

if jetpack_fast == true then
    playereffects.register_effect_type("flyj", "Fly mode available", "jetpack.png", {"fly"},
        function(player)
            local playername = player:get_player_name()
            local privs = minetest.get_player_privs(playername)
            privs.fly = true
            privs.fast = true
            minetest.set_player_privs(playername, privs)
        end,
        function(effect, player)
            local privs = minetest.get_player_privs(effect.playername)
            privs.fly = nil
            privs.fast = nil
            minetest.set_player_privs(effect.playername, privs)
        end,
        false,
        false)
    else
        playereffects.register_effect_type("flyj", "Fly mode available", "jetpack.png", {"fly"},
            function(player)
                local playername = player:get_player_name()
                local privs = minetest.get_player_privs(playername)
                privs.fly = true
                minetest.set_player_privs(playername, privs)
            end,
            function(effect, player)
                local privs = minetest.get_player_privs(effect.playername)
                privs.fly = nil
                minetest.set_player_privs(effect.playername, privs)
            end,
            false,
            false)
end

minetest.register_craftitem("jetpack:jetpack", {
    description = "Jetpack",
    inventory_image = "jetpack.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack_time, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craftitem("jetpack:jetpack_bronze", {
    description = "Bronze Jetpack",
    inventory_image = "jetpack_bronze.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack_time_bronze, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craftitem("jetpack:jetpack_gold", {
    description = "Gold Jetpack",
    inventory_image = "jetpack_gold.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of this jetpack!")
        else
            playereffects.apply_effect_type("flyj", jetpack_time_gold, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craftitem("jetpack:jetpack_base", {
    description = "Jetpack Tubes",
    inventory_image = "jetpack_base.png",
})

if jetpack_crafts == true then
  if minetest.get_modpath("default") then
    minetest.register_craft({
        output = "jetpack:jetpack_base",
        recipe = {
            {"default:steel_ingot", "", "default:steel_ingot"},
            {"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
            {"default:steel_ingot", "", "default:steel_ingot"},
        },
    })
    minetest.register_craft({
        output = "jetpack:jetpack",
        recipe = {
            {"default:diamond", "jetpack:jetpack_base", "default:diamond"},
            {"default:mese_crystal", "default:steelblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "jetpack:jetpack_bronze",
        recipe = {
            {"default:diamondblock", "jetpack:jetpack_base", "default:diamond"},
            {"default:mese", "default:bronzeblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "jetpack:jetpack_gold",
        recipe = {
            {"default:diamondblock", "jetpack:jetpack_base", "default:diamondblock"},
            {"default:mese", "default:goldblock", "default:mese"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
  end
  if minetest.get_modpath("mcl_core") then
    minetest.register_craft({
    output = "jetpack:jetpack_base",
    recipe = {
        {"mcl_core:ironblock", "mcl_minecarts:chest_minecart", "mcl_core:ironblock"},
        {"mcl_core:gold_ingot", "mcl_core:diamondblock", "mcl_core:gold_ingot"},
        {"mcl_core:lapisblock", "mcl_core:emeraldblock", "mcl_core:lapisblock"},
    },
  })

  minetest.register_craft({
      output = "jetpack:jetpack",
      recipe = {
          {"mcl_core:gold_nugget", "jetpack:jetpack_base", "mcl_core:gold_nugget"},
          {"mcl_core:goldblock", "mcl_end:end_rod_green", "mcl_core:goldblock"},
          {"mcl_core:diamond", "mcl_potions:swiftness", "mcl_core:diamond"},
      },
  })

  minetest.register_craft({
      output = "jetpack:jetpack_gold",
      recipe = {
          {"mcl_core:diamondblock", "jetpack:jetpack_base", "mcl_core:diamondblock"},
          {"mcl_core:emeraldblock", "mcl_core:goldblock", "mcl_core:emeraldblock"},
          {"mcl_core:diamond", "mesecons:redstone", "mcl_core:diamond"},
      },
  })
  end
end

--Not sure if this is a hack, but it stops unkown items appearing if jetpack.crafts is set to false, while removing them from the creative inventory.
if jetpack_crafts == false then
    minetest.register_craftitem("jetpack:jetpack_base", {
        description = "Jetpack Tubes",
        inventory_image = "jetpack_base.png",
        groups = {not_in_creative_inventory = 1},
    })
end
