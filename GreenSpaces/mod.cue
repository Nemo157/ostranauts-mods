package GreenSpaces

import (
  "nemo157.com/ostranauts-mods/schema"
)

data: schema.#Data

info: schema.#Info & {
  strAuthor: "Nemo157"
  strGameVersion: "0.10.0.0"
  strModVersion: "0.1"
  strNotes: "Plants"
}
