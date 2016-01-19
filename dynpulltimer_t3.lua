function(e, arg1)
	local _,_,_,_,_,name,_ = GetPlayerInfoByGUID(arg1)
	if name then
		local spec = GetInspectSpecialization(name)
		if WA_DPT_time_needed_from_spec[spec] >= WA_DPT_countdown then
			WA_DPT_countdown = WA_DPT_time_needed_from_spec[spec]
			EditMacro(WA_DPT_macro_name, nil, nil, string.format("/dbm pull %d", WA_DPT_countdown), 1, nil);
		else
			local n = GetNumGroupMembers() or 0
			local largest = 0
			for i=1,n do
				local raider = GetRaidRosterInfo(i)
				if _G["GExRT"].A["InspectViewer"].db.inspectDB[raider] and _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec and name ~= raider then
					local s = _G["GExRT"].A["InspectViewer"].db.inspectDB[raider].spec;
					if WA_DPT_time_needed_from_spec[s] > largest then
						largest = WA_DPT_time_needed_from_spec[s]
					end
				end
			end
			if largest == 0 then
				largest = WA_DPT_time_needed_from_spec[spec]
			end
			if largest < WA_DPT_countdown then
				WA_DPT_countdown = largest
				EditMacro(WA_DPT_macro_name, nil, nil, string.format(WA_DPT_macro_body_text, WA_DPT_countdown), 1, nil);
			end
		end
	end
end

