package GreenSpaces

_Photosynthesizeable: {
  #StartingConds: {
    IsPlant: _
    StatSugar: _
  }
  #StartingCondRules: {
    DcStatPhotosynthesizing: 1.0
    DcStatSugar: _
  }
}

data: {
  conditions: {
    StatPhotosynthesizing: {
      strDesc: "[us] is photosynthesizing."
    }
    StatPhotosynthesizingDone: {
      strDesc: "[us] has completed a round of photosynthesizing."
      aNext: [
        "TUpStatSugar",
        "TUpStatPhotosynthesizingBlocked",
        "TDnStatPhotosynthesizing",
      ]
      fDuration: 0.00028
    }
    // blocking photosynthesis for a set time caps the dependence on CO2
    // partial pressue, allowing it to get to extreme levels still
    StatPhotosynthesizingBlocked: {
      strDesc: "[us] has photosynthesized enough for now."
      fDuration: 0.1
    }
  }

  condrules: {
    DcStatPhotosynthesizing: {
      strCond: "StatPhotosynthesizing"
      aThresholds: [
        {
          strLootNew: "CONDStatPhotosynthesizingDone"
          fMin: 1.0
          fMax: 2.0
          fMinAdd: 1.0
          fMaxAdd: 1.0
        }
      ]
    }
  }

  condtrigs: {
    TIsReadyPhotosynthesis: {
      aReqs: [
        "IsPlant",
      ]
      aForbids: [
        "StatPhotosynthesizingBlocked",
        "DcSugarMax",
      ]
    }
    TDnStatPhotosynthesizing: {
      strCondName: "StatPhotosynthesizing"
      fCount: -1.0
    }
    TUpStatPhotosynthesizingBlocked: {
      strCondName: "StatPhotosynthesizingBlocked"
      fCount: 1.0
    }
  }

  gasrespires: {
    PlantPhotosynthesis: {
      strCTA: "TIsAirtightRoom"
      strCTB: "TIsAirtightRoom"
      strGasIn: "CO2"
      strGasOut: "O2"
      fVol: 0.001
      fConvRate: 0.5625
      strSignalCTMain: "TIsReadyPhotosynthesis"
      strStat: "StatPhotosynthesizing"
      fStatRate: 5000.0
    }
  }

  loot: {
    CONDStatPhotosynthesizingDone: {
      aCOs: ["StatPhotosynthesizingDone=1.0x1.0"]
      strType: "condition"
    }
  }
}
