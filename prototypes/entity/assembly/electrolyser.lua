-- Copyright (c) 2020 Kirazy
-- Part of Reskins: Bob's Mods
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobassembly"] then return end
if settings.startup["reskins-bobs-do-bobassembly"].value == false then return end

-- Set input parameters
local inputs = 
{
    type = "assembling-machine",
    root_name = "electrolyser",
    base_entity = "chemical-plant", -- Electrolyser will use Chemical Plant as a reference for explosion
    directory = reskins.bobs.directory,
    mod = "assembly",
    particles = {["big"] = 1, ["medium"] = 2},
    make_remnants = false,
    make_icons = false,
}

local tier_map =
    {
        ["electrolyser"]   = {1, 1, 1},
        ["electrolyser-2"] = {2, 2, 2},
        ["electrolyser-3"] = {3, 3, 3},
        ["electrolyser-4"] = {4, 4, 3},
        ["electrolyser-5"] = {5, 5, 5}
    }

-- Reskin entities, create and assign extra details
for name, map in pairs(tier_map) do
    -- Fetch entity
    entity = data.raw[inputs.type][name]

    -- Check if entity exists, if not, skip this iteration
    if not entity then
        goto continue
    end
    
    -- Parse map
    tier = map[1]
    subtier = map[2]
    shadow = map[3]

    -- Map entity to name used internally
    inputs.internal_name = inputs.root_name.."-"..tier

    -- Determine what tint we're using
    inputs.tint = reskins.lib.tint_index["tier-"..tier]
  
    reskins.lib.setup_standard_entity(name, tier, inputs)

    -- Reskin entities
    entity.animation = reskins.lib.make_4way_animation_from_spritesheet(
    {
        layers =
        {
            -- Base
            {
                filename = inputs.directory.."/graphics/entity/assembly/electrolyser/electrolyser-"..subtier.."-base.png",
                width = 136,
                height = 130,
                frame_count = 1,
                shift = util.by_pixel(17, 0),
                hr_version = 
                {
                    filename = inputs.directory.."/graphics/entity/assembly/electrolyser/hr-electrolyser-"..subtier.."-base.png",
                    width = 272,
                    height = 260,
                    frame_count = 1,
                    shift = util.by_pixel(17, 0),
                    scale = 0.5
                }
            },
            -- Mask
            {
                filename = inputs.directory.."/graphics/entity/assembly/electrolyser/electrolyser-"..subtier.."-mask.png",
                width = 136,
                height = 130,
                frame_count = 1,
                shift = util.by_pixel(17, 0),
                tint = inputs.tint,
                hr_version = 
                {
                    filename = inputs.directory.."/graphics/entity/assembly/electrolyser/hr-electrolyser-"..subtier.."-mask.png",
                    width = 272,
                    height = 260,
                    frame_count = 1,
                    shift = util.by_pixel(17, 0),
                    tint = inputs.tint,
                    scale = 0.5
                }
            },
            -- Highlights
            {
                filename = inputs.directory.."/graphics/entity/assembly/electrolyser/electrolyser-"..subtier.."-highlights.png",
                width = 136,
                height = 130,
                frame_count = 1,
                shift = util.by_pixel(17, 0),
                blend_mode = "additive",
                hr_version = 
                {
                    filename = inputs.directory.."/graphics/entity/assembly/electrolyser/hr-electrolyser-"..subtier.."-highlights.png",
                    width = 272,
                    height = 260,
                    frame_count = 1,
                    shift = util.by_pixel(17, 0),
                    blend_mode = "additive",
                    scale = 0.5
                }
            },
            -- Shadow
            {
                filename = inputs.directory.."/graphics/entity/assembly/electrolyser/electrolyser-"..shadow.."-shadow.png",
                width = 136,
                height = 130,
                frame_count = 1,
                shift = util.by_pixel(17, 0),
                draw_as_shadow = true,
                hr_version = 
                {
                    filename = inputs.directory.."/graphics/entity/assembly/electrolyser/hr-electrolyser-"..shadow.."-shadow.png",
                    width = 272,
                    height = 260,
                    frame_count = 1,
                    shift = util.by_pixel(17, 0),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    })

    -- Label to skip to next iteration
    ::continue::
end