# Construção de Imagens

## Construir uma imagem a partir de um Dockerfile:
docker build -t nome-da-imagem .

# Gerenciamento de Contêineres

## Iniciar um contêiner a partir de uma imagem:
docker run -d --name nome-do-container nome-da-imagem

## Listar contêineres em execução:
docker ps

## Listar todos os contêineres (incluindo parados):
docker ps -a

## Parar um contêiner em execução:
docker stop nome-do-container

## Iniciar um contêiner parado:
docker start nome-do-container

## Remover um contêiner parado:
docker rm nome-do-container

# Gerenciamento de Imagens

##Listar todas as imagens:
docker images

## Remover uma imagem:
docker rmi nome-da-imagem

# Acessando Contêineres

## Acessar o terminal de um contêiner em execução:
docker exec -it nome-do-container sh

# Copiar arquivos entre o host e o contêiner:

docker cp caminho/local nome-do-container:caminho/destino
docker cp nome-do-container:caminho/origem caminho/local
Docker Compose

# Iniciar serviços definidos em um arquivo docker-compose.yml:

docker-compose up -d

## Parar serviços definidos em um arquivo docker-compose.yml:
docker-compose down

## Reiniciar serviços definidos em um arquivo docker-compose.yml:
docker-compose restart

## Executar um comando em um serviço definido no docker-compose.yml:
docker-compose exec nome-do-servico comando

## Listar serviços em execução definidos no docker-compose.yml:
docker-compose ps

## Ver logs dos serviços definidos no docker-compose.yml:
docker-compose logs
docker-compose logs nome-do-servico

# Rede e Volumes

## Criar uma rede Docker:
docker network create nome-da-rede

## Conectar um contêiner a uma rede:
docker network connect nome-da-rede nome-do-container

## Desconectar um contêiner de uma rede:
docker network disconnect nome-da-rede nome-do-container

## Criar um volume Docker:
docker volume create nome-do-volume

## Listar volumes Docker:
docker volume ls

## Remover um volume Docker:
docker volume rm nome-do-volume

# Exemplo Prático para Laravel Passo a Passo:

## Construir a imagem do Laravel:
docker-compose build

## Iniciar os serviços (Laravel, PostgreSQL, Nginx):
docker-compose up -d

## Acessar o contêiner Laravel:
docker-compose exec app sh

## Executar migrações do Laravel:
docker-compose exec app php artisan migrate

## Ver logs do serviço Laravel:
docker-compose logs app

## Reiniciar os serviços:
docker-compose restart

## Parar e remover todos os serviços e volumes:
docker-compose down -v
