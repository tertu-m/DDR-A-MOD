-- This actor is duplicated.  Upvalues will not be duplicated.

local grades = {
	Grade_Tier01 = 0;
	Grade_Tier02 = 1;
	Grade_Tier03 = 2;
	Grade_Tier04 = 3;
	Grade_Tier05 = 4;
	Grade_Tier06 = 5;
	Grade_Tier07 = 6;
	Grade_Failed = 7;
	Grade_None = 8;
};
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
--[[ local t = LoadActor( "grades" ) .. {
	InitCommand=cmd(pause);
	SetGradeCommand=function(self, params)
		local state = grades[params.Grade] or grades.Grade_None;
		state = state*2;

		if params.PlayerNumber == PLAYER_2 then
			state = state+1;
		end

		self:setstate(state);
	end;
}; --]]



-- local t = LoadFont("Common Normal") .. {
	-- InitCommand=cmd(zoom,0.75;shadowlength,1;strokecolor,Color("Black"));
	-- ShowCommand=cmd(stoptweening;bounceend,0.15;zoomy,0.75);
	-- HideCommand=cmd(stoptweening;bouncebegin,0.15;zoomy,0);
	-- SetGradeCommand=function(self,params)
		-- local pnPlayer = params.PlayerNumber;
		-- local sGrade = params.Grade or 'Grade_None';
		-- local gradeString = THEME:GetString("Grade",string.sub(sGrade,7));
		
		
		-- self:settext(gradeString);
		-- self:diffuse(PlayerColor(pnPlayer));
		-- self:diffusetopedge(BoostColor(PlayerColor(pnPlayer),1.5));
		-- self:strokecolor(BoostColor(PlayerColor(pnPlayer),0.25));
--[[ 		if sGrade == "Grade_NoTier" then
			-- self:playcommand("Hide");
		-- else
			-- self:playcommand("Show");
		-- end; --]]
	-- end;
-- };


local t = Def.ActorFrame {
	-- Def.Quad  {
		-- InitCommand=cmd(zoomto,30,30;;shadowlength,0);
		-- ShowCommand=cmd(stoptweening;zoomy,0.75);
		-- HideCommand=cmd(stoptweening;zoomy,0.55);
		-- OnCommand=function(self,params)
			-- local pnPlayer = params.PlayerNumber;
			-- local sGrade = params.Grade or 'Grade_None';
			-- (cmd(diffuse,PlayerColor(PLAYER_1);diffusealpha,0;linear,0.35;diffusealpha,1))(self);
			

		-- end;
	-- };

	Def.Quad  {
		InitCommand=cmd(scaletoclipped,250,248;shadowlength,0;y,-1;x,10000);
		SetGradeCommand=function(self,params)
			
			local pnPlayer = params.PlayerNumber;
			local sGrade = params.Grade or 'Grade_None';
			local gradeString = THEME:GetString("Grade",string.sub(sGrade,7));
			
			self:LoadBackground(THEME:GetPathG("myMusicWheelGrade",ToEnumShortString(sGrade)));
			
			if sGrade == 'Grade_Tier01' then
				self:glowshift();
				self:effectperiod(0.02);
			else
				self:stopeffect();
			end
			-- self:diffusetopedge(BoostColor(PlayerColor(pnPlayer),1.5));
			-- self:diffusebottomedge(BoostColor(PlayerColor(pnPlayer),1.1));

			--self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(sGrade)));
			--self:diffusetopedge(BoostColor(PlayerColor(pnPlayer),1.5));
			if GAMESTATE:IsPlayerEnabled(PLAYER_1) and GAMESTATE:IsPlayerEnabled(PLAYER_2) then
				if pnPlayer == PLAYER_1 then
					self:cropright(0.5);
				else
					self:cropleft(0.5);
				end
			else
			--self:cropright(0.5);
			end
			--arrangeXPosition(self,params.Index);
		end;
	};
	

};

-- local t = Def.Quad{
			-- InitCommand=cmd(shadowlength,1;zoom,0.25;);
			-- OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
			-- SetGradeCommand=function(self)
				-- local pnPlayer = params.PlayerNumber;
				-- local sGrade = params.Grade or 'Grade_None';
				-- local gradeString = THEME:GetString("Grade",string.sub(sGrade,7));
				-- self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(sGrade)));
				-- self:diffusealpha(1);
			
			-- end;
	-- };

return t;

-- (c) 2007 Glenn Maynard
-- All rights reserved.
-- 
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, and/or sell copies of the Software, and to permit persons to
-- whom the Software is furnished to do so, provided that the above
-- copyright notice(s) and this permission notice appear in all copies of
-- the Software and that both the above copyright notice(s) and this
-- permission notice appear in supporting documentation.
-- 
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF
-- THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS
-- INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT
-- OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
-- OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
-- OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
-- PERFORMANCE OF THIS SOFTWARE.
