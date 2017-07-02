local t = Def.ActorFrame{};

--Life Meter Hot effect and Danger word.
t[#t+1] = LoadActor("LifeMeterHotDangerOverlay");

-- Full combo
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("FullCombo", pn) .. {
	};
end;


return t;