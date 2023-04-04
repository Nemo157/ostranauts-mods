package GreenSpaces

_Growable: {
	#StartingConds: {
		IsPlant:    _
		StatSugar:  _
		StatEnergy: _
	}
	#Tickers: {
		Grow: _
	}
	#StartingCondRules: {
		DcStatGrowth: 1.0
	}
}

data: {
	conditions: {
		StatGrowth: strDesc: "[us]'s current growth."
		StatGrowthAttempt: {
			strDesc: "[us] is attempting to grow."
			aNext: ["TUpStatGrowthSuccess", "TUpStatGrowthFailure"]
			fDuration: 0.00028
		}
		StatGrowthSuccess: {
			strDesc: "[us] is growing."
			aNext: ["TUpStatGrowth", "TDnStatSugar", "TDnStatEnergy"]
			fDuration: 0.00028
		}
		StatGrowthFailure: {
			strDesc: "[us] is consuming itself."
			aNext: ["TDnStatGrowth"]
			fDuration: 0.00028
		}
		DcGrowth01: {
			strNameFriendly: "Smol"
			strDesc:         "[us] is smol."
		}
		DcGrowth02: {
			strNameFriendly: "Growing"
			strDesc:         "[us] is growing."
		}
		DcGrowth03: {
			strNameFriendly: "Growing"
			strDesc:         "[us] is growing even more."
		}
		DcGrowth04: {
			strNameFriendly: "Thicc"
			strDesc:         "[us] is getting thicc."
		}
		DcGrowth05: {
			strNameFriendly: "Extra thicc"
			strDesc:         "[us] is getting _really_ thicc."
		}
		DcGrowthMax: {
			strNameFriendly: "Fully grown"
			strDesc:         "[us] is fully grown."
		}
	}

	condrules: {
		DcStatGrowth: {
			#Thresholds: {
				CONDDcGrowth01: {fMax: 5.0}
				CONDDcGrowth02: {fMax: 10.0}
				CONDDcGrowth03: {fMax: 20.0}
				CONDDcGrowth04: {fMax: 40.0}
				CONDDcGrowth05: {fMax: 80.0}
				CONDDcGrowthMax: _
			}
		}
	}

	condtrigs: {
		TUpStatGrowth: _
		TDnStatGrowth: _
		// Has enough sugar and energy to grow bigger, above a minimum reserve
		TIsReadyGrowthSuccess: {
			aReqs: ["StatSugar", "StatEnergy"]
			aForbids: ["DcSugarMin", "DcEnergyMin", "DcGrowthMax"]
		}
		TUpStatGrowthSuccess: aTriggers: ["TIsReadyGrowthSuccess"]
		// Not only doesn't have enough sugar and energy to grow bigger, is lacking
		// in one or the other and can't maintain current size so gets smaller
		THasSugarAndEnergy: aReqs: ["StatSugar", "StatEnergy"]
		TIsReadyGrowthFailure: {
			aReqs: ["StatGrowth"]
			aTriggersForbid: ["THasSugarAndEnergy"]
		}
		TUpStatGrowthFailure: aTriggers: ["TIsReadyGrowthFailure"]
	}

	loot: {
		CONDTickGrow: #COs: StatGrowthAttempt: _
		CONDDcGrowth01:  _
		CONDDcGrowth02:  _
		CONDDcGrowth03:  _
		CONDDcGrowth04:  _
		CONDDcGrowth05:  _
		CONDDcGrowthMax: _
	}

	tickers: {
		Grow: {
			strCondLoot: "CONDTickGrow"
			fPeriod:     1.0
			bRepeat:     true
		}
	}
}
