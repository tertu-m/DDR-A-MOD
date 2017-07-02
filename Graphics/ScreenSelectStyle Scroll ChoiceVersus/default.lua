local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
  GainFocusCommand=cmd(stoptweening;smooth,0.3;y,0;zoom,1);
  LoseFocusCommand=cmd(stoptweening;smooth,0.3;y,70;zoom,1);
  Def.ActorFrame{
    InitCommand=cmd(x,-4;y,96);
    OnCommand=cmd(zoom,0;sleep,0.5;linear,0.1;diffusealpha,1.0;zoom,1;smooth,0.1;zoom,0.9;smooth,0.1;zoom,1);
    LoadActor("offPad.png")..{
      OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
    };
    LoadActor("Pad.png")..{
      OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
      GainFocusCommand=cmd(smooth,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0");effectperiod,2);
      LoseFocusCommand=cmd(diffusealpha,0;stopeffect);
    };
  };
  LoadActor("Character") .. {
    InitCommand=cmd(diffusealpha,0;zoomx,1;x,-66;y,-8);
    OffCommand=cmd(sleep,0.3;linear,0.1;zoom,0;diffusealpha,0;);
    OnCommand=cmd(sleep,0.6;linear,0.1;diffusealpha,1;zoomy,0.8;linear,0.1;zoomy,1;zoomx,1.2;linear,0.1;zoomx,1);
  };
};

return t;
