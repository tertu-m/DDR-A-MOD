local t = Def.ActorFrame {};

t[#t+1] = LoadActor("PaneRadar")..{
	InitCommand=cmd(x,SCREEN_LEFT+175;y,SCREEN_CENTER_Y-118+12;player,PLAYER_2;zoom,0.9);
	OffCommand=cmd(linear,0.25;addx,-500);
};
t[#t+1] = StandardDecorationFromFileOptional( "GrooveRadarAP2_Pane", "GrooveRadarAP2_Pane" );
t[#t+1] = StandardDecorationFromFileOptional("PaneDisplayTextAP2","PaneDisplayTextAP2");
return t;
