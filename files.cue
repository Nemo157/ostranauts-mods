package cli

import (
	"github.com/nemo157/ostranauts-mods/schema"
	"github.com/nemo157/ostranauts-mods/GreenSpaces"
)

basePath: "output"

mods: {
	[string]:      schema.#Mod
	"GreenSpaces": GreenSpaces
}

files: {
	for modName, mod in mods {
		"\(modName)/mod_info.json": [{strName: modName, mod.info}]
		for k1, v1 in mod.data {
			"\(modName)/data/\(k1)/\(k1).json": [
				for k2, v2 in v1 {
					{strName: k2, {v2}}
				},
			]
		}
	}
}
