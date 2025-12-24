# Example python code-server

This example uses an nginx proxy with basic authentication using SSL.

### Creating an nginx password:

```sh
htpasswd  -c ./config/nginx/htpasswd rcolfin
```