local t = Def.ActorFrame {};


t[#t+1] = LoadActor("judgment");

if ThemePrefs.Get("Fast") == true then
	t[#t+1] = LoadActor("timingbg");
end

return t;
