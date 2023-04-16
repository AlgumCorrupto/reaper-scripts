--TODO-----------------------------------------------------------
--add: a user interface using ReaImGui
-----------------------------------------------------------------

function MakeRepeat(periodSize, startingPoint, noteNames, trackID)
    local repeatingPoints = {};
    local lessThanStaringPoint = 0;
    local names = {}

    -- Get all the pitch repeating points and store them in a array
    for check = startingPoint, 0 - periodSize, -periodSize do
        table.insert(repeatingPoints, 1, check)
    end
    for check = startingPoint, (127+periodSize), periodSize do
        table.insert(repeatingPoints, check)
    end

    reaper.ShowConsoleMsg(#repeatingPoints)
    reaper.ShowConsoleMsg("\n")


    -- Set note names 
    for i = 1, #repeatingPoints, 1 do
        local limit
        local start
        local k = 1;
        local pitch = 0

        if (repeatingPoints[i] < 0) then
            pitch = 0
            -- Ex. -16 -(-16) = -16 + 16
            for start = (0 - repeatingPoints[i]), periodSize-1, 1 do 
                reaper.SetTrackMIDINoteNameEx(0, reaper.GetTrack(0, trackID), pitch, -1, noteNames[start+1]);
                pitch = pitch + 1;
            end
        else if ((repeatingPoints[i] + periodSize-1) > 127) then
            limit = 127 - repeatingPoints[i];
            pitch = repeatingPoints[i]
            for j = 0, limit, 1 do
                reaper.SetTrackMIDINoteNameEx(0, reaper.GetTrack(0, trackID), pitch, -1, noteNames[k])
                reaper.ShowConsoleMsg(pitch);
                k = k + 1;
                pitch = pitch + 1
            end
            reaper.ShowConsoleMsg("\n")
        else
            pitch = repeatingPoints[i]
            for j = 0, periodSize-1, 1 do
                reaper.SetTrackMIDINoteNameEx(0, reaper.GetTrack(0, trackID), pitch, -1, noteNames[k])
                reaper.ShowConsoleMsg(pitch);
                k = k + 1;
                pitch = pitch + 1
            end                
          end
        end
      
    end
end

--USER CONFIGURATION-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Period Size Ex. in 22 EDO period Size is 22
local pSize = 22
-- Starting Point (recomended setting it as note 60 (middle C))
local sPoint = 60;
-- Here you set the note names 
local noteNames = {"1/22", "2/22", "3/22", "4/22", "5/22", "6/22", "7/22", "8/22", "9/22", "10/22", "11/22", "12/22", "13/22", "14/22", "15/22", "16/22", "17/22" ,"18/22" ,"19/22" ,"20/22", "21/22", "22/22"};
-- Here You set the track for the script be applied (first is 0, second is 1 and so on)
local trackID = 0

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- finally here's the function call
MakeRepeat(pSize, sPoint, noteNames, trackID)