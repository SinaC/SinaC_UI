local ADDON_NAME, ns = ...

if not ns.HealiumEnabled then return end

-- Get HealiumCore
local H = unpack(HealiumCore)

-- Get Tukui
local T, C, L = unpack(Tukui)

-------------------------------------------------------
-- Grid healium
-------------------------------------------------------
-- TODO: move this to config file
local healthHeight = 27
local buttonSize = 20
local buttonByRow = 5
local buffSize = 16
local debuffSize = 16
local initialWidth = buttonByRow*buttonSize
local initialHeight = 2*buttonSize + healthHeight
-- only one debuff inside frame
-- x rows of y buttons below frame
-- buff inside frame
-- ______________
-- |     DD      |
-- | _BB_BB_BB_BB|
-- HH HH HH HH HH
-- HH HH HH HH HH
-- HH HH HH HH HH
-- BB: buff
-- DD: debuff
-- HH: button
local function CreateHealiumGridButton(parent, name, size, anchor)
	-- frame
	local button = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	button:CreatePanel("Default", size, size, unpack(anchor))
	button:SetFrameLevel(9)
	button:SetFrameStrata(parent:GetFrameStrata())
	button:SetBackdrop(nil)
	-- texture setup, texture icon is set in UpdateFrameButtons
	button.texture = button:CreateTexture(nil, "ARTWORK")
	button.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.texture:SetPoint("TOPLEFT", button ,"TOPLEFT", 0, 0)
	button.texture:SetPoint("BOTTOMRIGHT", button ,"BOTTOMRIGHT", 0, 0)
	button:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
	button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	button.texture:SetVertexColor(1, 1, 1)
	-- button:SetBackdropColor(0, 0, 0)
	-- button:SetBackdropBorderColor(0, 0, 0)
	-- cooldown overlay
	button.cooldown = CreateFrame("Cooldown", "$parentCD", button, "CooldownFrameTemplate")
	button.cooldown:SetAllPoints(button.texture)
	return button
end

local function CreateHealiumGridDebuff(parent, name, size, anchor)
	-- frame
	local debuff = CreateFrame("Frame", name, parent) -- --debuff = CreateFrame("Frame", debuffName, parent, "TargetDebuffFrameTemplate")
	debuff:CreatePanel("Default", size, size, unpack(anchor))
	debuff:SetFrameLevel(9)
	debuff:SetFrameStrata(parent:GetFrameStrata())
	-- icon
	debuff.icon = debuff:CreateTexture(nil, "ARTWORK")
	--debuff.icon:SetAllPoints(debuff)
	debuff.icon:Point("TOPLEFT", 1, -1)
	debuff.icon:Point("BOTTOMRIGHT", -1, 1)
	debuff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	-- cooldown
	debuff.cooldown = CreateFrame("Cooldown", "$parentCD", debuff, "CooldownFrameTemplate")
	debuff.cooldown:SetAllPoints(debuff)
	debuff.cooldown:SetReverse()
	-- count
	debuff.count = debuff:CreateFontString("$parentCount", "OVERLAY")
	debuff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	debuff.count:Point("BOTTOMRIGHT", 1, -1)
	debuff.count:SetJustifyH("CENTER")
	-- debuff:SetAlpha(0.1)
	-- debuff.icon:SetAlpha(0.1)

	-- we can set framelevel to 3 (parent.Health:GetFrameLevel()) and ARTWORK to OVERLAY --> player name and debuff cooldown/count are shown over debuff icon
	return debuff
end

local function CreateHealiumGridBuff(parent, name, size, anchor)
	-- frame
	local buff = CreateFrame("Frame", name, parent) --buff = CreateFrame("Frame", buffName, frame, "TargetBuffFrameTemplate")
	buff:CreatePanel("Default", size, size, unpack(anchor))
	buff:SetFrameLevel(9)
	buff:SetFrameStrata(parent:GetFrameStrata())
	buff:SetBackdrop(nil)
	-- icon
	buff.icon = buff:CreateTexture(nil, "ARTWORK")
	buff.icon:SetAllPoints(buff)
	buff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	-- cooldown
	buff.cooldown = CreateFrame("Cooldown", "$parentCD", buff, "CooldownFrameTemplate")
	buff.cooldown:SetAllPoints(buff)
	buff.cooldown:SetReverse()
	-- count
	buff.count = buff:CreateFontString("$parentCount", "OVERLAY")
	buff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	buff.count:Point("BOTTOMRIGHT", 1, -1)
	buff.count:SetJustifyH("CENTER")
	return buff
end

local function ButtonAnchor(frame, buttonList, index)
	-- Matrix-positioning
	local buttonSpacing = 0
	local buttonAnchor = {"TOPLEFT", frame.Health, "BOTTOMLEFT", 0, 0}
	if index == 1 then
		return buttonAnchor
	elseif (index % buttonByRow) == 1 then
		return {"TOPLEFT", buttonList[index-buttonByRow], "BOTTOMLEFT", 0, -buttonSpacing}
	else
		return {"TOPLEFT", buttonList[index-1], "TOPRIGHT", buttonSpacing, 0}
	end
end

local function DebuffAnchor(frame, debuffList, index)
	-- Fixed-positioning
	return {"BOTTOMLEFT", frame.Health, "BOTTOMLEFT", 10, 1}
end

local function BuffAnchor(frame, buffList, index)
	-- Line-positioning
	local buffSpacing = 0
	local buffAnchor = {"BOTTOMRIGHT", frame.Health, "BOTTOMRIGHT", -1, 1}
	if index == 1 then
		return buffAnchor
	else
		local anchor = {"TOPRIGHT", buffList[index-1], "TOPLEFT", -buffSpacing, 0}
		return anchor
	end
end

local HealiumGridStyle = {
	CreateButton = CreateHealiumGridButton,
	CreateDebuff = CreateHealiumGridDebuff,
	CreateBuff = CreateHealiumGridBuff,
	GetButtonAnchor = ButtonAnchor,
	GetDebuffAnchor = DebuffAnchor,
	GetBuffAnchor = BuffAnchor,
	buttonSize = buttonSize,
	debuffSize = debuffSize,
	buffSize = buffSize,
	buttonSpacing = 0,
	debuffSpacing = 0,
	buffSpacing = 0,
	priorityDebuff = true
}
H:RegisterStyle("TukuiHealiumGrid", HealiumGridStyle)