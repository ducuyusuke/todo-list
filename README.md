# Achieve

Achieve é um gerenciador de listas de tarefas simples, limpo e fácil de usar, construído com Rails 7.

## Funcionalidades

* Hotwire para atualizações em tempo real
* Stimulus para interações dinâmicas
* Pundit para permissões de usuário
* ActiveRecord search para filtragem de tarefas
* SQLite3 para o banco de dados
* Bootstrap para UI responsiva
* Devise para autenticação de usuário

## Modelos & Relacionamentos

![Schema](assets/images/schema.png)

* **User**

  * has\_many \:lists
  * has\_many \:tasks, through: \:lists
  * has\_secure\_password (via Devise)

* **List**

  * belongs\_to \:user
  * has\_many \:tasks
  * Campos:

    * name: uma String que define a lista

* **Task**

  * belongs\_to \:list
  * belongs\_to \:user
  * Campos:

    * name: uma String que define a tarefa
    * position: um Integer que define a prioridade da tarefa
    * done: um campo Booleano que indica se a tarefa foi finalizada
    * due\_date: um objeto Datetime que define a data de vencimento da tarefa

## Configuração

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu-usuario/achieve.git
   cd achieve
   ```

2. Instale as dependências:

   ```bash
   bundle install
   ```

3. Configure o banco de dados:

   ```bash
   rails db:create db:migrate
   ```

4. Inicie o servidor:

   ```bash
   rails s
   ```

Acesse `http://localhost:3000` e comece a gerenciar suas tarefas.
