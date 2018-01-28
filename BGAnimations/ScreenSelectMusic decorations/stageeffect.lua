local t = Def.ActorFrame {};

--Stage BG
t[#t+1] = Def.ActorFrame {
	LoadActor( "stageeffect01" )..{
		InitCommand=cmd(x,SCREEN_LEFT+123;y,SCREEN_TOP+80;;zoom,14;);
		OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1.5;customtexturerect,0,0,20,1;texcoordvelocity,5,0);
		OffCommand=cmd(linear,0.1;zoomy,0);
		
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "stageeffect02" )..{
		InitCommand=cmd(x,SCREEN_LEFT+113;y,SCREEN_TOP+82;;zoom,14;);
		OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1.5;customtexturerect,0,0,10,1;texcoordvelocity,-1,0;playcommand,"Animate");
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;zoomy,0);
		AnimateCommand=cmd(linear,0.3;addx,20;linear,1.5;addx,-20;linear,0.6;addx,5;linear,1.3;addx,-5;linear,0.6;addx,15;linear,0.5;addx,-15;queuecommand,"Animate");
	}
};

return t;