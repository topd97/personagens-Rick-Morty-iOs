# Personagens-Rick-Morty-iOS
App ios para listar personagens de Rick&amp;Morty.


![image](https://user-images.githubusercontent.com/30189037/156460260-486f6ee9-357d-4f8f-a948-b7ea7e52884f.png)

## Detalhes sobre o projeto:
### Tecnologia utilizada:
Foi utilizado iOS 15 para a realização do projeto e swift 5 

### Libs utilizada:
* [Alamofire](https://github.com/Alamofire/Alamofire):

Biblioteca utilizada para realizar requisições na web. Em sua versào 5.5.0 a biblioteca foi atualizada para utilização de swift concurrency tornando possivel usar async await em suas chamadas

* [JGProgressHUD](https://github.com/JonasGessner/JGProgressHUD)

Biblioteca utilizada para adicionar loading personalizado. Embora o projeto utilize o loading comum, ela foi utilizada para ganhar tempo de desenvolvimento.

* [Kingfisher](https://github.com/onevcat/Kingfisher)

Biblioteca utilizada para download de imagens na web e cacheamento das mesmas.

### API
As requisições foram feitas para a API [The Rick and Morty API](https://rickandmortyapi.com/) utilizando o endpoint `/character` para a lista de personagens, e o endpoint `/episode` para a lista de episodios disposta na tela de detalhes


