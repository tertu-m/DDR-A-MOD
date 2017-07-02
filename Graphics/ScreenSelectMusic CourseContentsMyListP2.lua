local transform = function(self,offsetFromCenter,itemIndex,numitems)
	self:y( offsetFromCenter * 44 );
end
return Def.CourseContentsList {
	MaxSongs = 10;
    NumItemsToDraw = 6;
	ShowCommand=cmd(bouncebegin,0.3;zoomy,1);
	HideCommand=cmd(linear,0.3;zoomy,0);
	SetCommand=function(self)
		self:SetFromGameState();
		self:SetCurrentAndDestinationItem(3);
		self:SetPauseCountdownSeconds(1);
		self:SetSecondsPauseBetweenItems( 0.00 );
--		self:SetTransformFromFunction(transform);
		--
		self:SetDestinationItem(100);
		self:SetLoop(true);
		self:SetMask(480,54);
	end;
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");

	Display = Def.ActorFrame { 
		InitCommand=cmd(setsize,350,54);

		--LoadActor(THEME:GetPathG("CourseEntryMyDisplay","bar")) .. {
		Def.Quad { 
			SetSongCommand=function(self, params)
				--self:diffuseleftedge( CustomDifficultyToLightColor(params.Difficulty) );
				self:setsize(300,40);
				self:zoomx(1);
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;linear,0.05;glow,color("1,1,1,0.5");decelerate,0.1;glow,color("1,1,1,0")))(self);
			end;
		};


		LoadFont("Common","Normal") .. {
			Text="0";
			InitCommand=cmd(x,-70;y,-10;maxwidth,210;horizalign,left;zoom,0.85;shadowlength,0);
			SetSongCommand=function(self, params)
			self:diffuse( color("0,0,0,1") );
			
				if params.Secret ==true then
					self:settext("??????");
				else
					if params.Song then
						self:settext(params.Song:GetDisplayFullTitle());
					end;
				end;
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;))(self);
			end;
		}; 
		
		LoadFont("Common","Normal") .. {
			Text="0";
			InitCommand=cmd(x,-70;y,10;maxwidth,200;horizalign,left;zoom,0.65;shadowlength,0);
			SetSongCommand=function(self, params)
			self:diffuse( color("0,0,0,1") );
				if params.Secret ==true then
					self:settext("??????");
				else
					if params.Song then
						self:settext(params.Song:GetDisplayArtist());
					end;
				end;
				(cmd(finishtweening;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;))(self);
			end;
		}; 
 
		
		Def.Sprite {
			Name="SongBanner";
			SetSongCommand=function(self, params)
				if params.Song then
					self:Load(GetSongGPath(params.Song));
				else
					self:load("UnknownBanner.png");
				end
				self:scaletoclipped( 40,40 );
				self:x(-95);
				(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.1;linear,0.05;zoomx,1.1;decelerate,0.1;zoom,1))(self);
			end;
		};
		
		LoadFont("CourseEntryDisplay","number") .. {
			InitCommand=cmd(x,-133;y,0;shadowlength,0;diffuse,color( "0,0,0,1" );strokecolor,color("#999999"));
			SetSongCommand=function(self, params) 
				self:settext(string.format("%i", params.Number)); 

				(cmd(finishtweening;zoom,1;diffusealpha,0;sleep,0.125*params.Number;linear,0.125;diffusealpha,1;linear,0.05;zoomy,1*1;zoomx,1*1.1;glow,color("1,1,1,0.5");decelerate,0.1;zoom,1;glow,color("1,1,1,0")))(self);
			end;
		};
		Def.Quad {
			InitCommand=cmd(x,130;y,0;setsize,32,32);
			SetSongCommand=function(self, params)
				self:diffuse( CustomDifficultyToColor(params.Difficulty) );
				(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.1;linear,0.05;zoomx,1.1;decelerate,0.1;zoom,1))(self);
			end;
		};
 		LoadFont("_itc machine std 20px") .. {
			Text="0";
			InitCommand=cmd(x,130;y,-10;zoom,1.3;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
			SetSongCommand=function(self, params)
				if params.PlayerNumber ~= GAMESTATE:GetMasterPlayerNumber() then return end
				self:settext( params.Meter );
				
				(cmd(finishtweening;zoomy,0;sleep,0.125*params.Number;linear,0.125;zoomy,1.1;linear,0.05;zoomx,1.1;decelerate,0.1;zoom,1.3))(self);
			end;
		}; 
	};
};