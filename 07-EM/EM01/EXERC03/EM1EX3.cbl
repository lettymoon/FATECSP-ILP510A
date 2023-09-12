       identification division.
       program-id. EX03.
       author. Leticia Candido.
       installation. FATEC - SP.
       date-written. 12/09/2023.
       date-compiled. 12/09/2023.
       security. Apenas o autor pode modifica o codigo.

       environment division.
       configuration section.
           object-computer. laptop-letty.
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
          02 num-ent    pic 9(5).
          02 nome-ent   pic x(20).
          02 nota1-ent  pic 9(2)v99.
          02 nota2-ent  pic 9(2)v99.
          02 nota3-ent  pic 9(2)v99.

       fd CADATU.
       01  reg-sai.
          02 num-sai    pic 9(05).
          02 nome-sai   pic x(20).
          02 nota1-sai  pic 9(02).
          02 nota2-sai  pic 9(02).
          02 nota3-sai  pic 9(02).
          02 media-sai  pic 9(03).

       working-storage section.
          77 fim-arq-ent pic x value "N".

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
                   at end move "S" to fim-arq-ent.

           principal.
               perform gravacao
               perform calcula-media.
               perform leitura.
           
           calcula-media.
               compute media-sai = (nota1-ent + nota2-ent + nota3-ent) / 3.

           gravacao.
               move num-ent    to num-sai
               move media-sai  to media-sai
               write reg-sai.

           fim.
               close CADALU CADATU.
