local t = Def.ActorFrame{

LoadActor("PaneRadar")..{
	InitCommand=cmd(x,SCREEN_RIGHT-175-120;y,SCREEN_CENTER_Y-118+12;player,PLAYER_1;zoom,0.9);
	OffCommand=cmd(linear,0.25;addx,500);
};
StandardDecorationFromFileOptional( "GrooveRadarAP1_Pane", "GrooveRadarAP1_Pane" );
StandardDecorationFromFileOptional("PaneDisplayTextAP1","PaneDisplayTextAP1");
};
return t;
