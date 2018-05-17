# Usage
```lua
local promises = require(1788151932)

local promise = promises.new(workspace.ChildAdded, "WorkspaceChildListener")
-- self::new(RBXScriptSignal Signal, String Name)
-- returns:
---\\ table[RBXScriptSignal onComplete, function cancel]

promise.onComplete:Connect(function(child) -- Promise will run once then end
	print("omgosh, workspace had a baby!!! and", child, "is his name-o")
end)
---\\ additionally:
promise.cancel()
---\\ will terminate the current promise

local listener = promises:CreateListener(game.Players.PlayerAdded, "PlayerJoined", script)
-- self::CreateListener(RBXScriptSignal Signal, String Name, Object Storage = false)
-- returns:
---\\ table[RBXScriptSignal onRun, function cancel]

listener.onRun:Connect(function(player) -- Listener will run every time the event is fired
	print("Welcome", player, "to the game!")
end)
---\\ additionally:
listener.cancel()
---\\ will terminate the current listener
```
