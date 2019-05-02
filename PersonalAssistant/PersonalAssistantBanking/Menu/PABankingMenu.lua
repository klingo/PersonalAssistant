-- Local instances of Global tables --
local PA = PersonalAssistant
local PAC = PA.Constants
local PACAddon = PAC.ADDON
local PAHF = PA.HelperFunctions
local PAMenuHelper = PA.MenuHelper
local PAGMenuFunctions = PA.MenuFunctions.PAGeneral
local PABMenuChoices = PA.MenuChoices.choices.PABanking
local PABMenuChoicesValues = PA.MenuChoices.choicesValues.PABanking
local PABMenuDefaults = PA.MenuDefaults.PABanking
local PABMenuFunctions = PA.MenuFunctions.PABanking

local LAM2 = LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

local PABankingPanelData = {
    type = "panel",
    name = PACAddon.NAME_RAW.BANKING,
    displayName = PACAddon.NAME_DISPLAY,
    author = PACAddon.AUTHOR,
    version = PACAddon.VERSION_DISPLAY,
    website = PACAddon.WEBSITE,
    feedback = PACAddon.FEEDBACK,
    keywords = PACAddon.KEYWORDS.BANKING,
    slashCommand = "/pab",
    registerForRefresh = true,
    registerForDefaults = true,
}

local PABankingOptionsTable = setmetatable({}, { __index = table })

local PABCurrencyGoldSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyAlliancePointsSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyTelVarSubmenuTable = setmetatable({}, { __index = table })
local PABCurrencyWritVouchersSubmenuTable = setmetatable({}, { __index = table })

local PABCraftingBlacksmithingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingClothingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingWoodworkingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingJewelcraftingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingAlchemySubmenuTable = setmetatable({}, { __index = table })
local PABCraftingEnchantingSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingProvisioningSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingStyleMaterialsSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingTraitItemsSubmenuTable = setmetatable({}, { __index = table })
local PABCraftingFurnishingSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedMotifSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedRecipeSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedWritsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedGlyphsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedLiquidsSubmenuTable = setmetatable({}, { __index = table })
local PABAdvancedFoodDrinksSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedTrophiesSubmenuTable = setmetatable({}, { __index = table })

local PABAdvancedIntricateItemsSubmenuTable = setmetatable({}, { __index = table })

local PABIndividualLockpickSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualSoulGemSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualRepairKitSubmenuTable = setmetatable({}, { __index = table })
local PABIndividualGenericSubmenuTable = setmetatable({}, { __index = table })

local PABAvASiegeBallistaSubmenuTable = setmetatable({}, { __index = table })
local PABAvASiegeCatapultSubmenuTable = setmetatable({}, { __index = table })
local PABAvASiegeTrebuchetSubmenuTable = setmetatable({}, { __index = table })
local PABAvASiegeRamSubmenuTable = setmetatable({}, { __index = table })
local PABAvASiegeOilSubmenuTable = setmetatable({}, { __index = table })
local PABAvASiegeGraveyardSubmenuTable = setmetatable({}, { __index = table })

local PABAvARepairSubmenuTable = setmetatable({}, { __index = table })
local PABAvAOtherSubmenuTable = setmetatable({}, { __index = table })

-- =================================================================================================================

local function _createPABankingMenu()
    PABankingOptionsTable:insert({
        type = "header",
        name = GetString(SI_PA_MENU_BANKING_HEADER)
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_DESCRIPTION),
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ENABLE),
        getFunc = PABMenuFunctions.getCurrenciesEnabledSetting,
        setFunc = PABMenuFunctions.setCurrenciesEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Currencies.currenciesEnabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_GOLD_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_MONEY].keyboardTexture,
        tooltip = GetCurrencyDescription(CURT_MONEY),
        controls = PABCurrencyGoldSubmenuTable,
        disabledLabel = PABMenuFunctions.isGoldTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_ALLIANCE_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_ALLIANCE_POINTS].keyboardTexture,
        tooltip = GetCurrencyDescription(CURT_ALLIANCE_POINTS),
        controls = PABCurrencyAlliancePointsSubmenuTable,
        disabledLabel = PABMenuFunctions.isAlliancePointsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_TELVAR_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_TELVAR_STONES].keyboardTexture,
        tooltip = GetCurrencyDescription(CURT_TELVAR_STONES),
        controls = PABCurrencyTelVarSubmenuTable,
        disabledLabel = PABMenuFunctions.isTelVarTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_CURRENCY_WRIT_HEADER),
        icon = ZO_CURRENCIES_DATA[CURT_WRIT_VOUCHERS].keyboardTexture,
        tooltip = GetCurrencyDescription(CURT_WRIT_VOUCHERS),
        controls = PABCurrencyWritVouchersSubmenuTable,
        disabledLabel = PABMenuFunctions.isWritVouchersTransactionMenuDisabled,
    })

    -- -----------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })


    -- check if player has the addon [Dolgubon's Lazy Writ Crafter]
    if WritCreater then
        -- if yes, add additional option
        PABankingOptionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_BANKING_LWC_COMPATIBILTY),
            tooltip = GetString(SI_PA_MENU_BANKING_LWC_COMPATIBILTY_T),
            getFunc = PABMenuFunctions.getLazyWritCraftingCompatiblitySetting,
            setFunc = PABMenuFunctions.setLazyWritCraftingCompatiblitySetting,
            disabled = PAGMenuFunctions.isNoProfileSelected,
            default = PABMenuDefaults.lazyWritCraftingCompatiblity,
        })

        PABankingOptionsTable:insert({
            type = "divider",
            alpha = 0.5,
        })
    end


    if IsESOPlusSubscriber() then
        -- In case of ESO Plus Subscription, only show a remark that Crafting Material Banking
        -- options are not available (--> Virtual Bag)

        PABankingOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_ESOPLUS_DESC)
        })

    else
        -- Regular player without ESO Plus Subscription
        PABankingOptionsTable:insert({
            type = "checkbox",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENABLE),
            tooltip = GetString(SI_PA_MENU_BANKING_CRAFTING_ENABLE_T),
            getFunc = PABMenuFunctions.getCraftingItemsEnabledSetting,
            setFunc = PABMenuFunctions.setCraftingItemsEnabledSetting,
            disabled = PAGMenuFunctions.isNoProfileSelected,
            default = PABMenuDefaults.Crafting.craftingItemsEnabled,
        })

        PABankingOptionsTable:insert({
            type = "description",
            text = GetString(SI_PA_MENU_BANKING_CRAFTING_DESCRIPTION)
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_BLACKSMITHING),
            icon = PAC.ICONS.CRAFTBAG.BLACKSMITHING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingBlacksmithingSubmenuTable,
            disabledLabel = PABMenuFunctions.isBlacksmithingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_CLOTHING),
            icon = PAC.ICONS.CRAFTBAG.CLOTHING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingClothingSubmenuTable,
            disabledLabel = PABMenuFunctions.isClothingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_WOODWORKING),
            icon = PAC.ICONS.CRAFTBAG.WOODWORKING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingWoodworkingSubmenuTable,
            disabledLabel = PABMenuFunctions.isWoodworkingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_JEWELCRAFTING),
            icon = PAC.ICONS.CRAFTBAG.JEWELCRAFTING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingJewelcraftingSubmenuTable,
            disabledLabel = PABMenuFunctions.isJewelcraftingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ALCHEMY),
            icon = PAC.ICONS.CRAFTBAG.ALCHEMY.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingAlchemySubmenuTable,
            disabledLabel = PABMenuFunctions.isAlchemyTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_ENCHANTING),
            icon = PAC.ICONS.CRAFTBAG.ENCHANTING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingEnchantingSubmenuTable,
            disabledLabel = PABMenuFunctions.isEnchantingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_PROVISIONING),
            icon = PAC.ICONS.CRAFTBAG.PROVISIONING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingProvisioningSubmenuTable,
            disabledLabel = PABMenuFunctions.isProvisioningTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_STYLEMATERIALS),
            icon = PAC.ICONS.CRAFTBAG.STYLEMATERIALS.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingStyleMaterialsSubmenuTable,
            disabledLabel = PABMenuFunctions.isStyleMaterialsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_TRAITITEMS),
            icon = PAC.ICONS.CRAFTBAG.TRAITITEMS.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.LARGE,
            controls = PABCraftingTraitItemsSubmenuTable,
            disabledLabel = PABMenuFunctions.isTraitItemsTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_FURNISHING),
            icon = PAC.ICONS.CRAFTBAG.FURNISHING.PATH,
            iconTextureCoords = PAC.ICONS.TEXTURE_COORDS.MEDIUM,
            controls = PABCraftingFurnishingSubmenuTable,
            disabledLabel = PABMenuFunctions.isFurnishingTransactionMenuDisabled,
        })

        PABankingOptionsTable:insert({
            type = "dropdown",
            name = GetString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE),
            tooltip = GetString(SI_PA_MENU_BANKING_CRAFTING_GLOBAL_MOVEMODE_T),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemsGlobalMoveModeSetting(value) end,
            disabled = PABMenuFunctions.isCraftingItemsGlobalMoveModeDisabled,
            warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
            reference = "PERSONALASSISTANT_PAB_CRAFTING_GLOBAL_MOVE_MODE",
        })
    end

    -- ---------------------------------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_ENABLE),
        tooltip = GetString(SI_PA_MENU_BANKING_ADVANCED_ENABLE_T),
        getFunc = PABMenuFunctions.getAdvancedItemsEnabledSetting,
        setFunc = PABMenuFunctions.setAdvancedItemsEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Advanced.advancedItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_ADVANCED_DESCRIPTION)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_MOTIF_HEADER),
        icon = PAC.ICONS.ITEMS.MOTIF.PATH,
        controls = PABAdvancedMotifSubmenuTable,
        disabledLabel = PABMenuFunctions.isMotifTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_RECIPE_HEADER),
        icon = PAC.ICONS.ITEMS.RECIPE.PATH,
        controls = PABAdvancedRecipeSubmenuTable,
        disabledLabel = PABMenuFunctions.isRecipeTransactionMenuDisabled,
    })
    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_WRITS_HEADER),
        icon = PAC.ICONS.ITEMS.MASTER_WRIT.PATH,
        controls = PABAdvancedWritsSubmenuTable,
        disabledLabel = PABMenuFunctions.isWritsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLYPHS_HEADER),
        icon = PAC.ICONS.ITEMS.GLYPH_ARMOR_HEALTH.PATH,
        controls = PABAdvancedGlyphsSubmenuTable,
        disabledLabel = PABMenuFunctions.isGlyphsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_LIQUIDS_HEADER),
        icon = PAC.ICONS.ITEMS.POTION.PATH,
        controls = PABAdvancedLiquidsSubmenuTable,
        disabledLabel = PABMenuFunctions.isLiquidsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_FOOD_DRINKS_HEADER),
        icon = PAC.ICONS.ITEMS.FOOD.PATH,
        controls = PABAdvancedFoodDrinksSubmenuTable,
        disabledLabel = PABMenuFunctions.isFoodDrinksTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_TROPHIES_HEADER),
        icon = PAC.ICONS.ITEMS.TROPHY.PATH,
        controls = PABAdvancedTrophiesSubmenuTable,
        disabledLabel = PABMenuFunctions.isTrophiesTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_INTRICATE_ITEMS_HEADER),
        icon = PAC.ICONS.ITEMS.TRAITS.INTRICATE.PATH,
        controls = PABAdvancedIntricateItemsSubmenuTable,
        disabledLabel = PABMenuFunctions.isIntricateItemsTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE),
        tooltip = GetString(SI_PA_MENU_BANKING_ADVANCED_GLOBAL_MOVEMODE_T),
        choices = PABMenuChoices.itemMoveMode,
        choicesValues = PABMenuChoicesValues.itemMoveMode,
        getFunc = function() return end,
        setFunc = function(value) PABMenuFunctions.setAdvancedItemsGlobalMoveModeSetting(value) end,
        disabled = PABMenuFunctions.isAdvancedItemsGlobalMoveModeDisabled,
        warning = GetString(SI_PA_MENU_BANKING_ANY_GLOBAL_MOVEMODE_W),
        reference = "PERSONALASSISTANT_PAB_ADVANCED_GLOBAL_MOVE_MODE",
    })

    -- -----------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE),
        tooltip = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_ENABLE_T),
        getFunc = PABMenuFunctions.getIndividualItemsEnabledSetting,
        setFunc = PABMenuFunctions.setIndividualItemsEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.Individual.individualItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_DESCRIPTION)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_LOCKPICK_HEADER),
        icon = PAC.ICONS.ITEMS.LOCKPICK.PATH,
        controls = PABIndividualLockpickSubmenuTable,
        disabledLabel = PABMenuFunctions.isLockpickTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_SOULGEM_HEADER),
        icon = PAC.ICONS.ITEMS.SOULGEM.PATH,
        controls = PABIndividualSoulGemSubmenuTable,
        disabledLabel = PABMenuFunctions.isSoulGemTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_REPAIRKIT_HEADER),
        icon = PAC.ICONS.ITEMS.REPAIRKIT.PATH,
        controls = PABIndividualRepairKitSubmenuTable,
        disabledLabel = PABMenuFunctions.isRepairKitTransactionMenuDisabled,
    })

    -- check if there are any generic items added; if not skip the menu
    if #PAC.BANKING_INDIVIDUAL.GENERIC > 0 then
        PABankingOptionsTable:insert({
            type = "submenu",
            name = GetString(SI_PA_MENU_BANKING_INDIVIDUAL_GENERIC_HEADER),
            icon = PAC.ICONS.ITEMS.GENERIC_HELP.PATH,
            controls = PABIndividualGenericSubmenuTable,
            disabledLabel = PABMenuFunctions.isGenericTransactionMenuDisabled,
        })
    end


    -- ---------------------------------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_AVA_ENABLE),
        tooltip = GetString(SI_PA_MENU_BANKING_AVA_ENABLE_T),
        getFunc = PABMenuFunctions.getAvAItemsEnabledSetting,
        setFunc = PABMenuFunctions.setAvAItemsEnabledSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.AvA.avaItemsEnabled,
    })

    PABankingOptionsTable:insert({
        type = "description",
        text = GetString(SI_PA_MENU_BANKING_AVA_DESCRIPTION)
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_BALLISTA_HEADER),
        icon = PAC.ICONS.SIEGE.BALLISTA.PATH,
        controls = PABAvASiegeBallistaSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeBallistaTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_CATAPULT_HEADER),
        icon = PAC.ICONS.SIEGE.CATAPULT.PATH,
        controls = PABAvASiegeCatapultSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeCatapultTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_TREBUCHET_HEADER),
        icon = PAC.ICONS.SIEGE.TREBUCHET.PATH,
        controls = PABAvASiegeTrebuchetSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeTrebuchetTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_RAM_HEADER),
        icon = PAC.ICONS.SIEGE.RAM.PATH,
        controls = PABAvASiegeRamSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeRamTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_OIL_HEADER),
        icon = PAC.ICONS.SIEGE.OIL.PATH,
        controls = PABAvASiegeOilSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeOilTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_SIEGE_GRAVEYARD_HEADER),
        icon = PAC.ICONS.SIEGE.GRAVEYARD[PA.alliance].PATH,
        controls = PABAvASiegeGraveyardSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvASiegeGraveyardTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_REPAIR_HEADER),
        icon = PAC.ICONS.SIEGE.REPAIR.PATH,
        controls = PABAvARepairSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvARepairTransactionMenuDisabled,
    })

    PABankingOptionsTable:insert({
        type = "submenu",
        name = GetString(SI_PA_MENU_BANKING_AVA_OTHER_HEADER),
        icon = PAC.ICONS.SIEGE.OTHER.PATH,
        controls = PABAvAOtherSubmenuTable,
        disabledLabel = PABMenuFunctions.isAvAOtherTransactionMenuDisabled,
    })


    -- ---------------------------------------------------------------------------------------------------------

    PABankingOptionsTable:insert({
        type = "divider",
        alpha = 0.5,
    })

    PABankingOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_BANKING_DEPOSIT_STACKING),
        tooltip = GetString(SI_PA_MENU_BANKING_DEPOSIT_STACKING_T),
        choices = PABMenuChoices.stackingType,
        choicesValues = PABMenuChoicesValues.stackingType,
        width = "half",
        getFunc = PABMenuFunctions.getTransactionDepositStackingSetting,
        setFunc = PABMenuFunctions.setTransactionDepositStackingSetting,
        disabled = PABMenuFunctions.isTransactionDepositStackingDisabled,
        default = PABMenuDefaults.transactionDepositStacking,
    })

    PABankingOptionsTable:insert({
        type = "dropdown",
        name = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING),
        tooltip = GetString(SI_PA_MENU_BANKING_WITHDRAWAL_STACKING_T),
        choices = PABMenuChoices.stackingType,
        choicesValues = PABMenuChoicesValues.stackingType,
        width = "half",
        getFunc = PABMenuFunctions.getTransactionWithdrawalStackingSetting,
        setFunc = PABMenuFunctions.setTransactionWithdrawalStackingSetting,
        disabled = PABMenuFunctions.isTransactionWithdrawalStackingDisabled,
        default = PABMenuDefaults.transactionWithdrawalStacking,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS),
        tooltip = GetString(SI_PA_MENU_BANKING_AUTOSTACKBAGS_T),
        getFunc = PABMenuFunctions.getAutoStackBagsSetting,
        setFunc = PABMenuFunctions.setAutoStackBagsSetting,
        disabled = PAGMenuFunctions.isNoProfileSelected,
        default = PABMenuDefaults.autoStackBags,
    })

    PABankingOptionsTable:insert({
        type = "checkbox",
        name = GetString(SI_PA_MENU_SILENT_MODE),
        getFunc = PABMenuFunctions.getSilentModeSetting,
        setFunc = PABMenuFunctions.setSilentModeSetting,
        disabled = PABMenuFunctions.isSilentModeDisabled,
        default = PABMenuDefaults.silentMode,
    })
end

-- =================================================================================================================

local function _createPABCurrencyGoldSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_MONEY)
    PABCurrencyGoldSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getGoldTransactionSetting,
        setFunc = PABMenuFunctions.setGoldTransactionSetting,
        disabled = PABMenuFunctions.isGoldTransactionDisabled,
        default = PABMenuDefaults.Currencies.goldTransaction,
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getGoldMinToKeepSetting,
        setFunc = PABMenuFunctions.setGoldMinToKeepSetting,
        disabled = PABMenuFunctions.isGoldMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.goldMinToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MIN",
    })

    PABCurrencyGoldSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getGoldMaxToKeepSetting,
        setFunc = PABMenuFunctions.setGoldMaxToKeepSetting,
        disabled = PABMenuFunctions.isGoldMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.goldMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_GOLD_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyAlliancePointsSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_ALLIANCE_POINTS)
    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getAlliancePointsTransactionSetting,
        setFunc = PABMenuFunctions.setAlliancePointsTransactionSetting,
        disabled = PABMenuFunctions.isAlliancePointsTransactionDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsTransaction,
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getAlliancePointsMinToKeepSetting,
        setFunc = PABMenuFunctions.setAlliancePointsMinToKeepSetting,
        disabled = PABMenuFunctions.isAlliancePointsMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsMinToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MIN",
    })

    PABCurrencyAlliancePointsSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getAlliancePointsMaxToKeepSetting,
        setFunc = PABMenuFunctions.setAlliancePointsMaxToKeepSetting,
        disabled = PABMenuFunctions.isAlliancePointsMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.alliancePointsMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_ALLIANCEPOINTS_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyTelVarSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_TELVAR_STONES)
    PABCurrencyTelVarSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getTelVarTransactionSetting,
        setFunc = PABMenuFunctions.setTelVarTransactionSetting,
        disabled = PABMenuFunctions.isTelVarTransactionDisabled,
        default = PABMenuDefaults.Currencies.telVarTransaction,
    })

    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getTelVarMinToKeepSetting,
        setFunc = PABMenuFunctions.setTelVarMinToKeepSetting,
        disabled = PABMenuFunctions.isTelVarMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.telVarMinToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MIN",
    })
    PABCurrencyTelVarSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getTelVarMaxToKeepSetting,
        setFunc = PABMenuFunctions.setTelVarMaxToKeepSetting,
        disabled = PABMenuFunctions.isTelVarMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.telVarMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_TELVAR_MAX",
    })
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCurrencyWritVouchersSubmenuTable()
    local _currencyName = GetCurrencyName(CURT_WRIT_VOUCHERS)
    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "checkbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_CURRENCY_ENABLE, _currencyName),
        getFunc = PABMenuFunctions.getWritVouchersTransactionSetting,
        setFunc = PABMenuFunctions.setWritVouchersTransactionSetting,
        disabled = PABMenuFunctions.isWritVouchersTransactionDisabled,
        default = PABMenuDefaults.Currencies.writVouchersTransaction,
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MINTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MINTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getWritVouchersMinToKeepSetting,
        setFunc = PABMenuFunctions.setWritVouchersMinToKeepSetting,
        disabled = PABMenuFunctions.isWritVouchersMinToKeepDisabled,
        default = PABMenuDefaults.Currencies.writVouchersMinToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MIN",
    })

    PABCurrencyWritVouchersSubmenuTable:insert({
        type = "editbox",
        name = PAHF.getFormattedKey(SI_PA_MENU_BANKING_CURRENCY_MAXTOKEEP),
        tooltip = PAHF.getFormattedKey(SI_PA_MENU_BANKING_ANY_MAXTOKEEP_T, _currencyName),
        width = "half",
        getFunc = PABMenuFunctions.getWritVouchersMaxToKeepSetting,
        setFunc = PABMenuFunctions.setWritVouchersMaxToKeepSetting,
        disabled = PABMenuFunctions.isWritVouchersMaxToKeepDisabled,
        default = PABMenuDefaults.Currencies.writVouchersMaxToKeep,
        reference = "PERSONALASSISTANT_PAB_WRITVOUCHERS_MAX",
    })
end

-- =================================================================================================================

local function _createPABCraftingBlacksmithingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.BLACKSMITHING) do
        PABCraftingBlacksmithingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingClothingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.CLOTHING) do
        PABCraftingClothingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingWoodworkingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.WOODWORKING) do
        PABCraftingWoodworkingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingJewelcraftingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.JEWELCRAFTING) do
        PABCraftingJewelcraftingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingAlchemySubmenuTable()
    for _, itemType in pairs(PAC.BANKING.ALCHEMY) do
        PABCraftingAlchemySubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingEnchantingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.ENCHANTING) do
        PABCraftingEnchantingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingProvisioningSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.PROVISIONING) do
        PABCraftingProvisioningSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingStyleMaterialsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.STYLEMATERIALS) do
        PABCraftingStyleMaterialsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingTraitItemsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.TRAITITEMS) do
        PABCraftingTraitItemsSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABCraftingFurnishingSubmenuTable()
    for _, itemType in pairs(PAC.BANKING.FURNISHING) do
        PABCraftingFurnishingSubmenuTable:insert({
            type = "dropdown",
            name = GetString("SI_ITEMTYPE", itemType),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getCraftingItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setCraftingItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getCraftingItemsEnabledSetting() end,
            default = PABMenuDefaults.Crafting.ItemTypes[itemType],
        })
    end
end

-- =================================================================================================================

local function _createPABAdvancedMotifSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.LEARNABLE.MOTIF) do
        PABAdvancedMotifSubmenuTable:insert({
            type = "dropdown",
            name = table.concat({zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)), " (", GetString(SI_PA_MENU_BANKING_LEARNABLE_ITEM_KNOWN), ")"}),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedLearnableItemTypeMoveSetting(itemType, true) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedLearnableItemTypeMoveSetting(itemType, value, true) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.LearnableItemTypes[itemType].Known,
        })

        PABAdvancedMotifSubmenuTable:insert({
            type = "dropdown",
            name = table.concat({zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)), " (", GetString(SI_PA_MENU_BANKING_LEARNABLE_ITEM_UNKNOWN), ")"}),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedLearnableItemTypeMoveSetting(itemType, false) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedLearnableItemTypeMoveSetting(itemType, value, false) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.LearnableItemTypes[itemType].Unknown,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedRecipeSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.LEARNABLE.RECIPE) do
        PABAdvancedRecipeSubmenuTable:insert({
            type = "dropdown",
            name = table.concat({zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)), " (", GetString(SI_PA_MENU_BANKING_LEARNABLE_ITEM_KNOWN), ")"}),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedLearnableItemTypeMoveSetting(itemType, true) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedLearnableItemTypeMoveSetting(itemType, value, true) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.LearnableItemTypes[itemType].Known,
        })

        PABAdvancedRecipeSubmenuTable:insert({
            type = "dropdown",
            name = table.concat({zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)), " (", GetString(SI_PA_MENU_BANKING_LEARNABLE_ITEM_UNKNOWN), ")"}),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedLearnableItemTypeMoveSetting(itemType, false) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedLearnableItemTypeMoveSetting(itemType, value, true) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.LearnableItemTypes[itemType].Unknown,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedWritsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.WRITS) do
        PABAdvancedWritsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- =================================================================================================================

local function _createPABAdvancedGlyphsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.GLYPHS) do
        PABAdvancedGlyphsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedLiquidsSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.LIQUIDS) do
        PABAdvancedLiquidsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedFoodDrinksSubmenuTable()
    for _, itemType in pairs(PAC.BANKING_ADVANCED.REGULAR.FOOD_DRINKS) do
        PABAdvancedFoodDrinksSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMTYPE", itemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeMoveSetting(itemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeMoveSetting(itemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTypes[itemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedTrophiesSubmenuTable()
    for _, specializedItemType in pairs(PAC.BANKING_ADVANCED.SPECIALIZED.TROPHIES) do
        PABAdvancedTrophiesSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_SPECIALIZEDITEMTYPE", specializedItemType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTypeSpecializedMoveSetting(specializedItemType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTypeSpecializedMoveSetting(specializedItemType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.SpecializedItemTypes[specializedItemType],
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAdvancedIntricateItemsSubmenuTable()
    for itemTraitType, itemFilterType in pairs(PAC.BANKING_ADVANCED.TRAIT.INTRICATE) do
        PABAdvancedIntricateItemsSubmenuTable:insert({
            type = "dropdown",
            name = zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", itemFilterType)),
            choices = PABMenuChoices.itemMoveMode,
            choicesValues = PABMenuChoicesValues.itemMoveMode,
            getFunc = function() return PABMenuFunctions.getAdvancedItemTraitTypeMoveSetting(itemTraitType) end,
            setFunc = function(value) PABMenuFunctions.setAdvancedItemTraitTypeMoveSetting(itemTraitType, value) end,
            disabled = function() return not PABMenuFunctions.getAdvancedItemsEnabledSetting() end,
            default = PABMenuDefaults.Advanced.ItemTraitTypes[itemTraitType],
        })
    end
end

-- =================================================================================================================

local function _createPABIndividualLockpickSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.LOCKPICK) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualLockpickSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualLockpickSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualSoulGemSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.SOUL_GEM) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualSoulGemSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualSoulGemSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualRepairKitSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.REPAIR_KIT) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualRepairKitSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualRepairKitSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABIndividualGenericSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_INDIVIDUAL.GENERIC) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABIndividualGenericSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getIndividualItemsEnabledSetting() end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].operator,
        })

        PABIndividualGenericSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getIndividualItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setIndividualItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isIndividualItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.Individual.ItemIds[itemId].backpackAmount,
        })
    end
end

-- =================================================================================================================

local function _createPABAvASiegeBallistaSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].BALLISTA) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeBallistaSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeBallistaSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvASiegeCatapultSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].CATAPULT) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeCatapultSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeCatapultSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvASiegeTrebuchetSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].TREBUCHET) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeTrebuchetSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeTrebuchetSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvASiegeRamSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].RAM) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeRamSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeRamSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvASiegeOilSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].OIL) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeOilSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeOilSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvASiegeGraveyardSubmenuTable()
    for crossAllianceItemId, itemId in pairs(PAC.BANKING_AVA.SIEGE[PA.alliance].GRAVEYARD) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvASiegeGraveyardSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdMathOperatorSetting(crossAllianceItemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].operator,
        })

        PABAvASiegeGraveyardSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvACrossAlianceItemIdAmountSetting(crossAllianceItemId) end,
            setFunc = function(value) PABMenuFunctions.setAvACrossAlianceItemIdAmountSetting(crossAllianceItemId, value) end,
            disabled = function() return PABMenuFunctions.isAvACrossAlianceItemIdAmountDisabled(crossAllianceItemId) end,
            default = PABMenuDefaults.AvA.CrossAllianceItemIds[crossAllianceItemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvARepairSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_AVA.REPAIR) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvARepairSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvAItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setAvAItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.ItemIds[itemId].operator,
        })

        PABAvARepairSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvAItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setAvAItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isAvAItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.AvA.ItemIds[itemId].backpackAmount,
        })
    end
end

-- -----------------------------------------------------------------------------------------------------------------

local function _createPABAvAOtherSubmenuTable()
    for _, itemId in pairs(PAC.BANKING_AVA.OTHER) do
        local itemLink = table.concat({"|H1:item:", itemId, ":1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h"})

        PABAvAOtherSubmenuTable:insert({
            type = "dropdown",
            name = function() return PAHF.getFormattedKey(SI_PA_REL_OPERATOR, itemLink) end,
            tooltip = GetString(SI_PA_REL_OPERATOR_T),
            choices = PABMenuChoices.mathOperator,
            choicesValues = PABMenuChoicesValues.mathOperator,
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvAItemIdMathOperatorSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setAvAItemIdMathOperatorSetting(itemId, value) end,
            disabled = function() return not PABMenuFunctions.getAvAItemsEnabledSetting() end,
            default = PABMenuDefaults.AvA.ItemIds[itemId].operator,
        })

        PABAvAOtherSubmenuTable:insert({
            type = "editbox",
            name = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK),
            tooltip = GetString(SI_PA_MENU_BANKING_ANY_KEEPINBACKPACK_T),
            width = "half",
            getFunc = function() return PABMenuFunctions.getAvAItemIdAmountSetting(itemId) end,
            setFunc = function(value) PABMenuFunctions.setAvAItemIdAmountSetting(itemId, value) end,
            disabled = function() return PABMenuFunctions.isAvAItemIdAmountDisabled(itemId) end,
            default = PABMenuDefaults.AvA.ItemIds[itemId].backpackAmount,
        })
    end
end

-- =================================================================================================================

local function createOptions()
    _createPABankingMenu()

    _createPABCurrencyGoldSubmenuTable()
    _createPABCurrencyAlliancePointsSubmenuTable()
    _createPABCurrencyTelVarSubmenuTable()
    _createPABCurrencyWritVouchersSubmenuTable()

    if not IsESOPlusSubscriber() then
        _createPABCraftingBlacksmithingSubmenuTable()
        _createPABCraftingClothingSubmenuTable()
        _createPABCraftingWoodworkingSubmenuTable()
        _createPABCraftingJewelcraftingSubmenuTable()
        _createPABCraftingAlchemySubmenuTable()
        _createPABCraftingEnchantingSubmenuTable()
        _createPABCraftingProvisioningSubmenuTable()
        _createPABCraftingStyleMaterialsSubmenuTable()
        _createPABCraftingTraitItemsSubmenuTable()
        _createPABCraftingFurnishingSubmenuTable()
    end

    _createPABAdvancedMotifSubmenuTable()
    _createPABAdvancedRecipeSubmenuTable()
    _createPABAdvancedWritsSubmenuTable()
    _createPABAdvancedGlyphsSubmenuTable()
    _createPABAdvancedLiquidsSubmenuTable()
    _createPABAdvancedFoodDrinksSubmenuTable()

    _createPABAdvancedTrophiesSubmenuTable()

    _createPABAdvancedIntricateItemsSubmenuTable()

    _createPABIndividualLockpickSubmenuTable()
    _createPABIndividualSoulGemSubmenuTable()
    _createPABIndividualRepairKitSubmenuTable()
    _createPABIndividualGenericSubmenuTable()

    _createPABAvASiegeBallistaSubmenuTable()
    _createPABAvASiegeCatapultSubmenuTable()
    _createPABAvASiegeTrebuchetSubmenuTable()
    _createPABAvASiegeRamSubmenuTable()
    _createPABAvASiegeOilSubmenuTable()
    _createPABAvASiegeGraveyardSubmenuTable()

    _createPABAvARepairSubmenuTable()
    _createPABAvAOtherSubmenuTable()

    LAM2:RegisterAddonPanel("PersonalAssistantBankingAddonOptions", PABankingPanelData)
    LAM2:RegisterOptionControls("PersonalAssistantBankingAddonOptions", PABankingOptionsTable)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.Banking = PA.Banking or {}
PA.Banking.createOptions = createOptions
