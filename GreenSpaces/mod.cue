package GreenSpaces

import (
	"github.com/nemo157/ostranauts-mods/schema"
)

data: schema.#Data

info: schema.#Info & {
	strAuthor:      "Nemo157"
	strModURL:      "https://github.com/Nemo157/ostranauts-mods"
	strGameVersion: "0.10.0.0"
	strModVersion:  "0.0.1"
	strNotes:       "Plants"
}
