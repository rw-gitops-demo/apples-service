# Apples Service

This repository is one of a set providing a demonstration of a [GitOps](https://www.weave.works/technologies/gitops/) approach using [Argo CD](https://argo-cd.readthedocs.io/en/stable/) as the deployment tool and Kustomise for defining the Kubernetes manifests.
The full set of repositories in the demo are:
- [ops-manifests](https://github.com/rw-gitops-demo/ops-manifests) - the Kubernetes ops manifests, including Argo CD
- [app-manifests](https://github.com/rw-gitops-demo/app-manifests) - the Kubernetes application manifests
- [apples-service](https://github.com/rw-gitops-demo/apples-service) - an example Node.js application
- [gitops-scripts](https://github.com/rw-gitops-demo/gitops-scripts) - a set of scripts installed into the manifests repos as a git submodule

Please follow the [ops-manifests](https://github.com/rw-gitops-demo/ops-manifests) and [app-manifests](https://github.com/rw-gitops-demo/app-manifests) READMEs to set up the cluster before pushing changes to this repo.

The purpose of this repository is to provide an example microservice to be deployed to the Kubernetes cluster.

## CI GitHub action

There is a single `CI` GitHub action that runs on every push to `main`. The action performs the following steps:
- it tags the commit with the action run number;
- it creates a release with a CHANGELOG derived from the commit messages since the previous tag;
- it builds a docker image and pushes this to a GitHub registry; and finally
- it triggers the `CD` action in the [app-manifests](https://github.com/rw-gitops-demo/app-manifests) repository.

The `CD` action in the [app-manifests](https://github.com/rw-gitops-demo/app-manifests) will update the image name for the `apples-service` manifest to the newly built image and commit the change to that repository. Argo CD monitors the repository for changes, detects that the cluster is out-of-sync with the repo, and then rolls out the new version of the service.

Note that in order for the `CI` action to trigger the `CD` action in the [app-manifests](https://github.com/rw-gitops-demo/app-manifests) repository, it has been configured with a `DEPLOY_PAT` secret that has Read and Write access to actions for [app-manifests](https://github.com/rw-gitops-demo/app-manifests).
