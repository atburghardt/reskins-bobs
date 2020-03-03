-- Copyright (c) 2020 Kirazy
-- Part of Reskin Series: Bob's Structures
--     
-- See LICENSE.md in the project directory for license information.

-- Check to see if reskinning needs to be done.
if not mods["bobpower"] then return end
if settings.startup["bobmods-power-heatsources"].value == false then return end
if settings.startup["reskin-series-do-bobpower"].value == false then return end 

-- burner-reactor
-- burner-reactor-2
-- burner-reactor-3
-- fluid-reactor
-- fluid-reactor-2
-- fluid-reactor-3