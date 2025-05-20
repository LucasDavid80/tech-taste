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
    Home --> Restaurante[Tela de Restaurante]
    Restaurante --> Prato[Tela de Prato]
    Prato --> Carrinho[Adicionar ao Carrinho]
    Carrinho --> Checkout[Tela de Checkout]
    Checkout --> Confirmacao[Confirmação de Pedido]
```

### Exemplos de Telas

**Splash Screen**
<img src="assets/screenshots/splash-screen.jpg" width="350" alt="Splash Screen"/>

**Tela Principal**
<img src="assets/screenshots/home-screen.jpg" width="350" alt="Tela Principal"/>

**Tela de Restaurante**
<img src="assets/screenshots/restaurant-screen.jpg" width="350" alt="Tela de Restaurante"/>

**Tela de Prato**
<img src="assets/screenshots/dish-screen.jpg" width="350" alt="Tela de Prato"/>

**Tela de Checkout**
<img src="assets/screenshots/checkout-screen.jpg" width="350" alt="Tela de Checkout"/>

**Confirmação de Pedido**
<img src="assets/screenshots/order-confirmation.jpg" width="350" alt="Confirmação de Pedido"/>

## Contribuição

Contribuições são bem-vindas! Abra uma issue ou envie um pull request.

## Licença

Este projeto está licenciado sob a licença MIT.

**Aviso:** As imagens dos pratos presentes neste repositório foram geradas por inteligência artificial (IA).
