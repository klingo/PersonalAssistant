-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PAMD = PA.MenuDefaults
local PASV = PA.SavedVars
local PAEM = PA.EventManager
local L = PA.Localization

-- ---------------------------------------------------------------------------------------------------------------------

-- PAGeneral

--------------------------------------------------------------------------
-- PAGeneral   activeProfile
---------------------------------
local function getPAGeneralActiveProfile()
    local activeProfile = PASV.Profile.activeProfile
    if (activeProfile == nil) then
        return PAC.GENERAL.NO_PROFILE_SELECTED_ID
    else
        return activeProfile
    end
end

local function setPAGeneralActiveProfile(profileNo)
    if (profileNo ~= nil and profileNo ~= PAC.GENERAL.NO_PROFILE_SELECTED_ID) then
        -- get the previously active prefoile first
        local prevProfile = PASV.Profile.activeProfile
        -- then save the new one
        PASV.Profile.activeProfile = profileNo
        PA.activeProfile = profileNo
        -- if the previous profile was the "no profile selected" one, refresh the dropdown values
        if (prevProfile == nil) then
            local PAMenuHelper = PA.MenuHelper
            PAMenuHelper.reloadProfileList()
        end
        -- also refresh all event registrations
        PAEM.RefreshAllEventRegistrations()
    end
end

local function isDisabledPAGeneralNoProfileSelected()
    return (PA.activeProfile == nil)
end

-- ---------------------------------------------------------------------------------------------------------------------

local function isDisabled(savedVarsTable, ...)
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    local args = { ... }
    for _, tbl in ipairs(args) do
        -- return true when ANY setting is OFF
        if (#tbl == 1) then
            local attributeLevelOne = tbl[1]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne]) then return true end
        elseif (#tbl == 2) then
            local attributeLevelOne = tbl[1]
            local attributeLevelTwo = tbl[2]
            if (not savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]) then return true end
        else
            -- if either no table was sent, or more than 2; always return true (i.e. disabled)
            return true
        end
    end
    -- return false when ALL settings are ON
    return false
end


local function getValue(savedVarsTable, attributeTbl)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    if (#attributeTbl == 1) then
        local attributeLevelOne = attributeTbl[1]
        return savedVarsTable[PA.activeProfile][attributeLevelOne]
    elseif (#attributeTbl == 2) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        return savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo]
    else return end
end

local function setValue(savedVarsTable, value, attributeTbl)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    if (#attributeTbl == 1) then
        local attributeLevelOne = attributeTbl[1]
        savedVarsTable[PA.activeProfile][attributeLevelOne] = value
    elseif (#attributeTbl == 2) then
        local attributeLevelOne = attributeTbl[1]
        local attributeLevelTwo = attributeTbl[2]
        savedVarsTable[PA.activeProfile][attributeLevelOne][attributeLevelTwo] = value
    else return end
end

--------------------------------------------------------------------------
-- PAGeneral   activeProfileRename
---------------------------------
local function getPAGeneralActiveProfileRename()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].name
end

local function setPAGeneralActiveProfileRename(profileName)
    if (profileName ~= nil and profileName ~= "") then
        local PAMenuHelper = PA.MenuHelper
        PASV.General[PA.activeProfile].name = profileName
        -- when profile was changed, reload the profile list
        PAMenuHelper.reloadProfileList()
    end
end

--------------------------------------------------------------------------
-- PAGeneral   welcomeMessage
---------------------------------
local function getPAGeneralWelcomeMessage()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.General[PA.activeProfile].welcome
end

local function setPAGeneralWelcomeMessage(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.General[PA.activeProfile].welcome = value
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PARepair

--------------------------------------------------------------------------
-- PARepair   enable
---------------------------------
local function getPARepairEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
--    return PersonalAssistant.SavedVars.Repair[PersonalAssistant.SavedVars.Profile.activeProfile].enabled
    return PASV.Repair[PA.activeProfile].enabled
end

local function setPARepairEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PARepair   repairEquipped
---------------------------------
local function getPARepairRepairEquipped()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquipped
end

local function setPARepairRepairEquipped(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquipped = value
end

local function isDisabledPARepairRepairEquipped()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedThreshold
---------------------------------
local function getPARepairRepairEquippedThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedThreshold
end

local function setPARepairRepairEquippedThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedThreshold = value
end

local function isDisabledPARepairRepairEquippedThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKit
---------------------------------
local function getPARepairRepairEquippedWithKit()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedWithKit
end

local function setPARepairRepairEquippedWithKit(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedWithKit = value
end

local function isDisabledPARepairRepairEquippedWithKit()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   repairEquippedWithKitThreshold
---------------------------------
local function getPARepairRepairEquippedWithKitThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairEquippedWithKitThreshold
end

local function setPARepairRepairEquippedWithKitThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairEquippedWithKitThreshold = value
end

local function isDisabledPARepairRepairEquippedWithKitThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquippedWithKit)
end

--------------------------------------------------------------------------
-- PARepair   repairFullChatMode
---------------------------------
local function getPARepairRepairFullChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairFullChatMode
end

local function setPARepairRepairFullChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairFullChatMode = value
end

local function isDisabledPARepairRepairFullChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   repairPartialChatMode
---------------------------------
local function getPARepairRepairPartialChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].repairPartialChatMode
end

local function setPARepairRepairPartialChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].repairPartialChatMode = value
end

local function isDisabledPARepairRepairPartialChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].repairEquipped)
end

--------------------------------------------------------------------------
-- PARepair   chargeWeapons
---------------------------------
local function getPARepairChargeWeapons()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeapons
end

local function setPARepairChargeWeapons(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeapons = value
end

local function isDisabledPARepairChargeWeapons()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Repair[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PARepair   chargeWeaponsThreshold
---------------------------------
local function getPARepairChargeWeaponsThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeaponsThreshold
end

local function setPARepairChargeWeaponsThreshold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeaponsThreshold = value
end

local function isDisabledPARepairChargeWeaponsThreshold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].chargeWeapons)
end

--------------------------------------------------------------------------
-- PARepair   chargeWeaponsChatMode
---------------------------------
local function getPARepairChargeWeaponsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Repair[PA.activeProfile].chargeWeaponsChatMode
end

local function setPARepairChargeWeaponsChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Repair[PA.activeProfile].chargeWeaponsChatMode = value
end

local function isDisabledPARepairChargeWeaponsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Repair[PA.activeProfile].enabled and PASV.Repair[PA.activeProfile].chargeWeapons)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking

--------------------------------------------------------------------------
-- PABanking   Currencies       currenciesEnabled
---------------------------------
local function setPABankingCurrenciesEnabledSetting(value)
    setValue(PASV.Banking, value, {"Currencies", "currenciesEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Currencies       goldMinToKeep
---------------------------------
local function setPABAnkingGoldMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
    else
        local goldMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "goldMaxToKeep"}))

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= goldMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
--        else
--            setValue(PASV.Banking, goldMaxToKeep, {"Currencies", "goldMinToKeep"})
--            PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
        if (intValue > goldMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
            PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       goldMaxToKeep
---------------------------------
local function setPABAnkingGoldMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
    else
        local goldMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "goldMinToKeep"}))

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= goldMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
--        else
--            setValue(PASV.Banking, goldMinToKeep, {"Currencies", "goldMaxToKeep"})
--            PERSONALASSISTANT_PAB_GOLD_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "goldMaxToKeep"})
        if (intValue < goldMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "goldMinToKeep"})
            PERSONALASSISTANT_PAB_GOLD_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMinToKeep
---------------------------------
local function setPABAnkingAlliancePointsMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
    else
        local alliancePointsMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "alliancePointsMaxToKeep"}))

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= alliancePointsMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
--        else
--            setValue(PASV.Banking, alliancePointsMaxToKeep, {"Currencies", "alliancePointsMinToKeep"})
--            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
        if (intValue > alliancePointsMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       alliancePointsMaxToKeep
---------------------------------
local function setPABAnkingAlliancePointsMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
    else
        local alliancePointsMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "alliancePointsMinToKeep"}))

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= alliancePointsMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
--        else
--            setValue(PASV.Banking, alliancePointsMinToKeep, {"Currencies", "alliancePointsMaxToKeep"})
--            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMaxToKeep"})
        if (intValue < alliancePointsMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "alliancePointsMinToKeep"})
            PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMinToKeep
---------------------------------
local function setPABAnkingTelVarMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
    else
        local telVarMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "telVarMaxToKeep"}))

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= telVarMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
--        else
--            setValue(PASV.Banking, telVarMaxToKeep, {"Currencies", "telVarMinToKeep"})
--            PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
        if (intValue > telVarMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
            PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       telVarMaxToKeep
---------------------------------
local function setPABAnkingTelVarMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
    else
        local telVarMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "telVarMinToKeep"}))

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= telVarMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
--        else
--            setValue(PASV.Banking, telVarMinToKeep, {"Currencies", "telVarMaxToKeep"})
--            PERSONALASSISTANT_PAB_TELVAR_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "telVarMaxToKeep"})
        if (intValue < telVarMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "telVarMinToKeep"})
            PERSONALASSISTANT_PAB_TELVAR_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMinToKeep
---------------------------------
local function setPABAnkingWritVouchersMinToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
    else
        local writVouchersMaxToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "writVouchersMaxToKeep"}))

        -- OPTION 1: if min > max, deny changing min value
--        if (intValue <= writVouchersMaxToKeep) then
--            setValue(PASV.Banking, intValue, {"writVouchersMinToKeep"})
--        else
--            setValue(PASV.Banking, writVouchersMaxToKeep, {"Currencies", "writVouchersMinToKeep"})
--            PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
--        end

        -- OPTION 2: if min > max, also change max value
        setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMinToKeep"})
        if (intValue > writVouchersMaxToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Currencies       writVouchersMaxToKeep
---------------------------------
local function setPABAnkingWritVouchersMaxToKeepSetting(value)
    local intValue = tonumber(value)
    if not intValue or intValue < 0 then
        PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
    else
        local writVouchersMinToKeep = tonumber(getValue(PASV.Banking, {"Currencies", "writVouchersMinToKeep"}))

        -- OPTION 1: if max < min, deny changing max value
--        if (intValue >= writVouchersMinToKeep) then
--            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
--        else
--            setValue(PASV.Banking, writVouchersMinToKeep, {"Currencies", "writVouchersMaxToKeep"})
--            PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX:UpdateValue()
--        end

        -- OPTION 2: if max < min, also change min value
        setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMaxToKeep"})
        if (intValue < writVouchersMinToKeep) then
            setValue(PASV.Banking, intValue, {"Currencies", "writVouchersMinToKeep"})
            PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN:UpdateValue()
        end
    end
end

--------------------------------------------------------------------------
-- PABanking   Crafting         craftingItemsEnabled
---------------------------------
local function setPABankingCraftingItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Crafting", "craftingItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Crafting         craftingItemTypeMoveSetting
---------------------------------
local function getPABankingCraftingItemTypeMoveSetting(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Crafting.ItemTypesCrafting[itemType]
end

local function setPABankingCraftingItemTypeMoveSetting(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Crafting.ItemTypesCrafting[itemType] = value
end

local function setPABankingCraftingItemTypeMoveAllSettings(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    for itemType, _ in pairs(PASV.Banking[PA.activeProfile].Crafting.ItemTypesCrafting) do
        PASV.Banking[PA.activeProfile].Crafting.ItemTypesCrafting[itemType] = value
    end
    PERSONALASSISTANT_PAB_GLOBAL_MOVE_MODE:UpdateValue()
    -- TODO: chat-message do inform user?
end

--------------------------------------------------------------------------
-- PABanking   Advanced      advancedItemsEnabled
---------------------------------
local function setPABankingAdvancedItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Advanced", "advancedItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PABanking   Advanced         advancedItemTypeMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeMoveSetting(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Advanced.ItemTypesAdvanced[itemType]
end

local function setPABankingAdvancedItemTypeMoveSetting(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Advanced.ItemTypesAdvanced[itemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Advanced         advancedItemTypeSpecializedMoveSetting
---------------------------------
local function getPABankingAdvancedItemTypeSpecializedMoveSetting(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Banking[PA.activeProfile].Advanced.ItemTypesSpecializedAdvanced[itemType]
end

local function setPABankingAdvancedItemTypeSpecializedMoveSetting(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Advanced.ItemTypesSpecializedAdvanced[itemType] = value
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualItemsEnabled
---------------------------------
local function setPABankingIndividualItemsEnabledSetting(value)
    setValue(PASV.Banking, value, {"Individual", "individualItemsEnabled"})
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end


--------------------------------------------------------------------------
-- PABanking   Individual         individualMathOperator
---------------------------------
local function getPABankingIndividualItemIdMathOperatorSetting(individualItemId)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local value = PASV.Banking[PA.activeProfile].Individual.ItemIdOperator[individualItemId]
    if (value) then return value else return tonumber(PAMD.PABanking.Individual.individualOperator) end
end

local function setPABankingIndividualItemIdMathOperatorSetting(individualItemId, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Banking[PA.activeProfile].Individual.ItemIdOperator[individualItemId] = value
end

--------------------------------------------------------------------------
-- PABanking   Individual         individualBackpackAmount
---------------------------------
local function getPABankingIndividualItemIdBackpackAmountSetting(individualItemId)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local value = PASV.Banking[PA.activeProfile].Individual.ItemIdBackpackAmount[individualItemId]
    if (value) then return value else return tonumber(PAMD.PABanking.Individual.individualAmount) end
end


local function setPABankingIndividualItemIdBackpackAmountSetting(individualItemId, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    local intValue = tonumber(value)
    if intValue and intValue >= 0 then
        PASV.Banking[PA.activeProfile].Individual.ItemIdBackpackAmount[individualItemId] = intValue
    end
end

-- =====================================================================================================================
-- =====================================================================================================================

-- PABanking - Transaction Setting

--------------------------------------------------------------------------
-- PABanking   transactionDepositStacking
---------------------------------
local function isPABankingTransactionDepositStackingDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionWithdrawalStacking
---------------------------------
local function isPABankingTransactionWithdrawalStackingDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end

--------------------------------------------------------------------------
-- PABanking   transactionInterval
---------------------------------
local function isPABankingTransactionIntervalDisabled()
    if (not isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"})) then return false end
    if (not isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"})) then return false end
    return true
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PALoot

--------------------------------------------------------------------------
-- PALoot   enabled
---------------------------------
local function getPALootEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return (PASV.Loot[PA.activeProfile].enabled and not (GetSetting_Bool(SETTING_TYPE_LOOT, LOOT_SETTING_AUTO_LOOT)))
end

local function setPALootEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PALoot   lootGold
---------------------------------
local function getPALootLootGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootGold
end

local function setPALootLootGold(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootGold = value
end

local function isDisabledPALootLootGold()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootGoldChatMode
---------------------------------
local function getPALootLootGoldChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootGoldChatMode
end

local function setPALootLootGoldChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootGoldChatMode = value
end

local function isDisabledPALootLootGoldChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootGold)
end

--------------------------------------------------------------------------
-- PALoot   lootItems
---------------------------------
local function getPALootLootItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootItems
end

local function setPALootLootItems(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootItems = value
end

local function isDisabledPALootLootItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Loot[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PALoot   lootItemsChatMode
---------------------------------
local function getPALootLootItemsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootItemsChatMode
end

local function setPALootLootItemsChatMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootItemsChatMode = value
end

local function isDisabledPALootLootItemsChatMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   lootStolenItems
---------------------------------
local function getPALootLootStolenItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lootStolenItems
end

local function setPALootLootStolenItems(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lootStolenItems = value
end

local function isDisabledPALootLootStolenItems()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableBaitLootMode
---------------------------------
local function getPALootHarvestableBaitLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].harvestableBaitLootMode
end

local function setPALootHarvestableBaitLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].harvestableBaitLootMode = value
end

local function isDisabledPALootHarvestableBaitLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu harvestableItemTypesLootMode
---------------------------------
local function getPALootHarvestableItemTypesLootMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType]
end

local function setPALootHarvestableItemTypesLootMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = value
end

local function isDisabledPALootHarvestableItemTypesLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu autoLootAllHarvestableButton
---------------------------------
local function PALootAutoLootAllHarvestableButton()
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
    end
end

local function isDisabledPALootAutoLootAllHarvestableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   HarvestableItemSubMenu ignoreAllHarvestableButton
---------------------------------
local function PALootIgnoreAllHarvestableButton()
    for _, itemType in pairs(PALHarvestableItemTypes) do
        PASV.Loot[PA.activeProfile].HarvestableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
    end
end

local function isDisabledPALootIgnoreAllHarvestableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lootableItemTypesLootMode
---------------------------------
local function getPALootLootableItemTypesLootMode(itemType)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].LootableItemTypes[itemType]
end

local function setPALootLootableItemTypesLootMode(itemType, value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = value
end

local function isDisabledPALootLootableItemTypesLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu lockpickLootMode
---------------------------------
local function getPALootLockpickLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].lockpickLootMode
end

local function setPALootLockpickLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].lockpickLootMode = value
end

local function isDisabledPALootLockpickLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu questItemsLootMode
---------------------------------
local function getPALootQuestItemsLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Loot[PA.activeProfile].questItemsLootMode
end

local function setPALootQuestItemsLootMode(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Loot[PA.activeProfile].questItemsLootMode = value
end

local function isDisabledPALootQuestItemsLootMode()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu autoLootAllLootableButton
---------------------------------
local function PALootAutoLootAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_LOOT
        PASV.Loot[PA.activeProfile].lockpickLootMode = PAC_ITEMTYPE_LOOT
        PASV.Loot[PA.activeProfile].questItemsLootMode = PAC_ITEMTYPE_LOOT
    end
end

local function isDisabledPALootAutoLootAllLootableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end

--------------------------------------------------------------------------
-- PALoot   LootableItemSubMenu ignoreAllLootableButton
---------------------------------
local function PALootIgnoreAllLootableButton()
    for _, itemType in pairs(PALLootableItemTypes) do
        PASV.Loot[PA.activeProfile].LootableItemTypes[itemType] = PAC_ITEMTYPE_IGNORE
        PASV.Loot[PA.activeProfile].lockpickLootMode = PAC_ITEMTYPE_IGNORE
        PASV.Loot[PA.activeProfile].questItemsLootMode = PAC_ITEMTYPE_IGNORE
    end
end

local function isDisabledPALootIgnoreAllLootableButton()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not (PASV.Loot[PA.activeProfile].enabled and PASV.Loot[PA.activeProfile].lootItems)
end


-- =====================================================================================================================
-- =====================================================================================================================

-- PAJunk

--------------------------------------------------------------------------
-- PAJunk   enabled
---------------------------------
local function getPAJunkEnabled()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].enabled
end

local function setPAJunkEnabled(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].enabled = value
    -- when enabling/disabling a modules, refresh all event registrations
    PAEM.RefreshAllEventRegistrations()
end

--------------------------------------------------------------------------
-- PAJunk   autoSellJunk
---------------------------------
local function getPAJunkAutoSellJunk()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoSellJunk
end

local function setPAJunkAutoSellJunk(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoSellJunk = value
end

local function isDisabledPAJunkAutoSellJunk()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkTrash
---------------------------------
local function getPAJunkAutoMarkTrash()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoMarkTrash
end

local function setPAJunkAutoMarkTrash(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoMarkTrash = value
end

local function isDisabledPAJunkAutoMarkTrash()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
end

--------------------------------------------------------------------------
-- PAJunk   autoMarkOrnate
---------------------------------
local function getPAJunkAutoMarkOrnate()
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    return PASV.Junk[PA.activeProfile].autoMarkOrnate
end

local function setPAJunkAutoMarkOrnate(value)
    if (isDisabledPAGeneralNoProfileSelected()) then return end
    PASV.Junk[PA.activeProfile].autoMarkOrnate = value
end

local function isDisabledPAJunkAutoMarkOrnate()
    if (isDisabledPAGeneralNoProfileSelected()) then return true end
    return not PASV.Junk[PA.activeProfile].enabled
end



-- =====================================================================================================================
-- =====================================================================================================================

-- Export
PA.MenuFunctions = {
    PAGeneral = {
        isNoProfileSelected = isDisabledPAGeneralNoProfileSelected,

        getActiveProfile = getPAGeneralActiveProfile,
        setActiveProfile = setPAGeneralActiveProfile,

        getActiveProfileRename = getPAGeneralActiveProfileRename,
        setActiveProfileRename = setPAGeneralActiveProfileRename,

        getWelcomeMessageSetting = getPAGeneralWelcomeMessage,
        setWelcomeMessageSetting = setPAGeneralWelcomeMessage
    },
    PARepair = {
        isEnabled = getPARepairEnabled,
        setIsEnabled = setPARepairEnabled,

        isRepairEquippedDisabled = isDisabledPARepairRepairEquipped,
        getRepairEquippedSetting = getPARepairRepairEquipped,
        setRepairEquippedSetting = setPARepairRepairEquipped,

        isRepairEquippedThresholdDisabled = isDisabledPARepairRepairEquippedThreshold,
        getRepairEquippedThresholdSetting = getPARepairRepairEquippedThreshold,
        setRepairEquippedThresholdSetting = setPARepairRepairEquippedThreshold,

        isRepairEquippedWithKitDisabled = isDisabledPARepairRepairEquippedWithKit,
        getRepairEquippedWithKitSetting = getPARepairRepairEquippedWithKit,
        setRepairEquippedWithKitSetting = setPARepairRepairEquippedWithKit,

        isRepairEquippedWithKitThresholdDisabled = isDisabledPARepairRepairEquippedWithKitThreshold,
        getRepairEquippedWithKitThresholdSetting = getPARepairRepairEquippedWithKitThreshold,
        setRepairEquippedWithKitThresholdSetting = setPARepairRepairEquippedWithKitThreshold,

        isRepairFullChatModeDisabled = isDisabledPARepairRepairFullChatMode,
        getRepairFullChatModeSetting = getPARepairRepairFullChatMode,
        setRepairFullChatModeSetting = setPARepairRepairFullChatMode,

        isRepairPartialChatModeDisabled = isDisabledPARepairRepairPartialChatMode,
        getRepairPartialChatModeSetting = getPARepairRepairPartialChatMode,
        setRepairPartialChatModeSetting = setPARepairRepairPartialChatMode,

        isChargeWeaponsDisabled = isDisabledPARepairChargeWeapons,
        getChargeWeaponsSetting = getPARepairChargeWeapons,
        setChargeWeaponsSetting = setPARepairChargeWeapons,

        isChargeWeaponsThresholdDisabled = isDisabledPARepairChargeWeaponsThreshold,
        getChargeWeaponsThresholdSetting = getPARepairChargeWeaponsThreshold,
        setChargeWeaponsThresholdSetting = setPARepairChargeWeaponsThreshold,

        isChargeWeaponsChatModeDisabled = isDisabledPARepairChargeWeaponsChatMode,
        getChargeWeaponsChatModeSetting = getPARepairChargeWeaponsChatMode,
        setChargeWeaponsChatModeSetting = setPARepairChargeWeaponsChatMode,
    },
    PABanking = {
        -- -----------------------------------------------------------------------------------
        -- CURRENCIES
        -- -----------------------------
        getCurrenciesEnabledSetting = function() return getValue(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
        setCurrenciesEnabledSetting = setPABankingCurrenciesEnabledSetting,

        isGoldTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
        isGoldTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
        getGoldTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "goldTransaction"}) end,
        setGoldTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "goldTransaction"}) end,

        isGoldMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
        getGoldMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "goldMinToKeep"}) end,
        setGoldMinToKeepSetting =  setPABAnkingGoldMinToKeepSetting,

        isGoldMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "goldTransaction"}) end,
        getGoldMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "goldMaxToKeep"}) end,
        setGoldMaxToKeepSetting =  setPABAnkingGoldMaxToKeepSetting,

        isAlliancePointsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
        isAlliancePointsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
        getAlliancePointsTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsTransaction"}) end,
        setAlliancePointsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "alliancePointsTransaction"}) end,

        isAlliancePointsMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
        getAlliancePointsMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsMinToKeep"}) end,
        setAlliancePointsMinToKeepSetting = setPABAnkingAlliancePointsMinToKeepSetting,

        isAlliancePointsMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "alliancePointsTransaction"}) end,
        getAlliancePointsMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "alliancePointsMaxToKeep"}) end,
        setAlliancePointsMaxToKeepSetting = setPABAnkingAlliancePointsMaxToKeepSetting,

        isTelVarTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
        isTelVarTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
        getTelVarTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarTransaction"}) end,
        setTelVarTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "telVarTransaction"}) end,

        isTelVarMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
        getTelVarMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarMinToKeep"}) end,
        setTelVarMinToKeepSetting = setPABAnkingTelVarMinToKeepSetting,

        isTelVarMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "telVarTransaction"}) end,
        getTelVarMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "telVarMaxToKeep"}) end,
        setTelVarMaxToKeepSetting = setPABAnkingTelVarMaxToKeepSetting,

        isWritVouchersTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
        isWritVouchersTransactionDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}) end,
        getWritVouchersTransactionSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersTransaction"}) end,
        setWritVouchersTransactionSetting = function(value) setValue(PASV.Banking, value, {"Currencies", "writVouchersTransaction"}) end,

        isWritVouchersMinToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
        getWritVouchersMinToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersMinToKeep"}) end,
        setWritVouchersMinToKeepSetting = setPABAnkingWritVouchersMinToKeepSetting,

        isWritVouchersMaxToKeepDisabled = function() return isDisabled(PASV.Banking, {"Currencies", "currenciesEnabled"}, {"Currencies", "writVouchersTransaction"}) end,
        getWritVouchersMaxToKeepSetting = function() return getValue(PASV.Banking, {"Currencies", "writVouchersMaxToKeep"}) end,
        setWritVouchersMaxToKeepSetting = setPABAnkingWritVouchersMaxToKeepSetting,

        -- -----------------------------------------------------------------------------------
        -- CRAFTING ITEMS
        -- -----------------------------
        getCraftingItemsEnabledSetting = function() return getValue(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        setCraftingItemsEnabledSetting = setPABankingCraftingItemsEnabledSetting,

        isCraftingItemsGlobalMoveModeDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        setCraftingItemsGlobalMoveModeSetting = function(value) setPABankingCraftingItemTypeMoveAllSettings(value) end,

        getCraftingItemTypeMoveSetting = getPABankingCraftingItemTypeMoveSetting,
        setCraftingItemTypeMoveSetting = setPABankingCraftingItemTypeMoveSetting,

        isBlacksmithingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "blacksmithingTransaction"}) end,
        isBlacksmithingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getBlacksmithingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "blacksmithingTransaction"}) end,
        setBlacksmithingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "blacksmithingTransaction"}) end,

        isClothingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "clothingTransaction"}) end,
        isClothingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getClothingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "clothingTransaction"}) end,
        setClothingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "clothingTransaction"}) end,

        isWoodworkingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "woodworkingTransaction"}) end,
        isWoodworkingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getWoodworkingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "woodworkingTransaction"}) end,
        setWoodworkingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "woodworkingTransaction"}) end,

        isJewelcraftingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "jewelcraftingTransaction"}) end,
        isJewelcraftingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getJewelcraftingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "jewelcraftingTransaction"}) end,
        setJewelcraftingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "jewelcraftingTransaction"}) end,

        isAlchemyTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "alchemyTransaction"}) end,
        isAlchemyTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getAlchemyTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "alchemyTransaction"}) end,
        setAlchemyTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "alchemyTransaction"}) end,

        isEnchantingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "enchantingTransaction"}) end,
        isEnchantingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getEnchantingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "enchantingTransaction"}) end,
        setEnchantingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "enchantingTransaction"}) end,

        isProvisioningTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "provisioningTransaction"}) end,
        isProvisioningTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getProvisioningTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "provisioningTransaction"}) end,
        setProvisioningTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "provisioningTransaction"}) end,

        isStyleMaterialsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "styleMaterialsTransaction"}) end,
        isStyleMaterialsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getStyleMaterialsTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "styleMaterialsTransaction"}) end,
        setStyleMaterialsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "styleMaterialsTransaction"}) end,

        isTraitItemsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "traitItemsTransaction"}) end,
        isTraitItemsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getTraitItemsTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "traitItemsTransaction"}) end,
        setTraitItemsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "traitItemsTransaction"}) end,

        isFurnishingTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}, {"Crafting", "furnishingTransaction"}) end,
        isFurnishingTransactionDisabled = function() return isDisabled(PASV.Banking, {"Crafting", "craftingItemsEnabled"}) end,
        getFurnishingTransactionSetting = function() return getValue(PASV.Banking, {"Crafting", "furnishingTransaction"}) end,
        setFurnishingTransactionSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "furnishingTransaction"}) end,

        -- ----------------------------------------------------------------------------------
        -- ADVANCED ITEMS
        -- -----------------------------
        getAdvancedItemsEnabledSetting = function() return getValue(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        setAdvancedItemsEnabledSetting = setPABankingAdvancedItemsEnabledSetting,

        getAdvancedItemTypeMoveSetting = getPABankingAdvancedItemTypeMoveSetting,
        setAdvancedItemTypeMoveSetting = setPABankingAdvancedItemTypeMoveSetting,

        getAdvancedItemTypeSpecializedMoveSetting = getPABankingAdvancedItemTypeSpecializedMoveSetting,
        setAdvancedItemTypeSpecializedMoveSetting = setPABankingAdvancedItemTypeSpecializedMoveSetting,

        isMotifTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "motifTransaction"}) end,
        isMotifTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getMotifTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "motifTransaction"}) end,
        setMotifTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "motifTransaction"}) end,

        isRecipeTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "recipeTransaction"}) end,
        isRecipeTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getRecipeTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "recipeTransaction"}) end,
        setRecipeTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "recipeTransaction"}) end,

        isGlyphsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "glyphsTransaction"}) end,
        isGlyphsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getGlyphsTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "glyphsTransaction"}) end,
        setGlyphsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "glyphsTransaction"}) end,

        isLiquidsTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "liquidsTransaction"}) end,
        isLiquidsTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getLiquidsTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "liquidsTransaction"}) end,
        setLiquidsTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "liquidsTransaction"}) end,

        isTrophiesTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}, {"Advanced", "trophiesTransaction"}) end,
        isTrophiesTransactionDisabled = function() return isDisabled(PASV.Banking, {"Advanced", "advancedItemsEnabled"}) end,
        getTrophiesTransactionSetting = function() return getValue(PASV.Banking, {"Advanced", "trophiesTransaction"}) end,
        setTrophiesTransactionSetting = function(value) setValue(PASV.Banking, value, {"Advanced", "trophiesTransaction"}) end,

        -- ----------------------------------------------------------------------------------
        -- INDIVIDUAL ITEMS
        -- -----------------------------
        getIndividualItemsEnabledSetting = function() return getValue(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
        setIndividualItemsEnabledSetting = setPABankingIndividualItemsEnabledSetting,

        isLockpickTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "lockpickTransaction"}) end,
        isLockpickTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
        getLockpickTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "lockpickTransaction"}) end,
        setLockpickTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "lockpickTransaction"}) end,

        isSoulGemTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "soulGemTransaction"}) end,
        isSoulGemTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
        getSoulGemTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "soulGemTransaction"}) end,
        setSoulGemTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "soulGemTransaction"}) end,

        isRepairKitTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "repairKitTransaction"}) end,
        isRepairKitTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
        getRepairKitTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "repairKitTransaction"}) end,
        setRepairKitTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "repairKitTransaction"}) end,

        isGenericTransactionMenuDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}, {"Individual", "genericTransaction"}) end,
        isGenericTransactionDisabled = function() return isDisabled(PASV.Banking, {"Individual", "individualItemsEnabled"}) end,
        getGenericTransactionSetting = function() return getValue(PASV.Banking, {"Individual", "genericTransaction"}) end,
        setGenericTransactionSetting = function(value) setValue(PASV.Banking, value, {"Individual", "genericTransaction"}) end,

        getIndividualItemIdMathOperatorSetting = getPABankingIndividualItemIdMathOperatorSetting,
        setIndividualItemIdMathOperatorSetting = setPABankingIndividualItemIdMathOperatorSetting,
        getIndividualItemIdAmountSetting = getPABankingIndividualItemIdBackpackAmountSetting,
        setIndividualItemIdAmountSetting = setPABankingIndividualItemIdBackpackAmountSetting,

        -- ----------------------------------------------------------------------------------
        -- TRANSACTION SETTINGS
        -- -----------------------------
        isTransactionDepositStackingDisabled = isPABankingTransactionDepositStackingDisabled,
        getTransactionDepositStackingSetting = function() return getValue(PASV.Banking, {"Crafting", "craftingItemsDepositStacking"}) end,
        setTransactionDepositStackingSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "craftingItemsDepositStacking"}) end,

        isTransactionWithdrawalStackingDisabled = isPABankingTransactionWithdrawalStackingDisabled,
        getTransactionWithdrawalStackingSetting = function() return getValue(PASV.Banking, {"Crafting", "craftingItemsWithdrawalStacking"}) end,
        setTransactionWithdrawalStackingSetting = function(value) setValue(PASV.Banking, value, {"Crafting", "craftingItemsWithdrawalStacking"}) end,

        isTransactionInvervalDisabled = isPABankingTransactionIntervalDisabled,
        getTransactionInvervalSetting = function() return getValue(PASV.Banking, {"transactionInterval"}) end,
        setTransactionInvervalSetting = function(value) setValue(PASV.Banking, value, {"transactionInterval"}) end,

        getAutoStackBankSetting = function() return getValue(PASV.Banking, {"autoStackBank"}) end,
        setAutoStackBankSetting = function(value) setValue(PASV.Banking, value, {"autoStackBank"}) end,
    },
    PALoot = {
        isEnabled = getPALootEnabled,
        setIsEnabled = setPALootEnabled,

        isLootGoldDisabled = isDisabledPALootLootGold,
        getLootGoldSetting = getPALootLootGold,
        setLootGoldSetting = setPALootLootGold,

        isLootGoldChatModeDisabled = isDisabledPALootLootGoldChatMode,
        getLootGoldChatModeSetting = getPALootLootGoldChatMode,
        setLootGoldChatModeSetting = setPALootLootGoldChatMode,

        isLootItemsDisabled = isDisabledPALootLootItems,
        getLootItemsSetting = getPALootLootItems,
        setLootItemsSetting = setPALootLootItems,

        isLootItemsChatModeDisabled = isDisabledPALootLootItemsChatMode,
        getLootItemsChatModeSetting = getPALootLootItemsChatMode,
        setLootItemsChatModeSetting = setPALootLootItemsChatMode,

        isLootStolenItemsSettingDisabled = isDisabledPALootLootStolenItems,
        getLootStolenItemsSetting = getPALootLootStolenItems,
        setLootStolenItemsSetting = setPALootLootStolenItems,

        isHarvestableBaitLootModeDisabled = isDisabledPALootHarvestableBaitLootMode,
        getHarvestableBaitLootModeSetting = getPALootHarvestableBaitLootMode,
        setHarvestableBaitLootModeSetting = setPALootHarvestableBaitLootMode,

        isHarvestableItemTypesLootModeDisabled = isDisabledPALootHarvestableItemTypesLootMode,
        getHarvestableItemTypesLootModeSetting = getPALootHarvestableItemTypesLootMode,
        setHarvestableItemTypesLootModeSetting = setPALootHarvestableItemTypesLootMode,

        isAutoLootAllHarvestableButtonDisabled = isDisabledPALootAutoLootAllHarvestableButton,
        clickAutoLootAllHarvestableButton = PALootAutoLootAllHarvestableButton,

        isIgnoreAllHarvestableButtonDisabled = isDisabledPALootIgnoreAllHarvestableButton,
        clickIgnoreAllHarvestableButton = PALootIgnoreAllHarvestableButton,

        isLootableItemTypesLootModeDisabled = isDisabledPALootLootableItemTypesLootMode,
        getLootableItemTypesLootModeSetting = getPALootLootableItemTypesLootMode,
        setLootableItemTypesLootModeSetting = setPALootLootableItemTypesLootMode,

        isLockpickLootModeDisabled = isDisabledPALootLockpickLootMode,
        getLockpickLootModeSetting = getPALootLockpickLootMode,
        setLockpickLootModeSetting = setPALootLockpickLootMode,

        isQuestItemsLootModeDisabled = isDisabledPALootQuestItemsLootMode,
        getQuestItemsLootModeSetting = getPALootQuestItemsLootMode,
        setQuestItemsLootModeSetting = setPALootQuestItemsLootMode,

        isAutoLootAllLootableButtonDisabled = isDisabledPALootAutoLootAllLootableButton,
        clickAutoLootAllLootableButton = PALootAutoLootAllLootableButton,

        isIgnoreAllLootableButtonDisabled = isDisabledPALootIgnoreAllLootableButton,
        clickIgnoreAllLootableButton = PALootIgnoreAllLootableButton,
        
    },
    PAJunk = {
        isEnabled = getPAJunkEnabled,
        setIsEnabled = setPAJunkEnabled,

        isAutoSellJunkDisabled = isDisabledPAJunkAutoSellJunk,
        getAutoSellJunkSetting = getPAJunkAutoSellJunk,
        setAutoSellJunkSetting = setPAJunkAutoSellJunk,

        isAutoMarkTrashDisabled = isDisabledPAJunkAutoMarkTrash,
        getAutoMarkTrashSetting = getPAJunkAutoMarkTrash,
        setAutoMarkTrashSetting = setPAJunkAutoMarkTrash,

        isAutoMarkOrnateDisabled = isDisabledPAJunkAutoMarkOrnate,
        getAutoMarkOrnateSetting = getPAJunkAutoMarkOrnate,
        setAutoMarkOrnateSetting = setPAJunkAutoMarkOrnate,
    }
}











