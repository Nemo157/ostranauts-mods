package GreenSpaces

data: {
	conditions: {
		StatSugar: strDesc:  "[us]'s current stored sugar."
		DcSugarMin: strDesc: "[us]'s is nearly empty of sugar."
		DcSugarMax: strDesc: "[us]'s is full on sugar."
	}

	condrules: {
		DcStatSugar: {
			strCond: "StatSugar"
			#Thresholds: {
				CONDDcSugarMin: {fMax: 0.2}
				CONDDcSugarMax: {fMin: 1.0}
			}
		}
	}

	condtrigs: {
		TUpStatSugar: _
		TDnStatSugar: _
	}

	loot: {
		CONDDcSugarMin: _
		CONDDcSugarMax: _
	}
}
