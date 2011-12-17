local ADDON_NAME, ns = ...

local SinaCUI = ns.SinaCUI
local Private = ns.SinaCUI.Private

function Private.print(...)
	print("|cFF148587SinaC UI:|r", ...)
end

function Private.error(...)
	Private.print("|cffff0000Error:|r "..string.format(...))
end
