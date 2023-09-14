       identification division.
       program-id. EX05.
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
           select CADALU assign to disk
                   organization is line sequential.
           select  CADAPR assign to disk
                   organization is line sequential.
       
       data division.
       file section.

       fd CADALU.
       01 reg-ent.
          02 num-ent    pic 9(5).
          02 nome-ent   pic x(20).
          02 nota1-ent  pic 9(2)v99.
          02 nota2-ent  pic 9(2)v99.
          02 faltas-ent pic 9(02).

       fd CADAPR.
       01  reg-sai.
          03 num-sai    pic 9(05).
          03 nome-sai   pic x(20).
          03 media-sai  pic 9(2)v99.
          
       working-storage section.
          77 fim-arq-ent pic x value "N".
          77 soma-nota   pic 9(2)v9(2) value zeros.
          77 wmedia      pic 99v99     value zeros.

       procedure division.
           perform inicio
           perform principal until fim-arq-ent equal "S"
           perform fim
               stop run.

           inicio.
               open input CADALU output CADAPR.
               perform leitura.

           leitura.
               read CADALU
                   at end move "S" to fim-arq-ent.

           principal.
               perform calcula-media.
               perform selecao.
               perform leitura.
           
           calcula-media.
               add nota1-ent
                   nota2-ent
                       giving soma-nota.
               divide soma-nota by 2
                       giving wmedia.

           selecao.
               if wmedia is greater than or equal to 7 
                       and faltas-ent is less than or equal to 18
                   perform gravacao
               end-if.

           gravacao.
               move num-ent    to num-sai
               move nome-ent   to nome-sai
               move wmedia     to media-sai
               write reg-sai.

           fim.
               close CADALU CADAPR.
