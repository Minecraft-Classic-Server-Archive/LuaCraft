PLUGIN:SetName("Plugin Unloader");

-- On player chat
function HandleChat(player)		
	-- Get what they said
	local chatMsg = player:GetLastChat();
	
	-- Parse text for command
	if chatMsg == "/unload" then
		player:SendMessage("&eInvalid format! Use /unload <plugin_name>");
	elseif chatMsg:sub(1,8) == "/unload " then
		target = GetPluginByName(chatMsg:sub(9));
		if not target then
			player:SendMessage("&eCould not find plugin: &2"..chatMsg:sub(9));
			return;
		end
		print("Player ["..player:GetName().."] unloaded plugin ["..target.PLUGIN:GetName().."]");
		player:SendMessage("&eYou have unloaded the plugin: &2"..target.PLUGIN:GetName());
		target.PLUGIN:Unload();
	end
	
end
PLUGIN:AddHook("OnPlayerChat", "HandleChat");

-- Add manual entry
function PluginsLoaded()
	if GetPluginByName("Manual") then
		local ok, msg = pcall(GetPluginByName("Manual").AddMan, "unload", "Use /unload <plugin_name> to unload that plugin");
		if not ok then error(msg) end
	end
end
PLUGIN:AddHook("OnPluginsLoaded", "PluginsLoaded");