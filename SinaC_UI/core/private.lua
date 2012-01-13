local ADDON_NAME, ns = ...
local T, C, L = unpack(Tukui)
local SinaCUI = ns.SinaCUI
local Private = ns.SinaCUI.Private

function Private.print(...)
	print("|cFF148587SinaC UI:|r", ...)
end

function Private.error(...)
	Private.print("|cFFFF0000Error:|r "..string.format(...))
end

function Private.warning(...)
	Private.print("|cFFFFFF00Warning:|r "..string.format(...))
end

local tekWarningDisplayed = false
local tekDebugFrame = tekDebug and tekDebug:GetFrame(ADDON_NAME) -- tekDebug support
function Private.debug(lvl, ...)
	--print(tostring(lvl).."  "..type(lvl).."  "..strjoin(" ", ...))
	local params = strjoin(" ", ...)
	if type(lvl) ~= "number" then
		Private.error("INVALID DEBUG (lvl not a number)"..params)
	end
	if C.general.debug and C.general.debug >= lvl then
		--local line = "|cFF148587SinaC UI|r:" .. params
		if tekDebugFrame then
			--tekDebugFrame:AddMessage(line)
			tekDebugFrame:AddMessage(params)
		else
			if not tekWarningDisplayed then
				Private.warning("tekDebug not found. Debug message disabled") -- TODO: localization
				tekWarningDisplayed = true
			end
		end
	end
end