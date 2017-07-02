return Def.ActorFrame {
		-- Def.ActorFrame {
			-- LoadActor( "../CourseModeBG" )..{
				-- InitCommand=cmd();
				-- OnCommand=function(self)
					-- if GAMESTATE:IsCourseMode() then	
						-- (cmd(visible,1))(self);
					-- else
						-- (cmd(visible,0))(self);
					-- end;
				-- end;
			-- };
		-- };
			Def.Quad {
		InitCommand=cmd(scaletoclipped,SCREEN_WIDTH+1,SCREEN_HEIGHT);
		
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("0,0,0,1");diffusealpha,0.0;linear,0.1;diffusealpha,0.65;);
		OffCommand=cmd(sleep,0.2;linear,0.1;diffusealpha,0.0;);
	};
	--p1
	LoadActor( "Back" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-243-164+50;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		OffCommand=cmd(linear,0.15;addx,-700);
	};
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-243-164+50-3;y,SCREEN_BOTTOM-100-80+50);
		OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		OffCommand=cmd(linear,0.15;addx,-700);
	};
	--p2
	LoadActor( "Back" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);rotationy,180;x,SCREEN_CENTER_X+243+164-50;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		OffCommand=cmd(linear,0.15;addx,700);
	};
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+243+164-50+3;y,SCREEN_BOTTOM-100-80+50);
		OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		OffCommand=cmd(linear,0.15;addx,700);
	};
	--p1
	LoadActor( "OptionsLabels" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-310-220+166-164+50;y,SCREEN_CENTER_Y-50;draworder,1);
		OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		OffCommand=cmd(linear,0.15;addx,-700);
	};
	--p1
	LoadActor( "OptionsPage" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-310+164-164+50-2;y,SCREEN_CENTER_Y-50);
		OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		OffCommand=cmd(linear,0.15;addx,-700);
	};
	--p2
	LoadActor( "OptionsLabels" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+310+220-166+164-50-210-30+5;y,SCREEN_CENTER_Y-50;draworder,1);
		OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		OffCommand=cmd(linear,0.15;addx,700);
	};
	--p2
	LoadActor( "OptionsPage" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+310-164+164-50+210-20+10-2;y,SCREEN_CENTER_Y-50);
		OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		OffCommand=cmd(linear,0.15;addx,700);
	};
		LoadActor( THEME:GetPathS("common", "start") ).. {
		OnCommand=cmd(play);
	};
	LoadActor( "../_swoosh_out" ).. {
		OffCommand=cmd(play);
	}
}