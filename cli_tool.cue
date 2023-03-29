package resources

import (
  "encoding/json"
  "strings"
  "path"
  "tool/cli"
  "tool/file"
)

_basePath: "output"

command: {
  write: {
    task: {
      for filename, data in files {
        "\(filename)": {
          _path: path.Join([_basePath, filename])
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

  clean: file.RemoveAll & {
    path: _basePath
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
