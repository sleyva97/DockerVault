# Vault in a container

--------------------------------------------------------------------------------

## First some basics

### What is Vault?

Vault is a tool for securely accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, and more. Vault provides a unified interface to any secret, while providing tight access control and recording a detailed audit log. For more information please see the [vault documentation](https://www.vaultproject.io/docs/index.html).

### What are containers?

To start lets say what containers are not. Containers are not VMs. Sure there are some parallels but thinking of containers in this way can place limits on how you think they can be potentially used. Let consider container and some core technologies surrounding them.

#### Containers

Containers are a packaged self-contained unit that can run virtually anywhere. This includes dependancies as well as your application. Because they are clean, isolated environments they can be used for running your production applications in Kubernetes to testing out commands on you local machine in a clean, isolated environment. The lifecycle of a container is ideally short and the inside of a container should never be touched in production. If changes need to be made to the application or configuration of a container a new container with the changes should be built. This is a very high level explanation and only some of the use cases of containers. Here are some more resources to get started:

- [A Beginner-Friendly Introduction to Containers, VMs and Docker](https://medium.freecodecamp.org/a-beginner-friendly-introduction-to-containers-vms-and-docker-79a9e3e119b)
- [Docker Curriculum](https://docker-curriculum.com/)

#### Docker

Docker is a tool that is used to create, run, and manage applications using containers. For more information please see the [official documentation](https://docs.docker.com/).

#### Kubernetes

Kubernetes is a tool used to manage deployment, exposition, and scaling of containerized services. Think of the scheduler on your PC managing resources and allocating memory for your applications. Kubernetes does the same for your containers and handles the routing between your containers to provide a service. For more information please see the [official documentation](https://kubernetes.io/docs/home/)

### Build and run the container
```
docker build . -t vault
docker run -p 8200:8200 vault
```
Then run the following commands on your local machine to test that service is up. _Note: This step does require the vault binary be installed on the local machine. For help on installing that please see the [Vault Docs on how to install. ](https://www.vaultproject.io/docs/install/index.html)_

```
export VAULT_ADDR=127.0.0.1:8200
vault status
```

The output should look similar to this
```
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.3
Cluster Name: vault-cluster-0175ca94
Cluster ID: 752a4da9-fef8-ed59-3b00-f5516b4e6cba

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://172.17.0.2:8201
```

If these steps are successful you have a working instance of vault in a container to play around with locally on your machine.

### What is the Scope of this project?

The point of this project is to just mess around with Docker, Vault and containers. Each time the container will pull and build vault and consul from source. [Dumb-init](https://github.com/Yelp/dumb-init) is used right now to manage the processes in my container.

- [x] Run Docker version of vault and Consul
- [x] Separate containers for Docker and Consul
- [ ] Deploy into Google Cloud Platform using Kubernetes
- [ ] Find a way to securely manage unseal keys and auth tokens
- [ ] Automate the process
