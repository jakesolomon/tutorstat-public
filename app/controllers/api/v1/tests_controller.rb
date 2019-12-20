class Api::V1::TestsController < ApplicationController
# Here's what I would do if I were very very smart:
# Each /api/v1/ call should be separate by what data is being asked for,
# to keep separate responsibilities in separate files. But, how do we keep
# it DRY? I should create modules which API controllers inherit so they can
# share from the same database of functions. For now, I'll just make separate
# API controllers that repeat a lot.

# This is gonna be real ugly, refactor later
  def index
    sats = SAT.all
    satScores = {}
    sats.each do |sat|
      if !satScores.has_key? sat.student_name
        satScores[sat.student_name]=[sat.total]
      else
        satScores[sat.student_name].push(sat.total)
        # studentScores[test.student_name].sort!
      end
    end

    acts = ACT.all
    actScores = {}
    acts.each do |act|
      if !actScores.has_key? act.student_name
        actScores[act.student_name]=[act.composite]
      else
        actScores[act.student_name].push(act.composite)
        # studentScores[test.student_name].sort!
      end
    end

# I should probably just use some funciton to put one score in front and avoid
# making a second hash altogether.
    satScoresByStartingScore = {
      low: [],
      mid: [],
      high: [],
      veryHigh: []
    }

    actScoresByStartingScore = {
      low: [],
      mid: [],
      high: [],
      veryHigh: []
    }

    satScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        # score increase is max-first, not max-min.
        if scores[0]<1200
          satScoresByStartingScore[:low].push(scores.max-scores[0])
        elsif scores[0]<1400
          satScoresByStartingScore[:mid].push(scores.max-scores[0])
        elsif scores[0]<1500
          satScoresByStartingScore[:high].push(scores.max-scores[0])
        else
          satScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
        end
      end
    end

    actScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        # score increase is max-first, not max-min.
        if scores[0]<16
          actScoresByStartingScore[:low].push(scores.max-scores[0])
        elsif scores[0]<21
          actScoresByStartingScore[:mid].push(scores.max-scores[0])
        elsif scores[0]<26
          actScoresByStartingScore[:high].push(scores.max-scores[0])
        else
          actScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
        end
      end
    end

    satLowAvgScoreIncrease = satScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:low].size
    satMidAvgScoreIncrease = satScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:mid].size
    satHighAvgScoreIncrease = satScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:high].size
    satVeryHighAvgScoreIncrease = satScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:veryHigh].size

    actLowAvgScoreIncrease = actScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:low].size
    actMidAvgScoreIncrease = actScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:mid].size
    actHighAvgScoreIncrease = actScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:high].size
    actVeryHighAvgScoreIncrease = actScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:veryHigh].size


    satScoresAvgIncreaseByStartingScore = {
      low: satLowAvgScoreIncrease.round(1),
      mid: satMidAvgScoreIncrease.round(1),
      high: satHighAvgScoreIncrease.round(1),
      veryHigh: satVeryHighAvgScoreIncrease.round(1)
    }

    actScoresAvgIncreaseByStartingScore = {
      low: actLowAvgScoreIncrease.round(1),
      mid: actMidAvgScoreIncrease.round(1),
      high: actHighAvgScoreIncrease.round(1),
      veryHigh: actVeryHighAvgScoreIncrease.round(1)
    }

    payload = {
      satScoresAvgIncreaseByStartingScore: satScoresAvgIncreaseByStartingScore,
      actScoresAvgIncreaseByStartingScore: actScoresAvgIncreaseByStartingScore
    }

    render json: payload
  end
end
