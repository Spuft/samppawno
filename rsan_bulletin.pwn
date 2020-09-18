/*BULLETIN FILTERSCRIPT BY HOANGNAM
Please do not remove the credits, thanks for downloading my script <3
Introduction:
Bulletin FS allow you to pin your note on the board or read the information at anytime you want (if you are near the place)
Feel free to develop it for more features such as: saving notes in SQL (im sucks), in my code, all the notes
will be saved at the scriptfiles and it won't be able to save more if there are 6 notes saved. Everybody
can remove the notes on the board so it might be hard to work with some RP servers, try to do more about this*/
#define FILTERSCRIPT
#include <a_samp>
#include <zcmd>
#if defined FILTERSCRIPT
#define white 0xFFFFFFFF
#define MAX_NOTES 6 // Maximum amount of notes on your bulletin (6 is recommended)
#define bulletinpos 287.6534, -1996.7939, 1.2305 // position of your bulletin 
//#define function%0(%1) forward%0(%1);public%0(%1)
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new Text:Textdraw3;
new Text:Textdraw4;
new Text:Textdraw5;
new Text:Textdraw6;
new Text:Textdraw7;
new Text:Textdraw8;
new Text:Textdraw9;
new Text:Textdraw10;
new Text:Textdraw11;
new Text:Textdraw12;
new Text:Textdraw13;
new Text:Textdraw14;
new Text:Textdraw15;
new Text:Textdraw16;
new Text:Textdraw17;
new Text:Textdraw18;
new Text:Textdraw19;
new Text:Textdraw20;
new Text:Textdraw21;
new Text:Textdraw22;
new Text:Textdraw23;
new Text:Textdraw24;
new Text:Textdraw25;
new Text:Textdraw26;
new Text:Textdraw27;
new Text:Textdraw28;
new Text:note0;
new Text:note1;
new Text:note2;
new ShowNote[MAX_PLAYERS];
new BoardOpen[MAX_PLAYERS];
public OnFilterScriptInit()
{
	print("Loading script for RSAN STUDIOLD");
	return 1;
}

public OnFilterScriptExit()
{
	print("Well ok, have no idea why i'm being shut down, but damn");
	return 1;
}

#endif
 
CMD:rsanhelp(playerid, params[])
{
	SendClientMessage(playerid, white, "RSAN STUDIOLD (2020)");
	SendClientMessage(playerid, white, "He thong Live Camera (dang phat trien)");
	SendClientMessage(playerid, white, "Dung tai TV o phong khach, go /old de duoc xem doan video gioi thieu ve RSAN");
	SendClientMessage(playerid, white, "O tai phong nghi cua HQ, len giuong go /rest de ngu mot giac va nhan duoc full mau giap");
    SendClientMessage(playerid, white, "O tai phong khach, den nut fire go /sos de kich hoat he thong bao chay");
    SendClientMessage(playerid, white, "Tai cua an ninh Film Studio, den gan bang dieu khien, nhan nut O va nhap pass de mo cua");
    SendClientMessage(playerid, white, "O tai bang thong tin, de xem va them ghi chu, go /note");
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(ShowNote[playerid] == 1) // can't close note with ESC
        {
        	SendClientMessage(playerid, white, "Please close your note first!");
            TextDrawSetSelectable(note1, true);
            SelectTextDraw(playerid, -1);

        }
        if (BoardOpen[playerid] == 1 && ShowNote[playerid] == 0) // close board ESC key
        {
            BoardOpen[playerid] = 0;
            DestroyAllTextDraw(playerid);
        } 
    }
    if(clickedid == Textdraw10 && ShowNote[playerid] == 0) // close board
    {  
    DestroyAllTextDraw(playerid);
    }
    if((clickedid == Textdraw3 || clickedid == Textdraw4 || clickedid == Textdraw5|| clickedid == Textdraw7|| clickedid == Textdraw8|| clickedid == Textdraw9) && ShowNote[playerid] == 0) //|| clickedid == Textdraw4 || clickedid == Textdraw5|| clickedid == Textdraw7|| clickedid == Textdraw8|| clickedid == Textdraw9 && ShowNote[playerid] == 0)
    {
    ShowNoteTextDraw(playerid);
    }
    if(clickedid == note1) // close note
    {
    DestroyNoteTextDraw(playerid);
    ShowNote[playerid] = 0;
    }
    return 1;
}
CMD:note(playerid, params[])
{
if (IsPlayerInRangeOfPoint(playerid, 3, bulletinpos)) 
{  
ApplyAnimation(playerid, "POLICE", "COPTRAF_STOP", 4, 0, 0, 0, 0, 0, 0);
ShowAllTextDraw(playerid);
}
else if (BoardOpen[playerid] == 1 || ShowNote[playerid] == 1)
{
	SendClientMessage(playerid, white, "Ban dang xem tin roi!");
}
else SendClientMessage(playerid, white, "Ban khong o gan bang thong tin");
} 



public OnPlayerConnect(playerid)
{

SendClientMessage(playerid, white, "RSAN STUDIOLD SYSTEM: ON");
SendClientMessage(playerid, white, "To all members: Thank you for being a part of my life!");    SendClientMessage(playerid, white, "Type /rsan to teleport to HQ");
SendClientMessage(playerid, white, "To know about this system, type /rsanhelp");
ShowNote[playerid] = 0;
BoardOpen[playerid] = 0;
return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    DestroyAllTextDraw(playerid);
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
CMD:test(playerid, params[]) // just testing
{
new string[128];
format(string,sizeof(string),"Note written by %s",GetPlayerNameEx(playerid));
ShowNoteTextDraw(playerid);
TextDrawSetString(note2, string);
}
public OnPlayerText(playerid, text[])
{
new string[256];
format(string, sizeof(string), "%s", text);
new textdrawString[256];
splitLine(string, textdrawString);
ShowNoteTextDraw(playerid);
TextDrawSetString(note2, textdrawString);
return 1;
}
splitLine(text[], dst[])
{
    #define MAX_LINES   6
    #define MaxLineLength 24
    
    new len = strlen(text);
    new newLen = len + 3*MAX_LINES + 1;
    
    if(len <= MaxLineLength)
        return format(dst, MaxLineLength+1, "%s", text);

    new lines[MAX_LINES][MaxLineLength + 3];
    new lineIdx = 0;
    new lineNum = floatround(float(len)/MaxLineLength, floatround_ceil);

    new idx = 0;
    
    if(lineNum > MAX_LINES)
        return 0;

    format(dst, MaxLineLength +1, "");
    
    for(new i = 0; i < lineNum; i++) {
        strmid(lines[lineIdx], text, idx, idx+MaxLineLength);
        idx+=MaxLineLength;
        lineIdx++;
    }
    
    for(new i = 0; i < lineNum ; i++) {
        while(lines[i][strlen(lines[i])] == ' ')
            lines[i][strlen(lines[i])] = 0;
        while(lines[i][0] == ' ') {
            for(new j = 0; j < strlen(lines[i]); j++) {
                lines[i][j] = lines[i][j+1];
            }
        }
        strcat(dst, lines[i], newLen);
        if(i != lineNum-1)
            strcat(dst, "~n~", newLen);
    }
    
    return 1;
}
 
// stock
stock GetPlayerNameEx(playerid)
{
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	return playerName;
}
stock DestroyAllTextDraw(playerid)
{/*
	     CancelSelectTextDraw(playerid);
         TextDrawHideForPlayer(playerid, Textdraw0);
         TextDrawHideForPlayer(playerid, Textdraw1);
         TextDrawHideForPlayer(playerid, Textdraw2);
         TextDrawHideForPlayer(playerid, Textdraw3);
         TextDrawHideForPlayer(playerid, Textdraw4);
         TextDrawHideForPlayer(playerid, Textdraw5);
         TextDrawHideForPlayer(playerid, Textdraw6);
         TextDrawHideForPlayer(playerid, Textdraw7);
         TextDrawHideForPlayer(playerid, Textdraw8);
         TextDrawHideForPlayer(playerid, Textdraw9);
         TextDrawHideForPlayer(playerid, Textdraw10);
         TextDrawHideForPlayer(playerid, Textdraw11);
         TextDrawHideForPlayer(playerid, Textdraw12);
         TextDrawHideForPlayer(playerid, Textdraw13);
         TextDrawHideForPlayer(playerid, Textdraw14);
         TextDrawHideForPlayer(playerid, Textdraw15);
         TextDrawHideForPlayer(playerid, Textdraw16);
         TextDrawHideForPlayer(playerid, Textdraw17);
         TextDrawHideForPlayer(playerid, Textdraw18);
         TextDrawHideForPlayer(playerid, Textdraw19);
         TextDrawHideForPlayer(playerid, Textdraw20);
         TextDrawHideForPlayer(playerid, Textdraw21);
         TextDrawHideForPlayer(playerid, Textdraw22);
         TextDrawHideForPlayer(playerid, Textdraw23);
         TextDrawHideForPlayer(playerid, Textdraw24);
         TextDrawHideForPlayer(playerid, Textdraw25);
         TextDrawHideForPlayer(playerid, Textdraw26);
         TextDrawHideForPlayer(playerid, Textdraw27);
         TextDrawHideForPlayer(playerid, Textdraw28);*/
         TextDrawDestroy(Textdraw0);
         CancelSelectTextDraw(playerid);
         TextDrawDestroy(Textdraw0);
         TextDrawDestroy(Textdraw1);
         TextDrawDestroy(Textdraw2);
         TextDrawDestroy(Textdraw3);
         TextDrawDestroy(Textdraw4);
         TextDrawDestroy(Textdraw5);
         TextDrawDestroy(Textdraw6);
         TextDrawDestroy(Textdraw7);
         TextDrawDestroy(Textdraw8);
         TextDrawDestroy(Textdraw9);
         TextDrawDestroy(Textdraw10);
         TextDrawDestroy(Textdraw11);
         TextDrawDestroy(Textdraw12);
         TextDrawDestroy(Textdraw13);
         TextDrawDestroy(Textdraw14);
         TextDrawDestroy(Textdraw15);
         TextDrawDestroy(Textdraw16);
         TextDrawDestroy(Textdraw17);
         TextDrawDestroy(Textdraw18);
         TextDrawDestroy(Textdraw19);
         TextDrawDestroy(Textdraw20);
         TextDrawDestroy(Textdraw21);
         TextDrawDestroy(Textdraw22);
         TextDrawDestroy(Textdraw23);
         TextDrawDestroy(Textdraw24);
         TextDrawDestroy(Textdraw25);
         TextDrawDestroy(Textdraw26);
         TextDrawDestroy(Textdraw27);
         TextDrawDestroy(Textdraw28);
}
stock DestroyNoteTextDraw(playerid) // destroy thi phai create lai, hide thi bug
{
	TextDrawDestroy(note0);
    TextDrawDestroy(note1);
    TextDrawDestroy(note2); 
    /*TextDrawHideForPlayer(playerid, note0);
    TextDrawHideForPlayer(playerid, note1);
    TextDrawHideForPlayer(playerid, note2);*/

}
stock ShowNoteTextDraw(playerid)
{
	// Note textdraws
note0 = TextDrawCreate(186.399963, 78.399993, "LD_SPAC:white");
TextDrawLetterSize(note0, 0.000000, 0.000000);
TextDrawTextSize(note0, 269.600006, 289.706665);
TextDrawAlignment(note0, 2);
TextDrawColor(note0, -1061109505);
TextDrawSetShadow(note0, 0);
TextDrawSetOutline(note0, 0);
TextDrawFont(note0, 4);

note1 = TextDrawCreate(436.800018, 83.626678, "X");
TextDrawLetterSize(note1, 0.449999, 1.600000);
TextDrawAlignment(note1, 1);
TextDrawColor(note1, 255);
TextDrawSetShadow(note1, 0);
TextDrawSetOutline(note1, 1);
TextDrawBackgroundColor(note1, 51);
TextDrawFont(note1, 1);
TextDrawSetProportional(note1, 1);
 
note2 = TextDrawCreate(213.599929, 108.266654, "we knew there are 24 chars");
TextDrawLetterSize(note2, 0.449999, 1.600000);
TextDrawAlignment(note2, 1);
TextDrawColor(note2, 255);
TextDrawSetShadow(note2, 0);
TextDrawSetOutline(note2, 1);
TextDrawBackgroundColor(note2, 51);
TextDrawFont(note2, 1);
TextDrawSetProportional(note2, 1);
TextDrawSetSelectable(note1, true);
TextDrawShowForPlayer(playerid, note0);
TextDrawShowForPlayer(playerid, note1);
TextDrawShowForPlayer(playerid, note2);
ShowNote[playerid] = 1;
}
stock ShowAllTextDraw(playerid)
{
BoardOpen[playerid] = 1;
    // Bulletin board textdraws
Textdraw0 = TextDrawCreate(92.799995, 35.093292, "LD_SPAC:white");
TextDrawLetterSize(Textdraw0, 0.000000, 0.000000);
TextDrawTextSize(Textdraw0, 466.400207, 322.559967);
TextDrawAlignment(Textdraw0, 2);
TextDrawColor(Textdraw0, -1061109505);
TextDrawSetShadow(Textdraw0, 0);
TextDrawSetOutline(Textdraw0, 0);
TextDrawBackgroundColor(Textdraw0, -1061109505);
TextDrawFont(Textdraw0, 4);

Textdraw1 = TextDrawCreate(229.599990, 53.013362, "BANG THONG TIN");
TextDrawLetterSize(Textdraw1, 0.665200, 2.831997);
TextDrawAlignment(Textdraw1, 1);
TextDrawColor(Textdraw1, -1);
TextDrawSetShadow(Textdraw1, 2);
TextDrawSetOutline(Textdraw1, 0);
TextDrawBackgroundColor(Textdraw1, 51);
TextDrawFont(Textdraw1, 1);
TextDrawSetProportional(Textdraw1, 1);

Textdraw2 = TextDrawCreate(562.000061, 106.033325, "usebox");
TextDrawLetterSize(Textdraw2, 0.000000, -0.233703);
TextDrawTextSize(Textdraw2, 89.999992, 0.000000);
TextDrawAlignment(Textdraw2, 1);
TextDrawColor(Textdraw2, 255);
TextDrawUseBox(Textdraw2, true);
TextDrawBoxColor(Textdraw2, -2139062017);
TextDrawSetShadow(Textdraw2, 0);
TextDrawSetOutline(Textdraw2, 0);
TextDrawFont(Textdraw2, 0);

Textdraw3 = TextDrawCreate(113.600028, 117.973289, "LD_SPAC:white");
TextDrawLetterSize(Textdraw3, 0.000000, 0.000000);
TextDrawTextSize(Textdraw3, 115.199989, 142.613327);
TextDrawAlignment(Textdraw3, 1);
TextDrawColor(Textdraw3, -1);
TextDrawSetShadow(Textdraw3, -649);
TextDrawSetOutline(Textdraw3, 0);
TextDrawFont(Textdraw3, 4);
  
Textdraw4 = TextDrawCreate(271.200134, 118.719993, "LD_SPAC:white");
TextDrawLetterSize(Textdraw4, 0.000000, 0.000000);
TextDrawTextSize(Textdraw4, 114.400001, 141.866668);
TextDrawAlignment(Textdraw4, 1);
TextDrawColor(Textdraw4, -1);
TextDrawSetShadow(Textdraw4, 0);
TextDrawSetOutline(Textdraw4, 0);
TextDrawFont(Textdraw4, 4);
  
Textdraw5 = TextDrawCreate(424.799865, 120.213317, "LD_SPAC:white");
TextDrawLetterSize(Textdraw5, 0.000000, 0.000000);
TextDrawTextSize(Textdraw5, 113.599998, 140.373352);
TextDrawAlignment(Textdraw5, 1);
TextDrawColor(Textdraw5, -1);
TextDrawSetShadow(Textdraw5, 0);
TextDrawSetOutline(Textdraw5, 0);
TextDrawFont(Textdraw5, 4);
  
Textdraw6 = TextDrawCreate(92.799995, 239.679946, "LD_SPAC:white");
TextDrawLetterSize(Textdraw6, 0.000000, 0.000000);
TextDrawTextSize(Textdraw6, 465.600036, 168.746673);
TextDrawAlignment(Textdraw6, 1);
TextDrawColor(Textdraw6, -1061109505);
TextDrawSetShadow(Textdraw6, 0);
TextDrawSetOutline(Textdraw6, 0);
TextDrawFont(Textdraw6, 4);

Textdraw7 = TextDrawCreate(113.599998, 259.839996, "LD_SPAC:white");
TextDrawLetterSize(Textdraw7, 0.000000, 0.000000);
TextDrawTextSize(Textdraw7, 113.599998, 120.213356);
TextDrawAlignment(Textdraw7, 1);
TextDrawColor(Textdraw7, -1);
TextDrawSetShadow(Textdraw7, 0);
TextDrawSetOutline(Textdraw7, 0);
TextDrawFont(Textdraw7, 4);
  
Textdraw8 = TextDrawCreate(271.999969, 259.839874, "LD_SPAC:white");
TextDrawLetterSize(Textdraw8, 0.000000, 0.000000);
TextDrawTextSize(Textdraw8, 113.599998, 121.706687);
TextDrawAlignment(Textdraw8, 1);
TextDrawColor(Textdraw8, -1);
TextDrawSetShadow(Textdraw8, 0);
TextDrawSetOutline(Textdraw8, 0);
TextDrawFont(Textdraw8, 4);
  
Textdraw9 = TextDrawCreate(424.799896, 261.333221, "LD_SPAC:white");
TextDrawLetterSize(Textdraw9, 0.000000, 0.000000);
TextDrawTextSize(Textdraw9, 113.600006, 120.960014);
TextDrawAlignment(Textdraw9, 1);
TextDrawColor(Textdraw9, -1);
TextDrawSetShadow(Textdraw9, 0);
TextDrawSetOutline(Textdraw9, 0);
TextDrawFont(Textdraw9, 4);
  
Textdraw10 = TextDrawCreate(548.799865, 38.079998, "X");
TextDrawLetterSize(Textdraw10, 0.449999, 1.600000);
TextDrawTextSize(Textdraw10, 556.000061, 11.946665);
TextDrawAlignment(Textdraw10, 2);
TextDrawColor(Textdraw10, -1);
TextDrawUseBox(Textdraw10, true);
TextDrawBoxColor(Textdraw10, -16776961);
TextDrawSetShadow(Textdraw10, 0);
TextDrawSetOutline(Textdraw10, 1);
TextDrawBackgroundColor(Textdraw10, 51);
TextDrawFont(Textdraw10, 1);
TextDrawSetProportional(Textdraw10, 1);
  
Textdraw11 = TextDrawCreate(235.600006, 120.966659, "usebox");
TextDrawLetterSize(Textdraw11, 0.000000, 12.874444);
TextDrawTextSize(Textdraw11, 226.000000, 0.000000);
TextDrawAlignment(Textdraw11, 1);
TextDrawColor(Textdraw11, 0);
TextDrawUseBox(Textdraw11, true);
TextDrawBoxColor(Textdraw11, 102);
TextDrawSetShadow(Textdraw11, 0);
TextDrawSetOutline(Textdraw11, 0);
TextDrawFont(Textdraw11, 0);

Textdraw12 = TextDrawCreate(233.200012, 241.180007, "usebox");
TextDrawLetterSize(Textdraw12, 0.000000, -0.316666);
TextDrawTextSize(Textdraw12, 110.799995, 0.000000);
TextDrawAlignment(Textdraw12, 1);
TextDrawColor(Textdraw12, 0);
TextDrawUseBox(Textdraw12, true);
TextDrawBoxColor(Textdraw12, 102);
TextDrawSetShadow(Textdraw12, 0);
TextDrawSetOutline(Textdraw12, 0);
TextDrawFont(Textdraw12, 0);

Textdraw13 = TextDrawCreate(391.599975, 120.219993, "usebox");
TextDrawLetterSize(Textdraw13, 0.000000, 12.957409);
TextDrawTextSize(Textdraw13, 382.000000, 0.000000);
TextDrawAlignment(Textdraw13, 1);
TextDrawColor(Textdraw13, 0);
TextDrawUseBox(Textdraw13, true);
TextDrawBoxColor(Textdraw13, 102);
TextDrawSetShadow(Textdraw13, 0);
TextDrawSetOutline(Textdraw13, 0);
TextDrawFont(Textdraw13, 0);

Textdraw14 = TextDrawCreate(389.200012, 240.433349, "usebox");
TextDrawLetterSize(Textdraw14, 0.000000, -0.233704);
TextDrawTextSize(Textdraw14, 268.400024, 0.000000);
TextDrawAlignment(Textdraw14, 1);
TextDrawColor(Textdraw14, 0);
TextDrawUseBox(Textdraw14, true);
TextDrawBoxColor(Textdraw14, 102);
TextDrawSetShadow(Textdraw14, 0);
TextDrawSetOutline(Textdraw14, 0);
TextDrawFont(Textdraw14, 0);

Textdraw15 = TextDrawCreate(545.200012, 121.713340, "usebox");
TextDrawLetterSize(Textdraw15, 0.000000, 12.708517);
TextDrawTextSize(Textdraw15, 535.599975, 0.000000);
TextDrawAlignment(Textdraw15, 1);
TextDrawColor(Textdraw15, 0);
TextDrawUseBox(Textdraw15, true);
TextDrawBoxColor(Textdraw15, 102);
TextDrawSetShadow(Textdraw15, 0);
TextDrawSetOutline(Textdraw15, 0);
TextDrawFont(Textdraw15, 0);

Textdraw16 = TextDrawCreate(542.800048, 240.433349, "usebox");
TextDrawLetterSize(Textdraw16, 0.000000, -0.316666);
TextDrawTextSize(Textdraw16, 422.000000, 0.000000);
TextDrawAlignment(Textdraw16, 1);
TextDrawColor(Textdraw16, 0);
TextDrawUseBox(Textdraw16, true);
TextDrawBoxColor(Textdraw16, 102);
TextDrawSetShadow(Textdraw16, 0);
TextDrawSetOutline(Textdraw16, 0);
TextDrawFont(Textdraw16, 0);

Textdraw17 = TextDrawCreate(232.400009, 261.339996, "usebox");
TextDrawLetterSize(Textdraw17, 0.000000, 12.874444);
TextDrawTextSize(Textdraw17, 222.799987, 0.000000);
TextDrawAlignment(Textdraw17, 1);
TextDrawColor(Textdraw17, 0);
TextDrawUseBox(Textdraw17, true);
TextDrawBoxColor(Textdraw17, 102);
TextDrawSetShadow(Textdraw17, 0);
TextDrawSetOutline(Textdraw17, 0);
TextDrawFont(Textdraw17, 0);

Textdraw18 = TextDrawCreate(230.000000, 380.806671, "usebox");
TextDrawLetterSize(Textdraw18, 0.000000, -0.316666);
TextDrawTextSize(Textdraw18, 110.799995, 0.000000);
TextDrawAlignment(Textdraw18, 1);
TextDrawColor(Textdraw18, 0);
TextDrawUseBox(Textdraw18, true);
TextDrawBoxColor(Textdraw18, 102);
TextDrawSetShadow(Textdraw18, 0);
TextDrawSetOutline(Textdraw18, 0);
TextDrawFont(Textdraw18, 0);

Textdraw19 = TextDrawCreate(392.400024, 261.339996, "usebox");
TextDrawLetterSize(Textdraw19, 0.000000, 13.040372);
TextDrawTextSize(Textdraw19, 382.799987, 0.000000);
TextDrawAlignment(Textdraw19, 1);
TextDrawColor(Textdraw19, 0);
TextDrawUseBox(Textdraw19, true);
TextDrawBoxColor(Textdraw19, 102);
TextDrawSetShadow(Textdraw19, 0);
TextDrawSetOutline(Textdraw19, 0);
TextDrawFont(Textdraw19, 0);

Textdraw20 = TextDrawCreate(390.000000, 381.553344, "usebox");
TextDrawLetterSize(Textdraw20, 0.000000, -0.316666);
TextDrawTextSize(Textdraw20, 269.200012, 0.000000);
TextDrawAlignment(Textdraw20, 1);
TextDrawColor(Textdraw20, 0);
TextDrawUseBox(Textdraw20, true);
TextDrawBoxColor(Textdraw20, 102);
TextDrawSetShadow(Textdraw20, 0);
TextDrawSetOutline(Textdraw20, 0);
TextDrawFont(Textdraw20, 0);

Textdraw21 = TextDrawCreate(545.200012, 263.579986, "usebox");
TextDrawLetterSize(Textdraw21, 0.000000, 12.791484);
TextDrawTextSize(Textdraw21, 535.599975, 0.000000);
TextDrawAlignment(Textdraw21, 1);
TextDrawColor(Textdraw21, 0);
TextDrawUseBox(Textdraw21, true);
TextDrawBoxColor(Textdraw21, 102);
TextDrawSetShadow(Textdraw21, 0);
TextDrawSetOutline(Textdraw21, 0);
TextDrawFont(Textdraw21, 0);

Textdraw22 = TextDrawCreate(542.800048, 383.046691, "usebox");
TextDrawLetterSize(Textdraw22, 0.000000, -0.316666);
TextDrawTextSize(Textdraw22, 422.000000, 0.000000);
TextDrawAlignment(Textdraw22, 1);
TextDrawColor(Textdraw22, 0);
TextDrawUseBox(Textdraw22, true);
TextDrawBoxColor(Textdraw22, 102);
TextDrawSetShadow(Textdraw22, 0);
TextDrawSetOutline(Textdraw22, 0);
TextDrawFont(Textdraw22, 0);

Textdraw23 = TextDrawCreate(161.600021, 105.279998, ".");
TextDrawLetterSize(Textdraw23, 0.902800, 3.085865);
TextDrawAlignment(Textdraw23, 1);
TextDrawColor(Textdraw23, -2139094785);
TextDrawSetShadow(Textdraw23, 0);
TextDrawSetOutline(Textdraw23, 1);
TextDrawBackgroundColor(Textdraw23, 51);
TextDrawFont(Textdraw23, 1);
TextDrawSetProportional(Textdraw23, 1);

Textdraw24 = TextDrawCreate(321.600036, 101.546684, ".");
TextDrawLetterSize(Textdraw24, 0.985200, 3.832530);
TextDrawAlignment(Textdraw24, 1);
TextDrawColor(Textdraw24, -2139094785);
TextDrawSetShadow(Textdraw24, 0);
TextDrawSetOutline(Textdraw24, 1);
TextDrawBackgroundColor(Textdraw24, 51);
TextDrawFont(Textdraw24, 1);
TextDrawSetProportional(Textdraw24, 1);

Textdraw25 = TextDrawCreate(476.000000, 103.040000, ".");
TextDrawLetterSize(Textdraw25, 0.971600, 3.727998);
TextDrawAlignment(Textdraw25, 1);
TextDrawColor(Textdraw25, -2139094785);
TextDrawSetShadow(Textdraw25, 0);
TextDrawSetOutline(Textdraw25, 1);
TextDrawBackgroundColor(Textdraw25, 51);
TextDrawFont(Textdraw25, 1);
TextDrawSetProportional(Textdraw25, 1);

Textdraw26 = TextDrawCreate(163.199935, 247.146545, ".");
TextDrawLetterSize(Textdraw26, 0.833999, 3.212799);
TextDrawAlignment(Textdraw26, 1);
TextDrawColor(Textdraw26, -2139094785);
TextDrawSetShadow(Textdraw26, 0);
TextDrawSetOutline(Textdraw26, 1);
TextDrawBackgroundColor(Textdraw26, 51);
TextDrawFont(Textdraw26, 1);
TextDrawSetProportional(Textdraw26, 1);

Textdraw27 = TextDrawCreate(323.199890, 246.400009, ".");
TextDrawLetterSize(Textdraw27, 0.904400, 3.429333);
TextDrawAlignment(Textdraw27, 1);
TextDrawColor(Textdraw27, -2139094785);
TextDrawSetShadow(Textdraw27, 0);
TextDrawSetOutline(Textdraw27, 1);
TextDrawBackgroundColor(Textdraw27, 51);
TextDrawFont(Textdraw27, 1);
TextDrawSetProportional(Textdraw27, 1);

Textdraw28 = TextDrawCreate(477.599884, 246.399978, ".");
TextDrawLetterSize(Textdraw28, 0.901199, 3.466666);
TextDrawAlignment(Textdraw28, 1);
TextDrawColor(Textdraw28, -2139094785);
TextDrawSetShadow(Textdraw28, 0);
TextDrawSetOutline(Textdraw28, 1);
TextDrawBackgroundColor(Textdraw28, 51);
TextDrawFont(Textdraw28, 1);
TextDrawSetProportional(Textdraw28, 1); 

SelectTextDraw(playerid, -1);
TextDrawSetSelectable(Textdraw3, true);
TextDrawSetSelectable(Textdraw4, true);
TextDrawSetSelectable(Textdraw5, true);
TextDrawSetSelectable(Textdraw7, true);
TextDrawSetSelectable(Textdraw8, true);
TextDrawSetSelectable(Textdraw9, true);
TextDrawSetSelectable(Textdraw10, true);
TextDrawShowForPlayer(playerid, Textdraw0);
TextDrawShowForPlayer(playerid, Textdraw1);
TextDrawShowForPlayer(playerid, Textdraw2);
TextDrawShowForPlayer(playerid, Textdraw3);
TextDrawShowForPlayer(playerid, Textdraw4);
TextDrawShowForPlayer(playerid, Textdraw5);
TextDrawShowForPlayer(playerid, Textdraw6);
TextDrawShowForPlayer(playerid, Textdraw7);
TextDrawShowForPlayer(playerid, Textdraw8);
TextDrawShowForPlayer(playerid, Textdraw9);
TextDrawShowForPlayer(playerid, Textdraw10);
TextDrawShowForPlayer(playerid, Textdraw11);
TextDrawShowForPlayer(playerid, Textdraw12);
TextDrawShowForPlayer(playerid, Textdraw13);
TextDrawShowForPlayer(playerid, Textdraw14);
TextDrawShowForPlayer(playerid, Textdraw15);
TextDrawShowForPlayer(playerid, Textdraw16);
TextDrawShowForPlayer(playerid, Textdraw17);
TextDrawShowForPlayer(playerid, Textdraw18);
TextDrawShowForPlayer(playerid, Textdraw19);
TextDrawShowForPlayer(playerid, Textdraw20);
TextDrawShowForPlayer(playerid, Textdraw21);
TextDrawShowForPlayer(playerid, Textdraw23);
TextDrawShowForPlayer(playerid, Textdraw24);
TextDrawShowForPlayer(playerid, Textdraw25);
TextDrawShowForPlayer(playerid, Textdraw26);
TextDrawShowForPlayer(playerid, Textdraw27);
TextDrawShowForPlayer(playerid, Textdraw28);
}
