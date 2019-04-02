local PAC = PersonalAssistant.Constants
-- =================================================================================================================
-- == MENU/PANEL TEXTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot Menu --
SafeAddString(SI_PA_MENU_LOOT_DESCRIPTION, "PALoot peut vous avertir quand vous obtenez des objets spécifiques (tels que des recettes inconnues, des motifs, ou des traits)", 1)

-- Loot Recipes
SafeAddString(SI_PA_MENU_LOOT_RECIPES_HEADER, table.concat({" ", PAC.ICONS.ITEMS.RECIPE.NORMAL, "  ", "Sur prise du butin ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RECIPE), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG, table.concat({"Afficher un message si la ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " n'est pas connue"}), 1)
SafeAddString(SI_PA_MENU_LOOT_RECIPES_UNKNOWN_MSG_T, table.concat({"Quand une ", GetString("SI_ITEMTYPE", ITEMTYPE_RECIPE), " du butin n'est pas encore connue par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Motifs
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_HEADER, table.concat({" ", PAC.ICONS.ITEMS.MOTIF.NORMAL, "  ", "Sur prise du butin ", zo_strformat(GetString("SI_PA_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), 2)}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG, table.concat({"Afficher un message si le ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " n'est pas connu"}), 1)
SafeAddString(SI_PA_MENU_LOOT_MOTIFS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMTYPE", ITEMTYPE_RACIAL_STYLE_MOTIF), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

-- Loot Apparel & Weapons
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_HEADER, table.concat({" ", PAC.ICONS.CRAFTBAG.WEAPON.NORMAL, "  ", "Sur prise du butin ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR)), " & ", zo_strformat("<<m:1>>", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS))}), 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG, "Afficher un message si un Trait n'a pas encore été recherché", 1)
SafeAddString(SI_PA_MENU_LOOT_APPARELWEAPONS_UNKNOWN_MSG_T, table.concat({"Quand un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_ARMOR), " ou un ", GetString("SI_ITEMFILTERTYPE", ITEMFILTERTYPE_WEAPONS), " du butin n'est pas encore connu par ce personnage, un message sera affiché dans la fenêtre de chat"}), 1)

SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING, "Avertir sur espace faible de l'inventaire", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_WARNING_T, "Affiche un avertissement dans la fenêtre de chat s'il reste peu d'espace dans votre inventaire", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD, "Seuil d'espace faible", 1)
SafeAddString(SI_PA_MENU_LOOT_LOW_INVENTORY_THRESHOLD_T, "Si la place disponible restante dans l'inventaire est plus petite ou égale au seuil, un message sera affiché dans la fenêtre de chat", 1)


-- =================================================================================================================
-- == CHAT OUTPUTS == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_CHAT_LOOT_RECIPE_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s peut être ", PAC.COLORS.ORANGE,"apprise", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_MOTIF_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s peut être ", PAC.COLORS.ORANGE,"appris", PAC.COLORS.DEFAULT, " !"}), 1)
SafeAddString(SI_PA_CHAT_LOOT_TRAIT_UNKNOWN, table.concat({PAC.COLORED_TEXTS.PAL, "%s a le trait [", PAC.COLORS.ORANGE,"%s", PAC.COLORS.DEFAULT,"] qui peut être recherché !"}), 1)

SafeAddString(SI_PA_PATTERN_INVENTORY_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[place dans l'inventaire/place dans l'inventaire/places dans l'inventaire]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_REPAIRKIT_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[nécessaire de réparation/nécessaire de réparation/nécessaires de réparation]>> !"}), 1)
SafeAddString(SI_PA_PATTERN_SOULGEM_COUNT, table.concat({PAC.COLORED_TEXTS.PAL, "%sVous n'avez <<1[", PAC.COLORS.WHITE,"plus de/plus que ", PAC.COLORS.WHITE, "%d/plus que ", PAC.COLORS.WHITE, "%d]>> %s<<1[pierre d'âme/pierre d'âme/pierres d'âme]>> !"}), 1)


-- =================================================================================================================
-- == OTHER STRINGS FOR MENU == --
-- -----------------------------------------------------------------------------------------------------------------
-- PALoot --
SafeAddString(SI_PA_MENU_LOOT_ENABLE, "Activer les événements de butin", 1)