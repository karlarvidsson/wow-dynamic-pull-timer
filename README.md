# wow-dynamic-pull-timer
World of Warcraft dynamic pull timer based on weakauras2 and exorsus raid tools.

REQUIRED: This weakaura requires exorsus raid tools.

Generates a non character specific macro called WA_DPT_pull_macro with body "/ert pull x", where x is set to the highest preparation time for all specs in the raid. I.e., if there is an affliction warlock in the raid, x = 22. <br>
<br>
To make changes to the pull time needed for a spec, edit the table in the custom function of trigger 1 (dynpulltimer.lua). <br>
<br>Example: <br>
To change the pull time for arms warriors from 10 to 15 seconds, change the following line: <br>
            [71] = 10,    -- Warrior: Arms <br>
to <br>
            [71] = 15,    -- Warrior: Arms <br>


<br>
### Weakaura info:

Type: Icon<br>
Import string: Bottom of this page or importstring.txt

#### Display tab:
Display icon: Spell_Holy_BorrowedTime<br>
Text: %c<br>
Custom function: <a href="https://github.com/karlarvidsson/wow-dynamic-pull-timer/blob/master/dynpulltimer_display.lua">dynpulltimer_display.lua</a>  <br>
Size: 21<br>
Width: 40<br>
Height: 40<br>
#### Trigger tab:
Required for activation: any
##### Trigger 1:
Type: custom<br>
Event Type: Status<br>
Check on: every frame<br>
Custom Trigger: <a href="https://github.com/karlarvidsson/wow-dynamic-pull-timer/blob/master/dynpulltimer_t1.lua">dynpulltimer_t1.lua</a> 
##### Trigger 2:
Type: custom<br>
Event Type: Event<br>
Event: PLAYER_SPECIALIZATION_CHANGED<br>
Custom Trigger: <a href="https://github.com/karlarvidsson/wow-dynamic-pull-timer/blob/master/dynpulltimer_t2.lua">dynpulltimer_t2.lua</a> 
##### Trigger 3:
Type: custom<br>
Event Type: Event<br>
Event: INSPECT_READY<br>
Custom Trigger: <a href="https://github.com/karlarvidsson/wow-dynamic-pull-timer/blob/master/dynpulltimer_t3.lua">dynpulltimer_t3.lua</a> 

#### Import string:
<a href="https://github.com/karlarvidsson/wow-dynamic-pull-timer/blob/master/importstring.txt">Import string</a>
