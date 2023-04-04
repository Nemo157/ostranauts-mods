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
  #UpdateCommands: {
    GasRespire2: {
      PlantRespiration: _
    }
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
      #Thresholds: {
        CONDStatRespiringDone: { fMin: 1.0 }
      }
    }
  }

  condtrigs: {
    TIsReadyRespiration: {
      aReqs: ["IsPlant", "StatSugar"]
      aForbids: ["DcEnergyMax"]
    }
    TDnStatRespiring: _
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
    CONDStatRespiringDone: _
  }
}
