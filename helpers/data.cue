package helpers

import (
	"list"
	"strings"
	"github.com/nemo157/ostranauts-mods/schema"
)

#Identifier: schema.#Identifier

_#CEHelper: {
	input: {
		[#Identifier]: float | *1.0 | {chance: float | *1.0, count: float | *1.0}
	}
	output: [...schema.#ConditionEquation] & [
		for condition, count in input if *(count >= 0.0) | false {
			"\(condition)=\(1.0)x\(count)"
		},
		for condition, count in input if *(count < 0.0) | false {
			"-\(condition)=\(1.0)x\(-count)"
		},
		for condition, values in input if *(values.count >= 0.0) | false {
			"\(condition)=\(values.chance)x\(values.count)"
		},
		for condition, values in input if *(values.count < 0.0) | false {
			"-\(condition)=\(values.chance)x\(-values.count)"
		},
	]
}

#Data: schema.#Data & {
	conditions: {
		[#Identifier]: {
			strColor:         _ | *"Neutral"
		}
	}

	condowners: {
		[#Identifier]: {
			#StartingConds: _#CEHelper.input
			aStartingConds: _ | *(_#CEHelper & {input: #StartingConds}).output
			#StartingCondRules: {[#Identifier]: float}
			aStartingCondRules: _ | *[
						for rule, modifier in #StartingCondRules {
					"\(rule)=\(modifier)"
				},
			]
			#UpdateCommands: {
				GasRespire2: {[#Identifier]: #Identifier | *"null"}
				Destructable: {
					[Stat=#Identifier]: {
						LootModeSwitch:    #Identifier
						DamageCondMax:     #Identifier | *"\(Stat)Max"
						SignalCheckPeriod: float | *1.0
					}
					StatDamage?: _ | *{LootModeSwitch: "ACTDefaultDestroy"}
				}
			}
			aUpdateCommands: _ | *[
						for id, data in #UpdateCommands.GasRespire2 {
					"GasRespire2,\(id),\(data)"
				},
				for id, data in #UpdateCommands.Destructable {
					strings.Join([
						"Destructable",
						id,
						data.LootModeSwitch,
						data.DamageCondMax,
						"\(data.SignalCheckPeriod)",
					], ",")
				},
			]
			#SlotEffects: {[Slot=#Identifier]: #Identifier}
			mapSlotEffects: _ | *list.FlattenN([
					for slot, effect in #SlotEffects {
					[slot, effect]
				},
			], 1)
			#Tickers: {[#Identifier]: _}
			aTickers: _ | *[ for ticker, _ in #Tickers {ticker}]
		}
	}

	condrules: {
		[#Identifier]: {
			#Thresholds: {
				[#Identifier]: {
					fMinAdd: float | *1.0
					fMaxAdd: float | *-1.0
					fMin:    float
					fMax:    float
				}
			}
			aThresholds: _ | *{
				let keys = [ for key, _ in #Thresholds {key}]
				[
					for i in list.Range(0, len(keys), 1) {
						{
							strLootNew: keys[i]
							fMin:       _ | *(*#Thresholds[keys[i-1]].fMax | 0.0)
							fMax:       _ | *9e99
							#Thresholds[keys[i]]
						}
					},
				]
			}
		}

		[Name=strings.HasPrefix("Dc")]: {strCond: strings.TrimPrefix(Name, "Dc")}
	}

	condtrigs: {
		[#Identifier]: {
			fChance:      _ | *1.0
			fCount:       _ | *1.0
			bAND: _ | *true
		}

		[Name=strings.HasPrefix("TUp")]: {
			strCondName: strings.TrimPrefix(Name, "TUp")
			fCount: 1.0
		}

		[Name=strings.HasPrefix("TDn")]: {
			strCondName: strings.TrimPrefix(Name, "TDn")
			fCount: -1.0
		}
	}

	gasrespires: {
		[#Identifier]: {
			fGasPressTotalRef: _ | *101.3
			fConvRate:         _ | *1.0
			fSignalCheckRate:  _ | *1.0
			bAllowExternA:     _ | *true
			bAllowExternB:     _ | *true
		}
	}

	installables: {
		[#Identifier]: {
			strBuildType: _
			strCTThemMultCondUs:     "StatInstallRate\(strBuildType)"
			#Inputs:                 _#CEHelper.input
			aInputs:                 _ | *(_#CEHelper & {input: #Inputs}).output
			#ToolCTsUse: {[#Identifier]: _}
			aToolCTsUse: _ | *[ for condtrig, _ in #ToolCTsUse {condtrig}]
			#LootCOs: {[#Identifier]: _}
			aLootCOs: _ | *[ for loot, _ in #LootCOs {loot}]
		}

		[strings.HasSuffix("Install")]: {
			strJobType:          "install"
			strAllowLootCTsThem: "CONDInstallProgressx5"
			strProgressStat:     "StatInstallProgress"
		}

		[strings.HasSuffix("Uninstall")]: {
			strJobType:          "uninstall"
			strAllowLootCTsThem: "CONDUninstallProgressx5"
			strProgressStat:     "StatUninstallProgress"
		}
	}

	loot: {
		[#Identifier]: {
			#COs:       _#CEHelper.input
			aCOs:       _ | *(_#CEHelper & {input: #COs}).output
			#Loots:     _#CEHelper.input
			aLoots:     _ | *(_#CEHelper & {input: #Loots}).output
		}

		[strings.HasPrefix("COND")]: {strType: "condition"}
		[strings.HasPrefix("TIL")]: {strType: "condition"}

		[Name=strings.HasPrefix("CONDDc") | strings.HasPrefix("CONDStat")]: {
			#COs: "\(strings.TrimPrefix(Name, "COND"))": _
		}

		[strings.HasPrefix("Itm")]: {strType: "item"}
		[strings.HasPrefix("CT")]: {strType: "trigger"}
	}
}
