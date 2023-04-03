package GreenSpaces

data: {
  conditions: {
    StatSugar: strDesc: "[us]'s current stored sugar."
    DcSugarMin: strDesc: "[us]'s is nearly empty of sugar."
    DcSugarMax: strDesc: "[us]'s is full on sugar."
  }

  condrules: {
    DcStatSugar: {
      strCond: "StatSugar"
      aThresholds: [
        { strLootNew: "CONDDcSugarMin", fMin: 0.0, fMax: 0.2 },
        { strLootNew: "CONDDcSugarMax", fMin: 1.0, fMax: 9e99 },
      ]
    }
  }

  condtrigs: {
    TUpStatSugar: _
    TDnStatSugar: _
  }

  loot: {
    CONDDcSugarMin: aCOs: ["DcSugarMin=1.0x1.0"]
    CONDDcSugarMax: aCOs: ["DcSugarMax=1.0x1.0"]
  }
}
