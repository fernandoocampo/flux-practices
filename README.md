# flux-practices
just flux learning

## Fruits with Flux

0. Check kubernetes cluster first

```sh
flux check --pre
```

1. Create a token for this on your github account `settings / Developer settings`

Check these
```text
 repo               Full control of private repositories
 repo:status        Access commit status
 repo_deployment    Access deployment status
 public_repo        Access public repositories
 repo:invite        Access repository invitations
 security_events    Read and write security events
```


2. Install flux onto your cluster

```sh
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=flux-practices \
  --branch=master \
  --path=./clusters/kind \
  --personal
```

3. Create a GitRepository manifest pointing to fruits repository’s master branch:
```sh
flux create source git fruits \
    --namespace=flux-system \
    --url=https://github.com/fernandoocampo/fruits \
    --branch=master \
    --interval=60s \
    --export > ./clusters/kind/fruits-source.yaml
```

4. push ./clusters/kind/fruits-source.yaml into github repository.

5. Deploy fruits application creating  a kustomization that applies the fruits deployment.

```sh
flux create kustomization fruits \
  --target-namespace=default \
  --source=fruits \
  --path="./kustomize" \
  --prune=true \
  --interval=5m \
  --export > ./clusters/kind/fruits-kustomization.yaml
```

6. To troubleshoot any issues, you can run following commands.

* describe the flux gitrepository

```sh
kubectl describe -n flux-system gitrepository flux-system
```

## Monitoring with prometheus and grafana.

Follow this [tutorial](https://fluxcd.io/flux/guides/monitoring/)