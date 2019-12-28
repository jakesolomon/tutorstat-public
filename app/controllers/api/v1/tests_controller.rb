class Api::V1::TestsController < ApplicationController

# Here's what I would do if I were very very smart:
# Each /api/v1/ call should be separate by what data is being asked for,
# to keep separate responsibilities in separate files. But, how do we keep
# it DRY? I should create modules which API controllers inherit so they can
# share from the same database of functions. For now, I'll just make separate
# API controllers that repeat a lot.

  def index
    sats = SAT.all
    satScores = {}
    sats.each do |sat|
      if !satScores.has_key? sat.student_name
        satScores[sat.student_name]=[sat.total]
      else
        satScores[sat.student_name].push(sat.total)
      end
    end

    acts = ACT.all
    actScores = {}
    acts.each do |act|
      if !actScores.has_key? act.student_name
        actScores[act.student_name]=[act.composite]
      else
        actScores[act.student_name].push(act.composite)
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
    satIncreases = {
      "400–999": [],
      "1000–1099": [],
      "1100–1199": [],
      "1200–1299": [],
      "1300–1399": [],
      "1400–1499": [],
      "1500–1600": []
    }

    actIncreases = {
      "1–19": [],
      "20–21": [],
      "22–24": [],
      "25–27": [],
      "28–29": [],
      "30–32": [],
      "33–36": []
    }

    actConvertedIncreases = {
      "400–999": [],
      "1000–1099": [],
      "1100–1199": [],
      "1200–1299": [],
      "1300–1399": [],
      "1400–1499": [],
      "1500–1600": []
    }

    combinedActAndSatIncreases = {
      "400–999": [],
      "1000–1099": [],
      "1100–1199": [],
      "1200–1299": [],
      "1300–1399": [],
      "1400–1499": [],
      "1500–1600": []
    }

    # Populates satIncreases and combinedActAndSatIncreases
    satScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        if scores[0]<1000
          satIncreases[:"400–999"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"400–999"].push(scores.max-scores[0])
        elsif scores[0]<1100
          satIncreases[:"1000–1099"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1000–1099"].push(scores.max-scores[0])
        elsif scores[0]<1200
          satIncreases[:"1100–1199"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1100–1199"].push(scores.max-scores[0])
        elsif scores[0]<1300
          satIncreases[:"1200–1299"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1200–1299"].push(scores.max-scores[0])
        elsif scores[0]<1400
          satIncreases[:"1300–1399"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1300–1399"].push(scores.max-scores[0])
        elsif scores[0]<1500
          satIncreases[:"1400–1499"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1400–1499"].push(scores.max-scores[0])
        else
          satIncreases[:"1500–1600"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1500–1600"].push(scores.max-scores[0])
        end
      end
    end

    # Populates actIncreases, actConvertedIncreases,
    # and combinedActAndSatIncreases.
    actScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]
        # sort max score differences into buckets
        if scores[0]<20
          actIncreases[:"1–19"].push(scores.max-scores[0])
        elsif scores[0]<22
          actIncreases[:"20–21"].push(scores.max-scores[0])
        elsif scores[0]<25
          actIncreases[:"22–24"].push(scores.max-scores[0])
        elsif scores[0]<28
          actIncreases[:"25–27"].push(scores.max-scores[0])
        elsif scores[0]<30
          actIncreases[:"28–29"].push(scores.max-scores[0])
        elsif scores[0]<33
          actIncreases[:"30–32"].push(scores.max-scores[0])
        else
          actIncreases[:"33–36"].push(scores.max-scores[0])
        end

        # Now convert scores to SAT equivalent
        scores.map! { |score| convertActToSat[score]}

        if scores[0]<1000
          actConvertedIncreases[:"400–999"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"400–999"].push(scores.max-scores[0])
        elsif scores[0]<1100
          actConvertedIncreases[:"1000–1099"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1000–1099"].push(scores.max-scores[0])
        elsif scores[0]<1200
          actConvertedIncreases[:"1100–1199"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1100–1199"].push(scores.max-scores[0])
        elsif scores[0]<1300
          actConvertedIncreases[:"1200–1299"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1200–1299"].push(scores.max-scores[0])
        elsif scores[0]<1400
          actConvertedIncreases[:"1300–1399"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1300–1399"].push(scores.max-scores[0])
        elsif scores[0]<1500
          actConvertedIncreases[:"1400–1499"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1400–1499"].push(scores.max-scores[0])
        else
          actConvertedIncreases[:"1500–1600"].push(scores.max-scores[0])
          combinedActAndSatIncreases[:"1500–1600"].push(scores.max-scores[0])
        end
      end
    end

    def averageScores(scores)
      return scores.inject{ | sum, el| sum + el }.to_f / scores.size
    end

    satIncreases.each { |range, scores|
      satIncreases[range] = averageScores(scores).round(0)
    }

    actIncreases.each { |range, scores|
      actIncreases[range] = averageScores(scores).round(1)
    }

    actConvertedIncreases.each { |range, scores|
      actConvertedIncreases[range] = averageScores(scores).round(0)
    }

    combinedActAndSatIncreases.each { |range, scores|
      combinedActAndSatIncreases[range] = averageScores(scores).round(0)
    }

    payload = {
      satScores: satIncreases,
      actScores: actIncreases,
      convertedActScores: actConvertedIncreases,
      combinedScores: combinedActAndSatIncreases,
    }

    render json: payload
  end
end
