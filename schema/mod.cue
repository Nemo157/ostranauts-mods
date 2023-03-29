package schema

#Mod: {
  info: {
      strName: string
      strAuthor: string | *""
      strModURL: string | *""
      strGameVersion: =~ "\\d+(\\.\\d+){3}"
      strModVersion: =~ "\\d+\\.\\d+"
      strNotes: string | *""
  }
  data: #Data
}
