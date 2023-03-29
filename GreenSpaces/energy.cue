package GreenSpaces

data: {
  conditions: {
    StatEnergy: {
      strDesc: "[us]'s current free energy."
      aPer: ["CONDStatEnergyPer"]
    }
    StatEnergyDeficit: {
      strDesc: "[us]'s current lack of free energy."
    }
  }

  condtrigs: {
    TIsStatEnergyDeficit: {
      aReqs: ["StatEnergyDeficit"]
    }
    TUpStatEnergy: {
      strCondName: "StatEnergy"
    }
    TDnStatEnergy: {
      strCondName: "StatEnergy"
      fCount: -1.0
    }
  }

  loot: {
    CONDStatEnergyPer: {
      strType: "condition"
      aCOs: ["-StatEnergyDeficit=1.0x1.0"]
    }
    CONDTickEnergy: {
      strType: "condition"
      aCOs: ["-StatEnergy=1.0x0.001215"]
    }
  }

  tickers: {
    BaseEnergyLoad: {
      strCondLoot: "CONDTickEnergy"
      fPeriod: 0.00111
      bRepeat: true
    }
  }
}
