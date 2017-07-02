local t = Def.ActorFrame {}
 t[#t+1] = LoadActor( THEME:GetPathG("","_shigu") )..{
		InitCommand=cmd(x,SCREEN_RIGHT-150;y,SCREEN_BOTTOM-75;zoom,0.9;diffusealpha,0);
		StartTransitioningCommand=cmd(decelerate,0.1;diffusealpha,1;sleep,0.6;addx,20;sleep,0.04;addx,30;sleep,0.04;addx,45;sleep,0.04;addx,60;sleep,0.04;addx,80;);
	};
	-- LoadActor( THEME:GetPathS("", "_toasty") ) .. {
		-- StartTransitioningCommand = cmd(play);
	-- };


if FILEMAN:DoesFileExist("Themes/Tosty_Cut_In/default.lua") then
 t[#t+1] = LoadActor("../../Tosty_Cut_In")..{
	StartTransitioningCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
	CurrentSongChangedMessageCommand=function(self)
	local song = GAMESTATE:GetCurrentSong();
	if song then
		if GAMESTATE:PlayerIsUsingModifier(PLAYER_1,'StaticBG') or GAMESTATE:PlayerIsUsingModifier(PLAYER_2,'StaticBG') or song:HasBGChanges() then
		self:diffusealpha(0);
		else
		self:diffusealpha(1);
		end;
		end;
	end;
 }
end;


return t
