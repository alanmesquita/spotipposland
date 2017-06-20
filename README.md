# Stotiposland

Esse projeto refere-se ao desafio back-end [lenda de Spotippos](https://github.com/VivaReal/code-challenge/blob/master/backend.md)

## Especificacoes

- Desenvolvi o projeto em ruby:2.3.1
- Usei o framework sinatra
- Não usei nenhum banco de dados, já que na especificação do teste diz que pode
ser feito tudo em memoria (resolvi encarar o desafio :D)
- Não criei nenhum arquivo de recover ao derrubar o servidor você perdera todos os
dados salvos

## Como rodar

Desenvolvi usando `Docker` e `docker-compose`.

Modo de desenvolvimento (para poder ver o pry)
```
$ make develop
```
Rodar os testes
```
$ make test
```
Rodar normal
```
make up
```
Caso não queira usar o docker:
```
$ bundler install
$ bundle exec rackup -p 9292 #pode escolher uma porta
```

## Fazendo uma request
```
# Request de exemplo
$ curl -X POST -H "Content-Type: application/json" -d '{"x":1, "y":2}' localhost:9292/properties
```

## Observação
Com muitas informações salvas em memoria a leitura da url `/properties` ficaria
lenta, pois sempre faço um "full scan" nas propriedades já salva, em larga
escala minha opção seria colocar um banco de dados com seus devidos indexes
assim otimizando a pesquisa
