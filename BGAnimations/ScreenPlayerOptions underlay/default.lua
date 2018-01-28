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
		
		OnCommand=cmd(x,SCREEN_CENTER_X;y,SCREEN_CENTER_Y;diffuse,color("0,0,0,1");diffusealpha,0.0;linear,0.1;diffusealpha,0.75;);
		OffCommand=cmd(sleep,0.2;linear,0.1;diffusealpha,0.0;);
	};
	--p1
	LoadActor( "Back" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-243-134+30;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addy,-120;linear,0.15;addy,120);
		OffCommand=cmd(linear,0.15;addy,-120);
	};
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-243-154+40-3;y,SCREEN_BOTTOM-100-80+50);
		OnCommand=cmd(addy,200;linear,0.15;addy,-200);
		OffCommand=cmd(linear,0.15;addy,200);
	};
	--p2
	LoadActor( "Back" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+243+154-50;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addy,-120;linear,0.15;addy,120);
		OffCommand=cmd(linear,0.15;addy,-120);
	};
	LoadActor( "Explanation" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+243+154-50+3;y,SCREEN_BOTTOM-100-80+50);
		OnCommand=cmd(addy,200;linear,0.15;addy,-200);
		OffCommand=cmd(linear,0.15;addy,200);
	};
	--p1
	LoadActor( "OptionsLabels" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-310-100+166-134+30;y,SCREEN_CENTER_Y-50;draworder,1);
		OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		OffCommand=cmd(linear,0.15;addx,-500);
	};
	--p1
	-- LoadActor( "OptionsPage" )..{
		-- InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_1);x,SCREEN_CENTER_X-310+164-164+50-2;y,SCREEN_CENTER_Y-50);
		-- OnCommand=cmd(addx,-400;linear,0.15;addx,400);
		-- OffCommand=cmd(linear,0.15;addx,-700);
	-- };
	--p2
	LoadActor( "OptionsLabels" )..{
		InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+310+100-166+164-50;y,SCREEN_CENTER_Y-50;draworder,1);
		OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		OffCommand=cmd(linear,0.15;addx,500);
	};
	--p2
	-- LoadActor( "OptionsPage" )..{
		-- InitCommand=cmd(visible,GAMESTATE:IsHumanPlayer(PLAYER_2);x,SCREEN_CENTER_X+310-164+164-50+210-20+10-2;y,SCREEN_CENTER_Y-50);
		-- OnCommand=cmd(addx,400;linear,0.15;addx,-400);
		-- OffCommand=cmd(linear,0.15;addx,700);
	-- };
		LoadActor( THEME:GetPathS("common", "start") ).. {
		OnCommand=cmd(play);
	};
	LoadActor( "../_swoosh_out" ).. {
		OffCommand=cmd(play);
	}
}