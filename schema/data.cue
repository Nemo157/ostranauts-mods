package schema

import (
  "list"
  "strings"
)

#Identifier: =~"\\w+"

// todo: other colors
#Color: "Neutral"

#ConditionEquation: string & =~ "-?\\w+=\\d+(\\.\\d+)?x\\d+(\\.\\d+)?"

#Condition: {
  strNameFriendly?: string
  strColor: #Color | *"Neutral"
  strDesc: string
  strAnti?: #Identifier
  strCTImmune?: #Identifier
  bResetTimer?: bool
  nDisplaySelf?: int
  nDisplayOther?: int
  bFatal?: bool
  bKO?: bool
  bAlert?: bool
  bRemovalAll?: bool
  bPersists?: bool
  bNegative?: bool
  bRoom?: bool
  bRemoveOnLoad?: bool
  aNext?: [...#Identifier] // reference condtrigs
  aPer?: [...#Identifier] // reference loot conditions
  fDuration?: float
  fClampMax?: float
}

#UpdateCommand: =~"GasRespire2(,\\w+){2}|Destructable(,\\w+){3},\\d+(\\.\\d+)?"

#ConditionRuleExpr: =~"\\w+=\\d+(\\.\\d+)?"

#ConditionEquationsHelper: {
  input: { [#Identifier]: float | *1.0 | { chance: float | *1.0, count: float | *1.0 } }
  output: [...#ConditionEquation] & [
    for condition, count in input if *(count >= 0.0) | false {
        "\(condition)=\(1.0)x\(count)"
    }
    for condition, count in input if *(count < 0.0) | false {
        "-\(condition)=\(1.0)x\(-count)"
    }
    for condition, values in input if *(values.count >= 0.0) | false {
        "\(condition)=\(values.chance)x\(values.count)"
    }
    for condition, values in input if *(values.count < 0.0) | false {
        "-\(condition)=\(values.chance)x\(-values.count)"
    }
  ]
}

#ConditionOwner: {
  strNameFriendly: string
  strDesc: string
  strCODef?: string
  strItemDef?: #Identifier
  strType: "item"
  strLoot?: #Identifier
  inventoryWidth?: int
  inventoryHeight?: int
  strContainerCT?: string
  nStackLimit?: int
  nContainerHeight?: int
  nContainerWidth?: int
  aInteractions?: [...string]
  #StartingConds: #ConditionEquationsHelper.input
  aStartingConds: [...#ConditionEquation] | *((#ConditionEquationsHelper & { input: #StartingConds }).output)
  #StartingCondRules: { [#Identifier]: float }
  aStartingCondRules: [...#ConditionRuleExpr] | *[
    for rule, modifier in #StartingCondRules {
        "\(rule)=\(modifier)"
    }
  ]
  bSaveMessageLog?: bool
  bSlotLocked?: bool
  mapPoints?: [...string]
  #UpdateCommands: {
    GasRespire2: { [#Identifier]: #Identifier | *"null" }
    Destructable: {
      [Stat=#Identifier]: {
        LootModeSwitch: #Identifier
        DamageCondMax: #Identifier | *"\(Stat)Max"
        SignalCheckPeriod: float | *1.0
      }
      StatDamage?: _ | *{ LootModeSwitch: "ACTDefaultDestroy" }
    }
  }
  aUpdateCommands: [...#UpdateCommand] | *[
    for id, data in #UpdateCommands.GasRespire2 {
      "GasRespire2,\(id),\(data)"
    }
    for id, data in #UpdateCommands.Destructable {
      "Destructable,\(id),\(data.LootModeSwitch),\(data.DamageCondMax),\(data.SignalCheckPeriod)"
    }
  ]
  mapGUIPropMaps?: [...string]
  strPortraitImg?: string
  strAudioEmitter?: string
  jsonPI?: string
  aSlotsWeHave?: [...string]
  #SlotEffects: { [Slot=#Identifier]: #Identifier }
  mapSlotEffects: [...string] | *list.FlattenN([
    for slot, effect in #SlotEffects {
        [slot, effect]
    }
  ], 1)
  mapChargeProfiles?: [...string]
  mapAltItemDefs?: [...string]
  aComponents?: [...string]
  #Tickers: { [#Identifier]: _ }
  aTickers: [...#Identifier] | *[ for ticker, _ in #Tickers { ticker } ]
}

#ThresholdValues: {
  fMinAdd: float | *1.0
  fMaxAdd: float | *-1.0
  fMin: float
  fMax: float
}

#Threshold: {
  strLootNew: #Identifier
  #ThresholdValues
}

#ConditionRule: {
  strCond: #Identifier
  fPref?: float
  #Thresholds: { [#Identifier]: #ThresholdValues }
  aThresholds: [...#Threshold] | *{
    let keys = [for key, _ in #Thresholds { key }]
    [
      for i in list.Range(0, len(keys), 1) {
        {
          strLootNew: keys[i]
          fMin: _ | *(*#Thresholds[keys[i - 1]].fMax | 0.0)
          fMax: _ | *9e99
          #Thresholds[keys[i]]
        }
      }
    ]
  }
}

#ConditionTrigger: {
  strCondName?: #Identifier
  fChance: float | *1.0
  fCount: float | *1.0
  aReqs?: [...#Identifier]
  aForbids?: [...#Identifier]
  aTriggers?: [...#Identifier]
  aTriggersForbid?: [...#Identifier]
  bAND: bool | *true
}

#GasRespire: {
  strPtA?: #Identifier
  strPtB?: #Identifier
  strCTA?: #Identifier
  strCTB?: #Identifier
  strGasIn: string
  strGasOut: string
  fVol: float
  fGasPressTotalRef: float | *101.3
  fConvRate: float | *1.0
  fSignalCheckRate: float | *1.0
  strSignalCTMain?: #Identifier
  strSignalCTA?: #Identifier
  strSignalCTB?: #Identifier
  fStatRate?: float | *1.0
  strStat?: #Identifier
  bAllowExternA: bool | *true
  bAllowExternB: bool | *true
}

#Installable: {
  strAllowLootCTsThem?: #Identifier
  strProgressStat?: #Identifier
  strFinishInteraction?: string
  strLootOut?: string
  strPersistentCO?: string
  strActionCO?: string
  strInteractionTemplate?: string
  strStartInstall?: string
  strBuildType?: "FURN" | #Identifier
  strJobType?: "install" | "uninstall" | #Identifier
  strInteractionName?: #Identifier
  CTUs?: #Identifier
  CTAllowUs?: #Identifier
  CTThem?: #Identifier
  strCTThemMultCondUs: #Identifier | *"StatInstallRate\(strBuildType)"
  strCTThemMultCondTools?: #Identifier
  #Inputs: #ConditionEquationsHelper.input
  aInputs: [...#ConditionEquation] | *((#ConditionEquationsHelper & { input: #Inputs }).output)
  #ToolCTsUse: { [#Identifier]: _ }
  aToolCTsUse: [...#Identifier] | *[ for condtrig, _ in #ToolCTsUse { condtrig } ]
  #LootCOs: { [#Identifier]: _ }
  aLootCOs: [...#Identifier] | *[ for loot, _ in #LootCOs { loot } ]
  aInverse?: [...string]
  bHeadless?: bool
  bNoJobMenu?: bool
  fDuration?: float
  fTargetPointRange?: float
}

#Item: {
  strImg?: string
  strImgNorm?: string
  strImgDamaged?: string
  strDmgColor?: string
  nDmgMode?: int
  fDmgCut?: float
  fDmgTrim?: float
  fDmgIntensity?: float
  fDmgComplexity?: float
  bLerp?: bool
  bSinew?: bool
  bHasSpriteSheet?: bool
  ctSpriteSheet?: string
  nLayer?: int
  nCols?: int
  fZScale?: float
  aLights?: [...string]
  mapPoints?: [...string]
  aSocketAdds?: [...string]
  aSocketReqs?: [...string]
  aSocketForbids?: [...string]
  aShadowBoxes?: [...string]
}

#LootType: "trigger" | "condition" | "item" | "interaction" | "text" | "relationship" | "lifeevent" | "ship"

#Loot: {
  strType: #LootType
  bSuppress?: bool
  bNested?: bool
  #COs: #ConditionEquationsHelper.input
  aCOs: [...#ConditionEquation] | *((#ConditionEquationsHelper & { input: #COs }).output)
  #Loots: #ConditionEquationsHelper.input
  aLoots: [...#ConditionEquation] | *((#ConditionEquationsHelper & { input: #Loots }).output)
}

#Ticker: {
  strCondLoot?: #Identifier
  strCondLootCoeff?: #Identifier
  strCondUpdate?: #Identifier
  fPeriod: float
  fEpochStart?: float
  bQueue?: bool
  bRepeat?: bool
  bTickWhileAway?: bool
}

#Data: {
  conditions: { [Name=#Identifier]: #Condition }
  condowners: { [Name=#Identifier]: #ConditionOwner }
  condrules: {
    [Name=#Identifier]: #ConditionRule
    [Name=strings.HasPrefix("Dc")]: { strCond: strings.TrimPrefix(Name, "Dc") }
  }
  condtrigs: {
    [Name=#Identifier]: #ConditionTrigger
    [Name=strings.HasPrefix("TUp")]: { strCondName: strings.TrimPrefix(Name, "TUp"), fCount: 1.0 }
    [Name=strings.HasPrefix("TDn")]: { strCondName: strings.TrimPrefix(Name, "TDn"), fCount: -1.0 }
  }
  gasrespires: { [Name=#Identifier]: #GasRespire }
  installables: {
    [Name=#Identifier]: #Installable
    [strings.HasSuffix("Install")]: {
      strJobType: "install"
      strAllowLootCTsThem: "CONDInstallProgressx5"
      strProgressStat: "StatInstallProgress"
    }
    [strings.HasSuffix("Uninstall")]: {
      strJobType: "uninstall"
      strAllowLootCTsThem: "CONDUninstallProgressx5"
      strProgressStat: "StatUninstallProgress"
    }
  }
  items: { [Name=#Identifier]: #Item }
  loot: {
    [Name=#Identifier]: #Loot
    [strings.HasPrefix("COND")]: { strType: "condition" }
    [Name=strings.HasPrefix("CONDDc") | strings.HasPrefix("CONDStat")]: {
      #COs: "\(strings.TrimPrefix(Name, "COND"))": _
    }
    [strings.HasPrefix("Itm")]: { strType: "item" }
  }
  tickers: { [Name=#Identifier]: #Ticker }
}
