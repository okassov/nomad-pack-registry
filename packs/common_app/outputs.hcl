You deployed a [[ template "job_name" . ]] service to Nomad.

There are [[ .common_app.count ]] instances of your job now running.

The service is using the image: [[.common_app.image | quote]]

[[ if .common_app.register_consul_service ]]
You registered an associated Consul service named [[ template "job_name" . ]].
[[ end ]]
