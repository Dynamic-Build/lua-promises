local pstorage = {}
local promises = {
	["CreateListener"] = function(Signal, Name, Storage)
		assert(typeof(Signal) == "RBXScriptSignal", "Argument #1 to self::CreateListener must be an RBXScriptSignal")
		local be = Instance.new("BindableEvent")
		if type(Storage) == "Instance" then be.Parent = Storage end
		pstorage[Name] = be
		spawn(function()
			while wait() do
				local function con(...)
					be:Fire(...)
				end
				if not pcall(function()Signal:Disconnect(con)Signal:Connect(con)end) then break end
			end
			pstorage[Name] = nil
		end)
		return
		{
			["onRun"] = be.Event,
			["cancel"] = function()
				be:Destroy()
			end
		}
	end,
	["CancelAll"] = function()
		for i,v in pairs(pstorage) do
			pcall(function()v:Destroy()end)
		end
	end,
	["new"] = function(Signal, Name)
		assert(typeof(Signal) == "RBXScriptSignal", "Argument #1 to self::new must be an RBXScriptSignal")
		local be = Instance.new("BindableEvent")
		pstorage[Name] = be
		spawn(function()
			while wait() do
				local function con(...)
					be:Fire(...)
					error()
				end
				if not pcall(function()Signal:Disconnect(con)Signal:Connect(con)end) then break end
			end
			pstorage[Name] = nil
		end)
		return
		{
			["onComplete"] = be.Event,
			["cancel"] = function()
				be:Destroy()
			end
		}
	end
}
promises.New = promises.new
promises.createListener = promises.CreateListener
return promises
