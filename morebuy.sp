#include <sourcemod>
#include <sdktools>

public Plugin:myinfo =
{
	name = "MoreBuy",
	author = "233333Tech.Yunwanjia & iCraftDreamers",
	description = "Add more things to buy.",
	version = SOURCEMOD_VERSION,
	url = "https://233333.tech"
}

new ShieldCost = 1000
new HeavyCost = 6000
new HealthCost = 650
new BreachchargeCost = 859
new TagrenadeCost = 350
new BumpmineCost = 600
new ParachuteCost = 700
new ExojumpCost = 800
new NvgsCost = 400
new BombCost = 1500

new bool:RequireBuyZone = true;
Handle BuyStartRoundTimer;

public OnPluginStart()
{
	RegConsoleCmd("sm_buy", BuymenuCMD);
	RegConsoleCmd("sm_buyshield", BuyShieldCMD);
	RegConsoleCmd("sm_buyheavy", BuyHeavyCMD);
	RegConsoleCmd("sm_buyhealth", BuyHealthCMD);
	RegConsoleCmd("sm_buybreach", BuyBreachchargeCMD);
	RegConsoleCmd("sm_buytagrenade", BuyTagrenadeCMD);
	RegConsoleCmd("sm_buybumpmine", BuyBumpmineCMD);
	RegConsoleCmd("sm_buyparachute", BuyParachuteCMD);
	RegConsoleCmd("sm_buyexo", BuyExojumpCMD);
	RegConsoleCmd("sm_buynvgs", BuyNvgsCMD);
	RegConsoleCmd("sm_buybomb", BuyBombCMD);
	
	HookEvent("round_prestart", Event_RoundPreStart);
}

public Action BuymenuCMD(int client , int args)
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	new Handle:menu = CreateMenu(buyHandler);
	SetMenuTitle(menu, "拓展购买菜单");
	AddMenuItem(menu, "1", "$1000", "防暴盾牌");
	AddMenuItem(menu, "2", "$6000", "重型护甲");
	AddMenuItem(menu, "3", "$650", "医疗针");
	AddMenuItem(menu, "4", "$850", "遥控炸弹");
	AddMenuItem(menu, "5", "$350", "战术探测手雷");
	AddMenuItem(menu, "6", "$600", "弹射地雷");
	AddMenuItem(menu, "7", "$700", "降落伞");
	AddMenuItem(menu, "8", "$800", "外骨骼跳跃装置");
	AddMenuItem(menu, "9", "$400  夜视仪");
	AddMenuItem(menu, "10", "花$1500再来个包！");
	SetMenuExitButton(menu, true);
	bool:DisplayMenu(menu,client,0);
}

public buyHandler(Handle:menu, MenuAction:action, client, position)
{
	if ( action == MenuAction_Select )   
	{
		decl String: Item[128];
		GetMenuItem(menu,position,Item,sizeof(Item));
		if(StrEqual(Item,"1"))
		{
			ClientCommand(client,"sm_buyshield");
		}
		else if(StrEqual(Item,"2"))
		{
			ClientCommand(client,"sm_buyheavy");
		}
		else if(StrEqual(Item,"3"))
		{
			ClientCommand(client,"sm_buyhealth");
		}
		else if(StrEqual(Item,"4"))
		{
			ClientCommand(client,"sm_buybreach");
		}
		else if(StrEqual(Item,"5"))
		{
			ClientCommand(client,"sm_buytagrenade");
		}
		else if(StrEqual(Item,"6"))
		{
			ClientCommand(client,"sm_buybumpmine");
		}
		else if(StrEqual(Item,"7"))
		{
			ClientCommand(client,"sm_buyparachute");
		}
		else if(StrEqual(Item,"8"))
		{
			ClientCommand(client,"sm_buyexo");
		}
		else if(StrEqual(Item,"9"))
		{
			ClientCommand(client,"sm_buynvgs");
		}
		else if(StrEqual(Item,"10"))
		{
			ClientCommand(client,"sm_buybomb");
		}
	}
}

public Action BuyShieldCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < ShieldCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - ShieldCost);
	GivePlayerItem(client, "weapon_shield");
	
	return Plugin_Handled;
}

public Action BuyHeavyCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < HeavyCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - HeavyCost);
	GivePlayerItem(client, "item_heavyassaultsuit");
	
	return Plugin_Handled;
}

public Action BuyHealthCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < HealthCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - HealthCost);
	GivePlayerItem(client, "weapon_healthshot");
	
	return Plugin_Handled;
}

public Action BuyBreachchargeCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < BreachchargeCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - BreachchargeCost);
	GivePlayerItem(client, "weapon_breachcharge");
	
	return Plugin_Handled;
}

public Action BuyTagrenadeCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < TagrenadeCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - TagrenadeCost);
	GivePlayerItem(client, "weapon_tagrenade");
	
	return Plugin_Handled;
}

public Action BuyBumpmineCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < BumpmineCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - BumpmineCost);
	GivePlayerItem(client, "weapon_bumpmine");
	
	return Plugin_Handled;
}

public Action BuyParachuteCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < ParachuteCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - ParachuteCost);
	GivePlayerItem(client, "weapon_bumpmine");
	
	return Plugin_Handled;
}

public Action BuyExojumpCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < ExojumpCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - ExojumpCost);
	GivePlayerItem(client, "exojump");
	
	return Plugin_Handled;
}

public Action BuyNvgsCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < NvgsCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - NvgsCost);
	GivePlayerItem(client, "item_nvgs");
	
	return Plugin_Handled;
}

public Action BuyBombCMD(int client, int args) 
{
	if(RequireBuyZone)
	{
		new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
		if(!InBuyZone)
		{
			PrintHintText(client, "#BuyMenu_NotInBuyZone");
			return Plugin_Handled;
		}
		if (BuyStartRoundTimer == null)
		{
			PrintHintText(client, "#BuyMenu_OutOfTime")
			return Plugin_Handled;
		}
	}
	
	new account = GetEntProp(client, Prop_Send, "m_iAccount");
	if(account < BombCost)
	{
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return Plugin_Handled;
	}
	
	SetEntProp(client, Prop_Send, "m_iAccount", account - BombCost);
	GivePlayerItem(client, "weapon_c4");
	
	return Plugin_Handled;
}

public Event_RoundPreStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	new Float:BuyTime = 45.0;
	ConVar cvarBuyTime = FindConVar("mp_buytime");
	
	if(cvarBuyTime != null)
		BuyTime = float(cvarBuyTime.IntValue);
		
	if (BuyStartRoundTimer != null)
	{
		KillTimer(BuyStartRoundTimer);
		BuyStartRoundTimer = null;
	}
	
	BuyStartRoundTimer = CreateTimer(BuyTime, StopBuying);
}


public Action StopBuying(Handle timer, any client)
{
	BuyStartRoundTimer = null;
	
	return Plugin_Stop;
}