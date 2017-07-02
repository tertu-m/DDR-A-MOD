-- This variable was passed in to this file (actor) from the parent default.lua
local player = ...

local t = Def.ActorFrame {
}
local difficulties = {"Beginner", "Easy", "Medium", "Hard", "Challenge", "Edit"}

local function GetDifListX(self,offset)
        if player==PLAYER_1 then
                self:x(50+offset)
        elseif player==PLAYER_2 then
                self:x(_screen.w-320+offset)
        end
end

local function DrawDifListItem(diff)
 
        local DifficultyListItem = Def.ActorFrame {
 
                InitCommand=cmd(y, _screen.cy-225 ),
                CurrentSongChangedMessageCommand=cmd(playcommand,"Set"),
                CurrentStepsP1ChangedMessageCommand=function(self) if player == PLAYER_1 then self:playcommand("Set") end end,
                CurrentStepsP2ChangedMessageCommand=function(self) if player == PLAYER_2 then self:playcommand("Set") end end,
                CurrentTrailP1ChangedMessageCommand=function(self) if player == PLAYER_1 then self:playcommand("Set") end end,
                CurrentTrailP2ChangedMessageCommand=function(self) if player == PLAYER_2 then self:playcommand("Set") end end,
                CurrentCourseChangedMessageCommand=cmd(playcommand,"Set"),
				OffCommand=function(self)
					if player == PLAYER_1 then
						(cmd(sleep,0.15; linear,0.25; addx,-500))(self);
					elseif player == PLAYER_2 then
						(cmd(sleep,0.15; linear,0.25; addx,500))(self);
					end;
				end;
               
                --disabled
                -- Def.Quad{
                        -- InitCommand=cmd(diffuse,color("#000000");setsize,490,50;zoom,0.7),
                        -- SetCommand=function(self)
 
                                -- local st=GAMESTATE:GetCurrentStyle():GetStepsType()
                                -- local song=GAMESTATE:GetCurrentSong()
                                -- local course = GAMESTATE:GetCurrentCourse()
 
                                -- if song then
                                        -- GetDifListX(self, 35)
                                       
                                        -- self:y( Difficulty:Reverse()[diff] * 34.5 + 1.5 )
 
                                        -- if song:HasStepsTypeAndDifficulty(st,diff) then
                                                -- self:diffusealpha(0)
                                        -- else
                                                -- self:diffusealpha(0.3)
                                        -- end
								-- else
									-- self:diffusealpha(0.3)
                                -- end
                        -- end
                -- },
 
                --meter
                -- LoadFont("Common Normal")..{
                        -- InitCommand=cmd(draworder,99; diffuse,color("#000000"); strokecolor,Color.White; zoom,0.9),
                        -- SetCommand=function(self)
                                -- self:settext("")
                                -- local st=GAMESTATE:GetCurrentStyle():GetStepsType()
                                -- local song=GAMESTATE:GetCurrentSong()
 
                                -- if song then
                                        -- GetDifListX(self, -119)
                                        -- self:y( Difficulty:Reverse()[diff] * 23 )                                      
 
                                        -- if song:HasStepsTypeAndDifficulty( st, diff ) then
                                                -- local steps = song:GetOneSteps( st, diff )
                                                -- self:settext( steps:GetMeter() )
                                        -- end
                                -- end
                        -- end
                -- },
 
 
                --score number
                Def.RollingNumbers {
						--File = THEME:GetPathF("_itc machine std", "20px");
						File = THEME:GetPathF("common", "normal");
                        InitCommand=cmd(zoom,0.7;draworder,5);
                        BeginCommand=cmd(playcommand,"Set");
                        OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
                        SetCommand=function(self)
                                self:settext("")
                               
                                local st=GAMESTATE:GetCurrentStyle():GetStepsType()
                                local song=GAMESTATE:GetCurrentSong()
                                local course = GAMESTATE:GetCurrentCourse()
 
                                if song then
                                        GetDifListX(self, 140)
                                        self:y( (Difficulty:Reverse()[diff]) * 34.5+0)-- -7)
 
                                        if song:HasStepsTypeAndDifficulty(st,diff) then
 
                                                local steps = song:GetOneSteps( st, diff )
 
                                                if PROFILEMAN:IsPersistentProfile(player) then
                                                        profile = PROFILEMAN:GetProfile(player)
                                                else
                                                        profile = PROFILEMAN:GetMachineProfile()
                                                end
 
                                                scorelist = profile:GetHighScoreList(song,steps)
                                                local scores = scorelist:GetHighScores()
                                                local topscore=0
 
                                                if scores[1] then
                                                        topscore = scores[1]:GetScore()
                                                end
 
                                                self:diffuse(color("0,0,0,1"))
                                                --self:strokecolor(color("1,1,1,1"))
                                                self:diffusealpha(1)
                                                --self:shadowlength(2)
 
                                                if topscore ~= 0  then
                                                    self:Load("RollingNumbersSongData");
													self:targetnumber(topscore);
                                                end
                                        end
                                end
                        end
                },
 
 
                --grade
                Def.Quad{
                        InitCommand=cmd(shadowlength,2;zoom,0.3;draworder,5),
                        BeginCommand=cmd(playcommand,"Set"),
                        OffCommand=cmd(decelerate,0.05;diffusealpha,0;),
                        SetCommand=function(self)
 
                                local st=GAMESTATE:GetCurrentStyle():GetStepsType()
                                local song=GAMESTATE:GetCurrentSong()
                                local course = GAMESTATE:GetCurrentCourse()
 
                                if song then
										if player==PLAYER_1 then
											GetDifListX(self,259)
										else
											GetDifListX(self,125)
										end
                                        self:y( (Difficulty:Reverse()[diff]) * 34.5)
 
                                        if song:HasStepsTypeAndDifficulty(st,diff) then
 
                                                local steps = song:GetOneSteps( st, diff )
 
                                                if PROFILEMAN:IsPersistentProfile(player) then
                                                        profile = PROFILEMAN:GetProfile(player)
                                                else
                                                        profile = PROFILEMAN:GetMachineProfile()
                                                end
 
                                                scorelist = profile:GetHighScoreList(song,steps)
                                                local scores = scorelist:GetHighScores()
 
                                                local topscore=0
                                                if scores[1] then
                                                        topscore = scores[1]:GetScore()
                                                end
 
                                                local topgrade
                                                local temp=#scores;
												if scores[1] then
													for i=1,temp do 
														topgrade = scores[1]:GetGrade();
														curgrade = scores[i]:GetGrade();
														assert(topgrade);
														if scores[1]:GetScore()>1  then
															if scores[1]:GetScore()==1000000 and scores[1]:GetGrade() =="Grade_Tier07" then --AutoPlayHack
																self:LoadBackground(THEME:GetPathG("myMusicWheel","Tier01"));
																self:diffusealpha(1);
																break;
															else --Normal
																if ToEnumShortString(curgrade) ~= "Failed" then --current Rank is not Failed
																	self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
																	self:diffusealpha(1);
																	break;
																else --current Rank is Failed
																	if i == temp then
																		self:LoadBackground(THEME:GetPathG("myMusicWheel",ToEnumShortString(curgrade)));
																		self:diffusealpha(1);
																		break;
																	end;
																end;
															end;
														else
															self:diffusealpha(0);
														end;
													end;
												else
													self:diffusealpha(0);
												end;
                                        else
                                                self:diffusealpha(0);
                                        end;
                                else
                                        self:diffusealpha(0);
                                end
								self:addx(-60);
                        end
                };
 
 
                --FC Ring
                LoadActor(THEME:GetPathG("Player","Badge FullCombo"))..{
                        InitCommand=cmd(shadowlength,2;zoom,0;draworder,5);
                        BeginCommand=cmd(playcommand,"Set");
                        OffCommand=cmd(decelerate,0.05;diffusealpha,0;);
                        SetCommand=function(self)
                                local st=GAMESTATE:GetCurrentStyle():GetStepsType();
                                local song=GAMESTATE:GetCurrentSong();
                                local course = GAMESTATE:GetCurrentCourse();
                        if song then
                                if player==PLAYER_1 then
									GetDifListX(self,249)
								else
									GetDifListX(self,115)
								end
                                self:y( (Difficulty:Reverse()[diff]) * 34.5 - 8 );
                                if song:HasStepsTypeAndDifficulty(st,diff) then
                                        local steps = song:GetOneSteps( st, diff );
                                        if PROFILEMAN:IsPersistentProfile(player) then
                                                profile = PROFILEMAN:GetProfile(player);
                                        else
                                                profile = PROFILEMAN:GetMachineProfile();
                                        end;
                                        scorelist = profile:GetHighScoreList(song,steps);
                                        assert(scorelist);
                                        local scores = scorelist:GetHighScores();
                                        assert(scores);
                                        local topscore;
										local temp=#scores;
                                        if scores[1] then
											self:addx(-31);
											self:addy(13.5);
											for i=1,temp do 
												if scores[i] then
													topscore = scores[i];
													assert(topscore);
													local misses = topscore:GetTapNoteScore("TapNoteScore_Miss")+topscore:GetTapNoteScore("TapNoteScore_CheckpointMiss")
												+topscore:GetTapNoteScore("TapNoteScore_HitMine")+topscore:GetHoldNoteScore("HoldNoteScore_LetGo")
													local boos = topscore:GetTapNoteScore("TapNoteScore_W5")
													local goods = topscore:GetTapNoteScore("TapNoteScore_W4")
													local greats = topscore:GetTapNoteScore("TapNoteScore_W3")
													local perfects = topscore:GetTapNoteScore("TapNoteScore_W2")
													local marvelous = topscore:GetTapNoteScore("TapNoteScore_W1")
													local hasUsedLittle = string.find(topscore:GetModifiers(),"Little")
													if (misses+boos) == 0 and scores[1]:GetScore() > 0 and (marvelous+perfects)>0 and (not hasUsedLittle) then
															if (greats+perfects) == 0 then
																	self:diffuse(GameColor.Judgment["JudgmentLine_W1"]);
																	self:glowblink();
																	self:effectperiod(0.20);
																	self:zoom(0.25);
																	break;
															elseif greats == 0 then
																	self:diffuse(GameColor.Judgment["JudgmentLine_W2"]);
																	--self:glowshift();
																	self:zoom(0.25);
																	break;
															elseif (misses+boos+goods) == 0 then
																	self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],0.75));
																	self:stopeffect();
																	self:zoom(0.25);
																	if i==1 then
																		self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W3"],1));
																	end;
																	break;
															elseif (misses+boos) == 0 then
																	self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],0.75));
																	self:stopeffect();
																	self:zoom(0.25);
																	if i==1 then
																		self:diffuse(BoostColor(GameColor.Judgment["JudgmentLine_W4"],1));
																	end;
																	break;
															end;
															self:diffusealpha(0.8);
													else
															self:diffusealpha(0);
													end;
												else
													self:diffusealpha(0);
													break;
												end;
											end;
                                        else
                                                self:diffusealpha(0);
                                        end;
                                else
                                        self:diffusealpha(0);
                                end;
						else
                            self:diffusealpha(0);   
                        end;
                end
                }
				
        }
 
        return DifficultyListItem
end

for difficulty in ivalues(difficulties) do
     t[#t+1] = DrawDifListItem("Difficulty_" .. difficulty);
end

return t
