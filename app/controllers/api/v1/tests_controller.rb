require 'pry'
class Api::V1::TestsController < ApplicationController
  def index

    tests = Test.all
    studentScores = {}
    tests.each do |test|
      if !studentScores.has_key? test.student_name
        studentScores[test.student_name]=[test.total]
      else
        studentScores[test.student_name].push(test.total)
        studentScores[test.student_name].sort!
      end
    end

    scoresByStartingScore = {
      low: [],
      mid: [],
      high: [],
      veryHigh: []
    }

    studentScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        if scores[0]<1200
          scoresByStartingScore[:low].push(scores.last-scores[0])
        elsif scores[0]<1400
          scoresByStartingScore[:mid].push(scores.last-scores[0])
        elsif scores[0]<1500
          scoresByStartingScore[:high].push(scores.last-scores[0])
        else
          scoresByStartingScore[:veryHigh].push(scores.last-scores[0])
        end
      end
    end

    lowAvgScoreIncrease = scoresByStartingScore[:low].inject{ |sum, el| sum + el }.to_f / scoresByStartingScore[:low].size
    midAvgScoreIncrease = scoresByStartingScore[:mid].inject{ |sum, el| sum + el }.to_f / scoresByStartingScore[:mid].size
    highAvgScoreIncrease = scoresByStartingScore[:high].inject{ |sum, el| sum + el }.to_f / scoresByStartingScore[:high].size
    veryHighAvgScoreIncrease = scoresByStartingScore[:veryHigh].inject{ |sum, el| sum + el }.to_f / scoresByStartingScore[:veryHigh].size

    scoresAvgIncreaseByStartingScore = {
      low: lowAvgScoreIncrease.round(1),
      mid: midAvgScoreIncrease.round(1),
      high: highAvgScoreIncrease.round(1),
      veryHigh: veryHighAvgScoreIncrease.round(1)
    }

    render json: scoresAvgIncreaseByStartingScore
  end
end
