local function script1()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/NorQueloid/sabsourcesforvids/refs/heads/main/invis.lua'))()
end
local function script2()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/NorQueloid/sab/refs/heads/main/Leavepreventer.lua'))()
end

task.spawn(script1)
task.spawn(script2)
