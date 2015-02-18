dofile(minetest.get_modpath("wings") .. "/config.lua")
if wings.fast == true then
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

minetest.register_craftitem("wings:wings", {
    description = "Wings",
    inventory_image = "wings.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        playereffects.apply_effect_type("fly", wings.time, user)
        itemstack:take_item()
        return itemstack
    end,
})

minetest.register_craftitem("wings:wings_bronze", {
    description = "Bronze Wings",
    inventory_image = "wings_bronze.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        playereffects.apply_effect_type("fly", wings.time_bronze, user)
        itemstack:take_item()
        return itemstack
    end,
})

minetest.register_craftitem("wings:wings_gold", {
    description = "Gold Wings",
    inventory_image = "wings_gold.png",
    stack_max = 1,
    on_use = function(itemstack, user, pointed_thing)
        playereffects.apply_effect_type("fly", wings.time_gold, user)
        itemstack:take_item()
        return itemstack
    end,
})

if wings.crafts == true and minetest.get_modpath("default") ~= nil then
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