-- Copyright (c) 2021 Kirazy
-- Part of Artisanal Reskins: Bob's Mods
--
-- See LICENSE in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not (reskins.bobs and reskins.bobs.triggers.equipment.technologies) then return end

local inputs = {
    type = "energy-shield-equipment",
    icon_name = "energy-shield",
    mod = "bobs",
    group = "equipment",
}

-- Setup defaults
reskins.lib.parse_inputs(inputs)

local batteries = {
    ["energy-shield-equipment"] = {tier = 0},
    ["energy-shield-mk2-equipment"] = {tier = 1},
    ["energy-shield-mk3-equipment"] = {tier = 2},
    ["energy-shield-mk4-equipment"] = {tier = 3},
    ["energy-shield-mk5-equipment"] = {tier = 4},
    ["energy-shield-mk6-equipment"] = {tier = 5},
}

-- Reskin equipment
for name, map in pairs(batteries) do
    -- Fetch equipment
    local equipment = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not equipment then goto continue end

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index[map.tier]

    -- Construct icon
    reskins.lib.construct_icon(name, map.tier, inputs)

    -- Reskin the equipment
    equipment.sprite = {
        layers = {
            -- Base
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/energy-shield/energy-shield-equipment-base.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
            },
            -- Mask
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/energy-shield/energy-shield-equipment-mask.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                tint = inputs.tint,
            },
            -- Highlights
            {
                filename = reskins.bobs.directory.."/graphics/equipment/equipment/energy-shield/energy-shield-equipment-highlights.png",
                size = 64,
                priority = "medium",
                flags = { "no-crop" },
                blend_mode = reskins.lib.blend_mode, -- "additive",
            }
        }
    }

    -- Label to skip to next iteration
    ::continue::
end