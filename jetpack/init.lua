dofile(minetest.get_modpath("jetpack") .. "/config.lua")
if jetpack.fast == true then
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
            playereffects.apply_effect_type("flyj", jetpack.time, user)
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
            playereffects.apply_effect_type("flyj", jetpack.time_bronze, user)
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
            playereffects.apply_effect_type("flyj", jetpack.time_gold, user)
            itemstack:take_item()
            return itemstack
        end
    end,
})

if jetpack.crafts == true and minetest.get_modpath("default") ~= nil then
    minetest.register_craftitem("jetpack:jetpack_base", {
        description = "Jetpack Tubes",
        inventory_image = "jetpack_base.png",
    })
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

--Not sure if this is a hack, but it stops unkown items appearing if jetpack.crafts is set to false, while removing them from the creative inventory.
if jetpack.crafts == false then
    minetest.register_craftitem("jetpack:jetpack_base", {
        description = "Jetpack Tubes",
        inventory_image = "jetpack_base.png",
        groups = {not_in_creative_inventory = 1},
    })
end
