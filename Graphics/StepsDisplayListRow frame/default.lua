local t = Def.ActorFrame{
	InitCommand=cmd(draworder,30);
	LoadActor("back")..{
		InitCommand=cmd(horizalign,center;vertalign,middle;diffusealpha,0.25;blend,'BlendMode_Subtract');
	};
	Def.ActorFrame {
		InitCommand=cmd(diffuseshift;effectcolor1,1,1,1,0.9;effectcolor2,1,1,1,1;effectclock,"beat");
		LoadActor("light")..{
			InitCommand=cmd(horizalign,center;vertalign,middle;blend,'BlendMode_Add');
			SetCommand=function(self,param)
				if param.CustomDifficulty and param.CustomDifficulty ~= "" then
					self:diffuse(CustomDifficultyToColor(param.CustomDifficulty) );
				else
					self:diffuse(color('1,1,1,1'));
				end;
			end;
		};
	};
};

return t;
