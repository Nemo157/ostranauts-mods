package schema

#Info: {
	strAuthor:      string
	strModURL:      string
	strGameVersion: =~"\\d+(\\.\\d+){3}"
	strModVersion:  =~"\\d+\\.\\d+"
	strNotes:       string
}

#Mod: {
	info: #Info
	data: #Data
}
