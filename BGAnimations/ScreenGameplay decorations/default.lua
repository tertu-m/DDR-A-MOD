local t = LoadFallbackB()

local ScoringPlayers = {}

local tns_reverse = Enum.Reverse(TapNoteScore)

t[#t+1] = Def.Actor{
    Name="ScoringController",
    JudgmentMessageCommand = function(_,params)
		SN2Scoring.PrepareScoringInfo()
        if not ScoringPlayers[params.Player] then
            ScoringPlayers[params.Player] = true
        end
		--worstJudge is used by the combo code
		if not ScoringInfo.worstJudge then
			ScoringInfo.worstJudge = {}
		end

		local wj = ScoringInfo.worstJudge[params.Player]
		if tns_reverse[params.TapNoteScore] <= tns_reverse['TapNoteScore_W1'] and
			tns_reverse[params.TapNoteScore] >= tns_reverse['TapNoteScore_Miss'] then
			if (not wj) or tns_reverse[params.TapNoteScore] < tns_reverse[wj] then
				ScoringInfo.worstJudge[params.Player] = params.TapNoteScore
			end
		end
        local es = (GAMESTATE:Env()).EndlessState
        if es then
            local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(params.Player)
            es.scoring.handleNoteScore(params.HoldNoteScore or params.TapNoteScore,
                GAMESTATE:GetCurrentStageIndex()+1,
                pss:GetCurrentCombo())
            --SCREENMAN:SystemMessage(es.scoring.getScoreString())
        end
    end,
}

local function ScoreUpdate()
    for pn, _ in pairs(ScoringPlayers) do
        local info = ScoringInfo[pn]
        local stage = GAMESTATE:IsCourseMode() and GAMESTATE:GetCourseSongIndex() + 1 or nil
        local pss = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn)
        local score = info.GetCurrentScore(pss, stage)
        pss:SetScore(score)
        local scoreDisplay = SCREENMAN:GetTopScreen():GetChild("Score"..ToEnumShortString(pn))
        if scoreDisplay and scoreDisplay:GetChild("Text") then
            scoreDisplay:GetChild("Text"):targetnumber(score)
        end
        pss:SetCurMaxScore(info.GetCurrentMaxScore(pss, stage))
    end
end

t[#t+1] = Def.ActorFrame{
    Name = "ScoringController2",
    InitCommand = function(s) s:SetUpdateFunction(ScoreUpdate) end
}

t[#t+1] = LoadActor("OptionsHack.lua")..{
	InitCommand=cmd(draworder,1);
};


if ThemePrefs.Get("Fast") == true then
	t[#t+1] = LoadActor("TimingJudgements.lua")..{
		InitCommand=cmd(draworder,1);
	};
end

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

t[#t+1] = Def.ActorFrame{
	InitCommand=cmd(draworder,1);
	StandardDecorationFromFileOptional("ScoreFrameP1","ScoreFrameP1");
	StandardDecorationFromFileOptional("ScoreFrameP2","ScoreFrameP2");
	StandardDecorationFromFileOptional("SongFrame","SongFrame");
	StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
	StandardDecorationFromFileOptional("StageFrame","StageFrame");
	StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
	StandardDecorationFromFileOptional("SongTitle","SongTitle");
};

-- t[#t+1] = StandardDecorationFromFileOptional("ScoreFrameP1","ScoreFrameP1");
-- t[#t+1] = StandardDecorationFromFileOptional("ScoreFrameP2","ScoreFrameP2");
-- t[#t+1] = StandardDecorationFromFileOptional("SongFrame","SongFrame");
-- t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay");
-- t[#t+1] = StandardDecorationFromFileOptional("StageFrame","StageFrame");
-- t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
-- t[#t+1] = StandardDecorationFromFileOptional("SongTitle","SongTitle");


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





local showCal = true;

if ThemePrefs.Get("Calories") == true then
	showCal = true;
else
	showCal = false;
end

--MeterP1
if GAMESTATE:IsPlayerEnabled(PLAYER_1) and showCal == false then
--BG--
	t[#t+1] = LoadActor("diffmain")..{
		InitCommand=cmd(player,PLAYER_1;x,SCREEN_LEFT+198;y,SCREEN_CENTER_Y+295;zoom,1.5;draworder,50;);
		OnCommand=function(self)
			local diffP1 = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
			local sDifficulty = ToEnumShortString( diffP1 );
			self:diffuse(CustomDifficultyToColor( sDifficulty ));
			self:diffusetopedge(CustomDifficultyToDarkColor(sDifficulty));
		end;
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				local diffP1 = GAMESTATE:GetCurrentTrail(PLAYER_1):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetDifficulty();
				local sDifficulty = ToEnumShortString( diffP1 );
				self:diffuse(CustomDifficultyToColor( sDifficulty ));
				self:diffusetopedge(CustomDifficultyToDarkColor(sDifficulty));
			end;
		end;
	};
	t[#t+1] = LoadActor("diffmask")..{
		InitCommand=cmd(player,PLAYER_1;x,SCREEN_LEFT+198;y,SCREEN_CENTER_Y+295;zoom,1.5;draworder,50;);
		OnCommand=function(self)
			self:diffuse(color("0,0,0,0.8"));
		end;
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:diffuse(color("0,0,0,0.8"));
			end;
		end;
	};
--LEVEL--
t[#t+1] = LoadFont("_helvetica-condensed-light 24px")..{
			InitCommand=cmd(player,PLAYER_1;horizalign,right;settext,"LEVEL";x,SCREEN_CENTER_X-370-30;y,SCREEN_CENTER_Y+271.5;draworder,50;diffuse,color("#ffffff");maxwidth,80;zoomy,0.4;zoomx,1.3);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
					self:y(SCREEN_CENTER_Y+278.5);--self:y(SCREEN_CENTER_Y-306.5);
				else
					self:y(SCREEN_CENTER_Y+278.5);
			end;
		end;
	};
--number--
t[#t+1] = LoadFont("_squareslab711 lt bt Bold 24px")..{
			InitCommand=cmd(player,PLAYER_1;horizalign,left;x,SCREEN_CENTER_X-370-30+10;y,SCREEN_CENTER_Y+270;draworder,50;diffuse,color("#ffffff");strokecolor,color("#000000");zoomy,0.90;zoomx,1.2);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'reverse') then
					self:y(SCREEN_CENTER_Y+270+7);--self:y(SCREEN_CENTER_Y-305);
				else
					self:y(SCREEN_CENTER_Y+270+7);
				end;
				local meterP1 = GAMESTATE:GetCurrentSteps(PLAYER_1):GetMeter();
				self:settext(meterP1);
			end;
			CurrentSongChangedMessageCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					local meterP1 = GAMESTATE:GetCurrentTrail(PLAYER_1):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetMeter();
					self:settext(meterP1);
				end;
			end;
};
end;


--MeterP2
if GAMESTATE:IsPlayerEnabled(PLAYER_2) and showCal == false then
--BG--
	t[#t+1] = LoadActor("diffmain")..{
		InitCommand=cmd(player,PLAYER_2;x,SCREEN_RIGHT-198;y,SCREEN_CENTER_Y+295;rotationy,180;zoom,1.5;draworder,50;);
		OnCommand=function(self)
			local diffP2 = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
			local sDifficulty = ToEnumShortString( diffP2 );
			self:diffuse(CustomDifficultyToColor( sDifficulty ));
			self:diffusetopedge(CustomDifficultyToDarkColor(sDifficulty));
		end;
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				local diffP2 = GAMESTATE:GetCurrentTrail(PLAYER_2):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetDifficulty();
				local sDifficulty = ToEnumShortString( diffP2 );
				self:diffuse(CustomDifficultyToColor( sDifficulty ));
				self:diffusetopedge(CustomDifficultyToDarkColor(sDifficulty));
			end;
		end;
	};
	t[#t+1] = LoadActor("diffmask")..{
		InitCommand=cmd(player,PLAYER_2;x,SCREEN_RIGHT-198;y,SCREEN_CENTER_Y+295;rotationy,180;zoom,1.5;draworder,50;);
		OnCommand=function(self)
			self:diffuse(color("0,0,0,0.8"));
		end;
		CurrentSongChangedMessageCommand=function(self)
			if GAMESTATE:IsCourseMode() then
				self:diffuse(color("0,0,0,0.8"));
			end;
		end;
	};
--LEVEL--
t[#t+1] = LoadFont("_helvetica-condensed-light 24px")..{
			InitCommand=cmd(player,PLAYER_2;horizalign,right;settext,"LEVEL";x,SCREEN_CENTER_X+370+50;y,SCREEN_CENTER_Y+271.5;draworder,50;diffuse,color("#ffffff");maxwidth,80;zoomy,0.4;zoomx,1.3);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
					self:y(SCREEN_CENTER_Y+278.5);--self:y(SCREEN_CENTER_Y-306.5);
				else
					self:y(SCREEN_CENTER_Y+278.5);
			end;
		end;
	};
--number--
t[#t+1] = LoadFont("_squareslab711 lt bt Bold 24px")..{
			InitCommand=cmd(player,PLAYER_2;horizalign,left;x,SCREEN_CENTER_X+370+10+50;y,SCREEN_CENTER_Y+271+2;draworder,50;diffuse,color("#ffffff");strokecolor,color("#000000");zoomy,0.90;zoomx,1.2);
			OnCommand=function(self)
				if GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'reverse') then
					self:y(SCREEN_CENTER_Y+270+7);--self:y(SCREEN_CENTER_Y-305);
				else
					self:y(SCREEN_CENTER_Y+270+7);
				end;
				local meterP2 = GAMESTATE:GetCurrentSteps(PLAYER_2):GetMeter();
				self:settext(meterP2);
			end;
			CurrentSongChangedMessageCommand=function(self)
				if GAMESTATE:IsCourseMode() then
					local meterP2 = GAMESTATE:GetCurrentTrail(PLAYER_2):GetTrailEntry(GAMESTATE:GetCourseSongIndex()):GetSteps():GetMeter();
					self:settext(meterP2);
				end;
			end;
};
end;

if showCal then
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
end;


return t
