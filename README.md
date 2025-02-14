# tempo-provider-goname

## GoName Provider for Tempo

`tempo-provider-goname` is a provider for [`tempo`](https://github.com/indaco/tempo) that adds Go-specific string transformation functions to templates.

## 🔧 Usage

```bash
tempo register functions --name goname --url https://github.com/indaco/tempo-provider-goname.git
```

Once added to `tempo`, this provider enables several Go-related naming utilities as template functions.

## 🚀 Available Template Functions

| Function Name        | Template Function Name | Description                                                                                                |
| :------------------- | :--------------------- | :--------------------------------------------------------------------------------------------------------- |
| `ToGoPackageName`    | `goPackageName`        | Converts a string into a valid Go package name. Handles kebab-case, snake_case, camelCase, and PascalCase. |
| `ToGoExportedName`   | `goExportedName`       | Converts a string to a valid exported Go function name (PascalCase).                                       |
| `ToGoUnexportedName` | `goUnexportedName`     | Converts a string to a valid unexported Go function name (camelCase).                                      |

## 🆓 License

This project is licensed under the MIT License.
