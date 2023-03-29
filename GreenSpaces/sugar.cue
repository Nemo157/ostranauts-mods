package GreenSpaces

data: {
  conditions: {
    StatSugar: {
      strDesc: "[us]'s current stored sugar."
      aPer: ["CONDStatSugarPer"]
    }
    StatSugarDeficit: {
      strDesc: "[us]'s current lack of stored sugar."
    }
  }

  condtrigs: {
    TIsStatSugarDeficit: {
      aReqs: ["StatSugarDeficit"]
    }
    TUpStatSugar: {
      strCondName: "StatSugar"
      fCount: 1.0
    }
  }

  loot: {
    CONDStatSugarPer: {
      aCOs: ["-StatSugarDeficit=1.0x1.0"]
      strType: "condition"
    }
  }
}
