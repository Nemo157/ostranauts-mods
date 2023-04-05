package GreenSpaces

import (
	"strings"
)

data: {
	conditions: {
		IsPlant: {
			strDesc:       "[us] is a plant."
			nDisplaySelf:  2
			nDisplayOther: 1
		}
		IsMizuna: {
			strDesc:       "[us] is a mizuna lettuce."
			nDisplaySelf:  2
			nDisplayOther: 1
		}
		IsPlantable: {
			strDesc:       "[us] can be planted in."
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
			strDesc: strings.Replace("""
				A bulkhead mounted trellis of decorative plants,
				commonly setup on ships for improving air quality
				""", "\n", " ", -1)
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
			_ItmTrellisBase
			strNameFriendly: "Trellis"
			strItemDef:      "ItmTrellis"
			#StartingConds: {
				IsInstalled: _
				IsPlantable: _
			}
			strPortraitImg: "ItmTrellis"
			aInteractions: [
				"ACTTrellisPlantMizuna",
			]
		}

		ItmTrellisMizuna: {
			_ItmTrellisBase
			strNameFriendly: "Trellis with Mizuna Lettuce"
			strItemDef:      "ItmTrellisMizuna"
			#StartingConds: {
				IsInstalled: _
				IsPlant:     _
				IsMizuna:    _
			}
			#StartingCondRules: {
				DcStatSugar:  100.0
				DcStatEnergy: 100.0
			}
			strPortraitImg: "ItmTrellisMizuna"
			aInteractions: [
				"ACTTrellisMizunaUnplant",
			]
			_Photosynthesizeable
			_Respirable
			_Growable
		}

		ItmTrellisLoose: {
			_ItmTrellisBase
			strNameFriendly: "Trellis (Loose)"
			strItemDef:      "ItmTrellisLoose"
			#StartingConds: {
				IsCumbersome: _
			}
			#SlotEffects: {
				drag: "Blank"
			}
			strPortraitImg: "ItmTrellisLoose"
		}
	}

	condtrigs: {
		TIsMizuna: {
			aReqs: ["IsMizuna"]
		}
		TIsPlant: {
			aReqs: ["IsPlant"]
		}
		TIsPlantable: {
			aReqs: ["IsPlantable"]
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

		_TrellisUninstall: {
			strInteractionTemplate: "ACTUninstallNoSparksTEMP"
			CTThem:                 "TIsTrellisInstalled"
			fTargetPointRange:      2.0
			fDuration:              0.001
			#ToolCTsUse: TIsToolMortorq: _
			#LootCOs: ItmTrellisLoose:   _
			strBuildType:           "FURN"
			strCTThemMultCondTools: "IsToolMortorq"
		}

		TrellisUninstall: {
			_TrellisUninstall
			strActionCO: "ItmTrellis"
		}

		TrellisMizunaUninstall: {
			_TrellisUninstall
			strActionCO: "ItmTrellisMizuna"
			#LootCOs: ItmScrapTrash: _
		}
	}

	interactions: {
		ACTTrellisPlantMizuna: {
			strTitle:          "Plant Mizuna"
			strDesc:           "[us] is planting mizuna lettuce in [them]."
			strTargetPoint:    "use"
			fTargetPointRange: 1.0
			strDuty:           "Construct"
			strAnim:           "Tooling"
			strIdleAnim:       "Idle"
			strMapIcon:        "IcoPlant"
			aInverse: [
				"ACTTrellisPlantMizunaAllow,[us],[them]",
			]
			fDuration:       0.001
			strThemType:     "Other"
			nLogging:        1
			bHumanOnly:      true
			bOpener:         true
			bIgnoreFeelings: true
			CTTestThem:      "TIsPlantable"
		}

		ACTTrellisPlantMizunaAllow: {
			strTitle:              "Planted Mizuna"
			strDesc:               "[us] has planted mizuna lettuce in [them]."
			fTargetPointRange:     1.0
			fDuration:             0.00027
			strThemType:           "Other"
			nLogging:              1
			LootCTsUs:             "CTACTPlant"
			objLootModeSwitchThem: "ItmTrellisMizuna"
		}

		ACTTrellisMizunaUnplant: {
			strTitle:          "Tear Out Mizuna"
			strDesc:           "[us] is tearing mizuna lettuce out of [them]."
			strTargetPoint:    "use"
			fTargetPointRange: 1.0
			strDuty:           "Construct"
			strAnim:           "Tooling"
			strIdleAnim:       "Idle"
			strMapIcon:        "IcoPlant"
			aInverse: [
				"ACTTrellisMizunaUnplantAllow,[us],[them]",
			]
			fDuration:       0.001
			strThemType:     "Other"
			nLogging:        1
			bHumanOnly:      true
			bOpener:         true
			bIgnoreFeelings: true
			CTTestThem:      "TIsMizuna"
		}

		ACTTrellisMizunaUnplantAllow: {
			strTitle:              "Torn Out Mizuna"
			strDesc:               "[us] has torn mizuna lettuce out of [them]."
			fTargetPointRange:     1.0
			fDuration:             0.00027
			strThemType:           "Other"
			nLogging:              1
			LootCTsUs:             "CTACTUnplant"
			objLootModeSwitchThem: "ItmTrellisUnplanted"
		}
	}

	items: {
		_ItmTrellis: {
			fZScale: 0.75
			nCols:   1
			aSocketAdds: [
				"TILTrellisAdds",
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

		ItmTrellis: {
			_ItmTrellis
			strImg:     "ItmTrellis"
			strImgNorm: "ItmTrellisN"
		}

		ItmTrellisMizuna: {
			_ItmTrellis
			strImg:     "ItmTrellisMizuna"
			strImgNorm: "ItmTrellisMizunaN"
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
		ItmTrellis: #COs: ItmTrellis:             _
		ItmTrellisMizuna: #COs: ItmTrellisMizuna: _
		ItmTrellisLoose: #COs: ItmTrellisLoose:   _
		ItmTrellisUnplanted: #Loots: {
			ItmTrellis:    _
			ItmScrapTrash: _
		}

		TILPlant: #COs: IsPlant:     _
		TILPlantAdds: #COs: IsPlant: _
		TILTrellis: #COs: IsTrellis: _
		TILTrellisAdds: #COs: {
			IsWallDeco: _
			IsTrellis:  _
		}

		ItmRandomLot18: #Loots: ItmTrellisLoose:              _
		ItmRandomLotCrewStartLoot18: #Loots: ItmTrellisLoose: _

		CTACTPlant: #COs: {
			TUpAchievement: 0.1
			TUpMeaning:     0.1
			TUpFatigue:     0.03
		}
		CTACTUnplant: #COs: {
			TUpAchievement: 0.1
			TDnMeaning:     0.1
			TUpFatigue:     0.03
		}
	}
}
