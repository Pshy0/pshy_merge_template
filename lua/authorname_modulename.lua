--- authorname_modulename.lua
--
-- Module description.
--
-- @author TFM:authorname#0000 DC:authorname#8263
--
-- @require pshy_essentials.lua
-- @require pshy_perms.lua
-- @require pshy_version.lua



--- TFM Settings:
--system.disableChatCommandDisplay(nil, true)
--tfm.exec.disableAfkDeath(true)
--tfm.exec.disableAutoNewGame(true)
--tfm.exec.disableAutoScore(true)
--tfm.exec.disableAutoShaman(true)
--tfm.exec.disableAutoTimeLeft(true)
--tfm.exec.disableDebugCommand(true)
--tfm.exec.disableMinimalistMode(true)
--tfm.exec.disablePhysicalConsumables(true)



--- pshy_merge settings:
-- from `pshy_mapinfo.lua`:
--pshy.mapinfo_max_grounds = 50							-- Set the maximum amount of grounds parsed by `pshy_mapinfo`.
-- from `pshy_newgame.lua`:
--pshy.newgame_update_map_name_on_new_player = true		-- Enable or disable updating UI informations for new players.
-- from `pshy_perms.lua`:
pshy.authors[105766424] = "Pshy#3752"					-- Replace with your account id (`!accountid`) and nickname.
pshy.perms_auto_admin_authors = false					-- Allow the use of `!adminme` for authors in funcorp rooms.
-- from `pshy_version.lua`:
pshy.version_days_before_update_suggested = 14			-- How old the script should be before suggesting an update (`nil` to disable).
pshy.version_days_before_update_advised = 30			-- How old the script should be before requesting an update (`nil` to disable).
pshy.version_days_before_update_required = nil			-- How old the script should be before refusing to start (`nil` to disable).



function eventInit()
	print("This is the pshy_merge template example.")
	--pshy.newgame_SetRotation("#17")
	--tfm.exec.newGame()
end
