Goto = function(args)
	-- Find who we want to teleport to
	local currentPlayer = args.player
	local destPlayerName = string.match(args.text, "/goto (.+) ")

	-- Only allow teleports if destPlayer is in default world
	if currentPlayer:GetWorld() ~= DefaultWorld then
		Chat:Send(currentPlayer, "You're not in the default world", settings.textColour)
		return false
	end

	if destPlayerName then
		-- Teleport to the specified player
		for destPlayer in Server:GetPlayers() do
			if destPlayerName == destPlayer:GetName() then
				-- Only allow teleports if destination destPlayers are in the default world
				if destPlayer:GetWorld() ~= DefaultWorld then
					Chat:Send(currentPlayer, destPlayerName .. " is not in default world", settings.textColour)
					return false
				end

				-- Notify player they are teleporting
				Chat:Send(currentPlayer, "Teleporting to " .. destPlayerName, settings.textColour)

				-- Notify destination player someone is teleporting to them
				Chat:Send(destPlayer, currentPlayer:GetName() .. " is teleporting to you", settings.textColour)

				-- Teleport
				currentPlayer:SetPosition(destPlayer:GetPosition())

				return false
			end
		end
	end

	Chat:Send(currentPlayer, "Player \"" .. destPlayerName .. "\" does not exist", settings.textColour)
	return true
end

Events:Subscribe("PlayerChat", Goto)

