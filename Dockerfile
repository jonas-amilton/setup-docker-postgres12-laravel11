# Usando a imagem base do PHP 8.2 com FPM (FastCGI Process Manager)
FROM php:8.2-fpm

# Definindo variáveis para o usuário do Docker Hub
ARG user=nome_do_usuario_de_dockerhub
ARG uid=1000

# Atualiza a lista de pacotes e instala dependências necessárias
# O libpq-dev é necessário para a extensão PDO PostgreSQL
# O libpng-dev é necessário para a extensão GD (para manipulação de imagens)
# O libonig-dev é necessário para a extensão mbstring (para operações de string multibyte)
# O libxml2-dev é necessário para a extensão XML (para processamento de XML)
# O zip e unzip são necessários para a manipulação de arquivos ZIP
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpq-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Limpa o cache do apt para reduzir o tamanho da imagem final
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Instala extensões PHP necessárias
# pdo_pgsql: suporte ao PDO para PostgreSQL
# mbstring: suporte a strings multibyte
# exif: suporte a metadados EXIF em imagens
# pcntl: suporte a funcionalidades de processos (necessário para algumas bibliotecas e frameworks)
# bcmath: suporte a operações matemáticas com precisão arbitrária
# gd: biblioteca para criação e manipulação de imagens
# sockets: suporte para comunicação via sockets
RUN docker-php-ext-install pdo_pgsql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    sockets

# Instala o Composer, uma ferramenta de gerenciamento de dependências para PHP
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Cria um usuário personalizado e configura o diretório home do usuário
# Adiciona o usuário aos grupos www-data e root
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Define o diretório de trabalho para o contêiner
WORKDIR /var/www

# Copia um arquivo PHP.ini personalizado para o contêiner
# O arquivo custom.ini deve estar na pasta docker/php do projeto
COPY docker/php/custom.ini /usr/local/etc/php/conf.d/custom.ini

# Define o usuário que será usado para executar os comandos subsequentes
USER $user
