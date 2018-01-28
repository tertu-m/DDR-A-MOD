local t = LoadFallbackB();

local lang = "en";
if THEME:GetCurLanguage() == "ja" then
	lang = "jp";
end;

t[#t+1]= LoadActor("../_music_out" ) .. {
	OffCommand=function(self)
		(cmd(play))(self);
	end;
};

--ReadPaneControl
function ReadOrCreatePaneControlForPlayerSide(PlayerUID)
	local PaneControlFile = RageFileUtil:CreateRageFile()
	local MyValue2 = "";
	if PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",1) then 
		MyValue2 = PaneControlFile:Read();
	else
		PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",2);
		PaneControlFile:Write("ClosePanes");
		MyValue2="";
	end
	PaneControlFile:Close();
	return MyValue2;
end


function ReadOrCreatePaneControlForAnotherSide(PlayerUID)
	local PaneControlFile = RageFileUtil:CreateRageFile()
	local MyValue2 = "";
	if PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",1) then 
		MyValue2 = PaneControlFile:Read();
		
	else
		PaneControlFile:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",2);
		PaneControlFile:Write("ClosePanesA");
		MyValue2="";
	end
	PaneControlFile:Close();
	return MyValue2;
end

--SavePaneControl
function SavePaneControl( PlayerUID, MyValue, Mode)
	if Mode == "PlayerSide" then
		local PaneControlFile3 = RageFileUtil:CreateRageFile();
		PaneControlFile3:Open("Save/PaneControl/"..PlayerUID.."_PlayerSide.txt",2);
		PaneControlFile3:Write(tostring(MyValue));
		PaneControlFile3:Close();
	elseif Mode == "AnotherSide" then
		local PaneControlFile4 = RageFileUtil:CreateRageFile();
		PaneControlFile4:Open("Save/PaneControl/"..PlayerUID.."_AnotherSide.txt",2);
		PaneControlFile4:Write(tostring(MyValue));
		PaneControlFile4:Close();
		
	end
end;

--Stage BG
t[#t+1] = Def.ActorFrame {
	LoadActor( "stagebg" )..{
		InitCommand=cmd(x,SCREEN_LEFT+123;y,SCREEN_TOP+56;;zoom,1.5);
		OnCommand=cmd(zoomy,0;linear,0.1;zoomy,1.5);
		OffCommand=cmd(linear,0.1;zoomy,0);
	}
};

t[#t+1] = Def.ActorFrame {
	LoadActor( "stageeffect.lua" );
};


t[#t+1] = Def.ActorFrame {
	LoadActor( "sidebg" )..{
		InitCommand=cmd(x,SCREEN_LEFT+186;y,SCREEN_BOTTOM-323;zoomx,-1.5;zoomy,1.5);
		OnCommand=cmd(addx,-500;decelerate,0.1;addx,500);
		OffCommand=cmd(linear,0.1;diffusealpha,0);
	}
};
t[#t+1] = Def.ActorFrame {
	LoadActor( "sidebg" )..{
		InitCommand=cmd(x,SCREEN_RIGHT-186;y,SCREEN_BOTTOM-323;zoom,1.5);
		OnCommand=cmd(addx,500;decelerate,0.1;addx,-500);
		OffCommand=cmd(linear,0.1;diffusealpha,0);
	}
};



t[#t+1] = Def.ActorFrame {
	LoadActor( "sideeffect.lua" );
};

-- Legacy StepMania 4 Function
--???
local function StepsDisplay(pn)
	local function set(self, player)
		self:SetFromGameState( player );
	end

	local t = Def.StepsDisplay {
		InitCommand=cmd(Load,"StepsDisplay",GAMESTATE:GetPlayerState(pn););
	};

	if pn == PLAYER_1 then
		t.CurrentStepsP1ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP1ChangedMessageCommand=function(self) set(self, pn); end;
	else
		t.CurrentStepsP2ChangedMessageCommand=function(self) set(self, pn); end;
		t.CurrentTrailP2ChangedMessageCommand=function(self) set(self, pn); end;
	end

	return t;
end
t[#t+1] = StandardDecorationFromFileOptional("AlternateHelpDisplay","AlternateHelpDisplay");
t[#t+1] = StandardDecorationFromFileOptional("BannerFrame","BannerFrame");

--default difficulty stuff
local function GetDifListY(d)
	local r=0;
	if d == "Difficulty_Beginner" then
		r=(42*0);
	elseif d == "Difficulty_Easy" then
		r=(42*1);
	elseif d == "Difficulty_Medium" then
		r=(42*2);
	elseif d == "Difficulty_Hard" then
		r=(42*3);
	elseif d == "Difficulty_Challenge" then
		r=(42*4);
	elseif d == "Difficulty_Edit" then
		r=(42*5);
	end;
	return r;
end;

local function GetDifListX(self,pn,offset,fade)
	if pn==PLAYER_1 then
		self:x(SCREEN_LEFT+150-offset);
		if fade>0 then
			self:faderight(fade);
		end;
	else
		self:x(SCREEN_RIGHT-150+offset);
		if fade>0 then
			self:fadeleft(fade);
		end;
	end;
	return r;
end;

local function DrawDifList(pn,diff)
	local t=Def.ActorFrame {
		InitCommand=cmd(player,pn;y,SCREEN_CENTER_Y-150-43.5-25);
--meter
	LoadFont("_itc avant garde std bk 20px")..{
		InitCommand=cmd(diffuse,color("#000000");strokecolor,Color("White");zoom,0.9);
		SetCommand=function(self)
		local st=GAMESTATE:GetCurrentStyle():GetStepsType();
		local song=GAMESTATE:GetCurrentSong();
		local course = GAMESTATE:GetCurrentCourse();
		
		if song then
			GetDifListX(self,pn,110,0);
			self:y(GetDifListY(diff, st, song));
			if song:HasStepsTypeAndDifficulty(st,diff) then
			local steps = song:GetOneSteps( st, diff );
				self:settext(steps:GetMeter());
			else
				self:settext("");
			end;
			
		else
			self:settext("");
		end;
		end;
	CurrentSongChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentStepsP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP1ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentTrailP2ChangedMessageCommand=cmd(playcommand,"Set");
	CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	};
	};
	return t;
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
--Difficulty Info
	t[#t+1] = Def.ActorFrame {
		LoadActor( "diffInfo" )..{
			InitCommand=cmd(zoom,1.35;zoomx,-1.35;x,SCREEN_LEFT+144;y,SCREEN_CENTER_Y-238);
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( lang.."_diffLabel" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_LEFT+139;y,SCREEN_CENTER_Y-252);
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( "tapU" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_LEFT+121;y,SCREEN_CENTER_Y-252;queuecommand,"Animate");
			AnimateCommand=cmd(linear,.284;addy,4;linear,.284;addy,-4;sleep,1.01;queuecommand,"Animate");
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( "tapD" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_LEFT+155;y,SCREEN_CENTER_Y-252;queuecommand,"Animate");
			AnimateCommand=cmd(sleep,1.01;linear,.284;addy,4;linear,.284;addy,-4;queuecommand,"Animate");
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;zoom,0);
		}
	};
	
end;

if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
--Difficulty Info
	t[#t+1] = Def.ActorFrame {
		LoadActor( "diffInfo" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_RIGHT-144;y,SCREEN_CENTER_Y-238);
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( lang.."_diffLabel" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_RIGHT-139;y,SCREEN_CENTER_Y-252);
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( "tapU" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_RIGHT-157;y,SCREEN_CENTER_Y-252;queuecommand,"Animate");
			AnimateCommand=cmd(linear,.284;addy,4;linear,.284;addy,-4;sleep,1.01;queuecommand,"Animate");
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;zoom,0);
		}
	};

	t[#t+1] = Def.ActorFrame {
		LoadActor( "tapD" )..{
			InitCommand=cmd(zoom,1.35;x,SCREEN_RIGHT-124;y,SCREEN_CENTER_Y-252;queuecommand,"Animate");
			AnimateCommand=cmd(sleep,1.01;linear,.284;addy,4;linear,.284;addy,-4;queuecommand,"Animate");
			OnCommand=cmd(diffusealpha,0;sleep,0.2;linear,0.2;diffusealpha,1);
			OffCommand=cmd(stoptweening;linear,0.2;zoom,0);
		}
	};
end;

if not GAMESTATE:IsCourseMode() then




t[#t+1] = LoadActor("DefaultDifficulty.lua")..{ --Default Difficulty List
InitCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-225;zoom,1.5);
OffCommand=cmd(linear,0.25;diffusealpha,0;);
};

for pn in ivalues( GAMESTATE:GetHumanPlayers() ) do
t[#t+1] = LoadActor("diffScore.lua", pn)..{
InitCommand=cmd(zoom,1);
OffCommand=cmd(linear,0.25;diffusealpha,0;);
};
end

end;



t[#t+1] = LoadActor("scoresP1.lua")..{
		InitCommand=cmd(player,PLAYER_1;diffusealpha,0.9;draworder,0;x,SCREEN_LEFT+0;y,SCREEN_CENTER_Y+20;zoom,1.2);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" then
					(cmd(addx,-500;sleep,0.5;decelerate,0.5;addx,500))(self);
					self:linear(0.5);
					self:diffusealpha(1);
					
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					self:diffusealpha(0);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:diffusealpha(0);
					end
				end;
			end;
		end;
		CodeMessageCommand=function(self,params)
			local pn = params.PlayerNumber
			if pn==PLAYER_1 then
				if params.Name=="OpenPanes3"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes1" or params.Name=="OpenPanes2" then
					self:linear(0.15);
					self:diffusealpha(0);
				elseif  params.Name=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:linear(0.15);
						self:diffusealpha(0);
					end
				end;
			end;
			
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
			
			if pn==PLAYER_1 then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes2"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
			
		end;
		CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(0.8);
			else
				self:zoom(0);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(0.8);
			else
				self:zoom(0);
			end;
		end;
		
};
t[#t+1] = LoadActor("scoresP2.lua")..{
		InitCommand=cmd(player,PLAYER_2;diffusealpha,0.9;draworder,0;x,SCREEN_LEFT+255;y,SCREEN_CENTER_Y+20;zoom,1.2);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_2):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" then
					(cmd(addx,500;sleep,0.5;decelerate,0.5;addx,-500))(self);
					self:linear(0.5);
					self:diffusealpha(1);
					
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					self:diffusealpha(0);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:diffusealpha(0);
					end
				end;
			end;
		end;
		CodeMessageCommand=function(self,params)
			local pn = params.PlayerNumber
			if pn==PLAYER_2 then
				if params.Name=="OpenPanes3"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes1" then
					self:linear(0.15);
					self:diffusealpha(0);
				elseif  params.Name=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:linear(0.15);
						self:diffusealpha(0);
					end
				end;
			end;
			
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
			
			if pn==PLAYER_2 then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes2"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
			
		end;
		
		CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(0.8);
			else
				self:zoom(0);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(0.8);
			else
				self:zoom(0);
			end;
		end;
};





if GAMESTATE:IsCourseMode() then
t[#t+1] = StandardDecorationFromFileOptional("CourseContentsList","CourseContentsList");
t[#t+1] = StandardDecorationFromFileOptional("CourseContentsMyListP1","CourseContentsMyListP1")..{
		InitCommand=cmd(diffusealpha,0;visible,GAMESTATE:IsHumanPlayer(PLAYER_1);draworder,101;zoom,0.8;addy,90);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID();
				self:sleep(0.7);
				self:diffusealpha(1);
			end;
		end;
		
};

t[#t+1] = StandardDecorationFromFileOptional("CourseContentsMyListP2","CourseContentsMyListP2")..{
		InitCommand=cmd(diffusealpha,0;visible,GAMESTATE:IsHumanPlayer(PLAYER_2);draworder,101;zoom,0.8;addy,90);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_2):GetGUID();
				self:sleep(0.7);
				self:diffusealpha(1);
			end;
		end;
};

end;




t[#t+1] = Def.Quad{
	InitCommand=cmd(diffusealpha,0;setsize,310,310;x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y-200;MaskSource);
	OffCommand=cmd(sleep,0.0;decelerate,0.05;diffusealpha,1;MaskSource);
}

t[#t+1] = StandardDecorationFromFileOptional("BPMDisplay","BPMDisplay")..{
	InitCommand = cmd(draworder,110);
	OffCommand = cmd(zoom,0;MaskDest);
};
t[#t+1] = StandardDecorationFromFileOptional("BPMLabel","BPMLabel");
t[#t+1] = StandardDecorationFromFileOptional("SegmentDisplay","SegmentDisplay");
t[#t+1] = StandardDecorationFromFileOptional("ShockArrowDisplayP1","ShockArrowDisplayP1");
t[#t+1] = StandardDecorationFromFileOptional("ShockArrowDisplayP2","ShockArrowDisplayP2");

if GAMESTATE:IsCourseMode() then
	-- t[#t+1] = StandardDecorationFromFileOptional("NumCourseSongs","NumCourseSongs")..{
		-- InitCommand=cmd(horizalign,right;playcommand,"Set");
		-- OnCommand=cmd(playcommand,"Set");
		-- SetCommand=function(self)
			-- local curSelection= nil;
			-- local sAppend = "";
			
			-- if GAMESTATE:IsCourseMode() then
				-- curSelection = GAMESTATE:GetCurrentCourse();
				-- if curSelection then
					-- sAppend = (curSelection:GetEstimatedNumStages() == 1) and "Stage" or "Stages";
					-- self:visible(true);
					-- self:settext( curSelection:GetEstimatedNumStages() .. " " .. sAppend);
					
				-- else
					-- self:visible(false);
				-- end;
			-- else
				-- self:visible(false);
			-- end;
			
		-- end;
		
		-- CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	-- };
	
	t[#t+1] = LoadFont("_compacta blk bt 14px") ..{
		InitCommand=cmd(horizalign,right;x,190;y,65;zoomx,2.6;zoomy,2.2;playcommand,"Set");
		OnCommand=cmd(playcommand,"Set");
		OffCommand=cmd(diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;diffuse,1,1,1,1;sleep,0.05;diffuse,1,1,1,0;sleep,0.05;linear,0.05;diffusealpha,0);
		
		SetCommand=function(self)
			local curSelection= nil;
			local sAppend = "";
			
			if GAMESTATE:IsCourseMode() then
				curSelection = GAMESTATE:GetCurrentCourse();
				if curSelection then
					sAppend = (curSelection:GetEstimatedNumStages() == 1) and "Stage" or "Stages";
					self:visible(true);
					self:settext( curSelection:GetEstimatedNumStages() .. " " .. sAppend);
					
				else
					self:visible(false);
				end;
			else
				self:visible(false);
			end;
			
		end;
		
		CurrentCourseChangedMessageCommand=cmd(playcommand,"Set");
	};
end


--new song--
-- if not GAMESTATE:IsCourseMode() then

	-- t[#t+1] = StandardDecorationFromFileOptional("StageDisplay","StageDisplay");
-- end;



t[#t+1] = StandardDecorationFromFileOptional("DifficultyDisplay","DifficultyDisplay");
t[#t+1] = StandardDecorationFromFileOptional("SortOrderFrame","SortOrderFrame") .. {

};
t[#t+1] = StandardDecorationFromFileOptional("SortOrder","SortOrderText") .. {
	BeginCommand=cmd(playcommand,"Set");
	SortOrderChangedMessageCommand=cmd(playcommand,"Set";);
	SetCommand=function(self)
		local s = SortOrderToLocalizedString( GAMESTATE:GetSortOrder() );
		self:settext( s );
		self:playcommand("Sort");
	end;
};
t[#t+1] = StandardDecorationFromFileOptional("SongOptionsFrame","SongOptionsFrame") .. {
	ShowPressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsFrameShowCommand");
	ShowEnteringOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsFrameEnterCommand");
	HidePressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsFrameHideCommand");
};
t[#t+1] = StandardDecorationFromFileOptional("SongOptions","SongOptionsText") .. {
	ShowPressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsShowCommand");
	ShowEnteringOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsEnterCommand");
	HidePressStartForOptionsCommand=THEME:GetMetric(Var "LoadingScreen","SongOptionsHideCommand");
};
--gradient--
t[#t+1] = Def.Quad{
	InitCommand=cmd(horizalign,center;x,SCREEN_CENTER_X+230;y,SCREEN_CENTER_Y-155-15;setsize,240,26;faderight,0.3;fadeleft,0.3;draworder,98);
	OnCommand=cmd(addx,-1300;linear,0.15;addx,1300);
	OffCommand=cmd(linear,0.15;addx,-1300);
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	local group;
	local so = GAMESTATE:GetSortOrder();
	if not GAMESTATE:IsCourseMode() then
		if song then 
			if so == "SortOrder_Group" then
				self:diffuse(color("#195c64"));
			elseif so == "SortOrder_Title" then
				self:diffuse(color("#f98b2d"));
			elseif so == "SortOrder_Artist" then
				self:diffuse(color("#f98b2d"));
			elseif so == "SortOrder_BPM" then
				self:diffuse(color("#2ed1b4"));
			elseif so == "SortOrder_BeginnerMeter" or so == "SortOrder_EasyMeter" or so == "SortOrder_MediumMeter" or so == "SortOrder_HardMeter" or so == "SortOrder_ChallengeMeter" then
				self:diffuse(color("#2d56d1"));
			elseif so == "SortOrder_Popularity" then
				self:diffuse(color("#be32f9"));
			elseif so == "SortOrder_TopGrades" then
				self:diffuse(color("#7bd128"));
			elseif so == "SortOrder_Genre" then
				self:diffuse(color("#008392"));
			else
			end;
		else
			self:diffusealpha(0);
		end;
	else
		if so == "SortOrder_AllCourses" then
				self:diffuse(color("#195c64"));
			elseif so == "SortOrder_Nonstop" then
				self:diffuse(color("#1e1e68"));
			elseif so == "SortOrder_Oni" then
				self:diffuse(color("#be32f9"));
			else
				self:diffusealpha(0);
		end;
	end;
	end;
	};
--group title--
t[#t+1] = LoadFont("_helvetica-compressed 32px")..{
	InitCommand=cmd(horizalign,center;x,SCREEN_CENTER_X+230;y,SCREEN_CENTER_Y-155-15;zoom,0.8;diffuse,color("#ffffff");draworder,99);
	OnCommand=cmd(addx,-1300;linear,0.15;addx,1300);
	OffCommand=cmd(linear,0.15;addx,-1300);
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	local course = GAMESTATE:GetCurrentCourse();
	local groupName;
	local selgrp;
	local wheel;
	local so = GAMESTATE:GetSortOrder();
	local group_colors= {
		["SortOrder_Group"]= "#195c64",
		["SortOrder_Title"]= "#864b21",
		["SortOrder_Artist"]= "#864b21",
		["SortOrder_BPM"]= "#006a56",
		["SortOrder_BeginnerMeter"]= "#1e1e68",
		["SortOrder_EasyMeter"]= "#1e1e68",
		["SortOrder_MediumMeter"]= "#1e1e68",
		["SortOrder_HardMeter"]= "#1e1e68",
		["SortOrder_ChallengeMeter"]= "#1e1e68",
		["SortOrder_Popularity"]= "#2e0d54",
		["SortOrder_TopGrades"]= "#254f07",
		["SortOrder_Genre"]= "#015b61",
		["SortOrder_AllCourses"]= "#195c64",
		["SortOrder_Nonstop"]= "#1e1e68",
		["SortOrder_Oni"]= "#be32f9"
	}
	if not GAMESTATE:IsCourseMode() then
		if song then
			local color_str= group_colors[GAMESTATE:GetSortOrder()] or "#000000"
			self:maxwidth(260);
			self:strokecolor(color(color_str));
			if so == "SortOrder_Group" then
				self:settext(mySortGroupName(song:GetGroupName()))
				self:diffusealpha(1);
			else
				if SCREENMAN:GetTopScreen():GetNextScreenName()=="ScreenStageInformation" then
					if SCREENMAN:GetTopScreen():GetPrevScreenName()~="ScreenSelectMusic" then
					    wheel =SCREENMAN:GetTopScreen():GetMusicWheel();
						if wheel then 
							if not GAMESTATE:IsAnExtraStage() then
								selgrp = wheel:GetSelectedSection();
								groupName = TranslateGroupName(selgrp);
							end
						end
					end;
				end;
				
				if groupName== nil then
					groupName=" ";
				end
				
				if so == "SortOrder_Title" then
						self:settext("Song Title/ "..groupName);
				elseif so == "SortOrder_Artist" then
						self:settext("Artist/ "..groupName);
				elseif so == "SortOrder_BPM" then
						self:settext("BPM/ "..groupName);
				elseif so == "SortOrder_BeginnerMeter" then
						self:settext("Beginner/ "..groupName);
				elseif so == "SortOrder_EasyMeter" then
						self:settext("Basic/ "..groupName);
				elseif so == "SortOrder_MediumMeter" then
						self:settext("Difficult/ "..groupName);
				elseif so == "SortOrder_HardMeter" then
						self:settext("Expert/ "..groupName);
				elseif so == "SortOrder_ChallengeMeter" then
						self:settext("Challenge/ "..groupName);
				elseif so == "SortOrder_Popularity" then
						self:settext("Popularity/");
				elseif so == "SortOrder_TopGrades" then
						self:settext("Cleared Rank/ "..groupName);
				elseif so == "SortOrder_Genre" then
						self:settext("Genre/ "..groupName);
				end;	
			end
		else
			self:settext("");
		end
	else
		
				local color_str= group_colors[GAMESTATE:GetSortOrder()] or "#000000"
				self:maxwidth(260);
				self:strokecolor(color(color_str));
				
				if so == "SortOrder_AllCourses" then
						self:settext("All Course/");
				elseif so == "SortOrder_Nonstop" then
						self:settext("Nonstop/");
				elseif so == "SortOrder_Oni" then
						self:settext("Challenge/");
				else
					self:settext("");
				end;
			end;

	end;	
};	

local function DrawRecordCourse(pn)
	local t=Def.ActorFrame {
		InitCommand=cmd(player,pn;y,SCREEN_CENTER_Y+138;addy,900;sleep,0.5;linear,0.05;addy,-900;);
		--course=GAMESTATE:GetCurrentCourse();
		--¤À¼Æ
		Def.RollingNumbers {
			File = THEME:GetPathF("_Bolster","21px");
			InitCommand=cmd(shadowlength,0;zoom,1.0;strokecolor,Color("Outline"));
			BeginCommand=cmd(playcommand,"Set");
			OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
			SetCommand=function(self)
				local st=GAMESTATE:GetCurrentStyle():GetStepsType();
				local song=GAMESTATE:GetCurrentSong();
				local course = GAMESTATE:GetCurrentCourse();
				local trail = GAMESTATE:GetCurrentTrail(pn);

				if course then
					self:y(-55);
					if pn==PLAYER_1 then
						self:x(110);
					else
						self:x(SCREEN_RIGHT-110);
					end;
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(course,trail);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					if scores[1] then
						topscore = scores[1]:GetScore();
					end;
					assert(topscore);
					self:diffuse(color("1,1,1,1"));
					self:strokecolor(color("0.2,0.2,0.2,1"));
					self:diffusealpha(0.8);
					if pn==PLAYER_1 and topscore ~= 0  then
						self:Load("RollingNumbersCourseData");
						self:targetnumber(topscore);
						
					elseif pn==PLAYER_2 and topscore ~= 0  then
						self:Load("RollingNumbersCourseData");
						self:targetnumber(topscore);
						
						
					else 
						self:settextf("");
					end;
				else
					self:settext("");			
				end;
				self:diffuse(color("1,1,1,1"));
				self:strokecolor(color("0.2,0.2,0.2,1"));
			end;
			
			CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
		};
		
		--full combo
		LoadActor(THEME:GetPathG("Player","Spin FullCombo"))..{
			InitCommand=cmd(shadowlength,1;zoom,0;spin);
			BeginCommand=cmd(playcommand,"Set");
			OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
			SetCommand=function(self)
				local st=GAMESTATE:GetCurrentStyle():GetStepsType();
				local song=GAMESTATE:GetCurrentSong();
				local course = GAMESTATE:GetCurrentCourse();
				local trail = GAMESTATE:GetCurrentTrail(pn);

				if course then
					self:y(-59);
					if pn==PLAYER_1 then
						self:x(270);
					else
						self:x(SCREEN_RIGHT-210);
					end;
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(course,trail);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					local temp=#scores;
					if scores[1] then
							for i=1,temp do 

								if scores[i] then
									topscore = scores[i];
									assert(topscore);
									local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
													+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
									local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
									local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
									local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
									local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
									local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
									local hasUsedLittle = string.find(topscore:GetModifiers(),"Little")
									if (goods+misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0  then
										if (greats+perfects) == 0 then

											self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
											self:glowblink();
											self:effectperiod(0.20);
											self:zoom(0.35);
											break;
										elseif greats == 0 then
											self:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
											self:stopeffect();
											self:zoom(0.35);
											break;
										else
											self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],0.75));
											self:stopeffect();
											self:zoom(0.35);
											if i==1 then
												self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],1));
											end;
											break;
										end;
										self:diffusealpha(0.8);
									else 
										self:diffusealpha(0);
										
									end;
								else
									self:diffusealpha(0);
									break;
								end;
							end;
						else
							self:diffusealpha(0);
						end;
				else
					self:diffusealpha(0);		
				end;
				
			end;
			
			CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
		};
		
		
		--µû»ù
		Def.Quad{
			InitCommand=cmd(shadowlength,1;zoom,0.75;);
			BeginCommand=cmd(playcommand,"Set");
			OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
			SetCommand=function(self)
				local st=GAMESTATE:GetCurrentStyle():GetStepsType();
				local song=GAMESTATE:GetCurrentSong();
				local course = GAMESTATE:GetCurrentCourse();
				local trail = GAMESTATE:GetCurrentTrail(pn);

				if course then
					self:y(-45);
					if pn==PLAYER_1 then
						self:x(230);
					else
						self:x(SCREEN_RIGHT-250);
					end;
					if PROFILEMAN:IsPersistentProfile(pn) then
						profile = PROFILEMAN:GetProfile(pn);
					else
						profile = PROFILEMAN:GetMachineProfile();
					end;
					scorelist = profile:GetHighScoreList(course,trail);
					assert(scorelist);
					local scores = scorelist:GetHighScores();
					assert(scores);
					local topscore=0;
					local cursocre=0;
					local temp=#scores;
					if scores[1] then
						for i=1,temp do 
							topgrade = scores[1]:GetGrade();
							curgrade = scores[i]:GetGrade();
							assert(topgrade);
							if scores[1]:GetScore()>1  then
								if scores[1]:GetScore()==1000000 and topgrade=="Grade_Tier07" then --AutoPlayHack
									self:LoadBackground(THEME:GetPathG("myMusicWheel","Tier01"));
									self:diffusealpha(1);
									break;
								else --Normal
									if ToEnumShortString(curgrade) ~= "Failed" then --not failed
										self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(topgrade)));
										self:diffusealpha(1);
										break;
									else --failed
										if i == temp then
											self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
											self:diffusealpha(1);
											break;
										end;
									end;
								end;
							else
								self:diffusealpha(0);
							end;
						end;
					else
						self:diffusealpha(0);
					end;
				else
					self:diffusealpha(0);		
				end;
				
			end;
			
			CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set");
			CurrentCourseChangedMessageCommand=cmd(queuecommand,"Set");
		};
		
		
	};	
	
	
	return t;
end;

--for course mode
-- if GAMESTATE:IsCourseMode() then
	-- if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
		-- t[#t+1]=DrawRecordCourse(PLAYER_1);
	-- end

	-- if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		-- t[#t+1]=DrawRecordCourse(PLAYER_2);
	-- end
-- end;





t[#t+1] = LoadActor("detailP1")..{
		InitCommand=cmd(player,PLAYER_1;diffusealpha,0.9;draworder,0;zoom,1);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_1):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" then
					(cmd(addx,-500;sleep,0.5;decelerate,0.5;addx,500))(self);
					self:linear(0.5);
					self:diffusealpha(1);
					
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					self:diffusealpha(0);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:diffusealpha(0);
					end
				end;
			end;
		end;
		CodeMessageCommand=function(self,params)
			local pn = params.PlayerNumber
			if pn==PLAYER_1 then
				if params.Name=="OpenPanes1"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes3" or params.Name=="OpenPanes2" then
					self:linear(0.15);
					self:diffusealpha(0);
				elseif  params.Name=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:linear(0.15);
						self:diffusealpha(0);
					end
				end;
			end;
			
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
			
			if pn==PLAYER_1 then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes2"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
			
		end;
		CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(1);
			else
				self:zoom(0);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(1);
			else
				self:zoom(0);
			end;
		end;
		OffCommand=cmd(sleep,0.15;linear,0.25;addx,-500);
		
};
t[#t+1] = LoadActor("detailP2")..{
		InitCommand=cmd(player,PLAYER_2;diffusealpha,0.9;draworder,0;zoom,1);
		OnCommand=function(self)
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				local PlayerUID = PROFILEMAN:GetProfile(PLAYER_2):GetGUID();
				if ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes1" then
					(cmd(addx,500;sleep,0.5;decelerate,0.5;addx,-500))(self);
					self:linear(0.5);
					self:diffusealpha(1);
					
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes3" or ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="ClosePanes" then
					self:diffusealpha(0);
				elseif ReadOrCreatePaneControlForPlayerSide(PlayerUID)=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:diffusealpha(0);
					end
				end;
			end;
		end;
		CodeMessageCommand=function(self,params)
			local pn = params.PlayerNumber
			if pn==PLAYER_2 then
				if params.Name=="OpenPanes1"then
					self:linear(0.15);
					self:diffusealpha(1);
				elseif params.Name=="ClosePanes" or params.Name=="OpenPanes3" then
					self:linear(0.15);
					self:diffusealpha(0);
				elseif  params.Name=="OpenPanes2" then
					if GAMESTATE:IsCourseMode() == false then
						self:linear(0.15);
						self:diffusealpha(0);
					end
				end;
			end;
			
			local style = GAMESTATE:GetCurrentStyle():GetStyleType()
			local PlayerUID = PROFILEMAN:GetProfile(pn):GetGUID();
			
			if pn==PLAYER_2 then
				if params.Name=="OpenPanes1" then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes2"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="OpenPanes3"then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				elseif params.Name=="ClosePanes" 
				then
					SavePaneControl( PlayerUID, params.Name, "PlayerSide");
				end;
			end;
			
		end;
		
		CurrentSongChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(1);
			else
				self:zoom(0);
			end;
		end;
		CurrentCourseChangedMessageCommand=function(self)
		local song = GAMESTATE:GetCurrentSong()
		local course = GAMESTATE:GetCurrentCourse()
			if song or course then
				self:zoom(1);
			else
				self:zoom(0);
			end;
		end;
		OffCommand=cmd(sleep,0.15;linear,0.25;addx,500);
};

if GAMESTATE:IsCourseMode() == false then

	if GAMESTATE:IsPlayerEnabled(PLAYER_1) then


		--RadarBG
		t[#t+1] = Def.ActorFrame {
			LoadActor("radarbg")..{
				OnCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+60;zoom,0;linear,0.5;zoom,1.5);
				OffCommand=cmd(linear,0.2;zoom,0);
			};
			LoadActor("radarlabels")..{
				OnCommand=cmd(x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+30;zoom,1.5);
				OffCommand=cmd(linear,0.1;zoom,0);
			};
		};
		
		t[#t+1] = LoadActor("radarNumP1")..{
			InitCommand=cmd(diffusealpha,1;draworder,0;x,SCREEN_LEFT+160;y,SCREEN_CENTER_Y+60;zoom,1.5);
			OnCommand=cmd(zoom,0;decelerate,0.5;zoom,0.5);
			CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
				if song then
					self:zoom(0.5);
				else
					self:zoom(0);
				end;
			end;
			OffCommand=cmd(linear,0.1;zoom,0;addx,-1100);
	};

		

	t[#t+1] = StandardDecorationFromFileOptional( "GrooveRadarP1_Default", "GrooveRadarP1_Default" )..{
		OnCommand=function(self)
			self:zoom(1.05);
			self:linear(0.5);
			self:diffusealpha(1);
		end;
		
	};
	end
	if GAMESTATE:IsPlayerEnabled(PLAYER_2) then
		--RadarBG
		t[#t+1] = Def.ActorFrame {
			LoadActor("radarbg")..{
				OnCommand=cmd(x,SCREEN_RIGHT-160;y,SCREEN_CENTER_Y+60;zoom,0;linear,0.5;zoom,1.5);
				OffCommand=cmd(linear,0.2;zoom,0);
			};
			LoadActor("radarlabels")..{
				OnCommand=cmd(x,SCREEN_RIGHT-160;y,SCREEN_CENTER_Y+30;zoom,1.5);
				OffCommand=cmd(linear,0.1;zoom,0);
			};
		};
			t[#t+1] = LoadActor("radarNumP2")..{
			InitCommand=cmd(diffusealpha,1;draworder,0;x,SCREEN_RIGHT-160;y,SCREEN_CENTER_Y+60;zoom,1.5);
			OnCommand=cmd(zoom,0;decelerate,0.5;zoom,0.5);
			CurrentSongChangedMessageCommand=function(self)
			local song = GAMESTATE:GetCurrentSong()
				if song then
					self:zoom(0.5);
				else
					self:zoom(0);
				end;
			end;
			OffCommand=cmd(linear,0.1;zoom,0;addx,1100);
			};
			
		



	t[#t+1] = StandardDecorationFromFileOptional( "GrooveRadarP2_Default", "GrooveRadarP2_Default" )..{
		OnCommand=function(self)
			self:zoom(1.05);
			self:linear(0.5);
			self:diffusealpha(1);
		end;
	};
	end

end;



return t;
