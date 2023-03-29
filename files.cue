package resources

import (
  "nemo157.com/ostranauts-mods/greenspaces"
)

files: {
  "GreenSpaces/mod_info.json": [greenspaces.info]
  for k1, v1 in greenspaces.data {
    "GreenSpaces/data/\(k1)/\(k1).json": [
      for k2, v2 in v1 {
        { strName: k2, { v2 } }
      }
    ]
  }
}
