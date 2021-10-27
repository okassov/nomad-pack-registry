# Common App

This pack is a used to deploy a Docker image to as a service job to Nomad.

This is ideal for configuring and deploying a simple web application to Nomad.

## Customizing the Docker Image

The docker image deployed can be replaced with a variable. In the example
below, we will deploy and run `httpd:latest`.

```
nomad-pack run common_app --var image="httpd:latest"
```

## Customizing Ports

The ports that are exposed via Docker can be customized as well.

In this case, we'll write the port values to a file called `./overrides.hcl`:

```
{
  name = "http"
  port = 8000
},
{
  name = "https"
  port = 8001
}
```

Then pass the file into the run command:

```
nomad-pack run common_app -f ./overrides.hcl`"
```

## Customizing Resources

The application resource limits can be customized:

```
resources = {
  cpu = 500
  memory = 501
}
```

## Customizing Environment Variables

Environment variables can be added:

```
env_vars = [
  {
    key = "foo"
    value = 1
  }
]
```

## Consul Service and Load Balancer Integration

```
consul_tags = [
  "urlprefix-/",
  "traefik.enable=true",
  "traefik.http.routers.http.rule=Path(`/`)",
]
```

## Customizing Consul

```
health_check = {
  interval = "20s"
  timeout  = "3s"
}
```
