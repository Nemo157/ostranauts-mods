package GreenSpaces

data: {
  conditions: {
    StatSugar: {
      strDesc: "[us]'s current stored sugar."
    }
    DcSugarMax: {
      strDesc: "[us]'s is full on sugar."
    }
  }

  condrules: {
    DcStatSugar: {
      strCond: "StatSugar"
      aThresholds: [
        { strLootNew: "CONDDcSugarMax", fMin: 1.0, fMax: 9e99 }
      ]
    }
  }

  condtrigs: {
    TUpStatSugar: {
      strCondName: "StatSugar"
    }
  }

  loot: {
    CONDDcSugarMax: {
      aCOs: ["DcSugarMax=1.0x1.0"]
      strType: "condition"
    }
  }
}
