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

new bool:IfInBuyTime;
Menu buyMenu;

public OnPluginStart()
{
	RegConsoleCmd("sm_buy",BuyItems);

	HookEvent("buytime_ended",Event_OutOfBuyTime);
	HookEvent("round_prestart", Event_RoundPreStart);
	HookEvent("exit_buyzone", Event_NotInBuyZone);
}

public Action BuyItems(int client, int args)
{
	if(IfBuyAvail(client))
	{
		CreateBuyMenu().Display(client,0);
	}
	return Plugin_Continue;
}


Menu CreateBuyMenu()
{
	buyMenu = new Menu(MenuHandler);
	buyMenu.SetTitle("拓展购买菜单");
	char text[][] = {
		"$1000 防暴盾牌",
		"$6000 重型护甲",
		"$650 医疗针",
		"$850 遥控炸弹",
		"$350 战术探测手雷",
		"$600 弹射地雷",
		"$700 降落伞",
		"$800 外骨骼跳跃装置",
		"$400  夜视仪",
		"花$1500再来个包！"
	}
	for(int i = 0; i < 10; i++)
	{
		// if(strlen(text[i]) == 0)
		// 		break;
		char buffer[4];
		IntToString(i ,buffer, sizeof(buffer));
		buyMenu.AddItem(buffer, text[i]);
	}
	return buyMenu;
}
public int MenuHandler(Menu menu, MenuAction action, int client, int selection)
{
	// if (action == MenuAction_Select)
	// {
		
	// }
	switch (action) {
		case MenuAction_Select: {
			char itemName[32];
			menu.GetItem(selection, itemName, sizeof(itemName));
			IfCanBuy(client, selection);
			CreateBuyMenu().DisplayAt(client, GetMenuSelectionPosition(), 0);
		}
	}
	return 0;
}


public bool:IfBuyAvail(int client)
{
    new bool:InBuyZone = view_as<bool>(GetEntProp(client, Prop_Send, "m_bInBuyZone"));
    if (!IfInBuyTime){
        PrintHintText(client, "#BuyMenu_OutOfTime");
        return false;
		}
    if(!InBuyZone){
        PrintHintText(client, "#BuyMenu_NotInBuyZone");
        return false;
		}
    return true;
}

public IfCanBuy(int client,int args)
{
	char WeaponID[][] = {
		"weapon_shield",
		"item_heavyassaultsuit",
		"weapon_healthshot",
		"weapon_breachcharge",
		"weapon_tagrenade",
		"weapon_bumpmine",
		"parachute",
		"exojump",
		"item_nvgs",
		"weapon_c4",
	};
	int WeaponPrice[] = {1000,6000,650,850,350,600,700,800,400,1500};
	new PlayerAccount = GetEntProp(client, Prop_Send, "m_iAccount");
	if(WeaponPrice[args] > PlayerAccount){
		PrintHintText(client, "#Cstrike_TitlesTXT_Not_Enough_Money");
		return;
    }
	SetEntProp(client, Prop_Send, "m_iAccount", PlayerAccount - WeaponPrice[args]);
	GivePlayerItem(client, WeaponID[args]);
	
}

// public PrintInfo(int client,char[] args)
// {
// 	switch (args) {
// 		case OutOfTime: {
// 			PrintHintText(client, "#BuyMenu_OutOfTime");
// 		}
// 		case OutOfZone: {
// 			PrintHintText(client, "#SFUI_BuyMenu_NotInBuyZone");
// 		}
// 	}

// }
public Event_RoundPreStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	ConVar cvarBuyTime = FindConVar("mp_buytime");
	if(cvarBuyTime != null)
    {
        bool:IfInBuyTime = true;
    }
}

public Event_NotInBuyZone(Handle:event, const String:name[], bool:dontBroadcast)
{
	delete buyMenu;
}
public Event_OutOfBuyTime(Handle:event, const String:name[], bool:dontBroadcast)
{
    delete buyMenu;
    bool:IfInBuyTime = false;
}