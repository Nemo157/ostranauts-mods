package GreenSpaces

data: {
  conditions: {
    IsPlant: {
      strDesc: "[us] is a plant."
      nDisplaySelf: 2
      nDisplayOther: 1
    }
    IsTrellis: {
      strDesc: "[us] is a trellis."
      nDisplaySelf: 2
      nDisplayOther: 1
    }
  }

  condowners: {
    ItmTrellis: {
      strNameFriendly: "Trellis"
      strDesc: "A bulkhead mounted trellis of decorative plants, commonly setup on ships for improving air quality"
      strItemDef: "ItmTrellis"
      strType: "item"
      #StartingConds: {
        IsPlant: _
        IsTrellis: _
        IsFlammable: _
        IsInstalled: _
        StatBasePrice: 200.0
        StatInstallProgressMax: 40.0
        StatUninstallProgressMax: 40.0
        StatMass: 4.0
        StatDamageMax: 40.0
        StatEnergy: 20.0
        StatSugar: 20.0
      }
      #StartingCondRules: {
        DcStatRespiring: 1.0
        DcStatPhotosynthesizing: 1.0
        DcStatSugar: 100.0
        DcStatEnergy: 100.0
      }
      aUpdateCommands: [
        "GasRespire2,PlantRespiration,null",
        "GasRespire2,PlantPhotosynthesis,null",
        "Destructable,StatDamage,ACTDefaultDestroy,StatDamageMax,1.0",
      ]
      #Tickers: {
        BaseEnergyLoad: _
      }
      strPortraitImg: "ItmTrellis"
      // _photosynthesizeable
    }
    ItmTrellisLoose: {
      strNameFriendly: "Trellis (Loose)"
      strDesc: "A bulkhead mounted trellis of decorative plants, commonly setup on ships for improving air quality"
      strItemDef: "ItmTrellisLoose"
      strType: "item"
      #StartingConds: {
        IsTrellis: _
        IsFlammable: _
        IsCumbersome: _
        StatBasePrice: 200.0
        StatInstallProgressMax: 40.0
        StatUninstallProgressMax: 40.0
        StatMass: 4.0
        StatDamageMax: 4.0
      }
      aUpdateCommands: [
        "Destructable,StatDamage,ACTDefaultDestroy,StatDamageMax,1.0",
      ]
      #SlotEffects: {
        drag: "Blank"
      }
      strPortraitImg: "ItmTrellisLoose"
    }
  }

  condtrigs: {
    TIsPlant: {
      aReqs: ["IsPlant"]
    }
    TIsTrellisUninstalled: {
      aReqs: ["IsTrellis"]
      aForbids: ["IsInstalled", "IsDamaged"]
    }
    TIsTrellisInstalled: {
      aReqs: ["IsTrellis", "IsInstalled"]
      aForbids: ["IsDamaged"]
    }
  }

  installables: {
      TrellisInstall: {
        strActionCO: "ItmTrellisLoose"
        strInteractionTemplate: "ACTInstallNoSparksTEMP"
        CTThem: "TIsTrellisUninstalled" 
        aInputs: ["TIsTrellisUninstalled=1.0x1"]
        fTargetPointRange: 2.0
        fDuration: 0.001
        aToolCTsUse: ["TIsToolMortorq"]
        aLootCOs: ["ItmTrellis"]
        strStartInstall: "ItmTrellis"
        strBuildType: "FURN"
        strJobType: "install"
        strAllowLootCTsThem: "CONDInstallProgressx5"
        strProgressStat: "StatInstallProgress"
        strCTThemMultCondTools: "IsToolMortorq"
        strCTThemMultCondUs: "StatInstallRateFURN"
      }
      TrellisUninstall: {
        strActionCO: "ItmTrellis"
        strInteractionTemplate: "ACTUninstallNoSparksTEMP"
        CTThem: "TIsTrellisInstalled" 
        aInputs: []
        fTargetPointRange: 2.0
        fDuration: 0.001
        aToolCTsUse: ["TIsToolMortorq"]
        aLootCOs: ["ItmTrellisLoose"]
        strJobType: "uninstall"
        strAllowLootCTsThem: "CONDUninstallProgressx5"
        strProgressStat: "StatUninstallProgress"
        strCTThemMultCondTools: "IsToolMortorq"
        strCTThemMultCondUs: "StatInstallRateFURN"
      }
  }

  items: {
    ItmTrellis: {
      strImg: "ItmTrellis"
      strImgNorm: "ItmTrellisN"
      fZScale: 0.75
      nCols: 1
      aSocketAdds: [
        "TILWallDecoAdds"
      ]
      aSocketForbids: [
        "Blank", "Blank", "Blank",
        "Blank", "TILWallObstruction", "Blank",
        "Blank", "Blank", "Blank",
      ]
      aSocketReqs: [
        "Blank", "TILWall", "Blank",
        "Blank", "TILFloor", "Blank",
        "Blank", "Blank", "Blank",
      ]
    }
    ItmTrellisLoose: {
      strImg: "ItmTrellisLoose"
      strImgNorm: "ItmTrellisLooseN"
      fZScale: 0.5
      nCols: 1
      aSocketAdds: [
        "TILItemAdds"
      ]
      aSocketForbids: [
        "Blank", "Blank", "Blank",
        "Blank", "TILItemForbids", "Blank",
        "Blank", "Blank", "Blank",
      ]
      aSocketReqs: [
        "Blank", "Blank", "Blank",
        "Blank", "TILFloor", "Blank",
        "Blank", "Blank", "Blank",
      ]
    }
  }

  loot: {
    ItmTrellis: {
      aCOs: ["ItmTrellis=1.0x1"]
      strType: "item"
    }
    ItmTrellisLoose: {
      aCOs: ["ItmTrellisLoose=1.0x1"]
      strType: "item"
    }
    ItmRandomLot18: {
      aCOs: ["ItmTrellisLoose=1.0x1"]
      strType: "item"
    }
    ItmRandomLotCrewStartLoot18: {
      aCOs: ["ItmTrellisLoose=1.0x1"]
      strType: "item"
    }
  }
}
