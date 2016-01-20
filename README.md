# Dynamic Pull Timer (DPT)
http://www.curse.com/addons/wow/dynamic-pull-timer
World of Warcraft addon for automatic dynamic pull timer based on exorsus raid tools.

REQUIRED: This addon requires exorsus raid tools (DPT uses help from ExRT to know what specs are currently in the raid).

This addon automatically decides on a pre pull preparation time based on specs in the raid, and then calls "/ert pull x", where x is set to the highest preparation time for all specs in the raid. I.e., if there are affliction warlocks in the raid, the pull timer will be set to 22 seconds unless some other spec requires even more time. <br>
<br>
### Usage:
"/dpt" to initiate pull. This is equivalent to "/ert pull x", where x is the automatically determined pull time.<br>
<br>
### Settings:
For now, to make changes to the pull time needed for a spec, values must be manually edited in the addon's .lua file <br>
<br>Example: <br>
To change the pull time for arms warriors from 10 to 15 seconds, change the following line in DynamicPullTimer.lua: <br>
            [71] = 10,    -- Warrior: Arms <br>
to <br>
            [71] = 15,    -- Warrior: Arms <br>


<br>
