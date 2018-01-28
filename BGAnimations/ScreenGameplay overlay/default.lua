local t = Def.ActorFrame{};

--Life Meter Hot effect and Danger word.
t[#t+1] = LoadActor("LifeMeterHotDangerOverlay");
t[#t+1] = LoadActor("ExScoreTitle");
-- Full combo
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
	t[#t+1] = LoadActor("FullCombo", pn) .. {
	};
end;

t[#t+1] = LoadActor("OniGameOverDisplay");


return t;