return Def.ActorFrame {
	LoadActor( "bg" ) .. {
		InitCommand=cmd(x,0;y,0;zoom,0.75);
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MUSIC' or Screen.String("HeaderText") == 'SELECT COURSE' then
				self:diffusealpha(0);
			else
				self:diffusealpha(1);
			end
			(cmd(addy,-52;sleep,0.2;decelerate,0.0833;addy,52))(self);
		end;
		OffCommand=cmd(finishtweening;sleep,0.2;decelerate,0.0833;addy,-52);
	};

	LoadFont("_compacta blk bt 14px") .. {
		Name="HeaderText";
		Text=Screen.String("HeaderText");

		InitCommand=cmd(x,0;y,-38;zoomx,2.5;zoomy,1.7;shadowlength,0;diffuse,1,1,1,1;strokecolor,Color("White"););
		--OnCommand=cmd(skewx,-0.125;strokecolor,Color("Outline");diffusebottomedge,color("0.875,0.875,0.875"));
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MUSIC' or Screen.String("HeaderText") == 'SELECT COURSE' then
				self:diffusealpha(0);
			else
				self:diffusealpha(1);
			end
			if Screen.String("HeaderText") == 'RESULTS' then
				self:x(-100);
			end
			if Screen.String("HeaderText") == 'SELECT COURSE MODE' then
				self:zoomx(2);
			end
			(cmd(sleep,0.2;linear,0.0833;y,3))(self);
		end;
		OffCommand=cmd(linear,0.2;y,-38);
		UpdateScreenHeaderMessageCommand=function(self,param)
			self:settext(param.Header);
		end;
	};

	LoadFont("_compacta blk bt 14px") .. {
		Name="HeaderText";
		Text=Screen.String("HeaderText");

		InitCommand=cmd(x,-550;y,10;zoomx,0.9;zoomy,1.0;shadowlength,0;maxwidth,110;diffuse,1,1,1,1;strokecolor,Color("White"););
		--OnCommand=cmd(skewx,-0.125;strokecolor,Color("Outline");diffusebottomedge,color("0.875,0.875,0.875"));
		OnCommand=function(self)
			if Screen.String("HeaderText") == 'SELECT MUSIC' or Screen.String("HeaderText") == 'SELECT COURSE' then
				self:diffusealpha(1);
			else
				self:diffusealpha(0);
			end
			(cmd(linear,0.3;y,18))(self);
		end;
		OffCommand=cmd(linear,0.3;y,-38);
		UpdateScreenHeaderMessageCommand=function(self,param)
			self:settext(param.Header);
		end;
	};
}
