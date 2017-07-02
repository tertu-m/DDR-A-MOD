local t = Def.ActorFrame {};

--Info
--[[t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(x,244;y,-134;);
  LoadActor(THEME:GetPathG("","_sharedX3/SelectStyle/infomiddle"))..{
    OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.5;smooth,0.2;zoomy,1;diffusealpha,0.5);
    OffCommand=cmd(smooth,0.2;zoomy,0;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0;zoomy,0;smooth,0.2;zoomy,1;diffusealpha,0.5);
    LoseFocusCommand=cmd(queuecommand,"Off");
  };
  LoadActor(THEME:GetPathG("","_sharedX3/SelectStyle/infotop"))..{
    InitCommand=cmd(y,-94);
    OnCommand=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,-94;diffusealpha,1);
  };
  LoadActor(THEME:GetPathG("","_sharedX3/SelectStyle/infobottom"))..{
    InitCommand=cmd(y,72);
    OnCommand=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,72;diffusealpha,1);
  };
};]]--

t[#t+1] = Def.ActorFrame {
  GainFocusCommand=cmd(stoptweening;smooth,0.3;y,0;zoom,1);
  LoseFocusCommand=cmd(stoptweening;smooth,0.3;y,100;zoom,1);
  Def.ActorFrame{
    OnCommand=cmd(zoom,0;sleep,0.5;linear,0.1;diffusealpha,1.0;zoom,1;smooth,0.1;zoom,0.9;smooth,0.1;zoom,1);
    LoadActor("offPad.png")..{
      InitCommand=cmd(x,18;y,90);
      OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
    };
    LoadActor("Pad.png")..{
      InitCommand=cmd(x,18;y,90);
      OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
      GainFocusCommand=cmd(smooth,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0");effectperiod,2);
      LoseFocusCommand=cmd(diffusealpha,0;stopeffect);
    };
  };
  LoadActor("Character") .. {
    InitCommand=cmd(diffusealpha,0;zoomx,1;x,-8);
    OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
    OnCommand=cmd(sleep,0.6;linear,0.1;diffusealpha,1;zoomy,0.8;linear,0.1;zoomy,1;zoomx,1.2;linear,0.1;zoomx,1);
  };
};
return t;
