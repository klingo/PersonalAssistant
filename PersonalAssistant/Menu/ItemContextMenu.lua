-- Local instances of Global tables --
local PA = PersonalAssistant
local PAHF = PA.HelperFunctions

-- ---------------------------------------------------------------------------------------------------------------------

local _hooksOnInventoryContextMenuInitialized = false

local function _addDynamicContextMenuEntries(itemLink, bagId, slotIndex)
    local itemId = GetItemLinkItemId(itemLink)

    -- Add PABanking context menu entries
    if PA.Banking and PA.Banking.SavedVars.Custom.customItemsEnabled then
        zo_callLater(function()
            local PABCustomItemIds = PA.Banking.SavedVars.Custom.ItemIds
            local isRuleExisting = PAHF.isKeyInTable(PABCustomItemIds, itemId)
            local entries = {
                {
                    label = GetString(SI_PA_SUBMENU_PAB_ADD_RULE),
                    callback = function()
                        PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                        PA.CustomDialogs.showPABAddCustomRuleUIDIalog(itemLink)
                    end,
                    -- TODO: add logic to also check other itemTypes that are already covered!
                    -- TODO: Crafting Materials & AvA items?
                    -- TODO: Master Writs
                    -- TODO: Motifs
                    -- TODO: Recipes
                    disabled = function() return isRuleExisting end,
                },
                {
                    label = GetString(SI_PA_SUBMENU_PAB_EDIT_RULE),
                    callback = function()
                        PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                        PA.CustomDialogs.showPABAddCustomRuleUIDIalog(itemLink, PABCustomItemIds[itemId])
                    end,
                    disabled = function() return not isRuleExisting end,
                },
                {
                    label = GetString(SI_PA_SUBMENU_PAB_DELETE_RULE),
                    callback = function()
                        PA.CustomDialogs.initPABAddCustomRuleUIDialog()
                        PA.CustomDialogs.deletePABCustomRule(itemLink)
                    end,
                    disabled = function() return not isRuleExisting end,
                }
            }
            AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PAB), entries)
        end, 50)
    end

    -- Add PAJunk context menu entries
    if PA.Junk and PA.Junk.SavedVars.Custom.customItemsEnabled then
        zo_callLater(function()
            local PAJCustomItemIds = PA.Junk.SavedVars.Custom.ItemIds
            local canBeMarkedAsJunk = CanItemBeMarkedAsJunk(bagId, slotIndex)
            local isRuleExisting = PAHF.isKeyInTable(PAJCustomItemIds, itemId)
            local entries = {
                {
                    label = GetString(SI_PA_SUBMENU_PAJ_MARK_PERM_JUNK),
                    callback = function()
                        PA.Junk.addItemToPermanentJunk(itemLink, bagId, slotIndex)
                    end,
                    disabled = function() return not canBeMarkedAsJunk or isRuleExisting end,
                },
                {
                    label = GetString(SI_PA_SUBMENU_PAJ_UNMARK_PERM_JUNK),
                    callback = function()
                        PA.Junk.removeItemFromPermanentJunk(itemLink)
                    end,
                    disabled = function() return not isRuleExisting end,
                }
            }
            AddCustomSubMenuItem(GetString(SI_PA_SUBMENU_PAJ), entries)
        end, 50)
    end
end

local function _getSlotTypeName(slotType)
--    if slotType == SLOT_TYPE_ITEM then return "SLOT_TYPE_ITEM" end
--    if slotType == SLOT_TYPE_CRAFT_BAG_ITEM then return "SLOT_TYPE_CRAFT_BAG_ITEM" end
--    if slotType == SLOT_TYPE_EQUIPMENT then return "SLOT_TYPE_EQUIPMENT" end
    if slotType == SLOT_TYPE_BANK_ITEM then return "SLOT_TYPE_BANK_ITEM" end
    if slotType == SLOT_TYPE_GUILD_BANK_ITEM then return "SLOT_TYPE_GUILD_BANK_ITEM" end
--    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then return "SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then return "SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_POST_ITEM then return "SLOT_TYPE_TRADING_HOUSE_POST_ITEM" end
--    if slotType == SLOT_TYPE_REPAIR then return "SLOT_TYPE_REPAIR" end
--    if slotType == SLOT_TYPE_CRAFTING_COMPONENT then return "SLOT_TYPE_CRAFTING_COMPONENT" end
    if slotType == SLOT_TYPE_PENDING_CRAFTING_COMPONENT then return "SLOT_TYPE_PENDING_CRAFTING_COMPONENT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then return "SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT" end
    if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then return "SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING" end
    if slotType == SLOT_TYPE_LAUNDER then return "SLOT_TYPE_LAUNDER" end
    if slotType == SLOT_TYPE_LIST_DIALOG_ITEM then return "SLOT_TYPE_LIST_DIALOG_ITEM" end
--    if slotType == SLOT_TYPE_LOOT then return "SLOT_TYPE_LOOT" end
    if slotType == SLOT_TYPE_MAIL_ATTACHMENT then return "SLOT_TYPE_MAIL_ATTACHMENT" end
    if slotType == SLOT_TYPE_MAIL_QUEUED_ATTACHMENT then return "SLOT_TYPE_MAIL_QUEUED_ATTACHMENT" end
    if slotType == SLOT_TYPE_MY_TRADE then return "SLOT_TYPE_MY_TRADE" end
    if slotType == SLOT_TYPE_PENDING_CHARGE then return "SLOT_TYPE_PENDING_CHARGE" end
    if slotType == SLOT_TYPE_PENDING_REPAIR then return "SLOT_TYPE_PENDING_REPAIR" end
    if slotType == SLOT_TYPE_PENDING_RETRAIT_ITEM then return "SLOT_TYPE_PENDING_RETRAIT_ITEM" end
--    if slotType == SLOT_TYPE_QUEST_ITEM then return "SLOT_TYPE_QUEST_ITEM" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_BOOSTER then return "SLOT_TYPE_SMITHING_BOOSTER" end
    if slotType == SLOT_TYPE_SMITHING_STYLE then return "SLOT_TYPE_SMITHING_STYLE" end
    if slotType == SLOT_TYPE_SMITHING_TRAIT then return "SLOT_TYPE_SMITHING_TRAIT" end
    if slotType == SLOT_TYPE_STACK_SPLIT then return "SLOT_TYPE_STACK_SPLIT" end
--    if slotType == SLOT_TYPE_STORE_BUY then return "SLOT_TYPE_STORE_BUY" end
--    if slotType == SLOT_TYPE_STORE_BUYBACK then return "SLOT_TYPE_STORE_BUYBACK" end
    if slotType == SLOT_TYPE_THEIR_TRADE then return "SLOT_TYPE_THEIR_TRADE" end

    return tostring(slotType)
end

local function initHooksOnInventoryContextMenu()
    if not _hooksOnInventoryContextMenuInitialized then
        _hooksOnInventoryContextMenuInitialized = true
        ZO_PreHook('ZO_InventorySlot_ShowContextMenu',
            function(inventorySlot)
                -- TODO: if settings are turned ON, then
                local slotType = ZO_InventorySlot_GetType(inventorySlot)
                d("slotType=".._getSlotTypeName(slotType))
                if slotType == SLOT_TYPE_ITEM or slotType == SLOT_TYPE_BANK_ITEM then
                    local bagId, slotIndex = ZO_Inventory_GetBagAndIndex(inventorySlot)
                    local itemLink = GetItemLink(bagId, slotIndex)
                    _addDynamicContextMenuEntries(itemLink, bagId, slotIndex)
                end

    --            if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT then
    --                link = GetTradingHouseSearchResultItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
    --            end
    --            if slotType == SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING then
    --                link = GetTradingHouseListingItemLink(ZO_Inventory_GetSlotIndex(inventorySlot))
    --            end

    --            SLOT_TYPE_TRADING_HOUSE_POST_ITEM
    --            SLOT_TYPE_REPAIR

    --            SLOT_TYPE_PENDING_CRAFTING_COMPONENT
    --            SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT
    --            SLOT_TYPE_TRADING_HOUSE_ITEM_LISTING

    --            SLOT_TYPE_LAUNDER
    --            SLOT_TYPE_LIST_DIALOG_ITEM
    --            SLOT_TYPE_MAIL_ATTACHMENT
    --            SLOT_TYPE_MAIL_QUEUED_ATTACHMENT
    --            SLOT_TYPE_MY_TRADE
    --            SLOT_TYPE_PENDING_CHARGE
    --            SLOT_TYPE_PENDING_REPAIR
    --            SLOT_TYPE_PENDING_RETRAIT_ITEM
    --            SLOT_TYPE_QUEST_ITEM
    --            SLOT_TYPE_SMITHING_BOOSTER
    --            SLOT_TYPE_SMITHING_MATERIAL
    --            SLOT_TYPE_SMITHING_STYLE
    --            SLOT_TYPE_SMITHING_TRAIT
    --            SLOT_TYPE_STACK_SPLIT
    --            SLOT_TYPE_STORE_BUY
    --            SLOT_TYPE_STORE_BUYBACK
    --            SLOT_TYPE_THEIR_TRADE



                -- TODO: confirmed to be added to scope
                -- SLOT_TYPE_ITEM                               inventory/backpack
                -- SLOT_TYPE_CRAFTING_COMPONENT                 crafting components & items to be deconstructed & improvements

                -- TODO: confirmed to be out of scope
                -- SLOT_TYPE_EQUIPMENT                          worn equipment
                -- SLOT_TYPE_LOOT                               loot window
                -- SLOT_TYPE_CRAFT_BAG_ITEM                     craft bag
                -- SLOT_TYPE_TRADING_HOUSE_ITEM_RESULT          trading house search results
                -- SLOT_TYPE_STORE_BUY                          buying from store
                -- SLOT_TYPE_STORE_BUYBACK                      buyback from store
                -- SLOT_TYPE_REPAIR                             repair in store
                -- SLOT_TYPE_QUEST_ITEM                         quest items
            end
        )
    else
        PAHF.debuglnAuthor("Attempted to Re-Hook: [initHooksOnInventoryContextMenu]")
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
-- Export
PA.ItemContextMenu = {
    initHooksOnInventoryContextMenu = initHooksOnInventoryContextMenu
}
