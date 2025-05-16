function RewardTotal = CalculateCumulativeRewardAuditorySpatialSchema()
global BpodSystem

TrialData = BpodSystem.Data.Custom.TrialData;
RewardTotal = 0;

SideRewardTrials = TrialData.Rewarded;

if sum(~isnan(SideRewardTrials))
    GoalChoice = TrialData.GoalChoice;
    NotNan = ~isnan(GoalChoice);

    LeftChoices = GoalChoice(NotNan)==1;
    LeftRewards = LeftChoices==1 & SideRewardTrials(NotNan);
    TotalLeftReward = dot(TrialData.RewardMagnitudeL(NotNan), LeftRewards);

    RightChoices = GoalChoice(NotNan)==5;
    RightRewards = RightChoices & SideRewardTrials(NotNan);
    TotalRightReward = dot(TrialData.RewardMagnitudeR(NotNan), RightRewards);
    
    RewardTotal = TotalLeftReward + TotalRightReward;
end

try  % not all protocols have center reward
    CenterRewardTrials = TrialData.CenterPortRewarded;
    CenterMag = TrialData.CenterPortRewAmount;

    RewardTotal = RewardTotal + dot(CenterMag, CenterRewardTrials);
end

end %function