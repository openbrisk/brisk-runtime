# Runtime Development Guide

OpenBrisk can support any language that can respond to a HTTP request.
So the easiest way for implementing a runtime is to start a web server
that reponds on certain endpoints. The mandarory endpoints are defined 
in the `docs-api/runtime.yml` swagger service definition. Every HTTP
server must run on the fixed port `8080`.

Every runtime must hide the underlying HTTP protocol from the function.
This means that runtime is responsible for extracting the (optional)
content from the request a provide it as a contect structure to the
function. The context structure will contain serveral other informations
extracted from the HTTP request and the environment.

Every runtime must provide a HTTP agnostic way for a function to indicate
that the returned result should be `POST`ed by the API gateway to a given 
endpoint. This can be an internal API gateway function or an external 
endpoint. The runtime must distinguish between those two types of targets
by hiding the internal API gateway URL from the function.

Runtimes can optionally support the ability to load dependencies for a 
function. The dependencies must be loaded when the container is started
that hosts the function. Dependency loading will increase the startup
time of a function significantely. 

> _Future versions will support for caching dependencies, so that only one 
> function startup downloads the dependencies to a shared location and only 
> function updates removed them._

Functions that need compilation should perform the compilation on container
startup or when the server is started.

> _Future versions will address this overhead by creating speciaized compiler
> containers ans services that will compile the function when it is created
> and stores the results in a shared location together with the dependencies._

## HTTP Server

The HTTP server must listen on port `8080`. 

## HTTP API

The mandatory API is defined using swagger. The definition can be found in 
the file `docs-api/runtime.yml`. Every runtime must implement the API.

- `GET /`
	- Executes the function without content, but with the rest of the context.
- `POST /`
	- Executes the function with the content. The content ca be one of the two types:
		- `text/plain`
		- `application/json`
	- The `Content-Type` must be respected when creating the content, which ca be
	  a simple string or a JSON formatted structure.
- `GET /healthz`
	- This just returns 200 OK for the Kubernetes Pod health check.
- `GET /stats`
	- This returns a stats structure which collects several informations about
	  the running server. For now this only provides infos about the runtime.

## Function Definition

The function code file and the function dependencies file will be available 
inside the container in a mounted volume unter the path `/openbrisk/`.

## Environment Variables

The following environment variables are available in the container for the
runtime.

- `MODULE_NAME`
	- The name of the functions module. This can vary between languages. The .NET 
      runtime f.e will use the name for the following:
		- a) Find a code file named `${MODULE_NAME}.cs`
		- b) Find a class name `${MODULE_NAME}` in the compiled assembly.
- `FUNCTION_HANDLER`
	- The name of the actual function to call by the runtime. The .NET runtime f.e.
	  will try to find a method named `${FUNCTION_HANDLER}` in the class `${MODULE_NAME}`
	  and invoke it.
- `FUNCTION_DEPENDENCIES`
	- The name of the file containing the functions dependencies. The .NET runtime
	  f.e will try to restore the packges from a file named `${FUNCTION_DEPENDENCIES}.csproj`
- `FUNCTION_TIMEOUT`
	- The functions runtime timeoout in seconds.

## Function Handler Definition

The implemented function handler expects a single paramter: `the function context`.
This context structure contains the content of the HTTP request (or an empty one if
the function is called via GET) and other infos from the HTTP request and the runtime
environment.

**Example**

To simplify the representation of the structure we show the JSON serialized version
as an example.

```json
{
  "data": "Hello World!",
  "headers": {
    "Content-Type": "text/plain",
      "X-OpenBrisk-Forwarded-From": "/utils/to-base64",
  },
  "env": {
    "MODULE_NAME": "HelloWorld",
    "FUNCTION_HANDLER": "Execute",
    "FUNCTION_TIMEOUT": 10,
    "PATH": "/bin:/usr/local/bin"
  }
}
```

## Function Return Value Definition

The function can return a value, or it may just be a worker function that doesn't.
But even if the function does not produce any output, it may want to trigger another
function using the HTTP header `X-OpenBrisk-Forward`. If this header is set in the
HTTP response from the runtime, the API gatways tries to forward the recieved content
as the body for a `POST` to the function or external URL defined in the header.

As we hide the HTTP protocol from the function implmentation, we need a unified way
for functions to set this header implicitly.

### Return Value Without Forward

If the result of the function should not be forwarded one can just return the result
value of the function, f.e. the string `Hello World` or ca complex strcutre that will
become JSON formatted.

## Return Value Including Forward

If the result of the function should be forwared to another function or an extenal
URL one must return a structure that matches the one below. 

> _Keep in mind that the JSON formatting will happen outside of the function by the 
> runtime itself._

```json
{
  "result": "Hello World",
  "forward": {
    "type": "url",
      "to": "https://requestb.in/1ai78f21"
  }
}
```

**Note:** You can create an external POST endpoint using requestb.in website. It allows
you to see any inspect the incoming requests. A great tool, when developing webhook.

```json
{
  "result": "Hello World",
  "forward": {
    "type": "function",
    "to": "/{namespaceName}/{functionName}"
  }	
}
```

**Note:** You do not need to know the DNS name of the API gateway, just the path to
the target function is needed.