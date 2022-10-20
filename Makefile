watch-kustoms:
	flux get kustomizations --watch

ip-localstack:
	docker inspect infra-fruits-localstack-1 | grep IPAddress

describe-lambda:
	kubectl describe Function gofunction