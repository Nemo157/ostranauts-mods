package schema

#Identifier: =~"\\w+"

// todo: other colors
#Color: "Neutral"

#ConditionEquation: string & =~"-?\\w+=\\d+(\\.\\d+)?x\\d+(\\.\\d+)?"

#Condition: {
	strNameFriendly?: string
	strColor:         #Color
	strDesc:          string
	strAnti?:         #Identifier
	strCTImmune?:     #Identifier
	bResetTimer?:     bool
	nDisplaySelf?:    int
	nDisplayOther?:   int
	bFatal?:          bool
	bKO?:             bool
	bAlert?:          bool
	bRemovalAll?:     bool
	bPersists?:       bool
	bNegative?:       bool
	bRoom?:           bool
	bRemoveOnLoad?:   bool
	aNext?: [...#Identifier] // reference condtrigs
	aPer?: [...#Identifier] // reference loot conditions
	fDuration?:             float
	fClampMax?:             float
}

#UpdateCommand: =~"GasRespire2(,\\w+){2}|Destructable(,\\w+){3},\\d+(\\.\\d+)?"

#ConditionRuleExpr: =~"\\w+=\\d+(\\.\\d+)?"

#ConditionOwner: {
	strNameFriendly:   string
	strDesc:           string
	strCODef?:         string
	strItemDef?:       #Identifier
	strType:           "item"
	strLoot?:          #Identifier
	inventoryWidth?:   int
	inventoryHeight?:  int
	strContainerCT?:   string
	nStackLimit?:      int
	nContainerHeight?: int
	nContainerWidth?:  int
	aInteractions?: [...string]
	aStartingConds?: [...#ConditionEquation]
	aStartingCondRules?: [...#ConditionRuleExpr]
	bSaveMessageLog?: bool
	bSlotLocked?:     bool
	mapPoints?: [...string]
	aUpdateCommands?: [...#UpdateCommand]
	mapGUIPropMaps?: [...string]
	strPortraitImg?:  string
	strAudioEmitter?: string
	jsonPI?:          string
	aSlotsWeHave?: [...string]
	mapSlotEffects?: [...string]
	mapChargeProfiles?: [...string]
	mapAltItemDefs?: [...string]
	aComponents?: [...string]
	aTickers?: [...#Identifier]
}

#Threshold: {
	strLootNew: #Identifier
	fMinAdd:    float
	fMaxAdd:    float
	fMin:       float
	fMax:       float
}

#ConditionRule: {
	strCond: #Identifier
	fPref?:  float
	aThresholds?: [...#Threshold]
}

#ConditionTrigger: {
	strCondName?: #Identifier
	fChance?:     float
	fCount?:      float
	aReqs?: [...#Identifier]
	aForbids?: [...#Identifier]
	aTriggers?: [...#Identifier]
	aTriggersForbid?: [...#Identifier]
	bAND: bool
}

#GasRespire: {
	strPtA?:           #Identifier
	strPtB?:           #Identifier
	strCTA?:           #Identifier
	strCTB?:           #Identifier
	strGasIn:          string
	strGasOut:         string
	fVol:              float
	fGasPressTotalRef: float
	fConvRate:         float
	fSignalCheckRate:  float
	strSignalCTMain?:  #Identifier
	strSignalCTA?:     #Identifier
	strSignalCTB?:     #Identifier
	fStatRate?:        float
	strStat?:          #Identifier
	bAllowExternA:     bool
	bAllowExternB:     bool
}

#BuildType: "FURN" | #Identifier
#JobType:   "install" | "uninstall" | #Identifier

#Installable: {
	strAllowLootCTsThem?:    #Identifier
	strProgressStat?:        #Identifier
	strFinishInteraction?:   string
	strLootOut?:             string
	strPersistentCO?:        string
	strActionCO?:            string
	strInteractionTemplate?: string
	strStartInstall?:        string
	strBuildType?:           #BuildType
	strJobType?:             #JobType
	strInteractionName?:     #Identifier
	CTUs?:                   #Identifier
	CTAllowUs?:              #Identifier
	CTThem?:                 #Identifier
	strCTThemMultCondUs?:    #Identifier
	strCTThemMultCondTools?: #Identifier
	aInputs?: [...#ConditionEquation]
	aToolCTsUse?: [...#Identifier]
	aLootCOs?: [...#Identifier]
	aInverse?: [...string]
	bHeadless?:         bool
	bNoJobMenu?:        bool
	fDuration?:         float
	fTargetPointRange?: float
}

#Interaction: {
	strTitle?:          string
	strDesc?:           string
	strTargetPoint?:    string
	fTargetPointRange?: float
	fForcedChance?:     float
	strAnim?:           string
	strBubble?:         string
	strColor?:          string
	strDuty?:           string
	aInverse?: [...string]
	fDuration?:              float
	fRotation?:              float
	strTeleport?:            string
	strIdleAnim?:            string
	strCancelInteraction?:   string
	strUseCase?:             string
	strThemType?:            string
	strRaiseUI?:             string
	strSubUI?:               string
	strContextLootUs?:       string
	strContextLootThem?:     string
	strCTThemMultCondUs?:    string
	strCTThemMultCondTools?: string
	strImage?:               string
	strMapIcon?:             string
	strLedgerDef?:           string
	bPause?:                 bool
	bSocial?:                bool
	bIgnoreFeelings?:        bool
	bRandomInverse?:         bool
	bCloser?:                bool
	bGambit?:                bool
	bOpener?:                bool
	nLogging?:               int
	nMoveType?:              int
	bHardCode?:              bool
	bHumanOnly?:             bool
	bTargetOwned?:           bool
	bEquip?:                 bool
	bLot?:                   bool
	bPassThrough?:           bool
	bModeSwitchCheckFit?:    bool
	bNoWait?:                bool
	strStartInstall?:        string
	strPledgeAdd?:           string
	strMusic?:               string
	bForceMusic?:            bool
	LootCTsUs?:              string
	LootCTsThem?:            string
	LootCTs3rd?:             string
	LootCondsUs?:            string
	LootCondsThem?:          string
	LootConds3rd?:           string
	LootReveals?:            string
	CTTestUs?:               string
	CTTestThem?:             string
	CTTestRoom?:             string
	CTTest3rd?:              string
	PSpecTestThem?:          string
	PSpecTest3rd?:           string
	aLootItms?: [...string]
	objLootModeSwitch?:     string
	objLootModeSwitchThem?: string
	aSocialPrereqs?: [...string]
	aSocialNew?: [...string]
	strLootRELChangeThem?: string
	strLootRELChangeUs?:   string
	aTickersUs?: [...string]
	aTickersThem?: [...string]
	strSocialCombatPreview?: string
}

#Item: {
	strImg?:          string
	strImgNorm?:      string
	strImgDamaged?:   string
	strDmgColor?:     string
	nDmgMode?:        int
	fDmgCut?:         float
	fDmgTrim?:        float
	fDmgIntensity?:   float
	fDmgComplexity?:  float
	bLerp?:           bool
	bSinew?:          bool
	bHasSpriteSheet?: bool
	ctSpriteSheet?:   string
	nLayer?:          int
	nCols?:           int
	fZScale?:         float
	aLights?: [...string]
	mapPoints?: [...string]
	aSocketAdds?: [...string]
	aSocketReqs?: [...string]
	aSocketForbids?: [...string]
	aShadowBoxes?: [...string]
}

#LootType: "trigger" | "condition" | "item" | "interaction" | "text" |
	"relationship" | "lifeevent" | "ship"

#Loot: {
	strType:    #LootType
	bSuppress?: bool
	bNested?:   bool
	aCOs?: [...#ConditionEquation]
	aLoots?: [...#ConditionEquation]
}

#Slot: {
	strNameFriendly?: string
	strHitboxImage?:  string
	nItems?:          int
	nDepth?:          int
	fAlignX?:         float
	fAlignY?:         float
	bAlignSlot?:      bool
	bHoldSlot?:       bool
	bCarried?:        bool
	bAllowStacks?:    bool
	bHide?:           bool
}

#Ticker: {
	strCondLoot?:      #Identifier
	strCondLootCoeff?: #Identifier
	strCondUpdate?:    #Identifier
	fPeriod:           float
	fEpochStart?:      float
	bQueue?:           bool
	bRepeat?:          bool
	bTickWhileAway?:   bool
}

#Data: {
	conditions: {[Name=#Identifier]: #Condition}
	condowners: {[Name=#Identifier]: #ConditionOwner}
	condrules: {[Name=#Identifier]: #ConditionRule}
	condtrigs: {[Name=#Identifier]: #ConditionTrigger}
	gasrespires: {[Name=#Identifier]: #GasRespire}
	installables: {[Name=#Identifier]: #Installable}
	interactions: {[Name=#Identifier]: #Interaction}
	items: {[Name=#Identifier]: #Item}
	loot: {[Name=#Identifier]: #Loot}
	slots: {[Name=#Identifier]: #Slot}
	tickers: {[Name=#Identifier]: #Ticker}
}
