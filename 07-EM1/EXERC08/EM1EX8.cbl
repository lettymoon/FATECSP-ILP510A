       identification division.
       program-id. EX08.
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
           select CADFUN assign to disk
                   organization is line sequential.
           select  CADSAI assign to disk
                   organization is line sequential.
       data division.
       file section.

       fd CADFUN.
       01 reg-ent.
          02 codigo-ent pic 9(05).
          02 nome-ent   pic x(20).
          02 salario-ent pic 9(5)V99.

       fd CADSAI.
       01  reg-sai.
          02 codigo-sai pic 9(05).
          02 nome-sai   pic x(20).
          02 salario-sai pic 9(5)V99.

       working-storage section.
          77 fim-arq-ent pic x value "N".
          77 percentual-reajuste pic 99.
          77 salario-bruto pic 9(5)V99.

       procedure division.
           perform inicio
           perform principal until fim-arq-ent equal "S"
           perform fim
           stop run.

           inicio.
               open input CADFUN output CADSAI
               perform leitura.

           leitura.
               read CADFUN
                   at end move "S" to fim-arq-ent
               end-read.

           principal.
               move codigo-ent to codigo-sai
               move nome-ent to nome-sai
               move salario-ent to salario-bruto

               if salario-bruto <= 1000
                   move 12 to percentual-reajuste
               else if salario-bruto <= 2000
                   move 11 to percentual-reajuste
               else
                   move 10 to percentual-reajuste
               end-if

               compute salario-sai = salario-bruto + (salario-bruto * 
               percentual-reajuste / 100)
               write reg-sai
               perform leitura.

           fim.
               close CADFUN CADSAI.
