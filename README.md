# Spotify vpn
## Spotify vpn service para iniciar n dockers con el servicio

### Como iniciar el servicio
El comando corre una serie de N contenedores con el servicio de sportify y una vpn conectada
la cantidad de contenedores es configurable en dicho script con el parametro $CONTAINERS
```bash
$ ./truchada start
```
### Como stopear el servicio
Para detener el servicio es necesario desconectar la vpn del mismo sino el docker
entra en un estado erroneo.
```bash
$ ./truchada stop
```
