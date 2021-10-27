// allow nomad-pack to set the job name

[[- define "job_name" -]]
[[- if eq (.common_app.job_name | toString) "" -]]
[[- .nomad_pack.pack.name | quote -]]
[[- else -]]
[[- .common_app.job_name | quote -]]
[[- end -]]
[[- end -]]

// only deploys to a region if specified

[[- define "region" -]]
[[- if not (eq .common_app.region "") -]]
region = [[ .common_app.region | quote]]
[[- end -]]
[[- end -]]
