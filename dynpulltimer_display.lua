-- Dynamic pull timer
--
-- REQUIRED: This weakaura requires exorsus raid tools.
--
-- Generates a non character specific macro called WA_DPT_pull_macro
-- with body "/ert pull x", where x is set to the highest preparation
-- time for all specs in the raid. I.e., if there is an affliction warlock
-- in the raid, x = 22.
--
-- More info:
-- https://github.com/karlarvidsson/wow-dynamic-pull-timer

function()
    if WA_DPT_countdown then
        return string.format("%d", WA_DPT_countdown)
    end
    return string.format("%d", 10)
end

