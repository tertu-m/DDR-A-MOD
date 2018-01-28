local t = Def.ActorFrame {};
local function GetEdits( in_Song, in_StepsType )
	if in_Song then
		local sSong = in_Song;
		local sCurrentStyle = GAMESTATE:GetCurrentStyle();
		local sStepsType = in_StepsType;
		local iNumEdits = 0;
		if sSong:HasEdits( sStepsType ) then
			local tAllSteps = sSong:GetAllSteps();
			for i,Step in pairs(tAllSteps) do
				if Step:IsAnEdit() and Step:GetStepsType() == sStepsType then
					iNumEdits = iNumEdits + 1;
				end
			end
			return iNumEdits;
		else
			return iNumEdits;
		end
	else
		return 0;
	end
end;
t[#t+1] = Def.ActorFrame {
	-- LoadActor("_Background");
};
--
for idx,diff in pairs(Difficulty) do
	local sDifficulty = ToEnumShortString( diff );
	local eachHeight = 23;
	local tLocation = {
		Beginner	= eachHeight*0,
		Easy 		= eachHeight*1,
		Medium		= eachHeight*2,
		Hard		= eachHeight*3,
		Challenge	= eachHeight*4,
		Edit 		= eachHeight*5,
	};
	t[#t+1] = Def.ActorFrame {
		SetCommand=function(self)
			local c = self:GetChildren();
			local song = GAMESTATE:GetCurrentSong()
			local bHasStepsTypeAndDifficulty = false;
			local meter = "00";
			if song then
				local st = GAMESTATE:GetCurrentStyle():GetStepsType()
				bHasStepsTypeAndDifficulty = song:HasStepsTypeAndDifficulty( st, diff );
				local steps = song:GetOneSteps( st, diff );
				if steps then
					meter = steps:GetMeter();
					append = ""
				end
			else
				meter=0;
			end
			
		    c.Meter:settextf( "%01d", meter );
			local curDiff1;
			local curDiff2;
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) then 
				 curDiff1 = GAMESTATE:GetCurrentSteps(PLAYER_1):GetDifficulty();
			else
				self:visible(0);
			end
			
			
			
			if bHasStepsTypeAndDifficulty then
				if curDiff1==diff or curDiff2==diff then
					self:playcommand("Show");
				else
					self:playcommand("UnSelect");
					
				end
			else
				self:playcommand("Hide");
			end


		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentTrailP1ChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP1ChangedMessageCommand=cmd(queuecommand,"Set");

		
		Def.Quad {--底圖
			InitCommand=cmd(setsize,170,20;x,28-357;y,tLocation[sDifficulty];diffuse,color("#FFFFFF");diffusealpha,0.8);
		};
		
		LoadActor("cursorborder")..{--選擇的邊框
			ShowCommand=cmd(stoptweening;zoom,1;linear,0.2;diffusealpha,1;);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,28-357;y,tLocation[sDifficulty];shadowlength,0;zoom,1);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0;zoom,1);
		};
		
		LoadActor("cursorglow")..{--選擇的光暈
			ShowCommand=cmd(stoptweening;zoom,1.2;linear,0.2;diffusealpha,1;zoomy,0.78;zoomx,1);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,28-357;y,tLocation[sDifficulty];shadowlength,0;zoom,1;diffuseshift;effectcolor2,color("1,1,1,0.5");effectcolor1,color("1,1,1,1"));
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0;zoom,1.2);
		};
		LoadActor("cursorline")..{
			
			ShowCommand=cmd(stoptweening;zoom,1.2;linear,0.2;diffusealpha,1;zoom,1);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,28-357;y,tLocation[sDifficulty];shadowlength,0;zoom,1;);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0;zoom,1.2);
		};
		LoadActor("StepsDisplay ticks")..{--足圖樣
			Name="Meter";
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,CustomDifficultyToColor( sDifficulty ););
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5"));
			InitCommand=cmd(x,28-377;y,tLocation[sDifficulty];shadowlength,0;zoom,0.4;zoomx,1.5);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,CustomDifficultyToColor( sDifficulty ));
		};
		


		
		LoadFont("_helvetica-compressed 32px") .. { --難度描述
			Name="Meter";
			Text=THEME:GetString("CustomDifficulty",ToEnumShortString(diff));
			ShowCommand=cmd(stoptweening;linear,0.1;;diffuse,color("0,0,0,1");strokecolor, color( "0,0,0,0" );zoomx,0.40);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5" );strokecolor, color( "0.1,0.1,0.1,0.5" );zoomx,0.40);
			InitCommand=cmd(horizalign,left;x,-42-370;y,tLocation[sDifficulty];shadowlength,0;zoomx,0.40;zoomy,0.4);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color("0,0,0,1");strokecolor, color( "0,0,0,0" );zoomx,0.40);
		};

		
		LoadFont("_geo 95 20px") .. { --數字
			Name="Meter";
			Text="0";
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5" );strokecolor, color( "0.1,0.1,0.1,0.5" ));
			InitCommand=cmd(x,28-377;y,tLocation[sDifficulty]-7;shadowlength,1;zoomx,0.75;zoomy,0.8;strokecolor,CustomDifficultyToDarkColor(sDifficulty));
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,1.1;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
		};
		

		OffCommand=cmd(linear,0.25;addx,-100;);
	};
	t[#t+1] = Def.ActorFrame {
		SetCommand=function(self)
			local c = self:GetChildren();
			local song = GAMESTATE:GetCurrentSong()
			local bHasStepsTypeAndDifficulty = false;
			
			local meter = "00";
			if song then
				local st = GAMESTATE:GetCurrentStyle():GetStepsType()
				bHasStepsTypeAndDifficulty = song:HasStepsTypeAndDifficulty( st, diff );
				local steps = song:GetOneSteps( st, diff );
				if steps then
					meter = steps:GetMeter();
					append = ""
				end
			else
				meter="00";
			end
			
		    c.Meter:settextf( "%01d", meter );
			--c.Only1Meter:settextf( "%01d", meter );
			--c.Meter:settext(meter );
			local curDiff1;
			local curDiff2;
			
			if GAMESTATE:IsPlayerEnabled(PLAYER_2) then 
				curDiff2 = GAMESTATE:GetCurrentSteps(PLAYER_2):GetDifficulty();
			else
				self:visible(0);
			end
			
			
			if bHasStepsTypeAndDifficulty then
				if curDiff1==diff or curDiff2==diff then
					self:playcommand("Show");
				else
					self:playcommand("UnSelect");
				end
			else
				self:playcommand("Hide");
			end

		end;
		CurrentSongChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentTrailP2ChangedMessageCommand=cmd(queuecommand,"Set");
		CurrentStepsP2ChangedMessageCommand=cmd(queuecommand,"Set");

		
		--底圖
		Def.Quad {
		InitCommand=cmd(setsize,170,20;x,-28+357;y,tLocation[sDifficulty];diffuse,color("#FFFFFF");diffusealpha,0.8);
		};
		--足圖樣
		LoadActor("StepsDisplay ticks")..{
			Name="Meter";
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,CustomDifficultyToColor( sDifficulty ););
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5"));
			InitCommand=cmd(x,-28+377;y,tLocation[sDifficulty];shadowlength,0;zoom,0.4;zoomx,1.5);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,CustomDifficultyToColor( sDifficulty ));
		};
		--選擇的邊框
		LoadActor("cursorborder")..{
			ShowCommand=cmd(stoptweening;zoom,1;linear,0.2;diffusealpha,1;zoomx,1);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,-28+357;y,tLocation[sDifficulty];shadowlength,0;zoom,1;);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0;zoom,1);
		};
		--選擇的光暈
		LoadActor("cursorglow")..{
			
			ShowCommand=cmd(stoptweening;zoom,1.2;linear,0.2;diffusealpha,1;zoomy,0.78;zoomx,1);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,-28+357;y,tLocation[sDifficulty];shadowlength,0;zoom,1;diffuseshift;effectcolor2,color("1,1,1,0.5");effectcolor1,color("1,1,1,1"));
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;diffusealpha,0;zoom,1.2);
		};
		
		LoadActor("cursorline")..{
			
			ShowCommand=cmd(stoptweening;zoom,1.2;linear,0.2;diffusealpha,1;zoom,1);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0);
			InitCommand=cmd(x,-28+357;y,tLocation[sDifficulty];shadowlength,0;zoom,1;);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffusealpha,0;zoom,1.2);
		};
		
		--選擇中足圖樣
		LoadActor("StepsDisplay ticks")..{
			Name="Meter";
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,CustomDifficultyToColor( sDifficulty );zoomx,2.5);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5");zoomx,0);
			InitCommand=cmd(x,13-99410;y,tLocation[sDifficulty];shadowlength,0;zoomy,0.45;zoomx,2.5);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,CustomDifficultyToColor( sDifficulty );zoomx,0);
		};

		--難度描述
		LoadFont("_helvetica-compressed 32px") .. {
			Name="Meter";
			Text=THEME:GetString("CustomDifficulty",ToEnumShortString(diff));
			--ShowCommand=cmd(stoptweening;linear,0.1;diffuse,CustomDifficultyToColor( sDifficulty );strokecolor,CustomDifficultyToDarkColor(sDifficulty);zoomx,0.40);
			ShowCommand=cmd(stoptweening;linear,0.1;;diffuse,color("0,0,0,1");strokecolor, color( "0,0,0,0" );zoomx,0.40);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5" );strokecolor, color( "0.1,0.1,0.1,0.5" );zoomx,0.40);
			InitCommand=cmd(horizalign,right;x,42+370;y,tLocation[sDifficulty];shadowlength,0;zoomx,0.40;zoomy,0.4);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color("0,0,0,1");strokecolor, color( "0,0,0,0" );zoomx,0.40);
		};

		--數字
		LoadFont("_geo 95 20px") .. {
			Name="Meter";
			Text="0"; --(sDifficulty == "Edit") and "0 Edits" or "0";
			--ShowCommand=cmd(stoptweening;linear,0.1;diffuse,color( "1,1,1,1" );strokecolor,CustomDifficultyToDarkColor(sDifficulty));
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0.5" );strokecolor, color( "0.1,0.1,0.1,0.5" ));
			InitCommand=cmd(x,-28+377;y,tLocation[sDifficulty]-7;shadowlength,1;zoomx,0.75;zoomy,0.8;strokecolor,CustomDifficultyToDarkColor(sDifficulty));
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,1.1;diffuse,color( "1,1,1,1" );strokecolor, color( "0,0,0,1" ));
		};
		
		LoadFont("common normal") .. {--only 1 難度描述
			Name="Diff";
			Text=THEME:GetString("CustomDifficulty",ToEnumShortString(diff));
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,CustomDifficultyToColor( sDifficulty );shadowlength,1;zoomx,1.25);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0" );strokecolor, color( "0.1,0.1,0.1,0" );zoomx,1.20);
			InitCommand=cmd(x,99230;y,0;shadowlength,1;zoomx,1.20;zoomy,1.2;);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,1.1;diffuse,color( "0.52,0.52,0.52,0" );strokecolor, color( "0.15,0.15,0.15,0" );zoomx,1.20);
		};
		
		LoadFont("common normal") .. {--only 1 數字
			Name="Only1Meter";
			Text="0"; --(sDifficulty == "Edit") and "0 Edits" or "0";
			ShowCommand=cmd(stoptweening;linear,0.1;diffuse,color( "0,0,0,1" );shadowlength,1.1;);
			HideCommand=cmd(stoptweening;decelerate,0.2;shadowlength,0;diffuse,color( "0.5,0.5,0.5,0" );strokecolor, color( "0.1,0.1,0.1,0" ));
			InitCommand=cmd(x,99230;y,80;shadowlength,1;zoomx,0.95;zoomy,0.95;shadowlength,1.1;);
			UnSelectCommand=cmd(stoptweening;decelerate,0.2;shadowlength,1.1;diffuse,color( "0.70,0.70,0.70,0" );strokecolor, color( "0.15,0.15,0.15,0" ));
		};
		OffCommand=cmd(linear,0.25;addx,100;);
	};
	
end
return t