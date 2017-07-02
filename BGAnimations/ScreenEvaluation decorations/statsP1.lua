local t = Def.ActorFrame {};

local Combo = 	STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):MaxCombo();

local Marvelous = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W1");
local Perfect = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W2");
local Great = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W3");
local Good = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W4");
local Ok = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetHoldNoteScores("HoldNoteScore_Held");
local Miss = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_Miss") + STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetTapNoteScores("TapNoteScore_W5");



local Score = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1):GetScore();
local EXScore = Marvelous*3 + Perfect*2 + Great*1 + Ok*3;


--Max Combo--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.50;draworder,6;y,SCREEN_CENTER_Y-179;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Combo);
	end;
};
--Marvelous--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+217-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Marvelous);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};
--Perfect--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+242-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Perfect);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};
--Great--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+267-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Great);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};
--Good--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+292-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Good);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};
--Ok--
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+317-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Ok);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};
--Miss--(Almost+Miss)
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.42;draworder,5;y,SCREEN_TOP+342-12;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(Miss);
		self:diffuse(color("#000000"));
		self:strokecolor(color("#ffffff"));
	end;
};

--EXScore
t[#t+1] = LoadFont("_avantgarde-book 40px")..{
	InitCommand=cmd(player,PLAYER_1;zoom,0.50;draworder,5;y,SCREEN_TOP+356;horizalign,right;addx,15);
	OnCommand=function(self)
		self:settextf(math.round(EXScore));
		self:diffuse(color("#ffffff"));
	end;
};

return t;
