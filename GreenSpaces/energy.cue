package GreenSpaces

data: {
  conditions: {
    StatEnergy: {
      strDesc: "[us]'s current free energy."
    }
    DcEnergyMax: {
      strDesc: "[us]'s is full on energy."
    }
  }

  condrules: {
    DcStatEnergy: {
      strCond: "StatEnergy"
      aThresholds: [
        { strLootNew: "CONDDcEnergyMax", fMin: 1.0, fMax: 9e99 }
      ]
    }
  }

  condtrigs: {
    TUpStatEnergy: {
      strCondName: "StatEnergy"
    }
    TDnStatEnergy: {
      strCondName: "StatEnergy"
      fCount: -1.0
    }
  }

  loot: {
    CONDTickEnergy: {
      strType: "condition"
      aCOs: ["-StatEnergy=1.0x0.001215"]
    }
    CONDDcEnergyMax: {
      strType: "condition"
      aCOs: ["DcEnergyMax=1.0x1.0"]
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
