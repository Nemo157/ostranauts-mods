package schema

import (
  "list"
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
  #StartingConds: { [#Identifier]: float | *1.0 | { chance: float | *1.0, count: float | *1.0 } }
  aStartingConds: [...#ConditionEquation] | *[
    for condition, count in #StartingConds if *(count >= 0.0) | false {
        "\(condition)=\(1.0)x\(count)"
    }
    for condition, count in #StartingConds if *(count < 0.0) | false {
        "-\(condition)=\(1.0)x\(count)"
    }
    for condition, values in #StartingConds if *(values.count >= 0.0) | false {
        "\(condition)=\(values.chance)x\(values.count)"
    }
    for condition, values in #StartingConds if *(values.count < 0.0) | false {
        "-\(condition)=\(values.chance)x\(-values.count)"
    }
  ]
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

#Threshold: {
  strLootNew: #Identifier
  fMinAdd: float | *1.0
  fMaxAdd: float | *-1.0
  fMin: float
  fMax: float
}

#ConditionRule: {
  strCond: #Identifier
  fPref?: float
  aThresholds: [...#Threshold]
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
  strCTThemMultCondUs?: #Identifier
  strCTThemMultCondTools?: #Identifier
  aInputs?: [...#ConditionEquation]
  aToolCTsUse?: [...#Identifier]
  aLootCOs?: [...#Identifier]
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
  aCOs?: [...#ConditionEquation]
  aLoots?: [...#ConditionEquation]
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
  condrules: { [Name=#Identifier]: #ConditionRule }
  condtrigs: { [Name=#Identifier]: #ConditionTrigger }
  gasrespires: { [Name=#Identifier]: #GasRespire }
  installables: { [Name=#Identifier]: #Installable }
  items: { [Name=#Identifier]: #Item }
  loot: { [Name=#Identifier]: #Loot }
  tickers: { [Name=#Identifier]: #Ticker }
}
