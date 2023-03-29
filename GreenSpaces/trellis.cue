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
      aStartingConds: [
        "IsPlant=1.0x1",
        "IsTrellis=1.0x1",
        "IsFlammable=1.0x1",
        "IsInstalled=1.0x1",
        "StatBasePrice=1.0x200.0",
        "StatInstallProgressMax=1.0x40",
        "StatUninstallProgressMax=1.0x40",
        "StatMass=1.0x4.0",
        "StatDamageMax=1.0x40",
        "StatEnergy=1.0x20.0",
        "StatEnergyDeficit=1.0x80.0",
        "StatSugar=1.0x20.0",
        "StatSugarDeficit=1.0x80.0",
      ]
      aStartingCondRules: [
        "DcStatRespiring=1",
        "DcStatPhotosynthesizing=1",
      ]
      aUpdateCommands: [
        "GasRespire2,PlantRespiration,null",
        "GasRespire2,PlantPhotosynthesis,null",
        "Destructable,StatDamage,ACTDefaultDestroy,StatDamageMax,1.0",
      ]
      aTickers: [
        "BaseEnergyLoad",
      ]
      strPortraitImg: "ItmTrellis"
    }
    ItmTrellisLoose: {
      strNameFriendly: "Trellis (Loose)"
      strDesc: "A bulkhead mounted trellis of decorative plants, commonly setup on ships for improving air quality"
      strItemDef: "ItmTrellisLoose"
      strType: "item"
      aStartingConds: [
        "IsTrellis=1.0x1",
        "IsFlammable=1.0x1",
        "IsCumbersome=1.0x1.0",
        "StatBasePrice=1.0x200.0",
        "StatInstallProgressMax=1.0x40",
        "StatUninstallProgressMax=1.0x40",
        "StatMass=1.0x4.0",
        "StatDamageMax=1.0x4",
      ]
      aUpdateCommands: [
        "Destructable,StatDamage,ACTDefaultDestroy,StatDamageMax,1.0",
      ]
      mapSlotEffects: [
        "drag","Blank",
      ]
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
