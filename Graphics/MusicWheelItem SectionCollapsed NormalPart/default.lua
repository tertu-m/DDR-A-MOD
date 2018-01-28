local t = Def.ActorFrame {
	SetMessageCommand=function(self,params)
		self:zoom(params.HasFocus and 3 or 2.5);
	end;

 	LoadActor( 'normal' ) .. {
		InitCommand=cmd(y,-8);
	};
	LoadActor( 'normal' ) .. {
		InitCommand=cmd(y,-8;diffusecolor,Color('Yellow');blend,Blend.Add;diffusealpha,0.5;thump;effectclock,'beat';effectmagnitude,1,1.05,1;effectoffset,0.35);
		SetMessageCommand=function(self,params)
			if params.Index ~= nil then
				self:visible(params.HasFocus);
			end
		end;
	};
	LoadActor( 'bright' ) .. {
		InitCommand=cmd(y,-8;diffuseshift;effectcolor1,1,1,1,1;effectcolor2,1,1,1,0.5;effectclock,'beatnooffset');
		SetMessageCommand=function(self,params)
			if params.Index ~= nil then
				self:visible(params.HasFocus);
			end
		end;
	};
	LoadFont( '_dfphsgothic-w9 28px' ) .. {
		InitCommand=cmd(zoom,0.5;maxwidth,320);
		SetCommand=function(self,params)
			self:stoptweening();
			if params.Text == '' then
				self:settextf( '%s', "RANDOM SELECT MUSIC");
			elseif GAMESTATE:GetSortOrder() == 'SortOrder_Group' then
				if string.find(params.Text, '-' ) then
					local start = string.find(params.Text, '-' );
					self:settextf( '%s',string.sub(params.Text,start+2));
				else
					self:settextf( '%s',params.Text);
				end
			elseif GAMESTATE:GetSortOrder() == 'SortOrder_TopGrades' then
				if string.find(params.Text, 'AAAA' ) then
					local start = string.find(params.Text, 'AAAA' );
					self:settextf( 'AAA ' .. '%s',string.sub(params.Text,start+5));
				elseif string.find(params.Text, 'AAA' ) then
					local start = string.find(params.Text, 'AAA' );
					self:settextf( 'AA ' .. '%s',string.sub(params.Text,start+4));
				elseif string.find(params.Text, 'AA' ) then
					local start = string.find(params.Text, 'AA' );
					self:settextf( 'A ' .. '%s',string.sub(params.Text,start+3));
				elseif string.find(params.Text, 'A' ) then
					local start = string.find(params.Text, 'A' );
					self:settextf( 'B ' .. '%s',string.sub(params.Text,start+2));
				elseif string.find(params.Text, 'B' )then
					local start = string.find(params.Text, 'B' );
					self:settextf( 'C ' .. '%s',string.sub(params.Text,start+2));
				elseif string.find(params.Text, 'C' )then
					local start = string.find(params.Text, 'C' );
					self:settextf( 'D ' .. '%s',string.sub(params.Text,start+2));
				elseif string.find(params.Text, 'D' )then
					local start = string.find(params.Text, 'D' );
					self:settextf( 'E ' .. '%s',string.sub(params.Text,start+2));
				else
					self:settextf( '%s',params.Text);
				end
			else
				self:settextf( '%s',params.Text);
			end
		end;
	};
};

return t
