package cli

import (
  "encoding/json"
  "list"
  "strings"
  "path"
  "tool/cli"
  "tool/file"
)

command: {
  write: {
    task: {
      for filename, data in files {
        "\(filename)": {
          _path: path.Join([basePath, filename])
          _dir: path.Dir(_path)
          _contents: json.Marshal(data)
          mkdir: file.MkdirAll & {
            path: _dir
            $after: clean
          }
          create: file.Create & {
            filename: _path
            contents: _contents
            $after: mkdir
          }
          after: cli.Print & {
            text: "written \(_path)"
            $after: create
          }
        }
      }
    }
  }

  copy: {
    task: {
      for modName, _ in mods {
        "\(modName)": {
          rootGlob: file.Glob & {
            glob: "\(modName)/images/*.png"
          }
          dirsGlob: file.Glob & {
            glob: "\(modName)/images/*/*.png"
          }
          copy: {
            for _filename in list.FlattenN([rootGlob.files, dirsGlob.files], 1) {
              "\(_filename)": {
                _path: path.Join([basePath, _filename])
                _dir: path.Dir(_path)
                mkdir: file.MkdirAll & {
                  path: _dir
                  $after: clean
                }
                read: file.Read & {
                  filename: _filename
                }
                create: file.Create & {
                  filename: _path
                  contents: read.contents
                  $after: mkdir
                }
                after: cli.Print & {
                  text: "copied \(_filename) to \(_path)"
                  $after: create
                }
              }
            }
          }
        }
      }
    }
  }

  build: {
    written: write
    copied: copy
  }

  clean: file.RemoveAll & {
    path: basePath
  }

  dump: {
    task: print: cli.Print & {
      text: strings.Join([
        for file, data in files {
          "\(file): \(json.Indent(json.Marshal(data), "", "  "))"
        }
      ], "\n\n")
    }
  }

  dumpTasks: {
    task: print: cli.Print & {
      text: json.Indent(json.Marshal(command.write.task), "", "  ")
    }
  }
}
