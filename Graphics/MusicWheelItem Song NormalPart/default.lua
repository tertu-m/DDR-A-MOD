local sBannerPath = THEME:GetPathG("Common", "fallback jacket");
local sJacketPath = THEME:GetPathG("Common", "fallback jacket");
local bAllowJackets = true
local song;
local group;

--arrange song position devide by 3
function arrangeXPosition(myself, index)
	if index%3==0 then
		myself:x(-300);
	elseif index%3==1 then
		myself:x(0);
	else
		myself:x(300);
	end;
end

function arrangeXPosition2(myself, index, offset)
	if index%3==0 then
		myself:x(-300+offset);
	elseif index%3==1 then
		myself:x(0+offset);
	else
		myself:x(300+offset);
	end;
end

function arrangeAllClearMarkOnWheel(self,params,pn)
			local song = params.Song;
			local AllCleared = true;
			local WrostClearedRank = 7;
			local st=GAMESTATE:GetCurrentStyle():GetStyleType();
			
			if st == "StyleType_TwoPlayersTwoSides" then
				if pn == PLAYER_1 then
					self:cropright(0.5);
				else
					self:cropleft(0.5);
				end
			
			end;
			
			if song then
				local steps = SongUtil.GetPlayableSteps( song );
				
				arrangeXPosition(self,params.Index,0);

				if PROFILEMAN:IsPersistentProfile(pn) then 
					profile = PROFILEMAN:GetProfile(pn); --player profile
				else 
					profile = PROFILEMAN:GetMachineProfile(); --machine profile
				end;

				for i,step in ipairs(steps) do
					scorelist = profile:GetHighScoreList( song, step);
					
					local scores = scorelist:GetHighScores();
					local temp=#scores;
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					local topgrade;
					
					if scores[1] then   -- 7=Failed  6=D  5=C  4=B  3=A  2=AA  1=AAA
						for i=1,temp do 
							topgrade = scores[1]:GetGrade();
							curgrade = scores[i]:GetGrade();
							if scores[1]:GetScore()>1  then
								if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then --AutoPlayHack
									AllCleared = AllCleared and false;
									WrostClearedRank = 7;
									break;
								else --Normal
									if ToEnumShortString(curgrade) ~= "Failed"  then --not failed
										AllCleared = AllCleared and true;
										WrostClearedRank = 7;
										break;
									else --failed
										if i == temp then
											AllCleared = AllCleared and false;
											WrostClearedRank = 7;
											break;
										
										end;
									end;
								end;
							else
								AllCleared = AllCleared and false;
							end;
						end;
					else
						AllCleared = AllCleared and false;
					end
				end;
				
				if AllCleared == true then 
					self:diffusealpha(1);
					(cmd(diffuseshift;effectcolor1,1,1,1,0.65;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
					-- if WrostClearedRank == 7 then
					-- (cmd(diffuseshift;effectcolor1,1,0,0,0.65;effectcolor2,1,0,0,0.8;effectperiod,0.1))(self);
					-- end
				else
					self:diffusealpha(0);
				end
				
				if params.HasFocus then
					self:zoom(2.0);
				else
					self:zoom(1.8);
				end
			end
end

function arrangeAllClearMarkOnWheelSong(self,params,pn)
			local song = params.Song;
			local AllCleared = true;
			local WrostClearedRank = 1;
			local st=GAMESTATE:GetCurrentStyle():GetStyleType();
			
			if st == "StyleType_TwoPlayersTwoSides" then
				if pn == PLAYER_1 then
					self:cropright(0.5);
				else
					self:cropleft(0.5);
				end
			
			end;
			
			if song then
				local steps = SongUtil.GetPlayableSteps( song );
				
				arrangeXPosition(self,params.Index,0);

				if PROFILEMAN:IsPersistentProfile(pn) then 
					profile = PROFILEMAN:GetProfile(pn); --player profile
				else 
					profile = PROFILEMAN:GetMachineProfile(); --machine profile
				end;

				for i,step in ipairs(steps) do
					scorelist = profile:GetHighScoreList( song, step);
					
					local scores = scorelist:GetHighScores();
					local temp=#scores;
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					local topgrade;
					
					if scores[1] then   -- 7=Failed  6=D  5=C  4=B  3=A  2=AA  1=AAA
						for i=1,temp do 
							topgrade = scores[1]:GetGrade();
							curgrade = scores[i]:GetGrade();
							if scores[1]:GetScore()>1  then
								if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then --AutoPlayHack
									AllCleared = AllCleared and false;
									WrostClearedRank = 7;
									break;
								else --Normal
									if ToEnumShortString(curgrade) ~= "Failed"  then --not failed
										AllCleared = AllCleared and true;
										local gradenum = tonumber(string.sub(curgrade,-2,-1));
										if WrostClearedRank <  gradenum then
											WrostClearedRank = gradenum;
										end
										break;
									else --failed
										if i == temp then
											AllCleared = AllCleared and true;
											WrostClearedRank = 7;
											break;
										
										end;
									end;
								end;
							else
								AllCleared = AllCleared and false;
							end;
						end;
					else
						AllCleared = AllCleared and false;
					end
				end;
				
				if AllCleared == true then 
					self:diffusealpha(1);
					---(cmd(diffuseshift;effectcolor1,1,1,1,0.65;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
					if WrostClearedRank == 7 then --E
						(cmd(diffuseshift;effectcolor1,0,0,0,0.65;effectcolor2,0,0,0,1;effectperiod,1.1))(self);
					elseif WrostClearedRank == 6 then --D
						(cmd(diffuseshift;effectcolor1,0.6,0,0,0.65;effectcolor2,0.8,0,0,1;effectperiod,0.5))(self);
					elseif WrostClearedRank == 5 then --C
						(cmd(diffuseshift;effectcolor1,1,0,1,0.65;effectcolor2,1,0,1,0.35;effectperiod,0.5))(self);
					elseif WrostClearedRank == 4 then --B
						(cmd(diffuseshift;effectcolor1,0,0.3,1,0.65;effectcolor2,0,0.5,1,0.9;effectperiod,0.1))(self);
					elseif WrostClearedRank == 3 then --A
						(cmd(diffuseshift;effectcolor1,1,1,0.2,0.65;effectcolor2,1,1,0.2,0.35;effectperiod,0.1))(self);
					elseif WrostClearedRank == 2 then --AA
						(cmd(diffuseshift;effectcolor1,1,1,0.6,0.65;effectcolor2,1,1,0.7,1;effectperiod,0.1))(self);
					elseif WrostClearedRank == 1 then --AAA
						(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.8;effectperiod,0.1))(self);
					end
				else
					self:diffusealpha(0);
				end
				
				if params.HasFocus then
					self:zoom(2.0);
				else
					self:zoom(1.8);
				end
			end
end

--main backing
local t = Def.ActorFrame {

--border default
LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01.png"))..{
		InitCommand=cmd(zoom,1.8);
		SetMessageCommand=function(self,params)
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:zoom(2.0);
			else
				self:zoom(1.8);
			end
		end;
		};
		LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01.png"))..{
		InitCommand=cmd(zoom,1.8;diffusecolor,Color("Yellow");blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.35;);
		SetMessageCommand=function(self,params)
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:zoom(2.0);
			else
				self:zoom(0);
			end
		end;
		};	


--border bright
LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bright.png"))..{
		InitCommand=cmd(zoom,0);
		SetMessageCommand=function(self,params)
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:zoom(2.0);
				(cmd(diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.5;effectclock,'beatnooffset'))(self);
				--(cmd(thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.20;))(self);
			else
				self:zoom(0);
			end
		end;
		};

--border default
LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01.png"))..{
		InitCommand=cmd(zoom,1.8);
		SetMessageCommand=function(self,params)
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:zoom(2.0);
			else
				self:zoom(1.8);
			end
		end;
		};
		LoadActor(THEME:GetPathG("MusicWheelItem Song","NormalPart/bg01.png"))..{
		InitCommand=cmd(zoom,1.8;diffusecolor,Color("Yellow");blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1.0,1.05,1.0;effectoffset,0.35;);
		SetMessageCommand=function(self,params)
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:zoom(2.0);
			else
				self:zoom(0);
			end
		end;
		};	



Def.Quad {
	InitCommand=cmd(setsize,224,224;y,-5;diffuse,color("#000000"));
	SetMessageCommand=function(self,params)
		arrangeXPosition(self,params.Index,0);
		if params.HasFocus then
				self:zoom(0.9);
			else
				self:zoom(0.7);
			end
	end;
	};
--banner
	Def.Sprite {
		Name="Banner";
		InitCommand=cmd(scaletoclipped,220,220;y,-5);
		BannerCommand=cmd(scaletoclipped,220,220);
		JacketCommand=cmd(scaletoclipped,220,220);
		SetMessageCommand=function(self,params)
			local Song = params.Song;
			local Course = params.Course;
			if Song then
				if ( Song:GetJacketPath() ~=  nil ) and ( bAllowJackets ) then
					self:Load( Song:GetJacketPath() );
					self:playcommand("Jacket");
				elseif ( Song:GetBannerPath() ~= nil ) then
					self:Load( Song:GetBannerPath() );
					self:playcommand("Banner");
				elseif ( Song:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Song:GetBackgroundPath() );
					self:playcommand("Jacket");
				else
				  self:Load( bAllowJackets and sBannerPath or sJacketPath );
				  self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end;
			elseif Course then
				if ( Course:GetBackgroundPath() ~= nil ) and ( bAllowJackets ) then
					self:Load( Course:GetBackgroundPath() );
					self:playcommand("Jacket");
				elseif ( Course:GetBannerPath() ~= nil ) then
					self:Load( Course:GetBannerPath() );
					self:playcommand("Banner");
				else
					self:Load( sJacketPath );
					self:playcommand( bAllowJackets and "Jacket" or "Banner" );
				end
			else
				self:Load( bAllowJackets and sJacketPath or sBannerPath );
				self:playcommand( bAllowJackets and "Jacket" or "Banner" );
			end;
			if params.HasFocus then
				self:zoom(0.9);
			else
				self:zoom(0.7);
			end
			arrangeXPosition(self,params.Index,0);
		end;
	};

	LoadFont("Common Normal")..{
		InitCommand=cmd(y,110;zoomx,1;maxwidth,235;diffuse,Color("White");strokecolor,color("0.15,0.15,0.0,0.9"));
		SetCommand=function(self,params)
			local song = params.Song;
			local index= params.Index;
			local numItems = params.Items;
			local course = params.Course;
			local tit="";
			if song and not course then
				tit=song:GetDisplayFullTitle();
			elseif course and not song then
				tit=course:GetDisplayFullTitle();
			end;
			-- if string.len(tit)>20 then
				-- tit = string.sub(tit, 1, 21).."...";
			-- end;
			self:stoptweening();
			self:settextf("%s",tit);
			--self:settextf("%d",index);
			arrangeXPosition(self,params.Index,0);
			if params.HasFocus then
				self:y(117);
				self:zoom(1.2);
			else
				self:y(110);
				self:zoom(1);
			end
		end;
		
	};

	-- P1 All Clear Mark
	LoadActor("AllCleared_All")..{
		InitCommand=cmd(zoom,0;player,PLAYER_1);
		SetMessageCommand=function(self,params)
			arrangeAllClearMarkOnWheelSong(self,params,PLAYER_1)
		end;
	};
	-- P2 All Clear Mark
	LoadActor("AllCleared_All")..{
		InitCommand=cmd(zoom,0;player,PLAYER_2);
		SetMessageCommand=function(self,params)
			arrangeAllClearMarkOnWheelSong(self,params,PLAYER_2)
		end;
	};
-- Meter
	LoadFont("Common Normal")..{
		InitCommand=cmd(player,PLAYER_1;x,0;zoom,0.1;y,-95;draworder,2;diffuse,color("#000000");strokecolor,color("Outline"));
		OnCommand=cmd(zoom,1);
		SetMessageCommand=function(self,params)
		local song = params.Song
		local sum =0;
		local ii=0;
		local meters="";
		if song then
			local steps = SongUtil.GetPlayableSteps( song )
			for i,step in ipairs(steps) do
				local child = ( step:GetDifficulty() )
				--if child==GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty() then
					self:settext( step:GetMeter() )
					if meters~="" then
						meters=meters.." / "..step:GetMeter();
					else
						meters = step:GetMeter()
					end;
				--end;
				sum = sum +step:GetMeter();
				ii=ii+1;
			end;
			self:settext( meters );
			self:settext( "" );
			arrangeXPosition(self,params.Index,0);
		end;
	end;

	};	


	--Selection cursor
	Def.ActorFrame {
		LoadActor( "cursor" )..{
			InitCommand=cmd();
			SetCommand=function(self,params)
				
				(cmd(bounce;effectmagnitude,12,0,0;effectclock,'beatnooffset'))(self);
				if params.HasFocus then
					self:zoom(2.0);
				else
					self:zoom(0);
				end
				arrangeXPosition2(self,params.Index,-220);
			end;
			
			OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
		}
	};

	Def.ActorFrame {
		LoadActor( "cursor" )..{
			InitCommand=cmd(zoomx,-1);
			SetCommand=function(self,params)
				
				(cmd(bounce;effectmagnitude,-12,0,0;effectclock,'beatnooffset'))(self);
				if params.HasFocus then
					self:zoomy(2.0);
					self:zoomx(-2.0);
				else
					self:zoom(0);
				end
				arrangeXPosition2(self,params.Index,220);
			end;
			OffCommand=cmd(sleep,0.2;linear,0;diffusealpha,0);
		}
	};

	LoadActor("bgNew") .. {
		InitCommand=cmd(finishtweening;draworder,1;zoom,2);
		SetCommand=function(self,param)
			if param.Song then
				if PROFILEMAN:IsSongNew(param.Song) then
					self:visible(true);
				else
					self:visible(false);
				end
			else
				self:visible(false);
			end
			if param.HasFocus then
				self:zoom(2.0);
			else
				self:zoom(1.8);
			end
			arrangeXPosition(self,param.Index,0);
		end;
	};
};
return t;