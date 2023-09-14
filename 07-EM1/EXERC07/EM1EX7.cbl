       identification division.
       program-id. EX07.
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
           select  CADATU assign to disk
                   organization is line sequential.

       data division.
       file section.

       fd CADALU.
       01 reg-ent.
          02 num-ent  pic 9(05).
          02 nome-ent pic x(20).
          02 nota1-ent  pic 9(2)V99.
          02 nota2-ent  pic 9(2)V99.
          02 nota3-ent  pic 9(2)V99.
          02 nota4-ent  pic 9(2)V99.
          02 sexo-ent pic x(01).

       fd CADATU.
       01  reg-sai.
          02 num-sai  pic 9(05).
          02 nome-sai pic x(20).
          02 media-sai pic 9(2)V99.
          02 sexo-sai pic x(01).

       working-storage section.
          77 fim-arq-ent pic x value "N".
          77 media         pic 9(2)V99.

       procedure division.
           perform inicio
           perform principal until fim-arq-ent equal "S"
           perform fim
           stop run.

           inicio.
               open input CADALU output CADATU
               perform leitura.

           leitura.
               read CADALU
                   at end move "S" to fim-arq-ent
               end-read.

           principal.
               if sexo-ent = "F"
                   compute media = (nota1-ent + nota2-ent + nota3-ent + 
                   nota4-ent) / 4
                   move num-ent to num-sai
                   move nome-ent to nome-sai
                   move media to media-sai
                   move sexo-ent to sexo-sai
                   write reg-sai
               end-if
               perform leitura.

           fim.
               close CADALU CADATU.
