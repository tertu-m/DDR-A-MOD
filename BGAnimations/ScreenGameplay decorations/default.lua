local t = LoadFallbackB()
t[#t+1] = StandardDecorationFromFileOptional("ScoreFrameP1","ScoreFrameP1");
t[#t+1] = StandardDecorationFromFileOptional("ScoreFrameP2","ScoreFrameP2");
t[#t+1] = StandardDecorationFromFileOptional("SongFrame","SongFrame");
t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
t[#t+1] = StandardDecorationFromFileOptional("StageFrame","StageFrame");
t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
t[#t+1] = StandardDecorationFromFileOptional("SongTitle","SongTitle");
local customscore=GetCustomScoreMode();
 local cscore="SuperNOVA2";
 if not GAMESTATE:IsCourseMode() then
 local stepcnt={0,0}
 t[#t+1] = Def.Actor{
     JudgmentMessageCommand = function(self, params)
         if params.TapNoteScore and
          params.TapNoteScore ~= 'TapNoteScore_AvoidMine' and
          params.TapNoteScore ~= 'TapNoteScore_HitMine' and
          params.TapNoteScore ~= 'TapNoteScore_CheckpointMiss' and
          params.TapNoteScore ~= 'TapNoteScore_CheckpointHit' and
          params.TapNoteScore ~= 'TapNoteScore_None'
         then
             if customscore=="old" then
                 Scoring[scoreType](params, 
                     STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player))
             elseif customscore=="5b2" then
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5b2(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             elseif customscore=="5b1" then
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5b1(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             else
                 local pn=((params.Player==PLAYER_1) and 1 or 2);
                 stepcnt[pn]=stepcnt[pn]+1;
                 CustomScore_SM5a2(params,cscore,GAMESTATE:GetCurrentSteps(params.Player),stepcnt[pn]);
             end;
         end
     end;
     InitCommand=function(self)
         if customscore=="non" then
             CustomScore_SM5a2_Init();
         end;
     end;
     OffCommand=function(self)
         if customscore=="non" then
             CustomScore_SM5a2_Out();
         end;
     end;
 };
 end;
 
  --Options Hack
 if not GAMESTATE:IsCourseMode() then
	local OptionsP1;
	local OptionsP2;
	OptionsP1 = GAMESTATE:GetPlayerState('PlayerNumber_P1'):GetPlayerOptionsString('ModsLevel_Preferred');
	OptionsP2 = GAMESTATE:GetPlayerState('PlayerNumber_P2'):GetPlayerOptionsString('ModsLevel_Preferred');
	if GAMESTATE:IsExtraStage() then
		GAMESTATE:GetPlayerState('PlayerNumber_P1'):SetPlayerOptions('ModsLevel_Preferred',OptionsP1..',failimmediate,battery,4 lives');
		GAMESTATE:GetPlayerState('PlayerNumber_P2'):SetPlayerOptions('ModsLevel_Preferred',OptionsP2..',failimmediate,battery,4 lives');
	elseif GAMESTATE:IsExtraStage2() then
		GAMESTATE:GetPlayerState('PlayerNumber_P1'):SetPlayerOptions('ModsLevel_Preferred',OptionsP1..',failimmediate,battery,1 lives');
		GAMESTATE:GetPlayerState('PlayerNumber_P2'):SetPlayerOptions('ModsLevel_Preferred',OptionsP2..',failimmediate,battery,1 lives');
	else
		

		-- GAMESTATE:GetPlayerState('PlayerNumber_P1'):SetPlayerOptions('ModsLevel_Preferred',OptionsP1..',battery,4 lives');
		-- GAMESTATE:GetPlayerState('PlayerNumber_P2'):SetPlayerOptions('ModsLevel_Preferred','battery,4 lives');
	end;
	
	
	
	GAMESTATE:SetFailTypeExplicitlySet();


 end;
 
 if GAMESTATE:GetPlayMode()=="PlayMode_Oni" then
	local OptionsP1;
	local OptionsP2;
	OptionsP1 = GAMESTATE:GetPlayerState('PlayerNumber_P1'):GetPlayerOptionsString('ModsLevel_Preferred');
	OptionsP2 = GAMESTATE:GetPlayerState('PlayerNumber_P2'):GetPlayerOptionsString('ModsLevel_Preferred');
	
	if	GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
		if GAMESTATE:GetCurrentTrail('PlayerNumber_P1'):GetDifficulty() == "Difficulty_Hard" then
			GAMESTATE:GetPlayerState('PlayerNumber_P1'):SetPlayerOptions('ModsLevel_Preferred',OptionsP1..',failimmediate,battery,4 lives');
		else
			GAMESTATE:GetPlayerState('PlayerNumber_P1'):SetPlayerOptions('ModsLevel_Preferred',OptionsP1..',failimmediate,battery,8 lives');
		end
	end
	
	if	GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
		if GAMESTATE:GetCurrentTrail('PlayerNumber_P2'):GetDifficulty() == "Difficulty_Hard" then
			GAMESTATE:GetPlayerState('PlayerNumber_P2'):SetPlayerOptions('ModsLevel_Preferred',OptionsP2..',failimmediate,battery,4 lives');
		else
			GAMESTATE:GetPlayerState('PlayerNumber_P2'):SetPlayerOptions('ModsLevel_Preferred',OptionsP2..',failimmediate,battery,8 lives');
		end
	end
	
	GAMESTATE:SetFailTypeExplicitlySet();
 end
 
-- t[#t+1] = LoadActor("Frame1.png")..{
		-- InitCommand=cmd(player,PLAYER_1;horizalign,left;x,SCREEN_LEFT;draworder,49);
		-- OnCommand=function(self)
			-- if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
				-- self:y(SCREEN_CENTER_Y-301.5);
				-- self:rotationx(180);
			-- else
				-- self:y(SCREEN_CENTER_Y+275);
			-- end;
		-- end;
		-- CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	-- };
-- t[#t+1] = LoadActor("Frame2.png")..{
		-- InitCommand=cmd(player,PLAYER_2;horizalign,right;x,SCREEN_RIGHT;draworder,49);
		-- OnCommand=function(self)
			-- if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
				-- self:y(SCREEN_CENTER_Y-301.5);
				-- self:rotationx(180);
			-- else
				-- self:y(SCREEN_CENTER_Y+275);
			-- end;
		-- end;
		-- CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	-- };
--CaloriesP1--
--BigNumber--
local pn = GAMESTATE:GetMasterPlayerNumber()
t[#t+1] = LoadFont("_Bolster","21px")..{
			InitCommand=cmd(player,PLAYER_1;horizalign,right;settext,"0000";x,SCREEN_CENTER_X-370-30;y,SCREEN_CENTER_Y+271.5;draworder,50;diffuse,color("#fff200");maxwidth,80);
			StepMessageCommand=function(self)
				local pssp1 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1);
				local CaloriesBurnedP1 = pssp1:GetCaloriesBurned();
				self:settextf("%04.3f",CaloriesBurnedP1)
			end;
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
					self:y(SCREEN_CENTER_Y+271.5);--self:y(SCREEN_CENTER_Y-306.5);
				else
					self:y(SCREEN_CENTER_Y+271.5);
			end;
		end;
		--CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};
--kcal--
t[#t+1] = LoadFont("_Bolster","21px")..{
			InitCommand=cmd(player,PLAYER_1;horizalign,left;settext,"kcal";x,SCREEN_CENTER_X-370-30+10;y,SCREEN_CENTER_Y+271+2;draworder,50;diffuse,color("#fff200");zoom,0.85);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
					self:y(SCREEN_CENTER_Y+271.5);--self:y(SCREEN_CENTER_Y-305);
				else
					self:y(SCREEN_CENTER_Y+271+2);
			end;
		end;
		--CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};
--CaloriesP2--
--BigNumber--
local pn = GAMESTATE:GetMasterPlayerNumber()
t[#t+1] = LoadFont("_Bolster","21px")..{
			InitCommand=cmd(player,PLAYER_2;horizalign,right;settext,"0000";x,SCREEN_CENTER_X+370+50;y,SCREEN_CENTER_Y+271.5;draworder,50;diffuse,color("#fff200");maxwidth,80);
			StepMessageCommand=function(self)
				local pssp2 = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_2);
				local CaloriesBurnedP2 = pssp2:GetCaloriesBurned();
				self:settextf("%04.3f",CaloriesBurnedP2)
			end;
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
					self:y(SCREEN_CENTER_Y+271.5);--self:y(SCREEN_CENTER_Y-306.5);
				else
					self:y(SCREEN_CENTER_Y+271.5);
			end;
		end;
	};
--kcal--
t[#t+1] = LoadFont("_Bolster","21px")..{
			InitCommand=cmd(player,PLAYER_2;horizalign,left;settext,"kcal";x,SCREEN_CENTER_X+370+10+50;y,SCREEN_CENTER_Y+271+2;draworder,50;diffuse,color("#fff200");zoom,0.85);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
					self:y(SCREEN_CENTER_Y+271.5);--self:y(SCREEN_CENTER_Y-305);
				else
					self:y(SCREEN_CENTER_Y+271+2);
			end;
		end;
	};
--options--
t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P1") ) .. {
		InitCommand=cmd(player,PLAYER_1;zoomx,2;zoomy,1.5;x,WideScale(SCREEN_CENTER_X-221,SCREEN_CENTER_X-296);draworder,1);
		OnCommand=function(self)
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
				self:y(SCREEN_CENTER_Y-286);
			else
				self:y(SCREEN_CENTER_Y+252);
			end;
		end;
		-- CurrentSongChangedMessageCommand=function(self)
			-- if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
				-- self:y(SCREEN_CENTER_Y-276);
			-- else
				-- self:y(SCREEN_CENTER_Y+252);
			-- end;
		-- end;
	};
t[#t+1] = LoadActor( THEME:GetPathB("","optionicon_P2") ) .. {
		InitCommand=cmd(player,PLAYER_2;zoomx,2;zoomy,1.5;x,WideScale(SCREEN_CENTER_X+221,SCREEN_CENTER_X+296);draworder,1);
		OnCommand=function(self)
			if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
				self:y(SCREEN_CENTER_Y-286);
			else
				self:y(SCREEN_CENTER_Y+252);
			end;
		end;
		--CurrentSongChangedMessageCommand=cmd(playcommand,"On");
	};
--songinfo--
t[#t+1] = LoadFont("_arial black 28px")..{
	InitCommand=cmd(horizalign,center;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-58-11;zoom,0.72;draworder,50;strokecolor,color("#000000"));
	OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.25;diffusealpha,1);
	OffCommand=cmd(sleep,2;linear,0.15;diffusealpha,0);
	CurrentSongChangedMessageCommand=function(self)
	if   GAMESTATE:GetCurrentStage() ~= 'Stage_Demo' then
		local song = GAMESTATE:GetCurrentSong();
		if song then
			local text = song:GetDisplayFullTitle();
				self:diffusealpha(1);
				self:maxwidth(480);
				self:settext(text);
			end;
		end;
	end;
};
--artist--
t[#t+1] = LoadFont("_arial black 28px")..{
	InitCommand=cmd(horizalign,center;x,SCREEN_CENTER_X;y,SCREEN_BOTTOM-58+11;zoom,0.57;draworder,50;strokecolor,color("#000000"));
	OnCommand=cmd(diffusealpha,0;sleep,0.5;linear,0.25;diffusealpha,1);
	OffCommand=cmd(sleep,2;linear,0.15;diffusealpha,0);
	CurrentSongChangedMessageCommand=function(self)
	if   GAMESTATE:GetCurrentStage() ~= 'Stage_Demo' then
		local song = GAMESTATE:GetCurrentSong();
		if song then
		local text = song:GetDisplayArtist();
			self:diffusealpha(1);
			self:maxwidth(460);
			self:settext(text);
		end;
		end;
	end;
};

--Lock SpeedMod when Oni Course has SpeepMod in course file
if GAMESTATE:GetPlayMode()=="PlayMode_Oni" then
	local curTrailP1 = {}
	local curTrailP2 = {}
	local trailHasSpeedMod = false;
	
	if  GAMESTATE:IsPlayerEnabled('PlayerNumber_P1') then
		curTrailP1 = GAMESTATE:GetCurrentTrail('PlayerNumber_P1'):GetTrailEntries();
		local temp=#curTrailP1;
		
		if curTrailP1[1] then
			for i=1,temp do
				local modString = curTrailP1[temp]:GetNormalModifiers();
				if string.find(modString,"x") or string.find(modString,"X") then
					trailHasSpeedMod = true;
				end
			end
		end
	end
	if  GAMESTATE:IsPlayerEnabled('PlayerNumber_P2') then
		curTrailP1 = GAMESTATE:GetCurrentTrail('PlayerNumber_P2'):GetTrailEntries();
		local temp=#curTrailP2;
		
		if curTrailP2[1] then
			for i=1,temp do
				local modString = curTrailP2[temp]:GetNormalModifiers();
				if string.find(modString,"x") or string.find(modString,"X") then
					trailHasSpeedMod = true;
				end
			end
		end
	end
	
	if not trailHasSpeedMod then
		t[#t+1] = LoadActor("SpeedKill.lua");
	end	
	
else
	t[#t+1] = LoadActor("SpeedKill.lua");
end

	
return t