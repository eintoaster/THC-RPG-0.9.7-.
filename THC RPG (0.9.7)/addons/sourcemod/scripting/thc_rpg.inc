// Xp
native thc_rpg_SetXP(client, amount);
native thc_rpg_SetReqXP(client, amount);
native thc_rpg_SetStaticReqXP(client, amount);
native thc_rpg_SetStaticXP(client, amount);
native thc_rpg_GetXP(client);
native thc_rpg_TeamWinXP(team);
native thc_rpg_GetReqXP(client);
native thc_rpg_GetHurtXP(client);
native thc_rpg_SetHurtXP(client, amount);
// Level
native thc_rpg_SetLevel(client, amount);
native thc_rpg_SetStaticLevel(client, amount);
native thc_rpg_GetLevel(client);
// Credits
native thc_rpg_SetCredits(client, amount);
native thc_rpg_SetStaticCredits(client, amount);
native thc_rpg_GetCredits(client);
// Vip
native thc_rpg_GetVip(client);
// Databases
native thc_rpg_RemovePlayer(client);
native thc_rpg_GetPlayerTop10(client);
native thc_rpg_SavePlayerData(client);
native thc_rpg_LoadPlayerData(client);
native thc_rpg_InsertPlayer(client);
native thc_rpg_ResetPlayer(client);
// Menu
native thc_rpg_DisplayAdminMenu(client);
// Forwards
forward ThcRpg_LvlUp(client); (Player lvl up) 