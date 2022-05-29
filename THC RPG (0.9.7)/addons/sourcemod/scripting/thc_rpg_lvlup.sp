#pragma semicolon 1
#include <sourcemod>
#include <sdktools>

public Plugin:myinfo = 
{
	name = "THC RPG lvl up module",
	author = "[RUS] SenatoR",
	description = "settings lvl up in private THC RPG modification by SenatoR",
	version = "1.0"
}

new Handle:thc_rpg_lvlup_overlay;
new Handle:thc_rpg_lvlup_overlay_time;
new Handle:thc_rpg_lvlup_sound;
new Handle:thc_rpg_lvlup_effect;
new Handle:OverlayDelTimer[MAXPLAYERS+1];

public OnPluginStart()
{
	thc_rpg_lvlup_overlay = CreateConVar("thc_rpg_lvlup_overlay", "off",	"Путь до оверлея,указывать без папки materials и без формата (off отключить)");
	thc_rpg_lvlup_overlay_time	= CreateConVar("thc_rpg_lvlup_overlay_time", "5",	"Сколько секунд будет показан оверлей?");
	thc_rpg_lvlup_sound			= CreateConVar("thc_rpg_lvlup_sound", "buttons/combine_button2.wav",	"Путь до звука,указывать без папки sound(off отключить)");
	thc_rpg_lvlup_effect		= CreateConVar("thc_rpg_lvlup_effect", "1",	"Включить эффект?");
	AutoExecConfig(true, "THC RPG/thc_rpg_module_lvlup");
}

public ThcRpg_LvlUp(client)
{
    if(IsValidPlayer(client))
    {
		decl String:buffer[PLATFORM_MAX_PATH];
		//overlay
		GetConVarString(thc_rpg_lvlup_overlay, buffer, sizeof(buffer));
		if(!StrEqual(buffer, "off", false))
		{
			ClientCommand(client, "r_screenoverlay \"%s\"", buffer);
			OverlayDelTimer[client] = CreateTimer(GetConVarInt(thc_rpg_lvlup_overlay_time)*1.0, OverlayOffTimer, client, TIMER_FLAG_NO_MAPCHANGE);
		}
		//sound
		GetConVarString(thc_rpg_lvlup_sound, buffer, sizeof(buffer));
		if(!StrEqual(buffer, "off", false))
			EmitSoundToClient(client,buffer);
		
		// effect
		
		if(GetConVarBool(thc_rpg_lvlup_effect))
		{
			new particle = CreateEntityByName("env_smokestack");
			if(IsValidEdict(particle) && IsClientInGame(client))
			{
				decl String:Name[32], Float:fPos[3];
				Format(Name, sizeof(Name), "CSParticle_%i", client);
				GetEntPropVector(client, Prop_Send, "m_vecOrigin", fPos);
				fPos[2] += 28.0;
				new Float:fAng[3] = {0.0, 0.0, 0.0};
				
				DispatchKeyValueVector(particle, "Origin", fPos);
				DispatchKeyValueVector(particle, "Angles", fAng);
				DispatchKeyValueFloat(particle, "BaseSpread", 15.0);
				DispatchKeyValueFloat(particle, "StartSize", 2.0);
				DispatchKeyValueFloat(particle, "EndSize", 6.0);
				DispatchKeyValueFloat(particle, "Twist", 0.0);
				
				DispatchKeyValue(particle, "Name", Name);
				DispatchKeyValue(particle, "SmokeMaterial","effects/combinemuzzle2.vmt");
				DispatchKeyValue(particle, "RenderColor", "252 232 131");
				DispatchKeyValue(particle, "SpreadSpeed", "10");
				DispatchKeyValue(particle, "RenderAmt", "200");
				DispatchKeyValue(particle, "JetLength", "13");
				DispatchKeyValue(particle, "RenderMode", "0");
				DispatchKeyValue(particle, "Initial", "0");
				DispatchKeyValue(particle, "Speed", "10");
				DispatchKeyValue(particle, "Rate", "173");
				DispatchSpawn(particle);
				
				SetVariantString("!activator");
				AcceptEntityInput(particle, "SetParent", client, particle, 0);
				AcceptEntityInput(particle, "TurnOn");
				particle = EntIndexToEntRef(particle);
				SetVariantString("OnUser1 !self:Kill::3.5:-1");
				AcceptEntityInput(particle, "AddOutput");
				AcceptEntityInput(particle, "FireUser1");
			}
		}
    }
}

public Action:OverlayOffTimer(Handle:timer, any:client)
{
	OverlayDelTimer[client] = INVALID_HANDLE;
	if (IsClientInGame(client))
	{
		ClientCommand(client, "r_screenoverlay off");
	}
	return Plugin_Stop;
}

public OnClientDisconnect(client)
{
	if (OverlayDelTimer[client] != INVALID_HANDLE)
	{
		KillTimer(OverlayDelTimer[client]);
		OverlayDelTimer[client] = INVALID_HANDLE;
	}
}

stock bool:IsValidPlayer(client,bool:check_alive=false,bool:alivecheckbyhealth=false) 
{
	if(client>0 && client<=MaxClients && IsClientConnected(client) && IsClientInGame(client))
	{
		if(check_alive && !IsPlayerAlive(client))
		{
			return false;
		}
		if(alivecheckbyhealth&&GetClientHealth(client)<1) {
		return false;
		}
		return true;
	}
	return false;
}