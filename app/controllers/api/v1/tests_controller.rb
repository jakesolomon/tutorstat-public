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

    # This table is taken from:
    # https://www.princetonreview.com/college-advice/act-to-sat-conversion
    # I used the middle value, averaging middle two for even number of
    # possible conversions.
    convertActToSat = {
      36 => 1600,
      35 => 1575,
      34 => 1535,
      33 => 1500,
      32 => 1465,
      31 => 1430,
      30 => 1400,
      29 => 1365,
      28 => 1325,
      27 => 1290,
      26 => 1255,
      25 => 1215,
      24 => 1175,
      23 => 1140,
      22 => 1110,
      21 => 1075,
      20 => 1035,
      19 => 995,
      18 => 955,
      17 => 915,
      16 => 875,
      15 => 830,
      14 => 780,
      13 => 735,
      12 => 670,
      11 => 590
    };

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

    convertedActScoresByStartingScore = {
      low: [],
      mid: [],
      high: [],
      veryHigh: []
    }

    combinedActAndSatScoresByStartingScore = {
      low: [],
      mid: [],
      high: [],
      veryHigh: []
    }

    # Populates satScoresByStartingScore and combinedActAndSatScoresByStartingScore
    satScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        # score increase is max-first, not max-min.
        if scores[0]<1200
          satScoresByStartingScore[:low].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:low].push(scores.max-scores[0])
        elsif scores[0]<1400
          satScoresByStartingScore[:mid].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:mid].push(scores.max-scores[0])
        elsif scores[0]<1500
          satScoresByStartingScore[:high].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:high].push(scores.max-scores[0])
        else
          satScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
        end
      end
    end

    # Populates actScoresByStartingScore, convertedActScoresByStartingScore,
    # and combinedActAndSatScoresByStartingScore.
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

        # Now convert scores to SAT equivalent
        scores.map! { |score| convertActToSat[score]}

        if scores[0]<1200
          convertedActScoresByStartingScore[:low].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:low].push(scores.max-scores[0])
        elsif scores[0]<1400
          convertedActScoresByStartingScore[:mid].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:mid].push(scores.max-scores[0])
        elsif scores[0]<1500
          convertedActScoresByStartingScore[:high].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:high].push(scores.max-scores[0])
        else
          convertedActScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
          combinedActAndSatScoresByStartingScore[:veryHigh].push(scores.max-scores[0])
        end
      end
    end

    # I can definitely just write a function to average values and plug each
    # one of these into it.

    satLowAvgScoreIncrease = satScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:low].size
    satMidAvgScoreIncrease = satScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:mid].size
    satHighAvgScoreIncrease = satScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:high].size
    satVeryHighAvgScoreIncrease = satScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / satScoresByStartingScore[:veryHigh].size

    actLowAvgScoreIncrease = actScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:low].size
    actMidAvgScoreIncrease = actScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:mid].size
    actHighAvgScoreIncrease = actScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:high].size
    actVeryHighAvgScoreIncrease = actScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / actScoresByStartingScore[:veryHigh].size

    convertedActLowAvgScoreIncrease = convertedActScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / convertedActScoresByStartingScore[:low].size
    convertedActMidAvgScoreIncrease = convertedActScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / convertedActScoresByStartingScore[:mid].size
    convertedActHighAvgScoreIncrease = convertedActScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / convertedActScoresByStartingScore[:high].size
    convertedActVeryHighAvgScoreIncrease = convertedActScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / convertedActScoresByStartingScore[:veryHigh].size

    combinedActAndSatLowAvgScoreIncrease = combinedActAndSatScoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / combinedActAndSatScoresByStartingScore[:low].size
    combinedActAndSatMidAvgScoreIncrease = combinedActAndSatScoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / combinedActAndSatScoresByStartingScore[:mid].size
    combinedActAndSatHighAvgScoreIncrease = combinedActAndSatScoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / combinedActAndSatScoresByStartingScore[:high].size
    combinedActAndSatVeryHighAvgScoreIncrease = combinedActAndSatScoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / combinedActAndSatScoresByStartingScore[:veryHigh].size


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

    convertedActScoresAvgIncreaseByStartingScore = {
      low: convertedActLowAvgScoreIncrease.round(1),
      mid: convertedActMidAvgScoreIncrease.round(1),
      high: convertedActHighAvgScoreIncrease.round(1),
      veryHigh: convertedActVeryHighAvgScoreIncrease.round(1)
    }

    combinedActScoresAvgIncreaseByStartingScore = {
      low: combinedActAndSatLowAvgScoreIncrease.round(1),
      mid: combinedActAndSatMidAvgScoreIncrease.round(1),
      high: combinedActAndSatHighAvgScoreIncrease.round(1),
      veryHigh: combinedActAndSatVeryHighAvgScoreIncrease.round(1)
    }


    payload = {
      satScoresAvgIncreaseByStartingScore: satScoresAvgIncreaseByStartingScore,
      actScoresAvgIncreaseByStartingScore: actScoresAvgIncreaseByStartingScore,
      convertedActScoresAvgIncreaseByStartingScore: convertedActScoresAvgIncreaseByStartingScore,
      combinedActScoresAvgIncreaseByStartingScore: combinedActScoresAvgIncreaseByStartingScore
    }

    render json: payload
  end
end
