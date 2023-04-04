package GreenSpaces

_Photosynthesizeable: {
	#StartingConds: {
		IsPlant:   _
		StatSugar: _
	}
	#StartingCondRules: {
		DcStatPhotosynthesizing: 1.0
		DcStatSugar:             _
	}
	#UpdateCommands: {
		GasRespire2: {
			PlantPhotosynthesis: _
		}
	}
}

data: {
	conditions: {
		StatPhotosynthesizing: strDesc: "[us] is photosynthesizing."
		StatPhotosynthesizingDone: {
			strDesc: "[us] has completed a round of photosynthesizing."
			aNext: [
				"TUpStatSugar",
				"TUpStatPhotosynthesizingBlocked",
				"TDnStatPhotosynthesizing",
			]
			fDuration: 0.00028
		}
		// blocking photosynthesis for a set time caps the dependence on CO2
		// partial pressue, allowing it to get to extreme levels still
		StatPhotosynthesizingBlocked: {
			strDesc:   "[us] has photosynthesized enough for now."
			fDuration: 0.1
		}
	}

	condrules: {
		DcStatPhotosynthesizing: {
			#Thresholds: {
				CONDStatPhotosynthesizingDone: {fMin: 1.0}
			}
		}
	}

	condtrigs: {
		TIsReadyPhotosynthesis: {
			aReqs: ["IsPlant"]
			aForbids: ["StatPhotosynthesizingBlocked", "DcSugarMax"]
		}
		TDnStatPhotosynthesizing:        _
		TUpStatPhotosynthesizingBlocked: _
	}

	gasrespires: {
		PlantPhotosynthesis: {
			strCTA:          "TIsAirtightRoom"
			strCTB:          "TIsAirtightRoom"
			strGasIn:        "CO2"
			strGasOut:       "O2"
			fVol:            0.001
			fConvRate:       0.5625
			strSignalCTMain: "TIsReadyPhotosynthesis"
			strStat:         "StatPhotosynthesizing"
			fStatRate:       5000.0
		}
	}

	loot: {
		CONDStatPhotosynthesizingDone: _
	}
}
