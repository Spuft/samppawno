#define FILTERSCRIPT
#include <a_samp>
#include <a_actor>
#include <zcmd>
#if defined FILTERSCRIPT
#define function%0(%1) forward%0(%1);public%0(%1)
#define ATTACH_INDEX    (3)
#define POSSELLGEM -201.0373, -1740.7594, 1.1547 // place to sell gem
#define POSMACHINE -774.9731, -1945.0935, 7.1503 // gem machine (loading gem after digging)
#define POSLOADGEM -808.7507, -1905.1099, 9.1550 // Place to load gem on car
#define MININGVEH 422, 543, 554 // vehicle that allowed to transport gem
new soda[MAX_PLAYERS];
new cp1[MAX_PLAYERS];
new actor1;
new pVehicleID;
new obj1;
new obj2;
new obj3;
new stone1;
new stone2;
enum pInfo
{
	pGetJob,
	pStartJob,
	pAlreadySE
};
new PlayerInfo[MAX_PLAYERS][pInfo];
new Float:RandomSpawn[][3] =
{
    // Positions, (X, Y, Z and Facing Angle)
    {-873.1492,-1929.0703,24.6819},
    {-879.4926,-1911.9144,38.0141},
    {-862.8982,-1901.0688,38.3521},
    {-881.0944,-1989.5999,25.9896},
    {-737.8086,-1837.0662,22.1271},
    {-690.7778,-1913.4591,7.2225}
};
 
new color [][3] = // color of the gemstone
{
{0xFF4169E1},
{0xFF228B22},
{0xFF333333}
};

public OnFilterScriptInit()
{
	// the map i use for coding, this is optional
CreateObject(3406, -800.90002, -1936.30005, 3.80000,   0.00000, 0.00000, 316.00000);
CreateObject(3406, -794.79999, -1942.19995, 3.80000,   0.00000, 0.00000, 316.00000);
CreateObject(3406, -788.50000, -1948.30005, 3.80000,   0.00000, 0.00000, 316.00000);
CreateObject(3406, -782.29999, -1948.90002, 3.80000,   0.00000, 0.00000, 46.00000);
CreateObject(3406, -776.20001, -1942.59998, 3.80000,   0.00000, 0.00000, 46.00000);
CreateObject(16502, -772.29999, -1902.09998, 2.70000,   0.00000, 0.00000, 130.00000);
CreateObject(8873, -772.79999, -1891.50000, 12.20000,   0.00000, 0.00000, 334.00000);
CreateObject(920, -772.50000, -1892.59998, 6.50000,   0.00000, 0.00000, 5.00000);
CreateObject(3287, -816.29999, -1884.80005, 15.40000,   0.00000, 0.00000, 309.25000);
CreateObject(3675, -820.59998, -1888.40002, 12.40000,   0.00000, 0.00000, 310.00000);
CreateObject(16083, -770.20001, -1942.00000, 6.70000,   0.00000, 0.00000, 306.00000);
CreateObject(16071, -784.09998, -1928.59998, 8.10000,   0.00000, 0.00000, 346.00000);
CreateObject(3214, -803.50000, -1910.80005, 3.80000,   0.00000, 0.00000, 316.00000);
CreateObject(925, -812.70001, -1882.40002, 11.70000,   0.00000, 0.00000, 16.00000);
CreateObject(16405, -777.79999, -1894.69995, 7.80000,   0.00000, 0.00000, 310.00000);
CreateObject(1457, -807.79999, -1934.40002, 6.90000,   0.00000, 0.00000, 138.00000);
CreateObject(1458, -805.59998, -1920.19995, 6.00000,   7.99500, 2.02000, 13.71900);
CreateObject(3252, -796.90002, -1905.30005, 6.60000,   0.00000, 0.00000, 208.00000);
CreateObject(3403, -791.50000, -1868.90002, 13.50000,   0.00000, 0.00000, 36.00000);
CreateObject(647, -777.00000, -1854.19995, 12.50000,   0.00000, 0.00000, 0.00000);
CreateObject(647, -774.09998, -1856.30005, 11.50000,   0.00000, 0.00000, 0.00000);
CreateObject(647, -784.40002, -1860.40002, 11.30000,   0.00000, 0.00000, 0.00000);
CreateObject(759, -810.40002, -1941.00000, 5.30000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -813.09998, -1938.30005, 7.50000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -789.20001, -1905.09998, 7.60000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -789.90002, -1900.00000, 7.60000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -794.29999, -1902.90002, 7.60000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -798.00000, -1932.19995, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -796.50000, -1929.80005, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -794.00000, -1928.09998, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -793.20001, -1926.00000, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -790.79999, -1924.80005, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -795.00000, -1930.30005, 7.20000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -805.79999, -1939.30005, 7.20000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -782.09998, -1910.09998, 7.20000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -783.40002, -1911.69995, 7.20000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -782.09998, -1912.09998, 7.20000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -770.59998, -1900.19995, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -769.79999, -1899.19995, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -769.40002, -1901.09998, 7.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -769.20001, -1901.59998, 6.70000,   0.00000, 0.00000, 0.00000);
CreateObject(806, -769.20020, -1901.59961, 6.70000,   0.00000, 0.00000, 0.00000);
CreateObject(810, -827.79999, -1892.59998, 11.30000,   0.00000, 0.00000, 0.00000);
CreateObject(822, -818.90002, -1953.09998, 7.30000,   0.00000, 0.00000, 0.00000);
CreateObject(14469, -796.09998, -1869.40002, 11.00000,   0.00000, 0.00000, 0.00000);
CreateObject(14872, -808.50000, -1932.00000, 5.60000,   0.00000, 0.00000, 0.00000);
CreateObject(13435, -801.40002, -1860.90002, 13.40000,   0.00000, 0.00000, 302.00000);
CreateObject(839, -742.09998, -1880.50000, 7.80000,   280.00000, 0.00000, 214.00000);
CreateObject(833, -760.59998, -1890.69995, 6.80000,   342.00000, 0.00000, 186.00000);
CreateObject(18248, -826.90002, -1918.00000, 17.50000,   10.00000, 0.00000, 68.00000);
CreateObject(12957, -777.90002, -1869.00000, 11.50000,   0.00000, 0.00000, 0.00000);
CreateObject(3675, -773.09998, -1944.59998, 12.40000,   0.00000, 0.00000, 309.99600);
CreateObject(3675, -774.59998, -1945.80005, -1.10000,   1.75000, 180.00000, 129.99600);
CreateObject(3171, -805.29999, -1878.40002, 10.60000,   0.00000, 0.00000, 90.00000);
CreateObject(12991, -769.20001, -1860.50000, 11.30000,   0.00000, 3.25000, 176.00000);
CreateObject(11289, -816.20001, -1887.09998, 12.70000,   0.00000, 0.00000, 40.00000);
CreateObject(3265, -751.70001, -1863.69995, 10.90000,   0.00000, 0.00000, 72.00000);
CreateObject(2905, -768.00000, -1859.40002, 11.40000,   0.00000, 0.00000, 42.00000);
CreateObject(1558, -770.59998, -1858.50000, 11.80000,   0.00000, 0.00000, 0.00000);
CreateObject(1447, -756.20001, -1857.59998, 13.00000,   0.00000, 0.00000, 122.00000);
CreateObject(1447, -753.40002, -1862.00000, 12.80000,   358.01099, 353.99600, 121.78900);
CreateObject(1447, -844.79999, -1913.09998, 14.20000,   0.00000, 352.00000, 135.99800);
CreateObject(1447, -841.09998, -1916.69995, 13.40000,   0.00000, 351.99600, 135.99400);
CreateObject(1447, -837.40002, -1920.40002, 13.00000,   0.00000, 351.99600, 135.99400);
CreateObject(1447, -833.59998, -1924.09998, 12.40000,   0.00000, 351.99600, 135.99400);
CreateObject(1447, -818.09998, -1940.80005, 7.90000,   0.00000, 341.99600, 135.99400);
CreateObject(1447, -821.50000, -1937.30005, 9.20000,   0.00000, 345.99301, 135.99400);
CreateObject(1459, -771.90002, -1902.59998, 6.00000,   0.00000, 0.00000, 38.00000);
CreateObject(17031, -734.90002, -1828.80005, 16.50000,   0.00000, 0.00000, 260.00000);
CreateObject(17031, -875.79999, -1903.30005, 27.50000,   0.00000, 0.00000, 309.99701);
CreateObject(17031, -873.00000, -1919.00000, 18.50000,   0.00000, 0.00000, 289.99600);
CreateObject(823, -879.50000, -1927.80005, 30.50000,   0.00000, 0.00000, 0.00000);
CreateObject(823, -878.59998, -1930.30005, 29.30000,   0.00000, 0.00000, 0.00000);
CreateObject(803, -847.09998, -1915.90002, 13.90000,   0.00000, 0.00000, 0.00000);
CreateObject(803, -850.50000, -1918.09998, 14.40000,   0.00000, 0.00000, 0.00000);
CreateObject(803, -843.70001, -1918.40002, 13.10000,   0.00000, 0.00000, 0.00000);
CreateObject(803, -841.20001, -1921.00000, 13.10000,   0.00000, 0.00000, 0.00000);
CreateObject(803, -844.20001, -1912.69995, 13.60000,   0.00000, 0.00000, 0.00000);
CreateObject(762, -757.09998, -1857.40002, 14.50000,   0.00000, 0.00000, 180.00000);
CreateObject(762, -757.09961, -1857.40039, 14.50000,   0.00000, 0.00000, 129.99500);
CreateObject(762, -753.50000, -1849.40002, 12.80000,   0.00000, 0.00000, 149.99001);
CreateObject(803, -878.59998, -1930.90002, 27.60000,   0.00000, 0.00000, 0.00000);
CreateObject(855, -803.50000, -1938.09998, 4.50000,   0.00000, 0.00000, 0.00000);
CreateObject(855, -798.59998, -1932.50000, 4.50000,   0.00000, 0.00000, 0.00000);
CreateObject(855, -787.40002, -1918.40002, 5.80000,   0.00000, 0.00000, 0.00000);
CreateObject(855, -785.40002, -1914.19995, 5.80000,   0.00000, 0.00000, 0.00000);
CreateObject(855, -774.09998, -1902.50000, 5.60000,   0.00000, 0.00000, 0.00000);
CreateObject(943, -780.50000, -1898.19995, 6.80000,   6.00000, 0.00000, 42.00000);
CreateObject(1437, -776.29999, -1942.80005, 6.80000,   334.00000, 0.00000, 288.00000);
CreateObject(1472, -804.79999, -1879.90002, 10.70000,   0.00000, 0.00000, 0.00000);
CreateObject(1686, -822.20001, -1889.90002, 10.60000,   357.25000, 0.00000, 312.00000);
CreateObject(3525, -779.79999, -1899.00000, 6.60000,   0.00000, 0.00000, 0.00000);
CreateObject(2237, -802.29999, -1932.00000, 6.30000,   0.00000, 0.00000, 0.00000);
CreateObject(3262, -824.29999, -1935.80005, 8.70000,   0.00000, 0.00000, 304.00000);
CreateObject(3263, -832.40002, -1926.30005, 10.40000,   0.00000, 0.00000, 0.00000);
CreateObject(3265, -841.79999, -1940.59998, 11.30000,   0.00000, 0.00000, 6.00000);
CreateObject(850, -747.20001, -1872.80005, 9.20000,   11.88200, 8.17600, 356.30600);
CreateObject(3264, -744.40002, -1873.19995, 8.20000,   0.00000, 0.00000, 140.00000);
CreateObject(1369, -752.40002, -1864.80005, 11.60000,   7.92200, 351.92200, 95.12100);
CreateObject(2907, -767.70001, -1860.19995, 11.50000,   0.00000, 0.00000, 14.00000);
CreateObject(762, -778.29999, -1860.09998, 16.90000,   0.00000, 0.00000, 0.00000);
CreateObject(762, -778.59998, -1857.30005, 14.80000,   0.00000, 0.00000, 42.00000);
CreateObject(800, -742.70001, -1875.90002, 8.60000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -746.90002, -1876.00000, 9.40000,   0.00000, 0.00000, 50.00000);
CreateObject(800, -868.00000, -1910.50000, 35.90000,   0.00000, 0.00000, 0.00000);
CreateObject(800, -868.09998, -1912.59998, 35.00000,   0.00000, 0.00000, 0.00000);
CreateObject(818, -777.20001, -1905.40002, 7.40000,   0.00000, 0.00000, 0.00000);
CreateObject(818, -780.00000, -1908.69995, 7.40000,   0.00000, 0.00000, 80.00000);
CreateObject(818, -758.50000, -1890.69995, 7.60000,   0.00000, 0.00000, 0.00000);
CreateObject(818, -754.59998, -1888.30005, 7.60000,   0.00000, 0.00000, 16.00000);
CreateObject(818, -796.79999, -1928.80005, 7.90000,   0.00000, 0.00000, 0.00000);
obj1 = CreateObject(2936, -774.33093, -1937.94177, 6.38359,   0.00000, 0.00000, 0.00000);
obj2 = CreateObject(2936, -775.53168, -1936.48779, 6.55137,   0.00000, 0.00000, 0.00000);
obj3 = CreateObject(2936, -776.76068, -1935.39673, 6.79255,   0.00000, 0.00000, 0.00000);
actor1 = CreateActor(29, -806.1173,-1880.7642,11.7221, 180);

return 1;
} 
public OnFilterScriptExit()
{
	return 1;
}

#endif
public OnPlayerConnect(playerid)
{
PlayerInfo[playerid][pStartJob] = 0;
PlayerInfo[playerid][pAlreadySE] = 0;
Create3DTextLabel("Bob - Truong Doan Cong Nhan Mo\nChuot phai + Y de nhan viec", -1, -806.1173, -1880.7642, 11.7221, 0, 0, 0);
return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
// PlayerInfo[playerid][pGetJob] = 0;
// un-comment this if you want everytime players quit the game, they have to get job again
PlayerInfo[playerid][pStartJob] = 0;
soda[playerid] = 0;
DestroyObject(stone1);
DestroyObject(stone2);
return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_YES)
	{
		if(GetPlayerTargetActor(playerid) != INVALID_ACTOR_ID)
		{
			new actortarget = GetPlayerTargetActor(playerid);
			if(actortarget == actor1)
			{
			ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "What do you want from me?", "Xin Viec\nBat dau cong viec\nBo viec", "Chon", "Khong");
			}
	    }
	}
	return 1;
}

IsPlayerInMiningVeh(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
	    case MININGVEH: return 1;
	    default: return 0;
	}

	return 0;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
if(response)
    {
    switch(dialogid)
        {
		case 1:
    	    {
           	switch(listitem)
        	{
        	    case 0:
        	    {
					if (PlayerInfo[playerid][pGetJob] == 1) return SendClientMessage(playerid, -1, "Ban da nhan viec nay roi!");
					SendClientMessage(playerid, -1, "Ban da nhan viec Mining thanh cong!");
        	        SetPlayerSkin(playerid, 260);
        	        SetPlayerAttachedObject(playerid, ATTACH_INDEX, 19631, 6, 0.048, 0.029, 0.103, -80.0, 80.0, 0.0);
				    PlayerInfo[playerid][pGetJob] = 1;
				 }
        	    case 1:
        	    {
        	        if(PlayerInfo[playerid][pGetJob] != 1) return SendClientMessage(playerid, 0xFFFFFF, "Ban chua nhan viec!");
         	        if (PlayerInfo[playerid][pGetJob] == 1 && cp1[playerid] != 0) return SendClientMessage(playerid, -1, "Ban dang bat dau lam cong viec nay roi!");
         	        if (GetPVarInt(playerid, "jb") == 1) return SendClientMessage(playerid, -1, "Ban dang bat dau lam cong viec nay roi!");
         	        PlayerInfo[playerid][pStartJob] = 1;
					cp1[playerid] = 1;
					new rand = random(sizeof(RandomSpawn));
 					SetPlayerCheckpoint(playerid, RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 5);
        	    }
        	    case 2:
        	    {
        	        if(PlayerInfo[playerid][pGetJob] == 1)
                 {
        	        DisablePlayerCheckpoint(playerid);
                    SendClientMessage(playerid, 0xFFFFFF, "Bob: Ok bro, vê nha mà lo cho vo con, câm tam chai ruou di này");
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
                    PlayerInfo[playerid][pGetJob] = 0;
                    soda[playerid] = 0;
                    PlayerInfo[playerid][pStartJob] = 0;
                    PlayerInfo[playerid][pAlreadySE] = 0;
                    ResetPlayerWeapons(playerid);
                    SetPVarInt(playerid, "jb", 0);
                    }
                    else return SendClientMessage(playerid, 0xFFFFFF, "Ban chua nhan viec!");
        	    }
        	}
    	    }
	}
    }
return 1;
}
stock randomEx(min, max)
{    
    //Credits to ******    
    new rand = random(max-min)+min;    
    return rand;
}
public OnPlayerEnterCheckpoint(playerid)
{
if(cp1[playerid] == 1)
    {
    	if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
        {
    	PlayerPlaySound(playerid, 5201, 0, 0, 0);
    	DisablePlayerCheckpoint(playerid);
    	SetTimerEx("dig", 4000, 0, "i", playerid);
    	TogglePlayerControllable(playerid, 0);
    	SetPlayerArmedWeapon(playerid, 0);
    	ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1);
    	GameTextForPlayer(playerid, "~b~DANG DAO MO", 4000, 6);
		}
		else return SendClientMessage(playerid, -1, "Ban can xuong xe de lam viec nay");
    }
if(cp1[playerid] == 2)
{
SendClientMessage(playerid, -1, "Ban da dua vao khoang du tru 1 vien da");
SendClientMessage(playerid, -1, "Neu muon tiep tuc khai thac go /tieptuc");
SendClientMessage(playerid, -1, "De xem so luong da ban da dua vao nha may, go /soluong");
DisablePlayerCheckpoint(playerid);
soda[playerid]++;
SetPVarInt(playerid, "jb", 1);
SetPlayerAttachedObject(playerid, ATTACH_INDEX, 19631, 6, 0.048, 0.029, 0.103, -80.0, 80.0, 0.0);
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 1, 0, 0, 1, 0, 1);
SetTimerEx("placegem", 1000, 0, "i", playerid);
}
if(cp1[playerid] == 3)
{
    PlayerPlaySound(playerid, 5201, 0, 0, 0);
    DisablePlayerCheckpoint(playerid);
    SetTimerEx("dig", 4000, 0, "i", playerid);
    TogglePlayerControllable(playerid, 0);
    SetPlayerArmedWeapon(playerid, 0);
    ApplyAnimation(playerid, "BASEBALL", "Bat_1", 4.1, 1, 0, 0, 1, 0, 1);
    GameTextForPlayer(playerid, "~b~DANG DAO MO", 4000, 6);
    
}
if(cp1[playerid] == 4)
{
	if (IsPlayerInVehicle(playerid, pVehicleID))
	{
new string[128], cash = soda[playerid] * 2000, rdc = randomEx(1500, 3000);
new cashtest = rdc * soda[playerid];
format(string, sizeof(string), "Ban da dua vao nha may %i vien da va duoc ban voi gia $%i", soda, cashtest);
SendClientMessage(playerid, -1, string);
SendClientMessage(playerid, -1, "KuTun: Hmm... da ban lay kha chat luong day");
DisablePlayerCheckpoint(playerid);
GivePlayerMoney(playerid, cash);
soda[playerid] = 0;
DestroyObject(stone1);
DestroyObject(stone2);
PlayerInfo[playerid][pAlreadySE] = 0;
      }
      else return SendClientMessage(playerid, -1, "Ban chua chat da len xe nay");
}
if(cp1[playerid] == 5)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsPlayerInMiningVeh(vehicleid))
	{
		SendClientMessage(playerid, -1, "Cho 5s de da duoc chat len xe");
		TogglePlayerControllable(playerid, 0);
		SetTimerEx("loadgem", 5000, 0, "i", playerid);
		DisablePlayerCheckpoint(playerid);
	}
	else return SendClientMessage(playerid, -1, "Ban can o tren xe Bobcat hoac Sadler de lam viec nay");
}
else if(soda[playerid] == 10)
{
SendClientMessage(playerid, -1, "Nha may da day, dung gan dan may, go /se de may lam viec");
}
return 1;
} 
function loadgem(playerid)
{
	PlayerPlaySound(playerid, 1150, 0, 0, 0);
	pVehicleID = GetPlayerVehicleID(playerid);
    stone1 = CreateObject(2936, 0, 0, 0, 0, 0, 0, 0);
    stone2 = CreateObject(2936, 0, 0, 0, 0, 0, 0, 0);
	AttachObjectToVehicle(stone1, pVehicleID, -0.3000, -1.7999, 0.0000, 0.0000, 0.0000, 0.0000);
	AttachObjectToVehicle(stone2, pVehicleID, 0.2000, -1.2999, 0.0000, 0.0000, 0.0000, 0.0000);
	TogglePlayerControllable(playerid, 1);
	SetPlayerCheckpoint(playerid, POSSELLGEM, 5);
	cp1[playerid] = 4;
}
function dig(playerid)
{
ClearAnimations(playerid, 0);
TogglePlayerControllable(playerid, 1);
SendClientMessage(playerid, -1, "Ban da khai thac xong, hay chuyen da den gian may");
SendClientMessage(playerid, -1, "Toi da gian may co the chua: 10 vien da 1 luc");
SetPlayerCheckpoint(playerid, POSMACHINE, 5);
cp1[playerid] = 2;
new rand = random(sizeof(color));
SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
SetPlayerAttachedObject(playerid, ATTACH_INDEX, 2936, 5, 0.105, 0.086, 0.22, -80.3, 3.3, 28.7, 0.35, 0.35, 0.35, color[rand][0]);
}
function placegem(playerid)
{
ClearAnimations(playerid, 0);
cp1[playerid] = 0;
}
CMD:tieptuc(playerid, params[])
{
if(GetPVarInt(playerid, "jb") == 1 && cp1[playerid] == 0)
{
new rand = random(sizeof(RandomSpawn));
SetPlayerCheckpoint(playerid, RandomSpawn[rand][0], RandomSpawn[rand][1], RandomSpawn[rand][2], 5); 
cp1[playerid] = 3;
}
else return SendClientMessage(playerid, -1, "Ban chua lam viec");
return 1;
}
CMD:soluong(playerid, params[])
{
new string[128];
format(string, sizeof(string), "So luong da ban da dua vao nha may la: %i", soda);
SendClientMessage(playerid, -1, string);
}
CMD:se(playerid, params[])
{
if (IsPlayerInRangeOfPoint(playerid, 10, POSMACHINE) && PlayerInfo[playerid][pGetJob] == 1 && soda[playerid] > 0 && PlayerInfo[playerid][pAlreadySE] == 0)
{
MoveObject(obj3, -801.5023, -1911.7722, 12.5339, 5.0);
MoveObject(obj2, -801.5023, -1911.7722, 12.5339, 4.0);
MoveObject(obj1, -801.5023, -1911.7722, 12.5339, 3.0);
PlayerPlaySound(playerid, 1153, -10, 1, 0);
SendClientMessage(playerid, -1, "Ban da dua da vao nha may, hay chat da len xe va di den diem giao nhan");
SetPlayerCheckpoint(playerid, POSLOADGEM, 5);
cp1[playerid] = 5;
PlayerInfo[playerid][pAlreadySE] = 1;
}
else if (PlayerInfo[playerid][pGetJob] == 1) return SendClientMessage(playerid, -1, "Ban khong the lam viec nay");
if (PlayerInfo[playerid][pGetJob] != 1) return SendClientMessage(playerid, -1, "Ban chua nhan viec");
return 1;
}
