--Mage Nuggets 1.7 by B-Buck (Bbuck of Eredar)

local L = LibStub("AceLocale-3.0"):GetLocale("MageNuggets")

MageNugz = {
  spMonitorToggle = true;
  ssMonitorToggle = true;
  mageProcToggle = true;
  camZoomTogg = true;
  absorbToggle = true;
  mirrorImageToggle = true;
  waterEleToggle = true;
  evocationToggle = true;
  livingBombToggle = true;
  ScorchToggle = true;
  procMonitorToggle = true;
  arcaneBlastToggle = true;
  minimapToggle = true;
  polyToggle = true;
  spMonitorSize = 3;
  ssMonitorSize = 3;
  procMonitorSize = 3;
  livingBCounterSize = 3;
  lockFrames = false;
  borderStyle = 0;
  transColor = 0;
  consoleTextEnabled = true;
  slowfallMsg = L["Slowfall Cast On You"];
  slowfallMsg2 = L["Slowfall Cast On You"];
  slowfallMsg3 = L["Slowfall Cast On You"];
  focusMagicNotify = L["Focus Magic Cast On You"];
  focusMagicNotify2 = L["Focus Magic Cast On You"];
  focusMagicNotify3 = L["Focus Magic Cast On You"];
  focusMagicThanks = L["Thanks For Focus Magic"];
  focusMagicThanks2 = L["Thanks For Focus Magic"];
  innervatThanks = L["Thanks For The Innervate"];
  innervatThanks2 = L["Thanks For The Innervate"];
  backdropR = 0.0;
  backdropG = 0.0;
  backdropB = 0.0;
  backdropA = 0.0;
  MinimapPos = 45;
  miSound = "mirror.mp3";
  miSoundToggle = false;
  procSound = "proc.mp3";
  procSoundToggle = false;
}


local livingBombCount = 0;
local mirrorImageTime = 0;
local livingbombTime = 0;
local waterEleTime = 0;
local spellStealTog = 0;
local mageProcHSTime = 0;
local mageProcMBTime = 0;
local mageProcBFTime = 0
local fofProgMonTime = 0;
local mageImpProgMonTime = 0;
local combatTextCvar = GetCVar("enableCombatText");
local impactId = " ";
local hotStreakId = " ";
local missileBarId = " ";
local brainFreezeId =  " ";
local fingersFrostId = " ";
local ablastId = " ";
local abProgMonTime = 0;
local ttwFlag = false;
local icyveinsFlag = false;
local arcanepowFlag = false;
local abCastTime = 2.5;
local polyTimer = 0;
local scorchTime = 0;


function MN_Start(self)
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self:RegisterEvent("CVAR_UPDATE")
    self:RegisterEvent("UNIT_AURA")
    self:RegisterEvent("VARIABLES_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_UPDATE_RESTING")
    MageNuggetsOptions()
    SlashCmdList['MAGENUGGETS_SLASHCMD'] = MageNuggets_SlashCommandHandler
    SLASH_MAGENUGGETS_SLASHCMD1 = L["/magenuggets"]
end

function RoundCrit(critNum) --rounds the crit rating to two decimals
    return math.floor(critNum*math.pow(10,2)+0.5) / math.pow(10,2) 
end

function RoundThree(critNum) --rounds three places
    return math.floor(critNum*math.pow(10,3)+0.5) / math.pow(10,3) 
end

function MageNuggets_SlashCommandHandler(msg) --Handles the slash commands
    if (msg == "options") then
	    InterfaceOptionsFrame_OpenToCategory("Mage Nuggets");
    elseif (msg == "ports") then
        MageNuggets_Minimap_OnClick(); 
    else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff------------|cff00BFFF"..L["Mage"].." |cff00FF00"..L["Nuggets"].."|cffffffff 1.7--------------")
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff"..L["/magenuggets"].." "..L["options (Shows Option Menu)"])
    DEFAULT_CHAT_FRAME:AddMessage("|cffffffff"..L["/magenuggets"].." "..L["ports (Shows Portal Menu)"])
    end
end
--
local MN_UpdateInterval = 1.0;
function MageNuggets_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > MN_UpdateInterval) then
    if (spellStealTog >= 1) then 
        spellStealTog = spellStealTog - 1;
    else
        if (MageNugz.ssMonitorToggle == true) then
            local stealableBuffs, i = { }, 1;
            local buffName, _, _, _, _, _, _, _, isStealable = UnitAura("target", i, "HELPFUL");
            while buffName do
                if(isStealable == 1) then
                    stealableBuffs[#stealableBuffs + 1] = buffName;
                end
                i = i + 1;
                buffName, _, _, _, _, _, _, _, isStealable = UnitAura("target", i, "HELPFUL");
            end
            if (#stealableBuffs < 1) then
                MNSpellSteal_Frame:Hide(); 
            else
                MNSpellSteal_Frame:Show(); 
                stealableBuffs = table.concat(stealableBuffs, "\n");
                MNSpellSteal_FrameBuffText:SetText("|cffFFFFFF"..stealableBuffs);
            end
        end
    end
    if(UnitClass("Player") == 'Mage') then
        local p = 1; 
        local isMB = false
        local buffNamez, _, _, _, _, _, _, _, _, _, spellIdz = UnitAura("player", p, "HELPFUL");
        while buffNamez do
            if(spellIdz == 44401) then
                isMB = true;
            end
            p = p + 1;
            buffNamez, _, _, _, _, _, _, _, _, _, spellIdz = UnitAura("player", p, "HELPFUL");
        end
        if (isMB == false) then
            mageProcMBTime = 0;
        end
    end
  self.TimeSinceLastUpdate = 0;
  end
end     
--
local MNhs_UpdateInterval = 0.1;   
function MageNuggetsHS_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNhs_UpdateInterval) then   
        if (mageProcHSTime >= 0) then
            mageProcHSTime = mageProcHSTime - 0.1;
            MageNugProcFrame_ProcBar:SetValue(mageProcHSTime)
            if (mageProcHSTime <= 0) then
                MageNugProcFrame:Hide()
                MageNugProcFrame_ProcBar:SetValue(15)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
local MNmb_UpdateInterval = 0.1;   
function MageNuggetsMB_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNmb_UpdateInterval) then   
        if (mageProcMBTime >= 0) then
            mageProcMBTime = mageProcMBTime - 0.1;
            MageNugMBProcFrame_ProcBar:SetValue(mageProcMBTime)
            if (mageProcMBTime <= 0) then
                MageNugMBProcFrame:Hide()
                MageNugMBProcFrame_ProcBar:SetValue(14)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
local MNbf_UpdateInterval = 0.1;   
function MageNuggetsBF_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNbf_UpdateInterval) then   
        if (mageProcBFTime >= 0) then
            mageProcBFTime = mageProcBFTime - 0.1;
            MageNugBFProcFrame_ProcBar:SetValue(mageProcBFTime)
            if (mageProcBFTime <= 0) then
                MageNugBFProcFrame:Hide()
                MageNugBFProcFrame_ProcBar:SetValue(15)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--    
local MNab_UpdateInterval = 0.2;   
function MageNuggetsAB_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNab_UpdateInterval) then   
        if (abProgMonTime >= 0) then
            abProgMonTime = abProgMonTime - 0.2;
            MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
            if (abProgMonTime <= 0) then
                MageNugAB_Frame:Hide()
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--   
local MNlb_UpdateInterval = 0.2;
function MageNuggetsLB_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNlb_UpdateInterval) then   
        if (livingbombTime >= 0) then
            livingbombTime = livingbombTime - 0.2;
            MageNugLB_Frame_LBBar:SetValue(livingbombTime)
            if (livingbombTime <= 0) then
                livingBombCount = 0;
                MageNugLB_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
local MNscorch_UpdateInterval = 1.0;
function MageNuggetsScorch_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNscorch_UpdateInterval) then   
        if(scorchTime >= 0) then
            scorchTime = scorchTime - 1;
            MageNugScorch_FrameText:SetText(scorchTime)
            MageNugScorch_Frame_Bar:SetValue(scorchTime)
            if(scorchTime <= 0) then
                MageNugScorch_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
local MNmi_UpdateInterval = 1.0;
function MageNuggetsMI_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNmi_UpdateInterval) then   
        if (mirrorImageTime >= 0) then
            mirrorImageTime = mirrorImageTime - 1.0;
            MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
            MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
            if (mirrorImageTime <= 0) then
                MageNugMI_Frame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end
--
local MNwe_UpdateInterval = 1.0;   
function MageNuggetsWE_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNwe_UpdateInterval) then   
        if (waterEleTime >=0) then
            waterEleTime = waterEleTime - 1.0;
            MageNugWE_Frame_WEText1:SetText(" "..waterEleTime)
            MageNugWE_Frame_WeBar:SetValue(waterEleTime)
            if(waterEleTime <= 0) then
                MageNugWE_Frame:Hide();
            end
        end 
    self.TimeSinceLastUpdate = 0;
    end   
end
--   
local MNpoly_UpdateInterval = 1.0;   
function MageNuggetsPoly_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNpoly_UpdateInterval) then   
        if (polyTimer >= 0) then
            polyTimer = polyTimer - 1.0;
            MageNugPolyFrameTimerText:SetText(polyTimer);
            if(polyTimer <= 0) then
                MageNugPolyFrame:Hide();
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--  
local MNfof_UpdateInterval = 0.1;   
function MageNuggetsFoF_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNfof_UpdateInterval) then   
        if (fofProgMonTime >= 0) then
            fofProgMonTime = fofProgMonTime - 0.1;
            MageNugFoFProcFrame_ProcBar:SetValue(fofProgMonTime)
            if (fofProgMonTime <= 0) then
                MageNugFoFProcFrame:Hide()
                MageNugFoFProcFrame_ProcBar:SetValue(14)
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
local MNimp_UpdateInterval = 0.1;   
function MageNuggetsImpact_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
    if (self.TimeSinceLastUpdate > MNimp_UpdateInterval) then   
        if (mageImpProgMonTime >= 0) then
            mageImpProgMonTime = mageImpProgMonTime - 0.1;
            MageNugImpactProcFrame_ProcBar:SetValue(mageImpProgMonTime)
            if (mageImpProgMonTime <= 0) then
                MageNugImpactProcFrame:Hide()
                MageNugImpactProcFrame_ProcBar:SetValue(9)        
            end
        end
    self.TimeSinceLastUpdate = 0;
    end   
end  
--
local MNsp_UpdateInterval = 1.0
function MageNuggetsSP_OnUpdate(self, elapsed) 
 self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
 if (self.TimeSinceLastUpdate > MNsp_UpdateInterval) then   
        if (ttwFlag == false) then
            MNTorment_Frame:Hide();
        end
        if (icyveinsFlag == false) then
            MNicyveins_Frame:Hide();
        end
        if (arcanepowFlag == false) then
            MNarcanepower_Frame:Hide();
        end
        local _, _, _, _, currRank11, _ = GetTalentInfo(1,14); --torment the weak
        local spellHit = RoundCrit(GetCombatRatingBonus(8));
        local critRating = RoundCrit(GetSpellCritChance(3));
        local hasteRating = ((GetCombatRatingBonus(20)/100) + 1);
        local misFlag = false;
        local faerieFlag = false;
        local j = 1;
        local jj = 1;
        ttwFlag = false;
        icyveinsFlag = false;
        arcanepowFlag = false;
        local buffName3, rank3, _, count3, _, _, _, _, _, _, spellId3 = UnitAura("target", j, "HARMFUL");
        while buffName3 do
            if (currRank11 == 3) or (currRank11 == 2) or (currRank11 == 1) then
                if(spellId3 == 31589) or (spellId3 == 55095) or (spellId3 == 45524) or (spellId3 == 12323) or (spellId3 == 18223) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (spellId3 == 3600) or (spellId3 == 13809) or (spellId3 == 2974) or (spellId3 == 25809) or (spellId3 == 1715) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (buffName3 == frostboltId) or (buffName3 == conecoldId) or (buffName3 == blastwaveId) or (buffName3 == frostfireId) or (buffName3 == chilledId) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                elseif (buffName3 == judgementjustId) or (buffName3 == infectedwoundsIdthen) or (buffName3 == thunderclapId) or (buffName3 == deadlythrowId) or (buffName3 == frostshockId) or (buffName3 == mindflayId) then
                    ttwFlag = true;
                    MNTorment_Frame:Show();
                end
            end
            if(spellId3 == 33198) then --misery
                spellHit = spellHit + 3.0;
                misFlag = true;
            elseif (spellId3 == 33197) then
                spellHit = spellHit + 2.0;
                misFlag = true;
            elseif (spellId3 == 33196) then
                spellHit = spellHit + 1.0;
                misFlag = true;
            end
            if(spellId3 == 770) then --Faerie Fire
                faerieFlag = true;
            end
            if(spellId3 == 12579) then --winter's chill
                if(count3 == 1) then
                    critRating = critRating + 1.0;
                elseif(count3 == 2) then
                    critRating = critRating + 2.0;
                elseif(count3 == 3) then
                    critRating = critRating + 3.0;
                elseif(count3 == 4) then
                    critRating = critRating + 4.0;
                elseif(count3 == 5) then
                    critRating = critRating + 5.0;
                end
            end
            if(spellId3 == 22959) then --scorch
                critRating = critRating + 5.0;
            end
            if(spellId3 == 17800) then --shadow mastery
                critRating = critRating + 5.0;
            end
            j = j + 1;
            buffName3, rank3, _, count3, _, _, _, _, _, _, spellId3 = UnitAura("target", j, "HARMFUL");
        end     
        local buffName2, rank2, _, count2, _, _, _, _, _, _, spellId2 = UnitAura("player", jj, "HELPFUL");
        while buffName2 do
            if(spellId2 == 28878) then
                spellHit = spellHit + 1;
            end
            if(spellId2 == 10060) then --pushing the limit
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 70753) then --pushing the limit
                hasteRating = (hasteRating*1.12);
            end
            if(spellId2 == 12042) then --arcane power
                arcanepowFlag = true;
                MNarcanepower_Frame:Show();
            end
            if(spellId2 == 2895) then --wrath of air tot
                hasteRating = (hasteRating*1.05);
            end
            if(spellId2 == 24907) then --Moonkin Aura
                hasteRating = (hasteRating*1.03);
            end
            if(spellId2 == 26297) then --berserking
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 12472) then --icy veins
                icyveinsFlag = true;
                MNicyveins_Frame:Show();
                hasteRating = (hasteRating*1.20);
            end
            if(spellId2 == 2825) then --bloodlust
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 65980) then --bloodlust argent turny
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 32182) then --heroism
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 65983) then --heroism argent turny
                hasteRating = (hasteRating*1.30);
            end
            if(spellId2 == 16886) then --cfocus
                hasteRating = (hasteRating*1.20);
            end
            jj = jj + 1;
            buffName2, rank2, _, count2, _, _, _, _, _, _, spellId2 = UnitAura("player", jj, "HELPFUL");
        end 
        if(misFlag == false) then
            if (faerieFlag == true) then
                spellHit = spellHit + 3;
                if(UnitClass("Player") == 'Druid') then
                    critRating = critRating + 3.0;
                end
            end
        end
        if(UnitClass("Player") == 'Druid') then
            local nameD, _, _, _, currRankD, _ = GetTalentInfo(1,11) --cfocus 
            if(currRankD == 3) then
                hasteRating = (hasteRating*1.03)
            end
            if(currRankD == 2) then
                hasteRating = (hasteRating*1.02)
            end
            if(currRankD == 1) then
                hasteRating = (hasteRating*1.01)
            end
        end
        if(UnitClass("Player") == 'Mage') then
            local _, _, _, _, currRank7, _ = GetTalentInfo(3,6); --precision
            local _, _, _, _, currRank8, _ = GetTalentInfo(1,2); --arcane focus  
            local _, _, _, _, currRank9, _ = GetTalentInfo(1,22); --arcane power
            local _, _, _, _, currRank10, _ = GetTalentInfo(1,28); --netherwind presence
            if(currRank7 == 1) then
                spellHit = spellHit + 1.0;
            end
            if(currRank7 == 2) then
                spellHit = spellHit + 2.0;
            end
            if(currRank7 == 3) then
                spellHit = spellHit + 3.0;
            end
            if(currRank9 == 1) then
                if(currRank8 == 1) then
                    spellHit = spellHit + 1.0;
                end
                if(currRank8 == 2) then
                spellHit = spellHit + 2.0;
                end
                if(currRank8 == 3) then
                spellHit = spellHit + 3.0;
                end
            end
            if(currRank10 == 1) then
                hasteRating = (hasteRating*1.02);
            end
            if(currRank10 == 2) then
                hasteRating = (hasteRating*1.04);
            end
            if(currRank10 == 3) then
                hasteRating = (hasteRating*1.06);
            end
        end
        if(spellHit >= 17.0) then
            spellHit = "capped";
        else
            spellHit = spellHit.."%";
        end
        hasteRating = RoundCrit((hasteRating - 1)*100)
        abCastTime = RoundThree((2.5)/(1+(hasteRating/100)))
        if(abCastTime < 1) then
            MageNugAB_FrameCastText:SetText("|cffFF0000Haste\nCapped")
        else
            MageNugAB_FrameCastText:SetText("|cffFFFFFF"..abCastTime.."\nsec cast")
        end
        MageNugSP_FrameText:SetText("|cffFF0000SP:|cffFFFFFF"..GetSpellBonusDamage(3).."\n|cffFF6600Crit:|cffFFFFFF"..critRating.."%".."\n|cffCC33FFHaste:|cffFFFFFF"..hasteRating.."%".."\n|cffFFFF33 Hit:|cffFFFFFF"..spellHit);
    self.TimeSinceLastUpdate = 0;
  end
end   

function MageNuggets_OnEvent(self, event, ...)
    if (event == "VARIABLES_LOADED") then       
        MNVariablesLoaded_OnEvent()
    end  
    if (event == "CVAR_UPDATE") then
        combatTextCvar = GetCVar("enableCombatText")
    end
    if (event == "PLAYER_ENTERING_WORLD") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    end
    if (event == "PLAYER_UPDATE_RESTING") then
        MageNugHordeFrame:Hide();
        MageNugAlliFrame:Hide();
    end
    if (event == "UNIT_AURA") and (arg1 == "player") then
        _, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player",impactId)
        if (spellId == 64343) then
            local imptime = expirationTime - GetTime();
            if(MageNugz.procMonitorToggle == true) then
                mageImpProgMonTime = imptime;
                MageNugImpactProcFrameText:SetText("|cffFF0000"..L["IMPACT!"])
                MageNugImpactProcFrame_ProcBar:SetValue(mageImpProgMonTime)
                MageNugImpactProcFrame:Show();
            end
            if(imptime >= 9.9)then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage(L["IMPACT!"], CombatText_StandardScroll, 1.0, 0, 0, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end
        end
        _, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", missileBarId) 
        if (spellId ==  44401) then
            local mbtime = expirationTime - GetTime();
            if(MageNugz.procMonitorToggle == true) then
                mageProcMBTime = mbtime;
                MageNugMBProcFrameText:SetText("|cffFF33FF"..L["MISSILE BARRAGE!"])
                MageNugMBProcFrame_ProcBar:SetValue(mageProcMBTime)
                MageNugMBProcFrame:Show()
            end
            if(mbtime >= 14.9)then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage(L["MISSILE BARRAGE!"], CombatText_StandardScroll, 0.60, 0, 0.60, "crit", isStaggered, nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end  
        end
        _, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", hotStreakId) 
        if(spellId == 48108) then
            local hstime = expirationTime - GetTime();
            if(MageNugz.procMonitorToggle == true) then
                mageProcHSTime = hstime;
                MageNugProcFrameText:SetText("|cffFF0000"..L["HOT STREAK!"])
                MageNugProcFrame_ProcBar:SetMinMaxValues(0,9)
                MageNugProcFrame_ProcBar:SetValue(mageProcHSTime)
                MageNugProcFrame:Show()
            end
            if(hstime >= 9.9)then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage(L["HOT STREAK!"], CombatText_StandardScroll, 1, 0.10, 0, "crit", isStaggered,nil);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                    PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end  
        end
        _, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", brainFreezeId) 
        if(spellId == 57761) then
            local bftime = expirationTime - GetTime()
            if(MageNugz.procMonitorToggle == true) then
                mageProcBFTime = bftime;     
                MageNugBFProcFrameText:SetText("|cffFF3300"..L["BRAIN FREEZE!"])
                MageNugBFProcFrame_ProcBar:SetMinMaxValues(0,14)
                MageNugBFProcFrame_ProcBar:SetValue(mageProcBFTime)
                MageNugBFProcFrame:Show()
            end
            if(bftime >= 14.9)then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                        CombatText_AddMessage(L["BRAIN FREEZE!"], CombatText_StandardScroll, 1, 0.20, 0, "crit", isStaggered);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end  
        end       
        _, _, _, _, _, _, expirationTime, _, _, _, spellId = UnitBuff("player", fingersFrostId) 
        if(spellId == 44544) then
            local foftime = expirationTime - GetTime()
            if(MageNugz.procMonitorToggle == true) then
                fofProgMonTime = foftime;
                MageNugFoFProcFrameText:SetText("|cffFFFFFF"..L["Fingers Of Frost"])
                MageNugFoFProcFrame_ProcBar:SetValue(fofProgMonTime)
                MageNugFoFProcFrame:Show()
            end
            if(foftime >= 14.9)then
                if(combatTextCvar == '1') then
                    if (MageNugz.mageProcToggle == true) then
                       CombatText_AddMessage(L["Fingers Of Frost"], CombatText_StandardScroll, 1, 1, 1, "crit", 1);
			        end
                end
                if (MageNugz.procSoundToggle == true) then
                   PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.procSound)
                end
            end  
        end    
        _, _, _, count, _, _, expirationTime, _, _, _, spellId = UnitDebuff("player", ablastId) 
        if (spellId == 36032) then
            if (MageNugz.arcaneBlastToggle == true) then
                local ABtime = expirationTime - GetTime()
                abProgMonTime = ABtime;
                MageNugAB_FrameText:SetText("|cffFF00FF"..count)
                MageNugAB_Frame_ABBar:SetValue(abProgMonTime)
                MageNugAB_Frame:Show()
            end
        end
    end
    if (event == "COMBAT_LOG_EVENT_UNFILTERED")then   
        local _, event1, _, sourceName, _, destGUID, destName, _ = select(1, ...) 
        local arg, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = select(9, ...) 
		local spellId1 = select(12, ...)     
        if event1 == "SPELL_CAST_START" then
            if sourceName == UnitName("player") then
                if ((arg == 42832) or (arg == 42833) or (arg == 38692) or (arg == 27070) or (arg == 25306)) then
                    MageNugBFProcFrame:Hide() 
                end
                if ((arg == 42891) or (arg == 42890) or (arg == 33938) or (arg == 27132) or (arg == 18809) or (arg == 12526) or (arg == 12525)) then
                    MageNugProcFrame:Hide() 
                end
            end
        end
        if event1 == "SPELL_AURA_REFRESH" then
            if (MageNugz.polyToggle == true) then
                    local dest = tonumber(destGUID:sub(5,5), 16);
                    local maskdest = dest % 8;
                    if (arg == 61305) or (arg == 61721) or (arg == 28271) or (arg == 12826) or (arg == 28272) then
                        if (maskdest == 0) then
                            polyTimer = 8;
                        else
                            polyTimer = 49;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 12825)  then
                        if (maskdest == 0) then
                            polyTimer = 8;
                        else
                            polyTimer = 39;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 12824)  then
                        if (maskdest == 0) then
                            polyTimer = 8;
                        else
                            polyTimer = 29;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 118)  then
                        if (maskdest == 0) then
                            polyTimer = 8;
                        else
                            polyTimer = 19;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
            end            
            if(MageNugz.absorbToggle == true) then   
                if sourceName == UnitName("player") then
                    if (MageNugz.consoleTextEnabled == true) then
                        if (arg == 43039) then
                            local iceBarrTotal = ((GetSpellBonusDamage(3) * 0.8067) + 3300);
                            local iceBarrRounded = math.floor(iceBarrTotal*math.pow(10,0)+0.5) / math.pow(10,0)
                            for i = 1, 6 do
                                local enabled, glyphType, glyphSpellID, icon = GetGlyphSocketInfo(i);
                                if (enabled == 1) then
                                    if (glyphSpellID ~= nil) then
                                        if (glyphSpellID == 63095) then
                                        iceBarrRounded = iceBarrRounded + 990;
                                        end
                                    end
                                end
                            end    
                            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF"..L["Ice Barrier Absorbing"]..":|cffFFFFFF "..iceBarrRounded.."|cff00BFFF "..L["Damage"]);
                        end                
                        if (arg == 43020) then
                            local manaShieldTotal = ((GetSpellBonusDamage(3) * 0.805) + 1330);
                            local manaShieldRounded = math.floor(manaShieldTotal*math.pow(10,0)+0.5) / math.pow(10,0)              
                            DEFAULT_CHAT_FRAME:AddMessage("|cff00688B"..L["Mana Shield Absorbing"]..":|cffFFFFFF "..manaShieldRounded.."|cff00688B "..L["Damage"]);
                        end
                    end
                end    
            end
            if(arg == 22959) then
                if sourceName == UnitName("player") then
                    if(MageNugz.ScorchToggle == true) then
                        scorchTime = 29;
                        MageNugScorch_FrameText:SetText(scorchTime)
                        MageNugScorch_Frame_Bar:SetValue(scorchTime)
                        MageNugScorch_Frame:Show();
                    end
                end
            end
        end
        --
        if event1 == "SPELL_CAST_SUCCESS" then 
            if sourceName == UnitName("player") then
                if ((arg == 42845) or (arg == 42844) or (arg == 38703) or (arg == 38700) or (arg == 27076) or (arg == 25346))then
                    MageNugMBProcFrame:Hide()
                end    
                if (arg == 42873) or (arg == 42872) or (arg == 27079) or (arg == 27078) or (arg == 10199) or (arg == 10197) or (arg == 8413) then
                    MageNugImpactProcFrame:Hide();
                end
                if (arg == 33831) then
                    if (MageNugz.miSoundToggle == true) then
                        PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.miSound)
                    end
                end
                if (arg == 31687) then
                    if (MageNugz.waterEleToggle == true) then
                        local waterGlyphed = 0;
                        local nameTalent, icon, tier, column, currRank, maxRank= GetTalentInfo(3,26);
                        for k = 1, 6 do
                            local enabled, glyphType, glyphSpellID, icon = GetGlyphSocketInfo(k);
                            if (enabled == 1) then
                                if (glyphSpellID ~= nil) then
                                    if (glyphSpellID == 70937) then
                                        waterGlyphed = 1;
                                    end
                                end
                            end
                        end    
                        if(waterGlyphed == 0) then
                            if (currRank == 0) then 
                                MageNugWE_Frame_WeBar:SetMinMaxValues(0,45)           
                                waterEleTime = 45;
                                MageNugWE_Frame_WEText1:SetText(" "..waterEleTime)
                                MageNugWE_Frame_WeBar:SetValue(waterEleTime)
                                MageNugWE_Frame:Show()
                            end
                            if (currRank == 1) then 
                                MageNugWE_Frame_WeBar:SetMinMaxValues(0,50)           
                                waterEleTime = 50;
                                MageNugWE_Frame_WEText1:SetText(" "..waterEleTime)
                                MageNugWE_Frame_WeBar:SetValue(waterEleTime)
                                MageNugWE_Frame:Show()
                            end
                            if (currRank == 2) then 
                                MageNugWE_Frame_WeBar:SetMinMaxValues(0,55)           
                                waterEleTime = 55;
                                MageNugWE_Frame_WEText1:SetText(" "..waterEleTime)
                                MageNugWE_Frame_WeBar:SetValue(waterEleTime)
                                MageNugWE_Frame:Show()
                            end
                            if (currRank == 3) then 
                                MageNugWE_Frame_WeBar:SetMinMaxValues(0,60)           
                                waterEleTime = 60;
                                MageNugWE_Frame_WEText1:SetText(" "..waterEleTime)
                                MageNugWE_Frame_WeBar:SetValue(waterEleTime)
                                MageNugWE_Frame:Show()
                            end
                        end
                    end
                end
            end
        end
        --
        if event1 == "SPELL_AURA_REMOVED" then 
            if sourceName == UnitName("player") then
                if(arg == 22959) then
                    MageNugScorch_Frame:Hide();
                end
                if (arg == 36032) then
                    MageNugAB_Frame:Hide()
                end
                if (arg == 44544) then
			        MageNugFoFProcFrame:Hide()
                end
                if (arg == 55360) then
                    livingBombCount = livingBombCount - 1;
                    MageNugLB_FrameText:SetText("|cffFFFFFF"..livingBombCount)
                end
                if (MageNugz.polyToggle == true) then
                    if (arg == 28272) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Polymorph(Pig) Broken On"]..":|cffFFFFFF "..destName);
                        end
                    end
                    if (arg == 12826) or (arg == 12825) or (arg == 12824) or (arg == 118) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Polymorph(Sheep) Broken On"]..":|cffFFFFFF "..destName);
                        end
                    end
                    if (arg == 28271) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Polymorph(Turtle) Broken On"]..":|cffFFFFFF "..destName);
                        end
                    end
                    if (arg == 61721) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Polymorph(Rabbit) Broken On"]..":|cffFFFFFF "..destName);
                        end
                    end
                    if (arg == 61305) then
                        MageNugPolyFrame:Hide();
                        polyTimer = 0;
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage("Polymorph Broken", CombatText_StandardScroll, 1, 0.20, 1, "sticky", nil);
                        end
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Polymorph(Black Cat) Broken On"]..":|cffFFFFFF "..destName);
                        end
                    end 
                end
            end
        end
        --
        if event1 == "SPELL_AURA_APPLIED" then
            if sourceName == UnitName("player") then
                if (MageNugz.polyToggle == true) then
                    local destpoly = tonumber(destGUID:sub(5,5), 16);
                    local maskdest = destpoly % 8;
                    if (arg == 61305) or (arg == 61721) or (arg == 28271) or (arg == 12826) or (arg == 28272) then
                        if (maskdest == 0) then
                            polyTimer = 9;
                        else
                            polyTimer = 49;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 12825)  then
                        if (maskdest == 0) then
                            polyTimer = 9;
                        else
                            polyTimer = 39;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 12824)  then
                        if (maskdest == 0) then
                            polyTimer = 9;
                        else
                            polyTimer = 29;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                    if (arg == 118)  then
                        if (maskdest == 0) then
                            polyTimer = 9;
                        else
                            polyTimer = 19;
                        end
                        MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"]..":\n|cffFFFFFF "..destName);
                        MageNugPolyFrameTimerText:SetText(polyTimer);
                        MageNugPolyFrame:Show();
                    end
                end            
                if(MageNugz.absorbToggle == true) and (MageNugz.consoleTextEnabled == true) then
                    if (arg == 43039) then
                        local iceBarrTotal = ((GetSpellBonusDamage(3) * 0.8067) + 3300);
                        local iceBarrRounded = math.floor(iceBarrTotal*math.pow(10,0)+0.5) / math.pow(10,0)
                        for i = 1, 6 do
                            local enabled, glyphType, glyphSpellID, icon = GetGlyphSocketInfo(i);
                            if (enabled == 1) then
                                if (glyphSpellID ~= nil) then
                                    if (glyphSpellID == 63095) then
                                        iceBarrRounded = iceBarrRounded + 990;
                                    end
                                end
                            end
                        end    
                        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF"..L["Ice Barrier Absorbing"]..":|cffFFFFFF "..iceBarrRounded.."|cff00BFFF "..L["Damage"]);
                    end                
                    if (arg == 43012) then
                        local frostWardTotal = ((GetSpellBonusDamage(3) * 0.10) + 1950);
                        local frostWardRounded = math.floor(frostWardTotal*math.pow(10,0)+0.5) / math.pow(10,0)              
                        DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF"..L["Frost Ward Absorbing"]..":|cffFFFFFF "..frostWardRounded.."|cff00BFFF "..L["Frost"].." "..L["Damage"]);
                    end
                    if (arg == 43010) then
                        local fireWardTotal = ((GetSpellBonusDamage(3) * 0.10) + 1950);
                        local fireWardRounded = math.floor(fireWardTotal*math.pow(10,0)+0.5) / math.pow(10,0)              
                        DEFAULT_CHAT_FRAME:AddMessage("|cffFF030D "..L["Fire Ward Absorbing"]..":|cffFFFFFF "..fireWardRounded.."|cffFF030D "..L["Fire"].." "..L["Damage"]);
                    end
                    if (arg == 43020) then
                        local manaShieldTotal = ((GetSpellBonusDamage(3) * 0.805) + 1330);
                        local manaShieldRounded = math.floor(manaShieldTotal*math.pow(10,0)+0.5) / math.pow(10,0)              
                        DEFAULT_CHAT_FRAME:AddMessage("|cff00688B"..L["Mana Shield Absorbing"]..":|cffFFFFFF "..manaShieldRounded.."|cff00688B "..L["Damage"]);
                    end
                end
                if ((arg == 55360) or (arg == 55359) or (arg == 44457)) then
                    if (MageNugz.livingBombToggle == true) then
                        livingbombTime = 13;
                        livingBombCount = livingBombCount + 1;
                        MageNugLB_FrameText:SetText("|cffFFFFFF"..livingBombCount)
                        MageNugLB_Frame_LBBar:SetValue(livingbombTime)
                        MageNugLB_Frame:Show()
                    end
                end
                if (arg == 55342) then
                    if (MageNugz.mirrorImageToggle == true) then
                        if (MageNugz.miSoundToggle == true) then
                            PlaySoundFile("Interface\\AddOns\\MageNuggets\\Sounds\\"..MageNugz.miSound)
                        end
                        mirrorImageTime = 30;
                        MageNugMI_Frame_MIText1:SetText(" "..mirrorImageTime)
                        MageNugMI_Frame_MiBar:SetValue(mirrorImageTime)
                        MageNugMI_Frame:Show();
                    end
                end
                if(arg == 22959) then
                    if(MageNugz.ScorchToggle == true) then
                        scorchTime = 29;
                        MageNugScorch_FrameText:SetText(scorchTime)
                        MageNugScorch_Frame_Bar:SetValue(scorchTime)
                        MageNugScorch_Frame:Show();
                    end
                end
                if (arg == 130) then
                    if (destName ~= UnitName("player")) then
                        local sfRandomNum = math.random(1,3)
                        if(sfRandomNum == 1) then 
                            SendChatMessage(MageNugz.slowfallMsg, "WHISPER", nil, destName);
                        end
                        if(sfRandomNum == 2) then
                            SendChatMessage(MageNugz.slowfallMsg2, "WHISPER", nil, destName);
                        end
                        if(sfRandomNum == 3) then
                            SendChatMessage(MageNugz.slowfallMsg3, "WHISPER", nil, destName);
                        end
                    end
                end
                if (arg == 54646) then
                    local fmRandomNum = math.random(1,3)
                    if(fmRandomNum == 1) then
                        SendChatMessage(MageNugz.focusMagicNotify, "WHISPER", nil, destName);
                    end
                    if(fmRandomNum == 2) then
                        SendChatMessage(MageNugz.focusMagicNotify2, "WHISPER", nil, destName);
                    end
                    if(fmRandomNum == 3) then
                        SendChatMessage(MageNugz.focusMagicNotify3, "WHISPER", nil, destName);
                    end
                end
            end
            if destName == UnitName("player") then
			    if(arg == 10060) then
                    if(combatTextCvar == '1') then
                        if(MageNugz.mageProcToggle == true) then
                            CombatText_AddMessage(L["Power Infusion"], CombatText_StandardScroll, 1, 1, 1, nil, isStaggered, nil);
                        end
                    end
                end
                if (arg == 12536) then
                    if(combatTextCvar == '1') then
                        if (MageNugz.mageProcToggle == true) then
                            CombatText_AddMessage(L["Clearcast"], CombatText_StandardScroll, 1, 1, 1, nil, isStaggered, nil);
                        end
                    end
                end
                if (arg == 64868) then
				    if(combatTextCvar == '1') then
                        if (MageNugz.mageProcToggle == true) then
                            CombatText_AddMessage(L["Praxis"], CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil, nil);
                            CombatText_AddMessage(L["+350 Spellpower"], CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);
			            end
                    end
                end
		        if (arg == 12051) then
                    if (MageNugz.evocationToggle == true) then
                        local manaPoolTotal = UnitManaMax("player");
                        local evoTotal = manaPoolTotal * 0.60
                        evoTotal = math.floor(evoTotal+0.5) 
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cff663399"..L["Evocating For"].." "..evoTotal.." "..L["Mana"]);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(L["Evocating For"].." "..evoTotal.." Mana", CombatText_StandardScroll, 0, 0.10, 1, nil, isStaggered, nil);  
                        end
                    end
                end
                if(combatTextCvar == '1') then
                    if (arg == 63711) then
                        CombatText_AddMessage(L["STORM POWER"].."!!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage(L["(+135% Crit Damage)"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 65134) then
                        CombatText_AddMessage(L["STORM POWER"].."!", CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage(L["(+135% Crit Damage)"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 62821) then
                        CombatText_AddMessage(L["TOASTY FIRE!"], CombatText_StandardScroll, 1, 0.20, 0, "sticky", nil);
                    end
                    if (arg == 29232) then
                        CombatText_AddMessage(L["Fungal Creep!"], CombatText_StandardScroll, 0, 1, 0.2, "sticky", nil);
                        CombatText_AddMessage(L["(+50% Crit Rating)"], CombatText_StandardScroll, 0, 1, 0,2, "sticky", nil);
                    end
                    if (arg == 62320) then
                        CombatText_AddMessage(L["Aura of Celerity!"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage(L["(+20% Haste)"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                    if (arg == 62807) then
                        CombatText_AddMessage(L["Star Light!"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                        CombatText_AddMessage(L["(50% Haste)"], CombatText_StandardScroll, 1, 1, 1, "sticky", nil);
                    end
                end
                if (arg == 29166) then
                    if (sourceName ~= UnitName("player")) then
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF"..L["Innervated By"]..":|cffFFFFFF "..sourceName);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);
                            CombatText_AddMessage(L["INNERVATED YOU!"], CombatText_StandardScroll, 0, 0.10, 1, "sticky", nil);  
                        end
                        local inRandomNum = math.random(1,2)
                        if(inRandomNum == 1) then 
                            SendChatMessage(MageNugz.innervatThanks, "WHISPER", nil, sourceName);   
                        end
                        if(inRandomNum == 2) then 
                            SendChatMessage(MageNugz.innervatThanks2, "WHISPER", nil, sourceName);
                        end
                    end
                end
                if (arg == 54646) then
                    if (MageNugz.consoleTextEnabled == true) then
                        DEFAULT_CHAT_FRAME:AddMessage("|cff0000FF"..L["Focused Magic By"]..":|cffFFFFFF "..sourceName);
                    end
                    if(combatTextCvar == '1') then
                        CombatText_AddMessage(sourceName, CombatText_StandardScroll, 0, 0.10, 1, nil, nil);
                        CombatText_AddMessage(L["Focused Magic you"], CombatText_StandardScroll, 0, 0.10, 1, nil, nil);  
                    end
                    local fmRandomNum = math.random(1,2)
                    if(fmRandomNum == 1) then 
                       SendChatMessage(MageNugz.focusMagicThanks, "WHISPER", nil, sourceName);   
                    end
                    if(fmRandomNum == 2) then
                       SendChatMessage(MageNugz.focusMagicThanks2, "WHISPER", nil, sourceName);
                    end
                end
                if (arg == 2825) then
                    if sourceName ~= UnitName("player") then
                        if (MageNugz.consoleTextEnabled == true) then
                            DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000"..L["Blood Lust used by"]..":|cff0000FF "..sourceName);
                        end
                        if(combatTextCvar == '1') then
                            CombatText_AddMessage(sourceName, CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);
                            CombatText_AddMessage(L["BLOOD LUSTED!"], CombatText_StandardScroll, 1, 0.10, 0, "sticky", nil);  
                        end
                    end
                end
            end
		end
        --
        if event1 == "SPELL_STOLEN" then
            if sourceName == UnitName("player") then
				if(combatTextCvar == '1') then
                    CombatText_AddMessage(L["Stole"]..":"..GetSpellLink(spellId1), CombatText_StandardScroll, 0.10, 0, 1, "sticky", nil);
                end
                if (MageNugz.consoleTextEnabled == true) then
                    DEFAULT_CHAT_FRAME:AddMessage("|cffFFFFFF"..L["Spell Stolen"]..":"..GetSpellLink(spellId1))
	    	    end
            end
		end
    end
end

--------------------------------Options Functions----------------------------------

function MNVariablesLoaded_OnEvent() --Takes care of the options on load up
        if((UnitClass("Player") == 'Warrior') or (UnitClass("Player") == 'Rogue') or (UnitClass("Player") == 'Death Knight') or (UnitClass("Player") == 'Paladin') or (UnitClass("Player") == 'Hunter')) then
            MageNugz.spMonitorToggle = false;
            MageNugz.ssMonitorToggle = false;
            MageNugz.mageProcToggle = false;
            MageNugz.camZoomTogg = false;
            MageNugz.absorbToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.waterEleToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.consoleTextEnabled = false;
            MageNugz.arcaneBlastToggle = false;
            MageNugz.minimapToggle = false;
        end
        if((UnitClass("Player") == 'Druid') or (UnitClass("Player") == 'Shaman') or (UnitClass("Player") == 'Priest') or (UnitClass("Player") == 'Warlock')) then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF"..L["Mage"].."|cff00FF00"..L["Nuggets"].."|cffffffff 1.7 "..L["loaded! Some Options Disabled (Class:"]..UnitClass("Player")..")")
            MageNugz.ssMonitorToggle = false;
            MageNugz.mageProcToggle = false;
            MageNugz.absorbToggle = false;
            MageNugz.mirrorImageToggle = false;
            MageNugz.waterEleToggle = false;
            MageNugz.evocationToggle = false;
            MageNugz.livingBombToggle = false;
            MageNugz.procMonitorToggle = false;
            MageNugz.minimapToggle = false;
        end
        if(UnitClass("Player") == 'Mage') then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00BFFF"..L["Mage"].."|cff00FF00"..L["Nuggets"].."|cffffffff 1.7 "..L["loaded! (Use: /magenuggets options)"])
        end                
        if (MageNugz.minimapToggle == nil) then
            MageNugz.minimapToggle = true;
        end
        if (MageNugz.minimapToggle == true) then
            MageNug_MinimapFrame:Show();
            myTabPage1_CheckButton0:SetChecked(0);
        else
            MageNug_MinimapFrame:Hide();
            myTabPage1_CheckButton0:SetChecked(1);
        end
        combatTextCvar = GetCVar("enableCombatText")
        MNcheckbox0FontString:SetText(L["Disable Minimap Button"])
        MNcheckbox1FontString:SetText(L["Disable SP and Crit% Monitor"])
        MNcheckbox2FontString:SetText(L["Disable Spellsteal Monitor"])
        MNcheckbox3FontString:SetText(L["Disable Mage Proc Combat Text"])
        MNcheckbox4FontString:SetText(L["Disable Maximum Camera Zoom Out"])
        MNcheckbox5FontString:SetText(L["Disable Precise Shield Absorb Notify"])
        MNcheckbox6FontString:SetText(L["Disable Mirror Image Timer"])
        MNcheckbox7FontString:SetText(L["Disable Water Elemental Timer"])
        MNcheckbox8FontString:SetText(L["Disable Evocation Notify"])
        MNcheckbox9FontString:SetText(L["Disable Living Bomb Counter"])
        MNcheckboxScorchFontString:SetText(L["Disable Scorch"])
        MNcheckbox10FontString:SetText(L["Lock Frames"])
        MNcheckbox11FontString:SetText(L["Disable Mage Proc Monitor"])
        MNcheckbox12FontString:SetText(L["Disable Console Text"])
        MNcheckbox13FontString:SetText(L["Disable Arcane Blast Counter"])
        MNcheckboxPolyFontString:SetText(L["Disable Poly Monitor"])
        myTabPage3_SPSliderFontString:SetText(L["SP and Crit % Monitor Size"])
        myTabPage3_BorderSliderFontString:SetText(L["Border Type"])
        myTabPage3_TransSliderFontString:SetText(L["Background Transparency"])
        myTabPage3_ColorSliderFontString:SetText(L["Backdrop Color"])
        MN_Slider2FontString:SetText(L["Spellsteal Monitor Size"])
        MN_Slider3FontString:SetText(L["LB,AB,Scorch Counter Size"])
        MN_Slider4FontString:SetText(L["Mage Proc Monitor Size"])
        myTabPage1Button1:SetText(L["Preview Frames"])
        myTabPage2_Text1:SetText(L["Slowfall Notify Messages"])
        myTabPage2_Text2:SetText(L["Focus Magic Notify Messages"])
        myTabPage2_Text3:SetText(L["Focus Magic Thank You Messages"])
        myTabPage2_Text4:SetText(L["Innervate Thank You Messages"])
        if (MageNugz.MinimapPos == nil) then
            MageNugz.MinimapPos = 45;
        end
        if (MageNugz.spMonitorSize == nil) then
            myTabPage3_SPSizeSlider:SetValue(3)
        else
            myTabPage3_SPSizeSlider:SetValue(MageNugz.spMonitorSize)
        end
        if (MageNugz.ssMonitorSize == nil) then
            myTabPage1_Slider2:SetValue(3)
        else
            myTabPage1_Slider2:SetValue(MageNugz.ssMonitorSize)
        end
        if (MageNugz.livingBCounterSize == nil) then
            myTabPage1_Slider3:SetValue(3)
        else
            myTabPage1_Slider3:SetValue(MageNugz.livingBCounterSize)
        end
        if (MageNugz.procMonitorSize == nil) then
            myTabPage1_Slider4:SetValue(3)
        else
            myTabPage1_Slider4:SetValue(MageNugz.procMonitorSize)
        end
        if (MageNugz.slowfallMsg == nil) then
            SlowFallMsgEditBox:SetText(L["Slowfall Cast On You"])
        else
            SlowFallMsgEditBox:SetText(MageNugz.slowfallMsg)
        end
        if (MageNugz.slowfallMsg2 == nil) then
            SlowFallMsgEditBox2:SetText(L["Slowfall Cast On You"])
        else
            SlowFallMsgEditBox2:SetText(MageNugz.slowfallMsg2)
        end
        if (MageNugz.slowfallMsg3 == nil) then
            SlowFallMsgEditBox3:SetText(L["Slowfall Cast On You"])
        else
            SlowFallMsgEditBox3:SetText(MageNugz.slowfallMsg3)
        end
        if (MageNugz.focusMagicNotify == nil) then
            FocMagNotifyEditBox:SetText(L["Focus Magic Cast On You"])
        else
          FocMagNotifyEditBox:SetText(MageNugz.focusMagicNotify)
        end
        if (MageNugz.focusMagicNotify2 == nil) then
            FocMagNotifyEditBox2:SetText(L["Focus Magic Cast On You"])
        else
           FocMagNotifyEditBox2:SetText(MageNugz.focusMagicNotify2)
        end
        if (MageNugz.focusMagicNotify3 == nil) then
            FocMagNotifyEditBox3:SetText(L["Focus Magic Cast On You"])
        else
           FocMagNotifyEditBox3:SetText(MageNugz.focusMagicNotify3)
        end
        if (MageNugz.focusMagicThanks == nil) then
            FocMagThankEditBox:SetText( L["Thanks For Focus Magic"])
        else
            FocMagThankEditBox:SetText(MageNugz.focusMagicThanks)
        end
        if (MageNugz.focusMagicThanks2 == nil) then
            FocMagThankEditBox2:SetText( L["Thanks For Focus Magic"])
        else
            FocMagThankEditBox2:SetText(MageNugz.focusMagicThanks2)
        end
        if (MageNugz.innervatThanks == nil) then
            InnervThankEditBox:SetText(L["Thanks For The Innervate"])
        else
            InnervThankEditBox:SetText(MageNugz.innervatThanks)
        end
        if (MageNugz.innervatThanks2 == nil) then
            InnervThankEditBox2:SetText(L["Thanks For The Innervate"])
        else
            InnervThankEditBox2:SetText(MageNugz.innervatThanks2)
        end
        if (MageNugz.miSound == nil) then
            myTabPage4_MISoundEditBox:SetText("mirror.mp3")
        else
            myTabPage4_MISoundEditBox:SetText(MageNugz.miSound)
        end
        if (MageNugz.procSound == nil) then
            myTabPage4_ProcSoundEditBox:SetText("proc.mp3")
        else
            myTabPage4_ProcSoundEditBox:SetText(MageNugz.procSound)
        end
        if (MageNugz.spMonitorToggle == true) then
            MageNugSP_Frame:Show();
            myTabPage3_CheckButton1:SetChecked(0);
        else
           MageNugSP_Frame:Hide();
           myTabPage3_CheckButton1:SetChecked(1);
        end
        if (MageNugz.ssMonitorToggle == true) then
            myTabPage1_CheckButton2:SetChecked(0);
        else
            myTabPage1_CheckButton2:SetChecked(1);
        end
        if (MageNugz.mageProcToggle == true) then
            myTabPage1_CheckButton3:SetChecked(0);
        else
            myTabPage1_CheckButton3:SetChecked(1);
        end
        if (MageNugz.camZoomTogg == true) then
            ConsoleExec("cameraDistanceMax 50");
            myTabPage1_CheckButton4:SetChecked(0);
        else
            myTabPage1_CheckButton4:SetChecked(1);
        end     
        if (MageNugz.absorbToggle == true) then
            myTabPage1_CheckButton5:SetChecked(0);
        else
            myTabPage1_CheckButton5:SetChecked(1);
        end
        if (MageNugz.mirrorImageToggle == true) then
            myTabPage1_CheckButton6:SetChecked(0);
        else
            myTabPage1_CheckButton6:SetChecked(1);
        end
        if (MageNugz.waterEleToggle == true) then
            myTabPage1_CheckButton7:SetChecked(0);
        else
            myTabPage1_CheckButton7:SetChecked(1);
        end
        if (MageNugz.evocationToggle == true) then
            myTabPage1_CheckButton8:SetChecked(0);
        else
            myTabPage1_CheckButton8:SetChecked(1);
        end
        if (MageNugz.livingBombToggle == true) then
            myTabPage1_CheckButton9:SetChecked(0);
        else
            myTabPage1_CheckButton9:SetChecked(1);
        end
        if (MageNugz.ScorchToggle == true)then
            myTabPage1_ScorchCheckButton:SetChecked(0);
        else
            myTabPage1_ScorchCheckButton:SetChecked(1);
        end
        if (MageNugz.arcaneBlastToggle == true) then
            myTabPage1_CheckButton13:SetChecked(0);
        else
            myTabPage1_CheckButton13:SetChecked(1);
        end
        if (MageNugz.polyToggle == true) then
            myTabPage1_CheckButton14:SetChecked(0);
        else
            myTabPage1_CheckButton14:SetChecked(1);
        end
        if (MageNugz.lockFrames == nil) then
            MageNugz.lockFrames = false;
        end
        if (MageNugz.lockFrames == true) then
            myTabPage1_CheckButton10:SetChecked(1);
        else
            myTabPage1_CheckButton10:SetChecked(0);
        end
        if (MageNugz.consoleTextEnabled == nil) then
            MageNugz.consoleTextEnabled = true;
        end
        if (MageNugz.consoleTextEnabled == true) then
            myTabPage1_CheckButton12:SetChecked(0);
        else
            myTabPage1_CheckButton12:SetChecked(1);
        end
        if (MageNugz.procMonitorToggle == nil) then
            MageNugz.procMonitorToggle = true;
        end
        if (MageNugz.procMonitorToggle == true) then
            myTabPage1_CheckButton11:SetChecked(0);
        else
            myTabPage1_CheckButton11:SetChecked(1);
        end
        if(MageNugz.borderStyle == nil) then
            myTabPage3_BorderSlider:SetValue(0);
        else
            myTabPage3_BorderSlider:SetValue(MageNugz.borderStyle);
        end
        if(MageNugz.transColor == nil) then
            myTabPage3_TransparencySlider:SetValue(0);
        else
            myTabPage3_TransparencySlider:SetValue(MageNugz.transColor);
        end
        if (MageNugz.miSoundToggle == true) then
            myTabPage4_MICheckButton:SetChecked(1);
        else
            myTabPage4_MICheckButton:SetChecked(0);
        end
        if (MageNugz.procSoundToggle == true) then
            myTabPage4_ProcCheckButton:SetChecked(1);
        else
            myTabPage4_ProcCheckButton:SetChecked(0);
        end
        missileBarId, _, _, _, _, _, _, _, _ = GetSpellInfo(44401);
        hotStreakId, _, _, _, _, _, _, _, _ = GetSpellInfo(48108);
        brainFreezeId, _, _, _, _, _, _, _, _ = GetSpellInfo(57761);
        fingersFrostId, _, _, _, _, _, _, _, _ = GetSpellInfo(44544);
        ablastId, _, _, _, _, _, _, _, _ = GetSpellInfo(36032);
        frostboltId, _, _, _, _, _, _, _, _ = GetSpellInfo(42842);
        frostfireId, _, _, _, _, _, _, _, _ = GetSpellInfo(47610);
        conecoldId, _, _, _, _, _, _, _, _ = GetSpellInfo(42931);
        blastwaveId, _, _, _, _, _, _, _, _ = GetSpellInfo(42945);
        judgementjustId, _, _, _, _, _, _, _, _ = GetSpellInfo(53696);
        infectedwoundsId, _, _, _, _, _, _, _, _ = GetSpellInfo(48485);
        thunderclapId, _, _, _, _, _, _, _, _ = GetSpellInfo(47502);
        deadlythrowId, _, _, _, _, _, _, _, _ = GetSpellInfo(48674);
        frostshockId, _, _, _, _, _, _, _, _ = GetSpellInfo(49236);
        chilledId, _, _, _, _, _, _, _, _ = GetSpellInfo(7321); 
        mindflayId, _, _, _, _, _, _, _, _ = GetSpellInfo(48156);
        impactId, _, _, _, _, _, _, _, _ = GetSpellInfo(64343);
        MageNugz_MinimapButton_Move()
end

function MageNuggetsOptions() --Options Frame
    local MageNugOptions = CreateFrame("FRAME", "MageNugOptions", InterfaceOptionsFrame)
    MageNugOptions.name = "Mage Nuggets"
    InterfaceOptions_AddCategory(MageNugOptions)
    MageNugOptions:SetPoint("TOPLEFT", InterfaceOptionsFrame, "BOTTOMRIGHT", 0, 0)
end

function hideMonitorToggle() --Sp and Crit Monitor Toggle
    local monitorChecked = myTabPage3_CheckButton1:GetChecked();
    if (monitorChecked == 1) then
	    MageNugSP_Frame:Hide();
        MageNugz.spMonitorToggle = false;
    else
        MageNugSP_Frame:Show();
        MageNugz.spMonitorToggle = true;
    end
end

function MNMinimapButtonToggle()
    local mini = myTabPage1_CheckButton0:GetChecked();
    if (mini == 1) then
        MageNugz.minimapToggle = false; 
        MageNug_MinimapFrame:Hide();
    else
        MageNugz.minimapToggle = true; 
        MageNug_MinimapFrame:Show();
    end
end

function HideSSMonitorToggle() -- Spellsteal Monitor Toggle
    local stealMonitorChecked = myTabPage1_CheckButton2:GetChecked();
    if (stealMonitorChecked == 1) then
	    MageNugz.ssMonitorToggle = false; 
    else
        MageNugz.ssMonitorToggle = true;
    end
end

function MageProcNoteToggle() -- Mage Proc Notification Toggle
    local cNotifyChecked = myTabPage1_CheckButton3:GetChecked();
    if (cNotifyChecked == 1) then
	    MageNugz.mageProcToggle = false;
    else
        MageNugz.mageProcToggle = true;
    end
end

function cameraZoomToggle() -- Camera Zoom Out Toggle
    local camZoomChecked = myTabPage1_CheckButton4:GetChecked();
    if (camZoomChecked == 1) then
        ConsoleExec("cameraDistanceMax 15");
        MageNugz.camZoomTogg = false;
    else  
        ConsoleExec("cameraDistanceMax 50");
        MageNugz.camZoomTogg = true;
    end
end

function absorbNotifyToggle() -- Actual Shield Damage Notify Toggle
    local absorbChecked = myTabPage1_CheckButton5:GetChecked();
    if (absorbChecked == 1) then
        MageNugz.absorbToggle = false;
    else  
        MageNugz.absorbToggle = true;
    end
end

function MirrorImageSoundToggle() -- Mirror Image Sound Toggle
    local miChecked = myTabPage4_MICheckButton:GetChecked();
    if (miChecked == 1) then
        MageNugz.miSoundToggle = true;
    else  
        MageNugz.miSoundToggle = false;
    end
end

function ProcSoundToggle() -- Proc Sound Toggle
    local procChecked = myTabPage4_ProcCheckButton:GetChecked();
    if (procChecked == 1) then
        MageNugz.procSoundToggle = true;
    else  
        MageNugz.procSoundToggle = false;
    end
end

function MirrorImagToggle() -- Mirror Image Timer Toggle
    local mirrorChecked = myTabPage1_CheckButton6:GetChecked();
    if (mirrorChecked == 1) then
        MageNugz.mirrorImageToggle = false;
    else  
        MageNugz.mirrorImageToggle = true;
    end
end

function WaterEleToggle() -- Water Elemental Timer Toggle
    local waterChecked = myTabPage1_CheckButton7:GetChecked();
    if (waterChecked == 1) then
        MageNugz.waterEleToggle = false;
    else  
        MageNugz.waterEleToggle = true;
    end
end

function EvoToggle() -- Evocation Toggle
    local evoChecked = myTabPage1_CheckButton8:GetChecked();
    if (evoChecked == 1) then
        MageNugz.evocationToggle = false;
    else  
        MageNugz.evocationToggle = true;
    end
end

function LivingBToggle() -- Evocation Toggle
    local lbChecked = myTabPage1_CheckButton9:GetChecked();
    if (lbChecked == 1) then
        MageNugz.livingBombToggle = false;
    else  
        MageNugz.livingBombToggle = true;
    end
end

function ScorchToggle() -- Scorch Toggle
    local sChecked = myTabPage1_ScorchCheckButton:GetChecked();
    if (sChecked == 1) then
        MageNugz.ScorchToggle = false;
    else  
        MageNugz.ScorchToggle = true;
    end
end

function MageProcMonitorToggle()
    local mpChecked = myTabPage1_CheckButton11:GetChecked();
    if (mpChecked == 1) then
        MageNugz.procMonitorToggle = false;
    else  
        MageNugz.procMonitorToggle = true;
    end
end

function MNArcaneBlastToggle()
    local abChecked = myTabPage1_CheckButton13:GetChecked();
    if (abChecked == 1) then
        MageNugz.arcaneBlastToggle = false;
    else  
        MageNugz.arcaneBlastToggle = true;
    end
end

function MNpolyToggle()
    local polyChecked = myTabPage1_CheckButton14:GetChecked();
    if (polyChecked == 1) then
        MageNugz.polyToggle = false;
    else  
        MageNugz.polyToggle = true;
    end
end

function ShowConfigFrames() --Shows frames for 20 seconds
    if (MageNugz.ssMonitorToggle == true) then
        spellStealTog = 20;
        MNSpellSteal_Frame:Show();
    end
    mirrorImageTime = 20;
    MageNugMI_Frame:Show();
    livingbombTime = 20;
    MageNugLB_Frame:Show();
    waterEleTime = 20;
    MageNugWE_Frame:Show();
    polyTimer = 20
    MageNugPolyFrameText:SetText("|cffFFFFFF"..L["Polymorph"])
    MageNugPolyFrame:Show();
    mageImpProgMonTime = 20;
    MageNugImpactProcFrameText:SetText("|cffFF0000"..L["IMPACT!"])
    MageNugImpactProcFrame:Show()
    mageProcBFTime = 20;
    MageNugBFProcFrameText:SetText("|cffFF3300"..L["BRAIN FREEZE!"])
    MageNugBFProcFrame:Show();
    mageProcHSTime = 20;
    MageNugProcFrameText:SetText("|cffFF0000"..L["HOT STREAK!"]);
    MageNugProcFrame:Show();
    mageProcMBTime = 20;
    MageNugMBProcFrameText:SetText("|cffFF33FF"..L["MISSILE BARRAGE!"])
    MageNugMBProcFrame:Show();
    fofProgMonTime = 20;
    MageNugFoFProcFrameText:SetText("|cffFFFFFF"..L["Fingers Of Frost"])
    MageNugFoFProcFrame:Show(); 
    abProgMonTime = 20;
    MageNugAB_Frame:Show();
    scorchTime = 20;
    MageNugScorch_Frame:Show();
end

function LockFramesToggle()
    local flChecked = myTabPage1_CheckButton10:GetChecked();
    if (flChecked == 1) then
        MageNugz.lockFrames = true;
    else  
        MageNugz.lockFrames = false;
    end
end

function ConsoleTextToggle()
    local ctChecked = myTabPage1_CheckButton12:GetChecked();
    if (ctChecked == 1) then
        MageNugz.consoleTextEnabled = false;
            
    else
        MageNugz.consoleTextEnabled = true;
    end

end
function  MageNugSpMonitorSize() --Function for the SP Slider
    local tempInt = myTabPage3_SPSizeSlider:GetValue()
    if (tempInt == 0) then
        MageNugSP_Frame:SetScale(0.7);
        MageNugz.spMonitorSize = 0;
    end
    if (tempInt == 1) then
        MageNugSP_Frame:SetScale(0.8);
        MageNugz.spMonitorSize = 1;
    end
    if (tempInt == 2) then
        MageNugSP_Frame:SetScale(0.9);
        MageNugz.spMonitorSize = 2;
    end
    if (tempInt == 3) then
        MageNugSP_Frame:SetScale(1.0);
        MageNugz.spMonitorSize = 3;
    end
    if (tempInt == 4) then
        MageNugSP_Frame:SetScale(1.1);
        MageNugz.spMonitorSize = 4;
    end
    if (tempInt == 5) then
        MageNugSP_Frame:SetScale(1.2);
        MageNugz.spMonitorSize = 5;
    end
    if (tempInt == 6) then
        MageNugSP_Frame:SetScale(1.3);
        MageNugz.spMonitorSize = 6;
    end
end

function  MageNugSSMonitorSize() --Function for the SS Slider
    local tempInt = myTabPage1_Slider2:GetValue()
    if (tempInt == 0) then
        MNSpellSteal_Frame:SetScale(0.7);
        MageNugz.ssMonitorSize = 0;
    end
    if (tempInt == 1) then
        MNSpellSteal_Frame:SetScale(0.8);
        MageNugz.ssMonitorSize = 1;
    end
    if (tempInt == 2) then
        MNSpellSteal_Frame:SetScale(0.9);
        MageNugz.ssMonitorSize = 2;
    end
    if (tempInt == 3) then
        MNSpellSteal_Frame:SetScale(1.0);
        MageNugz.ssMonitorSize = 3;
    end
    if (tempInt == 4) then
        MNSpellSteal_Frame:SetScale(1.1);
        MageNugz.ssMonitorSize = 4;
    end
    if (tempInt == 5) then
        MNSpellSteal_Frame:SetScale(1.2);
        MageNugz.ssMonitorSize = 5;
    end
    if (tempInt == 6) then
        MNSpellSteal_Frame:SetScale(1.3);
        MageNugz.ssMonitorSize = 6;
    end
end

function  MageNugProcMonitorSize() --Function for the SS Slider
    local tempInt = myTabPage1_Slider4:GetValue()
    if (tempInt == 0) then
        MageNugProcFrame:SetScale(0.7);
        MageNugMBProcFrame:SetScale(0.7);
        MageNugFoFProcFrame:SetScale(0.7);
        MageNugBFProcFrame:SetScale(0.7);
        MageNugImpactProcFrame:SetScale(0.7);
        MageNugz.procMonitorSize = 0;
    end
    if (tempInt == 1) then
        MageNugProcFrame:SetScale(0.8);
        MageNugMBProcFrame:SetScale(0.8);
        MageNugFoFProcFrame:SetScale(0.8);
        MageNugBFProcFrame:SetScale(0.8);
        MageNugImpactProcFrame:SetScale(0.8);
        MageNugz.procMonitorSize = 1;
    end
    if (tempInt == 2) then
        MageNugProcFrame:SetScale(0.9);
        MageNugMBProcFrame:SetScale(0.9);
        MageNugFoFProcFrame:SetScale(0.9);
        MageNugBFProcFrame:SetScale(0.9);
        MageNugImpactProcFrame:SetScale(0.9);
        MageNugz.procMonitorSize = 2;
    end
    if (tempInt == 3) then
        MageNugProcFrame:SetScale(1.0);
        MageNugMBProcFrame:SetScale(1.0);
        MageNugFoFProcFrame:SetScale(1.0);
        MageNugBFProcFrame:SetScale(1.0);
        MageNugImpactProcFrame:SetScale(1.0);
        MageNugz.procMonitorSize = 3;
    end
    if (tempInt == 4) then
        MageNugProcFrame:SetScale(1.1);
        MageNugMBProcFrame:SetScale(1.1);
        MageNugFoFProcFrame:SetScale(1.1);
        MageNugBFProcFrame:SetScale(1.1);
        MageNugImpactProcFrame:SetScale(1.1);
        MageNugz.procMonitorSize = 4;
    end
    if (tempInt == 5) then
        MageNugProcFrame:SetScale(1.2);
        MageNugMBProcFrame:SetScale(1.2);
        MageNugFoFProcFrame:SetScale(1.2);
        MageNugBFProcFrame:SetScale(1.2);
        MageNugImpactProcFrame:SetScale(1.2);
        MageNugz.procMonitorSize = 5;
    end
    if (tempInt == 6) then
        MageNugProcFrame:SetScale(1.3);
        MageNugMBProcFrame:SetScale(1.3);
        MageNugFoFProcFrame:SetScale(1.3);
        MageNugBFProcFrame:SetScale(1.3);
        MageNugImpactProcFrame:SetScale(1.3);
        MageNugz.procMonitorSize = 6;
    end
end

function MageNugLivingBombSize() 
 local tempInt = myTabPage1_Slider3:GetValue()
    if (tempInt == 0) then
        MageNugLB_Frame:SetScale(0.7);
        MageNugAB_Frame:SetScale(0.7);
        MageNugScorch_Frame:SetScale(0.7);
        MageNugz.livingBCounterSize = 0;
    end
    if (tempInt == 1) then
        MageNugLB_Frame:SetScale(0.8);
        MageNugAB_Frame:SetScale(0.8);
        MageNugScorch_Frame:SetScale(0.8);
        MageNugz.livingBCounterSize = 1;
    end
    if (tempInt == 2) then
        MageNugLB_Frame:SetScale(0.9);
        MageNugAB_Frame:SetScale(0.9);
        MageNugScorch_Frame:SetScale(0.9);
        MageNugz.livingBCounterSize = 2;
    end
    if (tempInt == 3) then
        MageNugLB_Frame:SetScale(1.0);
        MageNugAB_Frame:SetScale(1.0);
        MageNugScorch_Frame:SetScale(1.0);
        MageNugz.livingBCounterSize = 3;
    end
    if (tempInt == 4) then
        MageNugLB_Frame:SetScale(1.1);
        MageNugAB_Frame:SetScale(1.1);
        MageNugScorch_Frame:SetScale(1.1);
        MageNugz.livingBCounterSize = 4;
    end
    if (tempInt == 5) then
        MageNugLB_Frame:SetScale(1.2);
        MageNugAB_Frame:SetScale(1.2);
        MageNugScorch_Frame:SetScale(1.2);
        MageNugz.livingBCounterSize = 5;
    end
    if (tempInt == 6) then
        MageNugLB_Frame:SetScale(1.3);
        MageNugAB_Frame:SetScale(1.3);
        MageNugScorch_Frame:SetScale(1.3);
        MageNugz.livingBCounterSize = 6;
    end
end

function Tab2_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF"..L["Mage"].." |cff00CD00"..L["Nuggets"]..":|cffFFFFFF"..L["Messages are picked at random."].." \n"..L["To disable a message leave all of its boxes blank."])
  GameTooltip:Show()
end

function Monitors_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF"..L["Mage"].." |cff00CD00"..L["Nuggets"]..":|cffFFFFFF "..L["You can disable or resize this"].." \n"..L["monitor in options."])
  GameTooltip:Show()
end

function SPMonitor_OnEnter()
    GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
    GameTooltip:SetText("|cff00BFFF"..L["Mage"].." |cff00CD00"..L["Nuggets"]..":|cffFFFFFF "..L["You can customize or disable this"].." \n"..L["monitor in options."])
    GameTooltip:Show()
end

function CombatText_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF"..L["Mage"].." |cff00CD00"..L["Nuggets"]..":|cffFFFFFF "..L["Checking this will disable all notifications sent to"].." \n"..L["the chat console. This includes shield absorb, polymorph, evocation,"].." \n"..L["spellsteal notifications and all other chat console notifications."])
  GameTooltip:Show()
end

function MageProc_OnEnter()
  GameTooltip_SetDefaultAnchor( GameTooltip, UIParent )
  GameTooltip:SetText("|cff00BFFF"..L["Mage"].." |cff00CD00"..L["Nuggets"]..":|cffFFFFFF "..L["The in game combat text must be turned on"].." \n"..L["for mage proc combat text to function."])
  GameTooltip:Show()
end

function MNLockFrames()
    if (MageNugz.lockFrames == false)then
       this:StartMoving(); this.isMoving = true;
    end
end

function BorderTypeSlider()
    local tempInt = myTabPage3_BorderSlider:GetValue()
    if (tempInt == 0) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 0;
    end
    if (tempInt == 1) then
         MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
                                    edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 1;
    end
    if (tempInt == 2) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 2;
    end
    if (tempInt == 3) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 3;
    end
    if (tempInt == 4) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 4;
    end
    if (tempInt == 5) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    edgeFile = "Interface/DialogFrame/UI-DialogBox-Gold-Border",
                                    tile = true, tileSize = 16, edgeSize = 8, 
                                    insets = { left = 1, right = 1, top = 1, bottom = 1 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 5;
    end
    if (tempInt == 6) then
        MageNugSP_Frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
                                    tile = true, tileSize = 16, edgeSize = 16, 
                                    insets = { left = 4, right = 4, top = 4, bottom = 4 }});
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.borderStyle = 6;
    end
end

function BackdropTransparencySlider()
    local tempInt = myTabPage3_TransparencySlider:GetValue()
    if (tempInt == 0) then
        MageNugz.backdropA = 1.0;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 0;
    end
    if (tempInt == 1) then
        MageNugz.backdropA = 0.85;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 1;
    end
    if (tempInt == 2) then
        MageNugz.backdropA = 0.7;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 2;
    end
    if (tempInt == 3) then
        MageNugz.backdropA = 0.55;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 3;
    end
    if (tempInt == 4) then
        MageNugz.backdropA = 0.4;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 4;
    end
    if (tempInt == 5) then
        MageNugz.backdropA = 0.25;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 5;
    end
    if (tempInt == 6) then
        MageNugz.backdropA = 0.0;
        MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
        MageNugz.transColor = 6;
    end
end

function MNSetBackdropBlack()
    MageNugz.backdropR = 0.0;
    MageNugz.backdropG = 0.0;
    MageNugz.backdropB = 0.0;
    MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA)
end

function MNColorSelector()
    MageNugz.backdropR, MageNugz.backdropG, MageNugz.backdropB = myTabPage3ColorSelect:GetColorRGB();
    MageNugSP_Frame:SetBackdropColor(MageNugz.backdropR,MageNugz.backdropG,MageNugz.backdropB,MageNugz.backdropA);
end

function MageNugz_MinimapButton_Move()
	MageNug_MinimapFrame:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(MageNugz.MinimapPos)),(80*sin(MageNugz.MinimapPos))-52)
end

function MageNugz_MinimapButton_DraggingFrame_OnUpdate()
	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()
	xpos = xmin-xpos/UIParent:GetScale()+70 
    ypos = ypos/UIParent:GetScale()-ymin-70
	MageNugz.MinimapPos = math.deg(math.atan2(ypos,xpos))
    MageNugz_MinimapButton_Move()
end

function MageNuggets_Minimap_OnClick() 
    local englishFaction, localizedFaction = UnitFactionGroup("player")
    if (englishFaction == "Horde")then
        MageNugHordeFrame:Show();
    end
    if (englishFaction == "Alliance") then
        MageNugAlliFrame:Show();
    end   
end

