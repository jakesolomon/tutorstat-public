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

# Taken from https://collegereadiness.collegeboard.org/pdf/understanding-sat-scores.pdf
    satPercentile = {
      1600 => 99,
      1590 => 99,
      1580 => 99,
      1570 => 99,
      1560 => 99,
      1550 => 99,
      1540 => 99,
      1530 => 99,
      1520 => 99,
      1510 => 99,
      1500 => 98,
      1490 => 98,
      1480 => 98,
      1470 => 97,
      1460 => 97,
      1450 => 96,
      1440 => 96,
      1430 => 96,
      1420 => 95,
      1410 => 95,
      1400 => 94,
      1390 => 93,
      1380 => 93,
      1370 => 92,
      1360 => 91,
      1350 => 91,
      1340 => 90,
      1330 => 89,
      1320 => 88,
      1310 => 87,
      1300 => 86,
      1290 => 85,
      1280 => 84,
      1270 => 83,
      1260 => 82,
      1250 => 81,
      1240 => 80,
      1230 => 78,
      1220 => 77,
      1210 => 76,
      1200 => 74,
      1190 => 73,
      1180 => 72,
      1170 => 70,
      1160 => 68,
      1150 => 67,
      1140 => 65,
      1130 => 64,
      1120 => 62,
      1110 => 60,
      1100 => 58,
      1090 => 57,
      1080 => 55,
      1070 => 53,
      1060 => 51,
      1050 => 49,
      1040 => 47,
      1030 => 46,
      1020 => 44,
      1010 => 42,
      1000 => 40,
      990 => 38,
      980 => 36,
      970 => 35,
      960 => 33,
      950 => 31,
      940 => 30,
      930 => 28,
      920 => 27,
      910 => 25,
      900 => 23,
      890 => 22,
      880 => 20,
      870 => 19,
      860 => 18,
      850 => 16,
      840 => 15,
      830 => 14,
      820 => 13,
      810 => 11,
      800 => 10,
      790 => 9,
      780 => 8,
      770 => 7,
      760 => 6,
      750 => 5,
      740 => 5,
      730 => 4,
      720 => 3,
      710 => 3,
      700 => 2,
      690 => 2,
      680 => 1,
      670 => 1,
      660 => 1,
      650 => 1,
      640 => 1,
      630 => 1,
      620 => 1,
      610 => 1,
      600 => 1,
      590 => 1,
      580 => 1,
      570 => 1,
      560 => 1,
      550 => 1,
      540 => 1,
      530 => 1,
      520 => 1,
      510 => 1,
      500 => 1,
      490 => 1,
      480 => 1,
      470 => 1,
      460 => 1,
      450 => 1,
      440 => 1,
      430 => 1,
      420 => 1,
      410 => 1,
      400 => 1
    }

    actPercentile = {
      36 => 100,
      35 => 99,
      34 => 99,
      33 => 98,
      32 => 97,
      31 => 95,
      30 => 93,
      29 => 91,
      28 => 88,
      27 => 85,
      26 =>82,
      25 =>78,
      24 =>74,
      23 =>69,
      22 => 64,
      21 => 58,
      20 => 52,
      19 => 46,
      18 => 40,
      17 => 33,
      16 => 27,
      15 => 20,
      14 => 14,
      13 => 9,
      12 => 4,
      11 => 1,
      10 => 1,
      9 => 1,
      8 => 1,
      7 => 1,
      6 => 1,
      5 => 1,
      4 => 1,
      3 => 1,
      2 => 1,
      1 => 1
    }

    def getPercentile(score, reference)
      if reference.keys.include? score
        return reference[score].to_f
      else
        return (reference[score-5].to_f + reference[score+5]).to_f / 2
      end
    end

    satIncreases = {
      "400–999": [],
      "1000–1099": [],
      "1100–1199": [],
      "1200–1299": [],
      "1300–1399": [],
      "1400–1499": [],
      "1500–1600": []
    }

    satPercentileIncreases = {
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

    actPercentileIncreases = {
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

    actPercentileConvertedIncreases = {
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

    combinedActAndSatPercentileIncreases = {
      "400–999": [],
      "1000–1099": [],
      "1100–1199": [],
      "1200–1299": [],
      "1300–1399": [],
      "1400–1499": [],
      "1500–1600": []
    }

    studentCount = {
      sat: {
        "400–999": 0,
        "1000–1099": 0,
        "1100–1199": 0,
        "1200–1299": 0,
        "1300–1399": 0,
        "1400–1499": 0,
        "1500–1600": 0
      },
      act: {
        "1–19": 0,
        "20–21": 0,
        "22–24": 0,
        "25–27": 0,
        "28–29": 0,
        "30–32": 0,
        "33–36": 0
      },
      actConverted: {
        "400–999": 0,
        "1000–1099": 0,
        "1100–1199": 0,
        "1200–1299": 0,
        "1300–1399": 0,
        "1400–1499": 0,
        "1500–1600": 0
      },
      combined: {
        "400–999": 0,
        "1000–1099": 0,
        "1100–1199": 0,
        "1200–1299": 0,
        "1300–1399": 0,
        "1400–1499": 0,
        "1500–1600": 0
      }
    }

    # Populates satIncreases, satPercentileIncreases, combinedActAndSatIncreases, and combinedActAndSatPercentileIncreases
    satScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]

        scoreIncrease = scores.max-scores[0]
        percentileIncrease = getPercentile(scores.max, satPercentile) - getPercentile(scores[0], satPercentile)

        # sort max score differences into buckets
        if scores[0]<1000
          satIncreases[:"400–999"].push(scoreIncrease)
          satPercentileIncreases[:"400–999"].push(percentileIncrease)
          combinedActAndSatIncreases[:"400–999"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"400–999"].push(percentileIncrease)
          studentCount[:sat][:"400–999"] += 1
          studentCount[:combined][:"400–999"] += 1
        elsif scores[0]<1100
          satIncreases[:"1000–1099"].push(scoreIncrease)
          satPercentileIncreases[:"1000–1099"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1000–1099"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1000–1099"].push(percentileIncrease)
          studentCount[:sat][:"1000–1099"] += 1
          studentCount[:combined][:"1000–1099"] += 1
        elsif scores[0]<1200
          satIncreases[:"1100–1199"].push(scoreIncrease)
          satPercentileIncreases[:"1100–1199"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1100–1199"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1100–1199"].push(percentileIncrease)
          studentCount[:sat][:"1100–1199"] += 1
          studentCount[:combined][:"1100–1199"] += 1
        elsif scores[0]<1300
          satIncreases[:"1200–1299"].push(scoreIncrease)
          satPercentileIncreases[:"1200–1299"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1200–1299"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1200–1299"].push(percentileIncrease)
          studentCount[:sat][:"1200–1299"] += 1
          studentCount[:combined][:"1200–1299"] += 1
        elsif scores[0]<1400
          satIncreases[:"1300–1399"].push(scoreIncrease)
          satPercentileIncreases[:"1300–1399"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1300–1399"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1300–1399"].push(percentileIncrease)
          studentCount[:sat][:"1300–1399"] += 1
          studentCount[:combined][:"1300–1399"] += 1
        elsif scores[0]<1500
          satIncreases[:"1400–1499"].push(scoreIncrease)
          satPercentileIncreases[:"1400–1499"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1400–1499"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1400–1499"].push(percentileIncrease)
          studentCount[:sat][:"1400–1499"] += 1
          studentCount[:combined][:"1400–1499"] += 1
        else
          satIncreases[:"1500–1600"].push(scoreIncrease)
          satPercentileIncreases[:"1500–1600"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1500–1600"].push(scoreIncrease)
          combinedActAndSatPercentileIncreases[:"1500–1600"].push(percentileIncrease)
          studentCount[:sat][:"1500–1600"] += 1
          studentCount[:combined][:"1500–1600"] += 1
        end
      end
    end

    # Populates actIncreases, actPercentileIncreases, and actConvertedIncreases,
    # actPercentileIncreases, combinedActAndSatIncreases, and combinedActAndSatPercentileIncreases.
    actScores.each do |student, scores|
      # filter out students that only have one score listed
      if scores[1]

        scoreIncrease = scores.max-scores[0]
        percentileIncrease = getPercentile(scores.max, actPercentile) - getPercentile(scores[0], actPercentile)

        # sort max score differences into buckets
        if scores[0]<20
          actIncreases[:"1–19"].push(scoreIncrease)
          actPercentileIncreases[:"1–19"].push(percentileIncrease)
          studentCount[:act][:"1–19"] += 1
          studentCount[:combined][:"400–999"] += 1
        elsif scores[0]<22
          actIncreases[:"20–21"].push(scoreIncrease)
          actPercentileIncreases[:"20–21"].push(percentileIncrease)
          studentCount[:act][:"20–21"] += 1
          studentCount[:combined][:"1000–1099"] += 1
        elsif scores[0]<25
          actIncreases[:"22–24"].push(scoreIncrease)
          actPercentileIncreases[:"22–24"].push(percentileIncrease)
          studentCount[:act][:"22–24"] += 1
          studentCount[:combined][:"1100–1199"] += 1
        elsif scores[0]<28
          actIncreases[:"25–27"].push(scoreIncrease)
          actPercentileIncreases[:"25–27"].push(percentileIncrease)
          studentCount[:act][:"25–27"] += 1
          studentCount[:combined][:"1200–1299"] += 1
        elsif scores[0]<30
          actIncreases[:"28–29"].push(scoreIncrease)
          actPercentileIncreases[:"28–29"].push(percentileIncrease)
          studentCount[:act][:"28–29"] += 1
          studentCount[:combined][:"1300–1399"] += 1
        elsif scores[0]<33
          actIncreases[:"30–32"].push(scoreIncrease)
          actPercentileIncreases[:"30–32"].push(percentileIncrease)
          studentCount[:act][:"30–32"] += 1
          studentCount[:combined][:"1400–1499"] += 1
        else
          actIncreases[:"33–36"].push(scoreIncrease)
          actPercentileIncreases[:"33–36"].push(percentileIncrease)
          studentCount[:act][:"33–36"] += 1
          studentCount[:combined][:"1500–1600"] += 1
        end

        # Now convert scores to SAT equivalent
        scores.map! { |score| convertActToSat[score]}

        convertedScoreIncrease = scores.max-scores[0]

        # Note about actPercentileConvertedIncreases:
        # Scores are calculated as ACT percentile
        # and then sorted into corresponding SAT equivalent buckets.
        if scores[0]<1000
          actConvertedIncreases[:"400–999"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"400–999"].push(percentileIncrease)
          combinedActAndSatIncreases[:"400–999"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"400–999"].push(percentileIncrease)
          studentCount[:actConverted][:"400–999"] += 1
        elsif scores[0]<1100
          actConvertedIncreases[:"1000–1099"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1000–1099"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1000–1099"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1000–1099"].push(percentileIncrease)
          studentCount[:actConverted][:"1000–1099"] += 1
        elsif scores[0]<1200
          actConvertedIncreases[:"1100–1199"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1100–1199"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1100–1199"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1100–1199"].push(percentileIncrease)
          studentCount[:actConverted][:"1100–1199"] += 1
        elsif scores[0]<1300
          actConvertedIncreases[:"1200–1299"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1200–1299"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1200–1299"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1200–1299"].push(percentileIncrease)
          studentCount[:actConverted][:"1200–1299"] += 1
        elsif scores[0]<1400
          actConvertedIncreases[:"1300–1399"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1300–1399"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1300–1399"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1300–1399"].push(percentileIncrease)
          studentCount[:actConverted][:"1300–1399"] += 1
        elsif scores[0]<1500
          actConvertedIncreases[:"1400–1499"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1400–1499"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1400–1499"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1400–1499"].push(percentileIncrease)
          studentCount[:actConverted][:"1400–1499"] += 1
        else
          actConvertedIncreases[:"1500–1600"].push(convertedScoreIncrease)
          actPercentileConvertedIncreases[:"1500–1600"].push(percentileIncrease)
          combinedActAndSatIncreases[:"1500–1600"].push(convertedScoreIncrease)
          combinedActAndSatPercentileIncreases[:"1500–1600"].push(percentileIncrease)
          studentCount[:actConverted][:"1500–1600"] += 1
        end
      end
    end

    def averageScores(scores)
      return scores.inject{ | sum, el| sum + el }.to_f / scores.size
    end

    satIncreases.each { |range, scores|
      satIncreases[range] = averageScores(scores).round(0)
    }

    satPercentileIncreases.each { |range, scores|
      satPercentileIncreases[range] = averageScores(scores).round(1)
    }

    actIncreases.each { |range, scores|
      actIncreases[range] = averageScores(scores).round(1)
    }

    actPercentileIncreases.each { |range, scores|
      actPercentileIncreases[range] = averageScores(scores).round(1)
    }

    actConvertedIncreases.each { |range, scores|
      actConvertedIncreases[range] = averageScores(scores).round(0)
    }

    actPercentileConvertedIncreases.each { |range, scores|
      actPercentileConvertedIncreases[range] = averageScores(scores).round(1)
    }

    combinedActAndSatIncreases.each { |range, scores|
      combinedActAndSatIncreases[range] = averageScores(scores).round(0)
    }

    combinedActAndSatPercentileIncreases.each { |range, scores|
      combinedActAndSatPercentileIncreases[range] = averageScores(scores).round(1)
    }

    payload = {
      satScores: satIncreases,
      satPercentiles: satPercentileIncreases,
      actScores: actIncreases,
      actPercentiles: actPercentileIncreases,
      convertedActScores: actConvertedIncreases,
      convertedActPercentiles: actPercentileConvertedIncreases,
      combinedScores: combinedActAndSatIncreases,
      combinedPercentiles: combinedActAndSatPercentileIncreases,
      studentCount: studentCount
    }

    render json: payload
  end
end
