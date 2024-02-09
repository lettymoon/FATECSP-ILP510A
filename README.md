# Linguagem de Programação I - Linguagem COBOL

Repositório da disciplina ILP510A Linguagem de Programação I - COBOL. FATEC São Paulo. 02/2023

Disciplina ministrada usando a linguagem COBOL.

Professor: HIROMASA NAGATA (FATECSP - DTI)

## Index

- [Linguagem de Programação I - Linguagem COBOL](#linguagem-de-programação-i---linguagem-cobol)
  - [Index](#index)
  - [Instalando](#instalando)
  - [Executando](#executando)
  - [Conteúdo](#conteúdo)
    - [Aulas](#aulas)
  - [Links Didáticos](#links-didáticos)

## Instalando

Antes de começar, garanta que você esta utilizando Linux ou o WSL (Windows Subsystem Linux for Windows)

(Todos os códigos desse respositório foram executados no Ubuntu 22.04.2 LTS)

- Instale o cobol utilizando o comando `sudo apt-get install open-cobol` ou `sudo apt-get install gnucobol4`

## Executando

Para executar entre na pasta a qual está o código utilizando o comando `cd <nome_pasta>`

Execute `cobc -x -free <arquivo>.cbl` para compilar o código

Finalmente execute `./<arquivo>` para executar o código compilado e seja Feliz :)

---
Exemplo prático estando na pasta raiz:

```bash
cd aula01/
cobc -x -free hello.cbl
./hello
```

Saida do programa:

```text
hello
```

## Conteúdo

### Aulas

- [Aula 01: Introdução à linguagem COBOL](01-introducao)
- [Aula 02: Identification e Environment Division](02-estrutura-cobol)
- [Aula 03: Fluxograma e DATA/PROCEDURE](03-estrutura-cobol)
- [Aula 04: Comandos aritméticos](04-comandos-aritmeticos)
- [Aula 05: Exercício de fixação](05-exercicios-fixacao)
- [Aula 06: Comandos de seleção/repetição](06-comandos-selecao-repeticao)
  - [Exercícios de fixação](06-comandos-selecao-repeticao/exercicios-fixacao)
- [Aula 07: EM - Exercícios de Máquina 01](07-EM1)
- [Aula 08: Impressões de relatórios](08-impressoes-relatorios)
- [Aula 09: Nível 88](09-nivel88)
- [Aula 10 e 11: Vetor](10-vetor)
- [Aula 12: Teoria de Redefines](12-redefines)
- [Aula 13: EM - Exercícios de Máquina 02](13-EM2)
- [Aula 14: Sort Teoria](14-sort)
- [Aula 18: EM - Exercícios de Máquina 03](18-EM3)
- [Aula 19: Teoria Balance](19-teoria-balance)

## Links Didáticos

[Learn COBOL - tutorials point](https://www.tutorialspoint.com/cobol/index.htm)
