# OpenBrisk Runtime

The API and service definitions every runtime must implement.

## Build Structure

Every runtime implementation needs to have a `test` make target hat runs the current version 
of the runtime server on port `8080`. A echo function with parameters (POST) must be
loaded from the examples. The function will get the following data:

```json
{
    "text": "Hello World!"
}
```

## Forward Function Result Structure

```json
{
    "result": "Hallo Welt!",
    "forward": {
        "to": "https://target.url/test"
    }
}
```

## Integration Tests

### TODO: Create integration test suite that every runtime must pass

- Execute syncronous GET function
- Execute asynchonous GET function
- Execute syncronous POST function
- Execute asynchonous POST function
- Restore function dependencies when available
- Kill function when timeout value is reached
- Check if defined endpoints are available

## Overview

| Runtime   | Status | Server | Health | Function | Duration | Timeout | Deps | Forward | Hide Protocol | Custom Context |
|-----------|:------:|:------:|:------:|:--------:|:--------:|:-------:|:----:|:-------:|:-------------:|:---------------:
| .NET Core |    O   |    +   |    +   |     +    |     +    |    +    |   +  |    +    |       +       |        -       |
| Java      |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| Go        |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| Ruby      |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| Python    |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| PHP       |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| Node.js   |    O   |    +   |    +   |     -    |     -    |    -    |   -  |    -    |       -       |        -       |
| Binary    |    O   |    +   |    +   |     +    |     +    |    +    |   +  |    +    |       +       |       N/A      |

TODO: Version ENV?

## Custom Headers

`X-OpenBrisk-Forward`

`X-OpenBrisk-Duration`