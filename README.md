# techtaste

Aplicativo Flutter para explorar restaurantes, pratos e categorias gastronômicas.

## Instalação

1. Clone o repositório:
   ```powershell
   git clone https://github.com/seuusuario/techtaste.git
   ```
2. Instale as dependências:
   ```powershell
   flutter pub get
   ```
3. Execute o app:
   ```powershell
   flutter run
   ```

## Funcionalidades

- Listagem de restaurantes e pratos
- Filtros por categoria
- Tela de checkout
- Splash screen personalizada

## Estrutura do Projeto

- `lib/`: Código principal do app
  - `data/`: Dados estáticos
  - `model/`: Modelos de dados
  - `ui/`: Telas e componentes visuais

## Fluxo do Aplicativo

```mermaid
flowchart TD
    Splash[Splash Screen] --> Home[Tela Principal]
    Home --> Categoria[Filtrar por Categoria]
    Categoria --> Restaurante[Tela de Restaurante]
    Home --> Restaurante[Tela de Restaurante]
    Restaurante --> Prato[Tela de Prato]
    Prato --> Carrinho[Adicionar ao Carrinho]
    Carrinho --> Checkout[Tela de Checkout]
    Checkout --> Confirmacao[Confirmação de Pedido]
```

### Exemplos de Telas

<div align="center">
  <h2>Splash Screen</h2>
  <img src="assets/screenshots/splash-screen.png" width="350" alt="Splash Screen"/>

  <h2>Tela Principal</h2>
  <img src="assets/screenshots/home-screen.png" width="350" alt="Tela Principal"/>

  <h2>Tela de Restaurante</h2>
  <img src="assets/screenshots/restaurant-screen.png" width="350" alt="Tela de Restaurante"/>

  <h2>Tela de Prato</h2>
  <img src="assets/screenshots/dish-screen.png" width="350" alt="Tela de Prato"/>

  <h2>Tela de Checkout</h2>
  <img src="assets/screenshots/checkout-screen.png" width="350" alt="Tela de Checkout"/>

  <h2>Confirmação de Pedido</h2>
  <img src="assets/screenshots/order-confirmation.png" width="350" alt="Confirmação de Pedido"/>
</div>

## Contribuição

Contribuições são bem-vindas! Abra uma issue ou envie um pull request.

## Licença

Este projeto está licenciado sob a licença MIT.

**Aviso:** As imagens dos pratos presentes neste repositório foram geradas por inteligência artificial (IA).
