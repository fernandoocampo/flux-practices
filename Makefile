watch-kustoms:
	flux get kustomizations --watch

ip-localstack:
	docker inspect infra-fruits-localstack-1 | grep IPAddress

describe-lambda:
	kubectl describe Function gofunction

reconcile:
	flux reconcile kustomization fruits

check:
	flux check