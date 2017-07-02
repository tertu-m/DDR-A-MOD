local t = Def.ActorFrame{
  GainFocusCommand=cmd(queuecommand,"Play");
  PlayCommand=function(self)
    SOUND:PlayAnnouncer( "ScreenSelectStyle comment Single" )
  end;
};

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(xy,SCREEN_CENTER_X+244,SCREEN_CENTER_Y-8;zoom,0.75);
  Def.ActorFrame{
    LoadActor(THEME:GetPathG("","_shared/SelectStyle/infomiddle"))..{
      OnCommand=cmd(diffusealpha,0;zoomy,0;sleep,0.5;smooth,0.2;zoomy,1;diffusealpha,1);
      OffCommand=cmd(smooth,0.2;zoomy,0;diffusealpha,0);
      GainFocusCommand=cmd(diffusealpha,0;zoomy,0;smooth,0.2;zoomy,1;diffusealpha,1);
      LoseFocusCommand=cmd(queuecommand,"Off");
    };
    LoadActor("text")..{
      InitCommand=cmd(y,-24);
      OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.2;diffusealpha,1);
      OffCommand=cmd(smooth,0.1;diffusealpha,0);
      GainFocusCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1);
      LoseFocusCommand=cmd(queuecommand,"Off");
    };
    LoadActor("pad")..{
      InitCommand=cmd(xy,189,34);
      OnCommand=cmd(diffusealpha,0;sleep,0.55;smooth,0.2;diffusealpha,1);
      OffCommand=cmd(smooth,0.1;diffusealpha,0);
      GainFocusCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1);
      LoseFocusCommand=cmd(queuecommand,"Off");
    };
  };
  Def.ActorFrame{
    InitCommand=cmd(y,-94);
    OnCommand=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,-94;diffusealpha,1);
    OffCommand=cmd(smooth,0.2;y,0;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0;y,0;smooth,0.2;y,-94;diffusealpha,1);
    LoseFocusCommand=cmd(queuecommand,"Off");
    LoadActor(THEME:GetPathG("","_shared/SelectStyle/infotop"));
    LoadActor("title")..{
      InitCommand=cmd(x,-7);
    };
  };
  LoadActor(THEME:GetPathG("","_shared/SelectStyle/infobottom"))..{
    InitCommand=cmd(y,72);
    OnCommand=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,72;diffusealpha,1);
    OffCommand=cmd(smooth,0.2;y,0;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0;y,0;smooth,0.2;y,72;diffusealpha,1);
    LoseFocusCommand=cmd(queuecommand,"Off");
  };
};

return t;
