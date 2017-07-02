local t = Def.ActorFrame{};

--Hacky way to get the transition.
t[#t+1] = Def.ActorFrame {
	LoadActor("_normal_door_close");
};

return t
