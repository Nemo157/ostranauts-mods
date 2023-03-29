package greenspaces

data: {
  conditions: {
    StatPhotosynthesizing: {
      strDesc: "[us] is photosynthesizing."
    }
    StatPhotosynthesizingDone: {
      strDesc: "[us] has completed a round of photosynthesizing."
      aNext: [
        "TUpStatSugar",
        "TDnStatPhotosynthesizing",
      ]
      fDuration: 0.001
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
        "StatSugarDeficit",
      ]
    }
    TDnStatPhotosynthesizing: {
      strCondName: "StatPhotosynthesizing"
      fCount: -1.0
    }
  }

  gasrespires: {
    PlantPhotosynthesis: {
      strCTA: "TIsAirtightRoom"
      strCTB: "TIsAirtightRoom"
      strGasIn: "CO2"
      strGasOut: "O2"
      fVol: 0.0001
      fConvRate: 0.8
      fGasPressTotalRef: 101.3
      strSignalCTMain: "TIsReadyPhotosynthesis"
      fStatRate: 1.0
      strStat: "StatPhotosynthesizing"
    }
  }

  loot: {
    CONDStatPhotosynthesizingDone: {
      aCOs: ["StatPhotosynthesizingDone=1.0x1.0"]
      strType: "condition"
    }
  }
}
