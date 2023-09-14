       identification division.
       program-id. EX06.
       author. Leticia Candido.
       installation. FATEC - SP.
       date-written. 12/09/2023.
       date-compiled. 12/09/2023.
       security. Apenas o autor pode modifica o codigo.

       environment division.
       configuration section.
           object-computer. ibm-pc.
           special-names. decimal-point is comma.

       input-output section.
       file-control.
           select CADENT assign to disk
                   organization is line sequential.
           select  CADSAI assign to disk
                   organization is line sequential.
       
       data division.
       file section.

       fd CADENT.
       01 reg-ent.
          02 matricula-ent  pic 9(05).
          02 nome-ent       pic x(30).
          02 salario-ent    pic 9(4)V99.

       fd CADSAI.
       01  reg-sai.
          02 matricula-sai  pic 9(05).
          02 nome-sai       pic x(30).
          02 salario-sai    pic 9(4)V99.

       working-storage section.
          77 fim-arq-ent pic x value "N".

       procedure division.
           perform inicio
           perform principal until fim-arq-ent equal "S"
           perform fim
           stop run.

           inicio.
               open input CADENT output CADSAI
               perform leitura.

           leitura.
               read CADENT
                   at end move "S" to fim-arq-ent
               end-read.

           principal.
               if salario-ent is greater than 3000
                   move matricula-ent to matricula-sai
                   move nome-ent to nome-sai
                   move salario-ent to salario-sai
                   write reg-sai
               end-if
               perform leitura.

           fim.
           close CADENT CADSAI.
