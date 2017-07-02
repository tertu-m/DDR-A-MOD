local t = Def.ActorFrame {};

t[#t+1] = LoadActor(THEME:GetPathB("","_door/backdrop"))..{
	InitCommand=cmd(FullScreen;Center);
};

--Those Weird Curved Things
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/bluebg (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/bluebg (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
}
--More Of THose Weird Curved Things
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/bluetopper (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/bluetopper (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
}

--Lines
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	LoadActor(THEME:GetPathB("","_door/lines (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+99;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_door/lines (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-99;zoomy,-1;zoom,-1.5);
	};
};
--Glow
t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX);
	OnCommand=cmd(queuecommand,"Animate");
	AnimateCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,2.5);
	LoadActor(THEME:GetPathB("","_door/glow (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_TOP+172;zoom,1.5;diffusealpha,0;linear,2.5;diffusealpha,1;);
	};
	LoadActor(THEME:GetPathB("","_door/glow (doubleres).png"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-172;zoomy,-1;zoom,-1.5;diffusealpha,0;linear,2.5;diffusealpha,1;);
	};
};

return t;
