local t = Def.ActorFrame {};


t[#t+1] = Def.ActorFrame {
	LoadActor( "sidefly" )..{
		InitCommand=cmd(x,SCREEN_LEFT+312;y,SCREEN_BOTTOM-281;zoomx,-2.54;zoomy,1.2;blend,Blend.Add;rotationz,-50;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,0.1,1;texcoordvelocity,0.5,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sidefly" )..{
		InitCommand=cmd(x,SCREEN_RIGHT-312;y,SCREEN_BOTTOM-281;zoomx,-2.54;zoomy,1.2;blend,Blend.Add;rotationz,230;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,0.1,1;texcoordvelocity,0.5,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sidefly" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-378;zoomx,-4.94;zoomy,1.2;blend,Blend.Add;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,0.95,1;texcoordvelocity,0.5,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "sidefly" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-378;zoomx,-4.94;zoomy,1.2;blend,Blend.Add;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,-0.95,1;texcoordvelocity,0.5,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};



t[#t+1] = Def.ActorFrame {
	LoadActor( "sideline" )..{
		InitCommand=cmd(x,SCREEN_LEFT+335;y,SCREEN_BOTTOM-283;zoomx,-2.0;zoomy,1;blend,Blend.Add;rotationz,-50;diffusealpha,0.2;cropright,0.37);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.005,0,0.1,1;texcoordvelocity,1,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sideline" )..{
		InitCommand=cmd(x,SCREEN_RIGHT-335;y,SCREEN_BOTTOM-283;zoomx,-2.0;zoomy,1;blend,Blend.Add;rotationz,230;diffusealpha,0.2;cropright,0.37);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,0.1,1;texcoordvelocity,1,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sideline" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-359;zoomx,-4.82;zoomy,1;blend,Blend.Add;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,0.95,1;texcoordvelocity,1,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "sideline" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-359;zoomx,-4.82;zoomy,1;blend,Blend.Add;diffusealpha,0.2);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;customtexturerect,-0.05,0,-0.95,1;texcoordvelocity,1,0);
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
	}
};






t[#t+1] = Def.ActorFrame {
	LoadActor( "sideblink" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-410;y,SCREEN_BOTTOM-185;zoom,0.25;blend,Blend.Add);
		OnCommand=cmd(addx,-500;decelerate,0.05;addx,500;playcommand,"Animate");
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
		AnimateCommand=cmd(diffusealpha,0.5;decelerate,0.5;diffusealpha,0;sleep,1.55;queuecommand,"Animate");
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sideblink" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X+410;y,SCREEN_BOTTOM-185;zoom,0.25;blend,Blend.Add);
		OnCommand=cmd(addx,-500;decelerate,0.05;addx,500;playcommand,"Animate");
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
		AnimateCommand=cmd(diffusealpha,0.5;decelerate,0.5;diffusealpha,0;sleep,1.55;queuecommand,"Animate");
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sideblink" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-240;y,SCREEN_BOTTOM-359;zoom,0.25;blend,Blend.Add);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;playcommand,"Animate");
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
		AnimateCommand=cmd(diffusealpha,0.5;decelerate,0.5;diffusealpha,0;sleep,1.35;queuecommand,"Animate");
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sideblink" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X+240;y,SCREEN_BOTTOM-359;zoom,0.25;blend,Blend.Add);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500;playcommand,"Animate");
		OffCommand=cmd(stopeffect;stoptweening;linear,0.1;diffusealpha,0);
		AnimateCommand=cmd(diffusealpha,0.5;decelerate,0.5;diffusealpha,0;sleep,1.35;queuecommand,"Animate");
	}
};



return t;