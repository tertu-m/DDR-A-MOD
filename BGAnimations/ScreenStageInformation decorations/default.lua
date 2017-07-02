local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame{}
local song = GAMESTATE:GetCurrentSong();


function isExtraSavior(STitle)
	if STitle == "宇宙(ソラ)への片道切符" or STitle == "Electric Dance System Music" or STitle == "TECH-NOID" or STitle == "Sora e no katamichi kippu" or STitle == "Cytokinesis" or STitle == "S!ck" or STitle == "Illegal Function Call" or STitle == "STERLING SILVER" or STitle == "STERLING SILVER (U1 overground mix)" or STitle == "Far east nightbird" or STitle == "Far east nightbird kors k Remix -DDR edit ver-" or STitle == "Angelic Jelly" or STitle == "Grand Chariot" or STitle == "Sephirot" or STitle == "StrayedCatz" or STitle == "ZEPHYRANTHES" or STitle == "Triple Counter" then
		return true;
	else
		return false;
	end
end;

function isExtraExclusive(STitle)
	if STitle == "New Century" or STitle == "RISING FIRE HAWK" or STitle == "Astrogazer" or STitle == "Come to Life" or STitle == "Emera" or STitle == "Start a New Day" then
		return true;
	else
		return false;
	end
end;

--Sound
t[#t+1] = Def.ActorFrame {
	LoadActor("../__swooshDDRA") .. {
		OnCommand=cmd(queuecommand,"Play");
		PlayCommand=cmd(play);
	};
	LoadActor("SoundStage") .. {};
};

t[#t+1] = Def.ActorFrame {
--Scanlines
	LoadActor("scanlines")..{
		InitCommand=cmd(Center;diffusealpha,0.5);
		OnCommand=cmd(zoom,1.8;sleep,0.033;linear,0.083;zoom,1.0);
	};
--BlackBg
	LoadActor("topbg") .. {
		OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-2;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+84;);
	};
	LoadActor("glowtop") .. {
		OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP-2;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+84;);
	};
	LoadActor("bottombg") .. {
		OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+7;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-76;);
	};
	LoadActor("topbar") .. {
		OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_TOP+9;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_TOP+58;);
	};
	LoadActor("bottombar") .. {
		OnCommand=cmd(zoom,1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-59;);
	};
	LoadActor("glowtop") .. {
		OnCommand=cmd(zoom,-1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,-1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-59;);
	};
	LoadActor("bottombar") .. {
		OnCommand=cmd(zoom,-1.125;diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-4;sleep,0.034;diffusealpha,1;sleep,0.033;linear,0.083;zoom,1.125;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
	};
	LoadActor("lightsUpper") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,1.034;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.9");effectperiod,0.02);
	};
	LoadActor("lightsLower") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,0.834;linear,0.3;diffusealpha,1;diffuseshift;effectcolor1,color("1,1,1,1");effectcolor2,color("1,1,1,0.7");effectperiod,0.03);
	};
	LoadActor("lightsUpper") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,1.034;linear,0.3;diffusealpha,0.3);
	};
	LoadActor("lightsLower") .. {
		OnCommand=cmd(diffusealpha,0;blend,Blend.Add;FullScreen;Center;sleep,0.834;linear,0.3;diffusealpha,0.3);
	};
};

t[#t+1] = Def.ActorFrame {
	LoadActor("sidebar") .. {
		OnCommand=cmd(diffusealpha,0;x,SCREEN_RIGHT+59;y,SCREEN_CENTER_Y-12;sleep,0.034;diffusealpha,1;sleep,0.833;linear,0.083;zoom,1;x,SCREEN_RIGHT-78;y,SCREEN_CENTER_Y-18;);
	};
	LoadActor("sidebar") .. {
		OnCommand=cmd(diffusealpha,0;x,SCREEN_LEFT-59;y,SCREEN_CENTER_Y-12;zoomx,-1;sleep,0.034;diffusealpha,1;sleep,0.833;linear,0.083;zoom,1;x,SCREEN_LEFT+78;y,SCREEN_CENTER_Y-18;zoomx,-1;);
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+166;zoom,1.7);
	LoadActor("jacket-bg")..{
		InitCommand=cmd(zoomy,0.0129;zoomx,1.3;diffusealpha,0;sleep,1.267;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.0645;addy,-8;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.1741;addy,-17;sleep,0.033;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.2806;addy,-17;zoomx,1.265;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.407;zoomx,1.245;addy,-17;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.527;addy,-18;zoomx,1.201;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.7;zoomx,1.126;addy,-25;sleep,0.034;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.790;zoomx,1.116;addy,-18;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;zoomy,0.952;zoomx,1.066;addy,-25;sleep,0.017;diffusealpha,1;sleep,0.017;diffusealpha,0;);
	};
	
};
t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y+19;zoom,1.7);
	LoadActor("jacket-bg")..{
		InitCommand=cmd(diffusealpha,0;sleep,1.617;zoomy,1.033;zoomx,1.033;addy,-3;sleep,0.034;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.016;diffusealpha,1;sleep,0.018;diffusealpha,0;sleep,0.017;diffusealpha,1;sleep,0.016;diffusealpha,0;sleep,0.018;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.016;diffusealpha,1;sleep,0.018;diffusealpha,0;sleep,0.150;zoomx,1.72;zoomy,0.335;addy,98;diffusealpha,1;sleep,0.017;diffusealpha,0;sleep,0.017;);
	};	
};

--stage word
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
	local STitle = song:GetDisplayFullTitle();
	--Extra Savior
		if isExtraSavior(STitle) then
			t[#t+1] = Def.ActorFrame {
				LoadActor("Savior")..{};
			};
		else
			--Extra Exclusive
			if isExtraExclusive(STitle) then
				t[#t+1] = Def.ActorFrame {
					LoadActor("Exclusive")..{};
				};
			else
				--Normal stage indicator
				t[#t+1] = Def.ActorFrame {
					LoadActor("StageDisplay")..{};
				};
			end
		end
else

	--Normal stage indicator
	t[#t+1] = Def.ActorFrame {
		LoadActor("StageDisplay")..{};
	};


end


t[#t+1] = Def.Quad{
	OnCommand=cmd(diffuse,color("#000000");Center;setsize,486,486;diffusealpha,0;zoom,1;sleep,1.9;linear,0.2;diffusealpha,1;zoom,1);
	};
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';Center;diffusealpha,0;zoom,1;sleep,1.9;linear,0.2;diffusealpha,1;zoom,1;sleep,3;diffusealpha,1);
	Def.Sprite {
		SetCommand=function(self)
			local song = GAMESTATE:GetCurrentSong();
			local course = GAMESTATE:GetCurrentCourse();
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
			elseif course then
				
					self:LoadBackground(course:GetBannerPath());
					self:setsize(480,480);
			else
					self:Load(THEME:GetPathG("","Common fallback jacket"));
					self:setsize(480,480);
			end;
		end;
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y);
	LoadActor("jacket-wbg")..{
		InitCommand=cmd(diffusealpha,0;zoom,1.55;sleep,1.6;linear,0.01;diffusealpha,1;zoom,1.55;sleep,0.1;diffusealpha,1;zoom,1.85;sleep,0.1;linear,0.11;diffusealpha,0;zoom,5.55;);
	};	
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "con_label" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-96;sleep,1.25;linear,0.401;zoom,0.8;addy,4;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "prog_bg" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-74;sleep,1.25;linear,0.401;zoom,0.8;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "progbar" )..{
		InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-74;cropright,1;sleep,1.25;linear,0.401;zoom,0.8;cropright,0;sleep,0.216;linear,0.033;zoomx,3;zoomy,0);
	}
};

--stage word
if GAMESTATE:IsExtraStage() or GAMESTATE:IsExtraStage2() then
	local STitle = song:GetDisplayFullTitle();
	--Extra Savior
		if isExtraSavior(STitle) then
			t[#t+1] = Def.ActorFrame {
				LoadActor("Savior")..{};
			};
		elseif isExtraExclusive(STitle) then
				t[#t+1] = Def.ActorFrame {
					LoadActor("Exclusive")..{};
				};
		end
end


--White Flare
t[#t+1] = Def.ActorFrame {
	Def.Quad{
		OnCommand=cmd(Center;FullScreen;diffusecolor,Color.White;draworder,1;diffusealpha,0.8;linear,0.7;diffusealpha,0;);
	};
};





return t
