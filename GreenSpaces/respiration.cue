package GreenSpaces

_Respirable: {
  #StartingConds: {
    IsPlant: _
    StatEnergy: _
    StatSugar: _
  }
  #StartingCondRules: {
    DcStatRespiring: 1.0
    DcStatEnergy: _
  }
  #Tickers: {
    BaseEnergyLoad: _
  }
}

data: {
  conditions: {
    StatRespiring: {
      strDesc: "[us] is respiring."
    }
    StatRespiringDone: {
      strDesc: "[us] has completed a round of respiring."
      aNext: [
        "TDnStatSugar",
        "TUpStatEnergy",
        "TDnStatRespiring",
      ]
      fDuration: 0.00028
    }
  }

  condrules: {
    DcStatRespiring: {
      strCond: "StatRespiring"
      aThresholds: [
        {
          strLootNew: "CONDStatRespiringDone"
          fMin: 1.0
          fMax: 2.0
          fMinAdd: 1.0
          fMaxAdd: 1.0
        }
      ]
    }
  }

  condtrigs: {
    TIsReadyRespiration: {
      aReqs: [
        "IsPlant",
        "StatSugar",
      ]
      aForbids: [
        "DcEnergyMax",
      ]
    }
    TDnStatRespiring: {
      strCondName: "StatRespiring"
      fCount: -1.0
    }
  }

  gasrespires: {
    PlantRespiration: {
      strCTA: "TIsAirtightRoom"
      strCTB: "TIsAirtightRoom"
      strGasIn: "O2"
      strGasOut: "CO2"
      fVol: 0.001
      fConvRate: 0.0005
      strSignalCTMain: "TIsReadyRespiration"
      strStat: "StatRespiring"
      fStatRate: 400.0
    }
  }

  loot: {
    CONDStatRespiringDone: {
      aCOs: ["StatRespiringDone=1.0x1.0"]
      strType: "condition"
    }
  }
}
