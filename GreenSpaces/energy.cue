package GreenSpaces

data: {
  conditions: {
    StatEnergy: strDesc: "[us]'s current free energy."
    DcEnergyMin: strDesc: "[us]'s is nearly empty of energy."
    DcEnergyMax: strDesc: "[us]'s is full on energy."
  }

  condrules: {
    DcStatEnergy: {
      #Thresholds: {
        CONDDcEnergyMin: { fMax: 0.2 }
        CONDDcEnergyMax: { fMin: 1.0 }
      }
    }
  }

  condtrigs: {
    TUpStatEnergy: _
    TDnStatEnergy: _
  }

  loot: {
    CONDTickEnergy: #COs: StatEnergy: -0.001215
    CONDDcEnergyMin: #COs: DcEnergyMin: _
    CONDDcEnergyMax: #COs: DcEnergyMax: _
  }

  tickers: {
    BaseEnergyLoad: {
      strCondLoot: "CONDTickEnergy"
      fPeriod: 0.00111
      bRepeat: true
    }
  }
}
