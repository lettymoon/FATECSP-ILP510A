       identification division.
       program-id. EX04.
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
          02 num-ent  pic 9(05).
          02 nome-ent pic x(20).
          02 sexo-ent pic x(01).
       fd CADATU.
       01  reg-sai.
          03 num-sai  pic 9(05).
          03 nome-sai pic x(20).

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
               perform selecao.
               perform leitura.
           
           selecao.
               if sexo-ent = "M" or sexo-ent = "m"
                   perform gravacao.

           gravacao.
               move num-ent  to num-sai.
               move nome-ent to nome-sai.
               write reg-sai.

           fim.
               close CADALU CADATU.
