local t = Def.ActorFrame{}

if not GAMESTATE:IsDemonstration() then

--Sound
	t[#t+1] = Def.ActorFrame {
		LoadActor("../__swooshDDRA") .. {
			OnCommand=cmd(play);
		};
	};

--BGVideo
	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenWithMenuElements background")..{
			OnCommand=cmd(linear,0.083;diffusealpha,0);
		};
	};

--Scanlines
	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/scanlines")..{
			InitCommand=cmd(Center;diffusealpha,0.5);
			OnCommand=cmd(zoom,1.0;linear,0.5;diffusealpha,0);
		};
	};

	--BlackBg
	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/topbg") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+84;linear,0.483;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP-224);
		};
	};
	
		t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/glowtop") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+84;linear,0.483;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP-224);
		};
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/bottombg") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-71;linear,0.483;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+194);
		};
	};
	
	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/glowtop") .. {
			OnCommand=cmd(zoom,-1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-71;linear,0.483;zoom,-1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+194);
		};
	};

	--Bars
	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/topbar") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+58;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP-154);
		};
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/bottombar") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-59;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+156);
		};
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/sidebar") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_RIGHT-68;y,SCREEN_CENTER_Y-18;linear,0.083;zoom,1.125;x,SCREEN_RIGHT+92;y,SCREEN_CENTER_Y-12;);
		};
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor("../ScreenStageInformation decorations/sidebar") .. {
			OnCommand=cmd(zoom,1.125;x,SCREEN_LEFT+68;y,SCREEN_CENTER_Y-18;zoomx,-0.75;linear,0.083;zoom,1.125;x,SCREEN_LEFT-92;y,SCREEN_CENTER_Y-12;zoomx,-1);
		};
	};
	
	
	t[#t+1] = Def.Quad{
	OnCommand=cmd(diffuse,color("#000000");Center;setsize,486,486;diffusealpha,1;zoom,1;sleep,1.41;linear,0.06;zoom,1.5;diffusealpha,0);
	};

	--Jacket
	t[#t+1] = Def.ActorFrame {
 	InitCommand=cmd(CenterX;y,SCREEN_CENTER_Y;diffusealpha,1;zoom,1);
	OnCommand=cmd(sleep,1.41;linear,0.06;zoom,1.5;diffusealpha,0);
	Def.Sprite {
		OnCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse()
			local group = song:GetGroupName();
			if GAMESTATE:IsCourseMode() then
				if course then
					self:LoadBackground(course:GetBannerPath());
					self:setsize(480,480);
				else
					-- default to the Banner of the first song in the course
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:setsize(480,480);
				end
			else
				if song then
					if song:HasJacket() then
						self:LoadBackground(song:GetJacketPath());
						self:setsize(480,480);
					elseif song:HasBanner() then
						self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
						self:setsize(480,480);
					else
						self:Load(THEME:GetPathG("","Common fallback jacket"));
						self:setsize(480,480);
					end;
				else
					self:diffusealpha(0);	
				end;
			end
				
		end;
	};
};

end

return t