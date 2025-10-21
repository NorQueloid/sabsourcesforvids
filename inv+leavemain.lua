local function script1()
    loadstring(game:HttpGet('https://api.luarmor.net/files/v3/loaders/2341c827712daf923191e93377656f67.lua'))()
end
local function script2()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/NorQueloid/sab/refs/heads/main/Leavepreventer.lua'))()
end

task.spawn(script1)
task.spawn(script2)
