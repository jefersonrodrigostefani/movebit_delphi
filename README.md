<img src="prints/delphi.png" width="79px" height="79px" alt="Logotipo do Delphi"> <img src="prints/firebird.png" width="79px" height="79px" alt="Logotipo do firebird">

## Sobre
O projeto Movebit Delphi foi criado para servir de referência para quem deseja iniciar no desenvolvimento de sistemas utilizando a ferramenta Delphi.

## Preparando o ambiente
Para mexer com o projeto, você precisa ter a ferramenta Delphi instalada em seu equipamento. Para o banco de dados, utilizei o Firebird na versão 2.5 Embedded.

## Atenção
Para fins didáticos, utilizei a versão Community Edition do Delphi 12 (Codinome Athenas). 
Mas você pode reproduzir os mesmos passos em outras versões, pois o princípio será o mesmo.

<img src="prints/print001.png">

## Estrutura do projeto
- Bin : Fica o arquivo executável do projeto, as dlls (descompactadas) e o banco de dados (descompactado).
- Src : Fica todo código fonte do projeto
- Tmp : Ficam os arquivos que precisaremos disponibilizar para o projeto funcionar.
  - Data.zip : Contem o arquivo de banco de dados, MOVEBID.FDB.
  - DLLs.zip : Contem as dlls necessárias para o funcionamento do sistema.