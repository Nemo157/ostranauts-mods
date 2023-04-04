package GreenSpaces

data: {
	conditions: {
		IsPlant: {
			strDesc:       "[us] is a plant."
			nDisplaySelf:  2
			nDisplayOther: 1
		}
		IsTrellis: {
			strDesc:       "[us] is a trellis."
			nDisplaySelf:  2
			nDisplayOther: 1
		}
	}

	condowners: {
		_ItmTrellisBase: {
			strDesc: "A bulkhead mounted trellis of decorative plants, commonly setup on ships for improving air quality"
			strType: "item"
			#StartingConds: {
				IsTrellis:                _
				IsFlammable:              _
				StatBasePrice:            200.0
				StatInstallProgressMax:   40.0
				StatUninstallProgressMax: 40.0
				StatMass:                 4.0
				StatDamageMax:            40.0
			}
			#UpdateCommands: {
				Destructable: {
					StatDamage: _
				}
			}
		}

		ItmTrellis: {
			strNameFriendly: "Trellis"
			strItemDef:      "ItmTrellis"
			#StartingConds: {
				IsInstalled: _
			}
			#StartingCondRules: {
				DcStatSugar:  100.0
				DcStatEnergy: 100.0
			}
			strPortraitImg: "ItmTrellis"
			_ItmTrellisBase
			_Photosynthesizeable
			_Respirable
			_Growable
		}

		ItmTrellisLoose: {
			strNameFriendly: "Trellis (Loose)"
			strItemDef:      "ItmTrellisLoose"
			#StartingConds: {
				IsCumbersome: _
			}
			#SlotEffects: {
				drag: "Blank"
			}
			strPortraitImg: "ItmTrellisLoose"
			_ItmTrellisBase
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
			strActionCO:            "ItmTrellisLoose"
			strInteractionTemplate: "ACTInstallNoSparksTEMP"
			CTThem:                 "TIsTrellisUninstalled"
			#Inputs: TIsTrellisUninstalled: _
			fTargetPointRange: 2.0
			fDuration:         0.001
			#ToolCTsUse: TIsToolMortorq: _
			#LootCOs: ItmTrellis:        _
			strStartInstall:        "ItmTrellis"
			strBuildType:           "FURN"
			strCTThemMultCondTools: "IsToolMortorq"
		}
		TrellisUninstall: {
			strActionCO:            "ItmTrellis"
			strInteractionTemplate: "ACTUninstallNoSparksTEMP"
			CTThem:                 "TIsTrellisInstalled"
			fTargetPointRange:      2.0
			fDuration:              0.001
			#ToolCTsUse: TIsToolMortorq: _
			#LootCOs: ItmTrellisLoose:   _
			strBuildType:           "FURN"
			strCTThemMultCondTools: "IsToolMortorq"
		}
	}

	items: {
		ItmTrellis: {
			strImg:     "ItmTrellis"
			strImgNorm: "ItmTrellisN"
			fZScale:    0.75
			nCols:      1
			aSocketAdds: [
				"TILWallDecoAdds",
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
			strImg:     "ItmTrellisLoose"
			strImgNorm: "ItmTrellisLooseN"
			fZScale:    0.5
			nCols:      1
			aSocketAdds: [
				"TILItemAdds",
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
		ItmTrellis: #COs: ItmTrellis:                         _
		ItmTrellisLoose: #COs: ItmTrellisLoose:               _
		ItmRandomLot18: #Loots: ItmTrellisLoose:              _
		ItmRandomLotCrewStartLoot18: #Loots: ItmTrellisLoose: _
	}
}
