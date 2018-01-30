# OpenBrisk Runtime

The API and service definitions every runtime must implement.

## API

- `GET /runtime/v1`
- `POST /runtime/v1`
- `GET /healthz`

## Server

- The server must run on port `8080`
- The module name is available via the environment variable `MODULE_NAME`
- The function handler name is available via the environment variable `FUNCTION_HANDLER`
- The functions dependencies file name is available via he environment variable `FUNCTION_DEPENDENCIES`
- The function timeout value (in seconds) is available via the environment variable `FUNCTION_TIMEOUT`
- The code and references files are located in a mounted volume unter the path `/openbrisk/`

## TODO

Create integration test suite that every runtime must pass.

- Execute syncronous GET function
- Execute asynchonous GET function
- Execute syncronous POST function
- Execute asynchonous POST function
- Restore function dependencies when available
- Kill function when timeout value is reached
- Check if defined endpoints are available
