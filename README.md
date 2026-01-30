# Apache Hello World com Docker Compose

Este projeto demonstra a configuração e execução de um servidor **Apache HTTP (httpd)** utilizando **Docker** e **Docker Compose**, servindo uma aplicação web simples (*Hello World*).

O foco do projeto é mostrar:

* Uso de arquivo **YAML** para definir um serviço Apache
* Definição do diretório da aplicação
* Execução de uma aplicação web completa via container
* Boas práticas ao estender a configuração do Apache

---

## 🛠 Tecnologias Utilizadas

* Docker
* Docker Compose (v2)
* Apache HTTP Server 2.4
* HTML

---

## 📂 Estrutura do Projeto

```
apache-hello-world/
│
├── docker-compose.yml
├── Dockerfile
│
├── apache/
│   └── app.conf
│
└── app/
    └── index.html
```

### Descrição dos arquivos

* **docker-compose.yml**: define o serviço Apache e o mapeamento de portas e volumes
* **Dockerfile**: cria a imagem baseada no Apache oficial
* **apache/app.conf**: configuração adicional do Apache (sem sobrescrever o httpd.conf padrão)
* **app/index.html**: aplicação web simples (Hello World)

---

## ⚙️ Configuração do Apache

O Apache utiliza a imagem oficial `httpd:2.4`. A configuração padrão da imagem é mantida e estendida por meio do arquivo:

```
apache/app.conf
```

Esse arquivo define:

* `DocumentRoot` da aplicação
* Permissões de acesso ao diretório
* Arquivo padrão (`index.html`)

Essa abordagem evita problemas de inicialização e segue boas práticas recomendadas.

---

## 📁 Diretório da Aplicação

Os arquivos da aplicação ficam no diretório:

```
./app
```

Esse diretório é montado no container via volume:

```
/usr/local/apache2/htdocs
```

Qualquer alteração nos arquivos HTML é refletida automaticamente no container.

---

## ▶️ Como Executar o Projeto

### Pré-requisitos

* Docker instalado
* Docker Compose v2

### Passos

1. Clone o repositório:

   ```bash
   git clone https://github.com/SEU_USUARIO/apache-hello-world.git
   ```

2. Acesse a pasta do projeto:

   ```bash
   cd apache-hello-world
   ```

3. Suba o container:

   ```bash
   docker compose up -d --build
   ```

4. Acesse no navegador:

   ```
   http://localhost:8080
   ```

Se tudo estiver correto, a página **Hello World** será exibida.

---

## 🔍 Observações Importantes

* O Docker **não copia arquivos** ao usar volumes, ele apenas monta diretórios
* A pasta `app` e o arquivo `index.html` devem existir antes de subir o container
* Caminhos relativos no Docker Compose são resolvidos a partir do diretório onde o comando é executado

---

## 🎯 Objetivo Educacional

Este projeto tem finalidade educacional e demonstra conceitos fundamentais de:

* Containerização
* Infraestrutura como código (YAML)
* Servidores web
* Boas práticas com Docker e Apache

---

## 📄 Licença

Projeto livre para fins educacionais.
