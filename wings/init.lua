-- Fetch settings from settingtypes.txt or use default values
local wings_fast = minetest.settings:get_bool("wings.fast", false)
local wings_time = minetest.settings:get("wings.time") or 7
local wings_time_bronze = minetest.settings:get("wings.time_bronze") or 15
local wings_time_gold = minetest.settings:get("wings.time_gold") or 30
local wings_mana_divisor = minetest.settings:get("wings.mana_divisor") or 2
local wings_crafts = minetest.settings:get_bool("wings.crafts", true)
local wings_mana = minetest.settings:get("wings.mana") or 100
local wings_mana_bronze = minetest.settings:get("wings.mana_bronze") or 150
local wings_mana_gold = minetest.settings:get("wings.mana_gold") or 200

wings = {}
-- Register fly effect based on settings
if wings_fast == true then
    playereffects.register_effect_type("fly", "Fly mode available", "wings_plain.png", {"fly"},
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
    playereffects.register_effect_type("fly", "Fly mode available", "wings_plain.png", {"fly"},
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

-- Check for mana availability
wings.mana_check = function(player, cost)
    local allowed
    if minetest.get_modpath("mana") then
        if mana.subtract(player:get_player_name(), cost) then
            allowed = true
        else
            allowed = false
        end
    else
        allowed = true
    end
    return allowed
end

minetest.register_craftitem("wings:wings", {
    description = "Wings",
    inventory_image = "wings.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of these wings!")
        elseif minetest.get_modpath("mana") then
            if wings.mana_check(user, wings.mana) then
                playereffects.apply_effect_type("fly", wings_time / wings_mana_divisor, user)
            end
        else
            playereffects.apply_effect_type("fly", wings_time, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craftitem("wings:wings_bronze", {
    description = "Bronze Wings",
    inventory_image = "wings_bronze.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of these wings!")
        elseif minetest.get_modpath("mana") then
            if wings.mana_check(user, wings.mana_bronze) then
                playereffects.apply_effect_type("fly", wings_time_bronze / wings_mana_divisor, user)
            end
        else
            playereffects.apply_effect_type("fly", wings_time_bronze, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

minetest.register_craftitem("wings:wings_gold", {
    description = "Gold Wings",
    inventory_image = "wings_gold.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        local playername = user:get_player_name()
        local privs = minetest.get_player_privs(playername)
        if privs.fly == true then
            minetest.chat_send_player(playername, "You already have the fly priv, and so have no need of these wings!")
        elseif minetest.get_modpath("mana") then
            if wings.mana_check(user, wings.mana_gold) then
                playereffects.apply_effect_type("fly", wings_time_gold / wings_mana_divisor, user)
            end
        else
            playereffects.apply_effect_type("fly", wings_time_gold, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

if wings_crafts == true then
  if minetest.get_modpath("default") ~= nil then
    minetest.register_craft({
        output = "wings:wings",
        recipe = {
            {"default:diamond", "default:mese_crystal", "default:diamond"},
            {"default:mese_crystal", "default:steelblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "wings:wings_bronze",
        recipe = {
            {"default:diamondblock", "default:mese_crystal", "default:diamond"},
            {"default:mese", "default:bronzeblock", "default:mese_crystal"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
    minetest.register_craft({
        output = "wings:wings_gold",
        recipe = {
            {"default:diamondblock", "default:mese_crystal", "default:diamondblock"},
            {"default:mese", "default:goldblock", "default:mese"},
            {"default:diamond", "default:mese_crystal", "default:diamond"},
        },
    })
  end
if minetest.get_modpath("mcl_core") ~= nil then
    minetest.register_craft({
        output = "wings:wings",
        recipe = {
            {"mcl_core:diamond", "mesecons:redstone", "mcl_core:diamond"},
            {"mesecons:redstone", "mcl_core:ironblock", "mesecons:redstone"},
            {"mcl_core:diamond", "mesecons:redstone", "mcl_core:diamond"},
        },
    })
    minetest.register_craft({
        output = "wings:wings_gold",
        recipe = {
            {"mcl_core:diamondblock", "mesecons:redstone", "mcl_core:diamondblock"},
            {"mesecons:redstone", "mcl_core:goldblock", "mesecons:redstone"},
            {"mcl_core:diamond", "mesecons:redstone", "mcl_core:diamond"},
        },
    })
  end
end
