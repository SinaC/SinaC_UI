-------------------------------------------------------
-- Normal healium
-------------------------------------------------------

local ADDON_NAME, ns = ...
local SinaCUI = ns.SinaCUI
if not SinaCUI.HealiumEnabled then return end

local Private = SinaCUI.Private
local T, C, L = unpack(Tukui)
local H = unpack(HealiumCore)

-- local backdropr, backdropg, backdropb = unpack(C["media"].backdropcolor)
-- local backdropa = 1
-- local borderr, borderg, borderb = unpack(C["media"].bordercolor)


-- BB BB UnitFrame HH HH HH DD DD DD
-- BB: buff
-- DD: debuff
-- HH: button
--[[
local function CreateHealiumButton(parent, name, size, anchor)
	-- frame
	local button = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")--"SecureActionButtonTemplate, ActionButtonTemplate")
	button:CreatePanel("Default", size, size, unpack(anchor))
	-- texture setup, texture icon is set in UpdateFrameButtons
	button.texture = button:CreateTexture(nil, "ARTWORK")
	button.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.texture:SetPoint("TOPLEFT", button ,"TOPLEFT", 0, 0)
	button.texture:SetPoint("BOTTOMRIGHT", button ,"BOTTOMRIGHT", 0, 0)
	button:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
	button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	button.texture:SetVertexColor(1, 1, 1)
	button:SetBackdropColor(0.6, 0.6, 0.6)
	button:SetBackdropBorderColor(0.1, 0.1, 0.1)
	-- cooldown overlay
	button.cooldown = CreateFrame("Cooldown", "$parentCD", button, "CooldownFrameTemplate")
	button.cooldown:SetAllPoints(button.texture)
	return button
end

local function CreateHealiumDebuff(parent, name, size, anchor)
	-- frame
	local debuff = CreateFrame("Frame", name, parent) -- --debuff = CreateFrame("Frame", debuffName, parent, "TargetDebuffFrameTemplate")
	debuff:CreatePanel("Default", size, size, unpack(anchor))
	-- icon
	debuff.icon = debuff:CreateTexture(nil, "ARTWORK")
	debuff.icon:Point("TOPLEFT", 2, -2)
	debuff.icon:Point("BOTTOMRIGHT", -2, 2)
	debuff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	-- cooldown
	debuff.cooldown = CreateFrame("Cooldown", "$parentCD", debuff, "CooldownFrameTemplate")
	debuff.cooldown:SetAllPoints(debuff.icon)
	debuff.cooldown:SetReverse()
	-- count
	debuff.count = debuff:CreateFontString("$parentCount", "OVERLAY")
	debuff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	debuff.count:Point("BOTTOMRIGHT", 1, -1)
	debuff.count:SetJustifyH("CENTER")
	return debuff
end

local function CreateHealiumBuff(parent, name, size, anchor)
	-- frame
	local buff = CreateFrame("Frame", name, parent) --buff = CreateFrame("Frame", buffName, frame, "TargetBuffFrameTemplate")
	buff:CreatePanel("Default", size, size, unpack(anchor))
	-- icon
	buff.icon = buff:CreateTexture(nil, "ARTWORK")
	buff.icon:Point("TOPLEFT", 2, -2)
	buff.icon:Point("BOTTOMRIGHT", -2, 2)
	buff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	-- cooldown
	buff.cooldown = CreateFrame("Cooldown", "$parentCD", buff, "CooldownFrameTemplate")
	buff.cooldown:SetAllPoints(buff.icon)
	buff.cooldown:SetReverse()
	-- count
	buff.count = buff:CreateFontString("$parentCount", "OVERLAY")
	buff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	buff.count:Point("BOTTOMRIGHT", 1, -1)
	buff.count:SetJustifyH("CENTER")
	return buff
end
--]]

local function SkinHealiumButton(frame, button)
	local size = frame:GetHeight()
	button:SetTemplate("Default")
	button:SetSize(size, size)
	button:SetFrameLevel(1)
	button:SetFrameStrata("BACKGROUND")
	button.texture:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	button.texture:ClearAllPoints()
	button.texture:Point("TOPLEFT", button ,"TOPLEFT", 0, 0)
	button.texture:Point("BOTTOMRIGHT", button ,"BOTTOMRIGHT", 0, 0)
	button:SetPushedTexture("Interface/Buttons/UI-Quickslot-Depress")
	button:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square")
	button.texture:SetVertexColor(1, 1, 1)
	--button:SetBackdrop(nil)
	button:SetBackdropColor(0.6, 0.6, 0.6)
	button:SetBackdropBorderColor(0.1, 0.1, 0.1)
	--print("backdrop: "..tostring(backdropr).."  "..tostring(backdropg).."  "..tostring(backdropb))
	--print("border: "..tostring(borderr).."  "..tostring(borderg).."  "..tostring(borderb))
	--button:SetBackdropColor(backdropr, backdropg, backdropb, backdropa)
	--button:SetBackdropBorderColor(borderr,borderg, borderb)
end

local function SkinHealiumDebuff(frame, debuff)
	local size = frame:GetHeight()
	debuff:SetTemplate("Default")
	debuff:SetSize(size, size)
	debuff:SetFrameLevel(1)
	debuff:SetFrameStrata("BACKGROUND")
	debuff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	debuff.icon:ClearAllPoints()
	debuff.icon:Point("TOPLEFT", 2, -2)
	debuff.icon:Point("BOTTOMRIGHT", -2, 2)
	debuff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	debuff.count:ClearAllPoints()
	debuff.count:Point("BOTTOMRIGHT", 1, -1)
	debuff.count:SetJustifyH("CENTER")
end

local function SkinHealiumBuff(frame, buff)
	local size = frame:GetHeight()
	buff:SetTemplate("Default")
	buff:SetSize(size, size)
	buff:SetFrameLevel(1)
	buff:SetFrameStrata("BACKGROUND")
	buff.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	buff.icon:ClearAllPoints()
	buff.icon:Point("TOPLEFT", 2, -2)
	buff.icon:Point("BOTTOMRIGHT", -2, 2)
	buff.count:SetFont(C["media"].uffont, 14, "OUTLINE")
	buff.count:ClearAllPoints()
	buff.count:Point("BOTTOMRIGHT", 1, -1)
	buff.count:SetJustifyH("CENTER")
end

local HealiumNormalStyle = {
	--CreateButton = CreateHealiumButton,
	--CreateDebuff = CreateHealiumDebuff,
	--CreateBuff = CreateHealiumBuff,
	SkinButton = SkinHealiumButton,
	SkinDebuff = SkinHealiumDebuff,
	SkinBuff = SkinHealiumBuff,
}
H:RegisterStyle("TukuiHealiumNormal", HealiumNormalStyle)