job [[ template "job_name" . ]] {
  [[ template "region" . ]]
  datacenters = [[ .common_app.datacenters | toPrettyJson ]]

  type = "service"

  constraint {
    attribute = "${attr.kernel.name}"
    value     = "linux"
  }

  group "app" {
    count = [[ .common_app.count ]]

    network {
      [[- range $port := .common_app.ports ]]
      port [[ $port.name | quote ]] {
        to = [[ $port.port ]]
      }
      [[- end ]]
    }

    [[- if .common_app.register_consul_service ]]
    service {
      name = "[[ template "job_name" ]]"
      port = "[[ .common_app.consul_service_port ]]"
      tags = [[ .common_app.consul_tags | toPrettyJson ]]

      [[- if .common_app.has_health_check ]]
      check {
        name     = "alive"
        type     = "tcp"
        interval = [[ .common_app.health_check.interval | quote ]]
        timeout  = [[ .common_app.health_check.timeout | quote ]]
      }
      [[- end ]]
    }
    [[- end ]]

    restart {
      attempts = [[ .common_app.restart_attempts ]]
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "server" {
      driver = "docker"

      config {
        image = [[.common_app.image | quote]]
        ports = ["http"]
      }

      env {
        [[- range $key, $value := .common_app.env_vars ]]
        [[ $key ]] = [[ $value ]]
        [[- end ]]
      }

      vault {
        policies = [[.common_app.region]]-[[.coomon_app.job_name]]
      }
      
      resources {
        cpu    = [[ .common_app.resources.cpu ]]
        memory = [[ .common_app.resources.memory ]]
      }
    }
  }
}
