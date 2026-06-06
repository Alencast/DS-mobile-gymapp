# Gym App

## Descrição

O Gym App é uma aplicação desenvolvida em Flutter com o objetivo de auxiliar usuários no gerenciamento de treinos físicos. A aplicação permite cadastrar, visualizar e organizar informações básicas sobre diferentes treinos de forma simples e intuitiva.


---

## Objetivo

Facilitar o registro e a visualização de treinos personalizados, permitindo que o usuário mantenha um controle simples de suas atividades físicas.

---

## Funcionalidades

### Cadastro de Treinos

O usuário pode cadastrar um novo treino informando:

* Título do treino;
* Descrição;
* Duração;
* Nível de dificuldade.

### Listagem de Treinos

Os treinos cadastrados são exibidos em uma lista dinâmica contendo:

* Nome do treino;
* Descrição;
* Tempo de duração;
* Nível de dificuldade.

### Interface Responsiva

A aplicação adapta automaticamente sua interface conforme o tamanho da tela:

#### Mobile

* Exibição otimizada para smartphones;
* Formulário de cadastro;
* Lista de treinos.

#### Desktop

* Menu lateral;
* Área principal para gerenciamento dos treinos;
* Melhor aproveitamento do espaço disponível.

---

## Tecnologias Utilizadas

* Flutter
* Dart
* Material Design

---

## Estrutura da Aplicação

### MyApp

Classe principal responsável pela inicialização da aplicação e configuração do tema.

### ResponsiveLayout

Responsável por identificar o tamanho da tela e direcionar para o layout adequado.

### MobileLayout

Contém:

* Formulário de cadastro;
* Armazenamento local em memória;
* Exibição dos treinos cadastrados.

### DesktopLayout

Versão adaptada para telas maiores utilizando menu lateral e área principal de conteúdo.

---

## Fluxo de Uso

1. O usuário acessa a aplicação.
2. Preenche os dados do treino.
3. Clica em "Adicionar treino".
4. O treino é armazenado temporariamente na aplicação.
5. O treino aparece imediatamente na lista de treinos cadastrados.

---



## Melhorias Futuras

* Integração com banco de dados.
* Cadastro e login de usuários.
* Edição e exclusão de treinos.
* Filtros por nível de dificuldade.
* Histórico de treinos.
* Estatísticas e acompanhamento de desempenho.
* Integração com dispositivos fitness.

---



