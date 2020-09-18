// Still working on some more features and some bug haven't been fixed yet
#define FILTERSCRIPT
#include <a_samp>
#include <LiveCam>
#include <sscanf2>
#include <zcmd>
#include <streamer>
#if defined FILTERSCRIPT
#define MAX_FLARES 5
enum flInfo
{
    flCreated,
    Float:flX,
    Float:flY,
    Float:flZ,
    flObject,
    flObject2,
};

new Reporter[MAX_PLAYERS];
new Live;
new FlareInfo[MAX_FLARES][flInfo];
 
#endif
public OnFilterScriptInit()
{
	print("Camera Live Stream Loaded");
	return 1;
}

public OnFilterScriptExit()
{
	return 1;
}
 
new Text3D:note;
stock CreateFlare(Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(FlareInfo); i++)
  	{
  	    if(FlareInfo[i][flCreated] == 0)
  	    {
            FlareInfo[i][flCreated]=1;
            FlareInfo[i][flX]=x;
            FlareInfo[i][flY]=y;
            FlareInfo[i][flZ]=z-0.9;
            FlareInfo[i][flObject2] = CreateDynamicObject(19623, x, y, z+0.6, 0, 0, Angle);
            FlareInfo[i][flObject] = CreateDynamicObject(19611, x, y, z-1, 0, 0, Angle);
            FlareInfo[i][flObject] = CreateDynamicObject(19610, x, y-0.1, z+0.6, 0, 0, Angle-180);

	        return 1;
  	    }
  	}
  	return 0;
}
CMD:clean(playerid, params[])
{
    Reporter[playerid] = 0;
}
CMD:setrp(playerid, params[])
{
	new string[128], cameraman;
    if(IsPlayerAdmin(playerid) && !sscanf(params, "u", cameraman))
	{
		if (IsPlayerConnected(cameraman))
		{
			if(cameraman != INVALID_PLAYER_ID)
			{
				format(string, sizeof(string), "Ban da nang %s len lam reporter", GetPlayerNameEx(cameraman));
				SendClientMessage(playerid, -1, string);
				SendClientMessage(cameraman, -1, "Ban da duoc nang len lam reporter");
				Reporter[cameraman] = 1;
			}
			else return SendClientMessage(playerid, -1, "Nguoi choi khong hop le");
		}
		
	}
	else return SendClientMessage(playerid, -1, "Ban khong the lam dieu nay");
    return 1;
}
CMD:live(playerid, params[])
{
	new string[128];
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, -1, "Ban khong the lam viec nay khi ngoi tren xe");
    if(Reporter[playerid] == 1)
    {
    SendClientMessage(playerid, -1, "Ban da bat dau live stream, go /stop de dung");
    Live = 1;
    GivePlayerCamera(playerid);
    format(string, sizeof(string), "%s da bat dau phat truc tiep, /watch ngay!", GetPlayerNameEx(playerid));
    SendClientMessageToAll(-1, string);
    }
    else return SendClientMessage(playerid, -1, "Ban khong phai la phong vien");
    return 1;
}
CMD:watch(playerid, params[])
{
    new Float:x, Float:y, Float:z, cameraman;
    if(IsPlayerWatchingCamera(playerid)) return SendClientMessage(playerid, -1, "Ban dang xem chuong trinh nay roi");
    if(IsPlayerRecording(playerid)) return SendClientMessage(playerid, -1, "Ban khong the lam viec nay");
    if(Live == 1)
    {
    GetPlayerPos(playerid, x, y, z);
    StartPlayerWatchingCamera(playerid, cameraman);
    SendClientMessage(playerid, -1, "Ban dang xem buoi phat song, de ngung xem an lenh /stopwt");
    note = CreateDynamic3DTextLabel("Nguoi choi dang xem buoi phat song truc tiep", -1, x, y, z+1, 5, INVALID_PLAYER_ID, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid));
    Attach3DTextLabelToPlayer(note, playerid, 0.0, 0.0, 0.47);
    }
    /*if(GetPVarInt(playerid, "place") == 1)
    {
    for(new i = 0; i < sizeof(FlareInfo); i++)
  	{
	AttachCameraToDynamicObject(playerid, FlareInfo[i][flObject2]);
	}
	}*/
    else return SendClientMessage(playerid, -1, "Khong co buoi phat song nao de xem");
    return 1;
}
CMD:stopwt(playerid, params[])
{
if(IsPlayerWatchingCamera(playerid))
{
StopPlayerWatchingCamera(playerid);
SendClientMessage(playerid, -1, "Ban da ngung xem buoi phat song");
Delete3DTextLabel(note);
}
else return SendClientMessage(playerid, -1, "Ban khong the lam dieu nay");
return 1;
}
CMD:stop(playerid, params[])
{
if(IsPlayerRecording(playerid))
{
RemovePlayerCamera(playerid);
SendClientMessageToAll(-1, "Buoi phat song da ket thuc");
Live = 0;
}
if(IsPlayerWatchingCamera(playerid))
{
StopPlayerWatchingCamera(playerid);
Delete3DTextLabel(note);
}
if (!IsPlayerWatchingCamera(playerid)) return SendClientMessage(playerid, -1, "Ban khong the lam dieu nay");
return 1;
}
stock RemoveHoldingCamera(playerid)
{
	//ClearAnimations(playerid);
	SetPlayerSpecialAction(playerid , SPECIAL_ACTION_NONE);
	RemovePlayerAttachedObject(playerid , 0);
	RemovePlayerAttachedObject(playerid , 1);
	return 1;
}
CMD:datmay(playerid, params[])
{
if(IsPlayerRecording(playerid))
{
RemoveHoldingCamera(playerid); // cai nay remove luon applyanimation, can fix lai va code attach obj to obj
new Float:angle, Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
GetPlayerFacingAngle(playerid, angle);
CreateFlare(x, y, z, angle);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 3500, 0);
SetPVarInt(playerid, "place", 1);
}
if(Reporter[playerid] == 1)
{
new Float:angle, Float:x, Float:y, Float:z;
GetPlayerPos(playerid, x, y, z);
GetPlayerFacingAngle(playerid, angle);
CreateFlare(x, y, z, angle);
ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 3500, 0);
SetPVarInt(playerid, "place", 1);
}
return 1;
}

public OnPlayerConnect(playerid)
{

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    Reporter[playerid] = 0;
    Live = 0;
	return 1;
}
stock GetPlayerNameEx(playerid)
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    return playerName;
}
/*stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetDynamicObjectPos(FlareInfo[i][flObject2], x, y, a);
	GetPlayerFacingAngle(playerid, a);
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
forward OnCameraUpdate(playerid, cameraman);
public OnCameraUpdate(playerid, cameraman)
{
    if(__pc[playerWatching])
    {
        if(_playerCamera[cameraman][playerRecording])
        {
        	new Float:x , Float:y , Float:z;
        	GetDynamicObjectPos(FlareInfo[i][flObject2], x, y, z);
    		GetXYInFrontOfPlayer(cameraman , x , y , 0.6);
        	SetPlayerCameraPos(playerid , x ,y ,z+0.8);
        	GetPlayerPos(cameraman , x ,y ,z);
        	GetXYInFrontOfPlayer(cameraman , x , y , 10.0);
        	SetPlayerCameraLookAt(playerid , x , y , z+0.8 );
        } else StopPlayerWatchingCamera(playerid);
    }
    return 1;
}
CMD:veh(playerid,params[])
{
new car;
new string[128];
new Float:X, Float:Y, Float:Z;
GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
if(sscanf(params,"i", car)) return SendClientMessage(playerid,0xff0000ff,"USAGE: /Veh <Vehicle ID 400 - 611>");
else if(car < 400 || car >611) return SendClientMessage(playerid, 0xff0000ff, "ERROR: Cannot go under 400 or above 611.");
{
if(Vehicle[playerid] != 0)
{
DestroyVehicle(Vehicle[playerid]);
}
Vehicle[playerid] = CreateVehicle(car, X, Y, Z + 2.0, 0, -1, -1, 1);
format(string,sizeof(string),"You Have Spawned Vehicle ID %i",car);
SendClientMessage(playerid, 0xffffffff, string);
PutPlayerInVehicle(playerid, Vehicle[playerid], 0);
}
return 1;
}*/
