# k8sdev

## About

This project demonstrates mounting your local MacOS filesystem to a Kubernetes pod using [rclone](https://rclone.org/).

## Prerequisites

- [Docker](https://www.docker.com/)
- [GNU sed](https://www.gnu.org/software/sed/)
- [kind](https://kind.sigs.k8s.io/)
- [kubectl](https://kubernetes.io/docs/reference/kubectl/)

## Steps

### Enable Remote Login under System Settings > General > Sharing > Advanced

```sh
sudo systemsetup -setremotelogin on
```

### Clone the repository

```sh
git clone https://github.com/chrisbradleydev/k8sdev.git
cd k8sdev
```

### Generate public/private ed25519 key pair

```sh
ssh-keygen -t ed25519 -a 32 -f ./id_ed25519 -N ""
```

### Add public key to `~/.ssh/authorized_keys`

```sh
echo "" >> ~/.ssh/authorized_keys
cat id_ed25519.pub >> ~/.ssh/authorized_keys
```

### Run `init.sh` for guided initialization

```sh
./init.sh
```

### Observe behavior in container

```sh
kubectl exec -ti $(kubectl get po -n k8sdev -o yaml | yq '.items[0].metadata.name') -c alpine321 -- sh
```
