# SSH Bastion Host

Securely SSH into private servers via bastion host server to improve security and access restriction.

Bastion hosts should be the only public facing server and use ssh proxy jump via bastion host to reach the private server.

### Build SSH Bastion host docker

```
docker build --build-arg SSH_USER=bastionuser -t ssh-bastion-host .
```

### Connect via SSH Bastion host

```
ssh -J user@<bastion:port> <user@remote:port>
```

### Add connection config to ssh config

```
Host bastion-host-nickname
  User bastionuser
  HostName bastion-hostname
  Port 2222

Host remote-host-nickname
  HostName remote-hostname
  ProxyJump bastion-host-nickname
```

```
ssh remote-host-nickname
```

### More info about bastion host

[Setting up SSH Bastion host!](https://goteleport.com/blog/ssh-bastion-host/)
[Connecting to servers via SSH Bastion host!](https://www.redhat.com/sysadmin/ssh-proxy-bastion-proxyjump)
