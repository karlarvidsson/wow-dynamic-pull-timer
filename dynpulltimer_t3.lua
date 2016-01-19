function(e, arg1)
    print(e)
   -- print(arg1)
	local _,_,_,race,_,name,realm = GetPlayerInfoByGUID(arg1)
	print(name)
	if name then
		local spec = GetInspectSpecialization(name)
		print("spec:", spec, "new time:", WA_DPT_time_needed_from_spec[spec], "old time:", WA_DPT_countdown)
		if WA_DPT_time_needed_from_spec[spec] >= WA_DPT_countdown then
			WA_DPT_countdown = WA_DPT_time_needed_from_spec[spec]
			EditMacro(WA_DPT_macro_name, nil, nil, string.format("/dbm pull %d", WA_DPT_countdown), 1, nil);
			print("countdown updated from talent trigger", WA_DPT_countdown)
		else
			local n = GetNumGroupMembers() or 0
			print("n:",n)
			local largest = 0
			for i=1,n do
				local raider = GetRaidRosterInfo(i)
				print("i:", i, "raider:",raider)
				
				print(name, raider)
			--	if _G["GExRT"].A["InspectViewer"].db.inspectDB[raider] then
			--		print(_G["GExRT"].A["InspectViewer"].db.inspectDB[raider])
			--		if _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec then
			--			print(_G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec)
			--		end
			--	end
				
				if _G["GExRT"].A["InspectViewer"].db.inspectDB[raider] and _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec and name ~= raider then
					local s = _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec;
					local _,spec_name,_ = GetSpecializationInfoByID(s)
					print("player:", raider, " spec:", s, spec_name, "time needed:", WA_DPT_time_needed_from_spec[s])
					if WA_DPT_time_needed_from_spec[s] > largest then
						largest = WA_DPT_time_needed_from_spec[s]
					end
				end
			end
			print("largest:", largest, "WA_DPT_countdown:",WA_DPT_countdown)
			if largest == 0 then
				print("spec changer was the only one found, going with time needed for new spec")
				largest = WA_DPT_time_needed_from_spec[spec]
			end
			if largest < WA_DPT_countdown then
				print("this player was probably the cause of higher timer, changing to new highest:", largest)
				WA_DPT_countdown = largest
				EditMacro(WA_DPT_macro_name, nil, nil, string.format("/dbm pull %d", WA_DPT_countdown), 1, nil);
			end
		end
	end
end

