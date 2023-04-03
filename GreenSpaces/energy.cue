package GreenSpaces

data: {
  conditions: {
    StatEnergy: strDesc: "[us]'s current free energy."
    DcEnergyMin: strDesc: "[us]'s is nearly empty of energy."
    DcEnergyMax: strDesc: "[us]'s is full on energy."
  }

  condrules: {
    DcStatEnergy: {
      strCond: "StatEnergy"
      aThresholds: [
        { strLootNew: "CONDDcEnergyMin", fMin: 0.0, fMax: 0.2 },
        { strLootNew: "CONDDcEnergyMax", fMin: 1.0, fMax: 9e99 },
      ]
    }
  }

  condtrigs: {
    TUpStatEnergy: _
    TDnStatEnergy: _
  }

  loot: {
    CONDTickEnergy: aCOs: ["-StatEnergy=1.0x0.001215"]
    CONDDcEnergyMin: aCOs: ["DcEnergyMin=1.0x1.0"]
    CONDDcEnergyMax: aCOs: ["DcEnergyMax=1.0x1.0"]
  }

  tickers: {
    BaseEnergyLoad: {
      strCondLoot: "CONDTickEnergy"
      fPeriod: 0.00111
      bRepeat: true
    }
  }
}
