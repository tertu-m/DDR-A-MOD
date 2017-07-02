local t = Def.ActorFrame {};

t[#t+1] = LoadActor("bar") .. {
	InitCommand=cmd();
	OnCommand=cmd(zoomx,1.2;linear,0.2;zoomy,1.2;y,2);
	OffCommand=cmd(linear,0.2;zoomy,0);
};

return t