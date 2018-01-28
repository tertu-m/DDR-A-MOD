local lang = "us";
local t = Def.ActorFrame {};

if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

local path = THEME:GetAbsolutePath("Graphics/ScreenSelectStyle Icon/versus/");

t[#t+1] = Def.ActorFrame{
  InitCommand=cmd(xy,SCREEN_CENTER_X+360,SCREEN_CENTER_Y-8);
  Def.ActorFrame{
    LoadActor(THEME:GetPathG("","_shared/SelectStyle/infomiddle"))..{
      OnCommand=function(self)
        if GAMESTATE:GetNumPlayersEnabled() == 2 then
          self:queuecommand("On2");
        else
          self:diffusealpha(0);
        end;
      end;
      On2Command=cmd(diffusealpha,0;zoomy,0;sleep,0.5;smooth,0.2;zoomy,1;diffusealpha,1);
      OffCommand=cmd(smooth,0.2;zoomy,0;diffusealpha,0);
      GainFocusCommand=cmd(finishtweening;diffusealpha,0;zoomy,0;smooth,0.2;zoomy,1;diffusealpha,1);
      LoseFocusCommand=cmd(finishtweening;queuecommand,"Off");
    };
    Def.Sprite{
      InitCommand=cmd(y,-24;playcommand,"Set");
      OnCommand=function(self)
        if GAMESTATE:GetNumPlayersEnabled() == 2 then
          self:queuecommand("On2");
        else
          self:diffusealpha(0);
        end;
      end;
			SetCommand=function(self)
				if lang == "us" then
					self:Load(path.."e_text.png");
				else
					self:Load(path.."j_text.png")
				end;
			end;
      On2Command=cmd(diffusealpha,0;sleep,0.55;smooth,0.2;diffusealpha,1);
      OffCommand=cmd(smooth,0.1;diffusealpha,0);
      GainFocusCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1);
      LoseFocusCommand=cmd(queuecommand,"Off");
    };
    LoadActor("infopad")..{
      InitCommand=cmd(xy,160,34);
      OnCommand=function(self)
        if GAMESTATE:GetNumPlayersEnabled() == 2 then
          self:queuecommand("On2");
        else
          self:diffusealpha(0);
        end;
      end;
      On2Command=cmd(diffusealpha,0;sleep,0.55;smooth,0.2;diffusealpha,1);
      OffCommand=cmd(smooth,0.1;diffusealpha,0);
      GainFocusCommand=cmd(diffusealpha,0;sleep,0.1;smooth,0.2;diffusealpha,1);
      LoseFocusCommand=cmd(queuecommand,"Off");
    };
  };
  Def.ActorFrame{
    InitCommand=cmd(y,-94);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:queuecommand("On2");
      else
        self:diffusealpha(0);
      end;
    end;
    On2Command=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,-94;diffusealpha,1);
    OffCommand=cmd(smooth,0.1;y,0;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0;y,0;smooth,0.2;y,-94;diffusealpha,1);
    LoseFocusCommand=cmd(queuecommand,"Off");
    LoadActor(THEME:GetPathG("","_shared/SelectStyle/infotop"));
    Def.Sprite{
      InitCommand=cmd(x,-50;playcommand,"Set");
      SetCommand=function(self)
        if lang == "us" then
          self:Load(path.."e_title.png");
        else
          self:Load(path.."j_title.png")
        end;
      end;
    }
  };
  LoadActor(THEME:GetPathG("","_shared/SelectStyle/infobottom"))..{
    InitCommand=cmd(y,72);
    OnCommand=function(self)
      if GAMESTATE:GetNumPlayersEnabled() == 2 then
        self:queuecommand("On2");
      else
        self:diffusealpha(0);
      end;
    end;
    On2Command=cmd(diffusealpha,0;y,0;sleep,0.5;smooth,0.2;y,72;diffusealpha,1);
    OffCommand=cmd(smooth,0.1;y,0;diffusealpha,0);
    GainFocusCommand=cmd(diffusealpha,0;y,0;smooth,0.2;y,72;diffusealpha,1);
    LoseFocusCommand=cmd(queuecommand,"Off");
  };
};

return t;
