local t = Def.ActorFrame{
	OnCommand=function(self)
    if not FILEMAN:DoesFileExist("Save/ThemePrefs.ini") then
      Trace("ThemePrefs doesn't exist; creating file")
      ThemePrefs.ForceSave()
    end
    if SN3Debug then
      SCREENMAN:SystemMessage("Saving ThemePrefs.")
    end
    ThemePrefs.Save()
  end;
};

--Logo
t[#t+1] = Def.ActorFrame {
	LoadActor( "ScreenLogo decorations/ddra" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-2;y,SCREEN_CENTER_Y-63;zoom,1.5);
	};
	LoadActor( "ScreenLogo decorations/copy" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X-5;y,SCREEN_CENTER_Y+75;zoom,1.5);
	};
	LoadActor(THEME:GetPathB("","_Arcade Decorations/bg"))..{
		InitCommand=cmd(xy,SCREEN_CENTER_X,SCREEN_CENTER_Y+160;zoom,1.5);
	};
};

return t
