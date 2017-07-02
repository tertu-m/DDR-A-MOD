local song = GAMESTATE:GetCurrentSong();
local t = Def.ActorFrame{};
local dt = 1.235;
--nt = 3.604 --fct = 4.872

if not GAMESTATE:IsDemonstration() then



	t[#t+1] = Def.ActorFrame {


--Sound
LoadActor("../_failed") .. {
	OnCommand=cmd(sleep,dt;queuecommand,"Play");
	PlayCommand=cmd(play);
};

	-- Cleared song --
    LoadActor("../ClearedSwoosh") .. {
		StartTransitioningCommand=cmd(play);
	};

--Sound
LoadActor("../__swooshDDRA") .. {
	OnCommand=cmd(sleep,dt;queuecommand,"Play");
	PlayCommand=cmd(play);
};

		--Black BG
		Def.Quad{
			OnCommand=cmd(Center;FullScreen;diffusecolor,Color.Black;diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;);
		};
		Def.Quad{
			OnCommand=cmd(Center;FullScreen;diffusecolor,color("#00f6ff");diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;linear,0.5;diffusealpha,0.1);
		};
		Def.Quad{
			OnCommand=cmd(blend,Blend.Add;Center;FullScreen;diffusecolor,Color.Blue;diffusealpha,0;sleep,dt;sleep,0.434;linear,0.033;diffusealpha,1;linear,0.3;diffusealpha,0);
		};
		
		--Animated grid
		LoadActor("hextile2")..{
			InitCommand=cmd(FullScreen);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w,h);
				self:texcoordvelocity(2.5,0);
				self:cropright(.5);
				self:diffusealpha(0);
				self:sleep(dt);
				self:sleep(0.701);
				self:linear(0.2);
				self:diffusealpha(1);
				self:sleep(0.734);
				self:linear(0.099);
				self:diffusealpha(0);
			end;
		};

		LoadActor("hextile2")..{
			InitCommand=cmd(FullScreen);
			OnCommand=function(self)
				local w = DISPLAY:GetDisplayWidth() / self:GetWidth();
				local h = DISPLAY:GetDisplayHeight() / self:GetHeight();
				self:customtexturerect(0,0,w,h);
				self:texcoordvelocity(-2.5,0);
				self:cropleft(.5);
				self:diffusealpha(0);
				self:sleep(dt);
				self:sleep(0.701);
				self:linear(0.2);
				self:diffusealpha(1);
				self:sleep(0.734);
				self:linear(0.099);
				self:diffusealpha(0);
			end;
		};

		--White flash
		LoadActor( "../_door/whiteflash" )..{
			OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoomx,0;sleep,dt;sleep,0.3;linear,0.134;zoomx,1;linear,0.099;zoom,3);
		};

		--Up side
		--BG
		LoadActor( "../_door/bluebg" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		};
		LoadActor( "../_door/bluetopper" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		};
		LoadActor( "../_door/lines" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_TOP-99;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_TOP+99;);
		};

		--Down Side
		--BG
		LoadActor( "../_door/bluebg" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
		};
		LoadActor( "../_door/bluetopper" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
		};
		LoadActor( "../_door/lines" )..{
			OnCommand=cmd(zoom,1.5;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM+99;zoomy,-1.5;sleep,dt;linear,0.283;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-99;);
		};

	}
	
t[#t+1] =	LoadActor( "Stage Cleared BG" )..{
	InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;zoom,1.5);
	OnCommand=function(self)
		self:diffusealpha(0):zoom(3):sleep(dt):linear(0.264):diffusealpha(1):zoom(1.5);
	end;
	};
	
	t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(CenterX;diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,2.5);
	--AnimateCommand=cmd(diffuseshift;effectcolor1,1,1,1,0;effectcolor2,1,1,1,0.9;effectperiod,0.5);
	LoadActor(THEME:GetPathB("","_door/glow"))..{
		InitCommand=cmd(y,SCREEN_TOP+172;zoom,1.5);
		OnCommand=cmd(addy,-232;sleep,dt;linear,0.283;addy,232;diffusealpha,1;);
	};
	LoadActor(THEME:GetPathB("","_door/glow"))..{
		InitCommand=cmd(y,SCREEN_BOTTOM-172;zoomy,-1;diffusealpha,0;zoom,-1.5);
		OnCommand=cmd(addy,232;sleep,dt;linear,0.283;addy,-232;diffusealpha,1;);
	};
};

	if not GAMESTATE:IsCourseMode() and song:GetDisplayFullTitle() == "Tohoku EVOLVED" then
		-- t[#t+1] = Def.ActorFrame {
			
			-- LoadActor( "tohoku" )..{--Left
				-- OnCommand=cmd(zoom,1.5;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			-- };
			
			-- LoadActor( "tohoku" )..{--Right
				-- OnCommand=cmd(zoom,1.5;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			-- };
			
			-- LoadActor( "tohoku" )..{--Glow
				-- OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,1.7;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			-- };
		-- }
		t[#t+1] = Def.ActorFrame {
			--Left
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.5;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Right
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.5;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Glow
			LoadActor( "cleared" )..{
				OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,1.7;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			};
			LoadActor( "glow_cleared" )..{
				OnCommand=cmd(zoom,1.5;diffusealpha,0;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");
				diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,2.283;linear,0.217;diffusealpha,1;);
			};
		}
	else
		t[#t+1] = Def.ActorFrame {
			--Left
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.5;x,SCREEN_LEFT-556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Right
			LoadActor( "cleared" )..{
				OnCommand=cmd(zoom,1.5;x,SCREEN_RIGHT+556;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.116;linear,0.217;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;);
			};
			--Glow
			LoadActor( "cleared" )..{
				OnCommand=cmd(diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;sleep,0.283;diffusealpha,0.5;zoom,1.7;linear,0.017;diffusealpha,1;linear,0.133;diffusealpha,0;zoom,2.25);
			};
			LoadActor( "glow_cleared" )..{
				OnCommand=cmd(zoom,1.5;diffusealpha,0;blend,Blend.Add;diffuseshift;effectperiod,0.55;effectcolor1,color("1,1,1,1");effectcolor2,color("0.5,0.5,0.5,1");
				diffusealpha,0;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;sleep,dt;linear,0.217;diffusealpha,1;);
			};
		}
	end

end

return t;