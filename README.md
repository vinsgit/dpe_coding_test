# E-commerce Platform

This project is a simple e-commerce platform with a dynamic pricing engine and shopping cart functionality. It allows users to browse products, add items to the shopping cart, and place orders. The key feature of this project is the dynamic pricing adjustment, where product prices are modified based on inventory levels, demand, and competitor prices.

## Feature Overview

### Dynamic Pricing

Dynamic pricing is a key feature of this platform, designed to adjust product prices dynamically based on inventory, demand, and competitor prices. The pricing system considers the following factors:
- **Inventory Level**: When inventory falls below a certain threshold, prices increase; when inventory is above a specific threshold, prices decrease. These thresholds can be customized.
- **Demand Level**: As demand increases, prices may also increase.
- **Competitor Prices**: By calling an external API to fetch competitor prices, the platform can adjust prices if a competitor’s price is lower than the current price.

These factors are combined to calculate and update product prices in real-time, enhancing the platform’s competitiveness and ensuring efficient inventory management.

## API Endpoints

Below are the API endpoints provided by this platform and how to use them.

### Product-related Endpoints

#### Get All Products
- **URL**: `/api/products`
- **Method**: `GET`
- **Response Format**: JSON

**Example Response**:
```json
[
  {
    "id": "1",
    "name": "Product A",
    "category": "Electronics",
    "qty": 50,
    "price": 95.0
  },
  ...
]
```

#### Get product details
- **URL**: `/api/products/:id`
- **Method**: `GET`
- **Response Format**: JSON

**Example Response**:
```json

  {
    "id": "1",
    "name": "Product A",
    "category": "Electronics",
    "qty": 50,
    "price": 95.0
  }
```

#### Import Products (require admin user)
- **URL**: `/api/products/import`
- **Method**: `POST`
- **Request Params**
  - `inventory_file`
  - `username`
  - `password`
- **Response Format**: JSON

#### Add item to cart
- **URL**: `/api/carts/add`
- **Method**: `PUT`
- **Request Params**
  - `product_id`
  - `qty`
  - `username`
  - `password`
- **Response Format**: JSON
```json
{
  "id": "ID",
  "status": "ongoing",
  "cart_items": [
    {
      "item": "ITEM1",
      "qty": 1
    }, {...}
  ]
}
```

#### Place Order
- **URL**: `/api/carts/place_order`
- **Method**: `POST`
- **Request Params**
  - `username`
  - `password`
- **Note**
  - username needs to be `admin` please refer to Installation section to create admin user first!
- **Response Format**: JSON
```json
{
  "id": "ORDER_ID",
  "total_amt": 100.5
}
```

### Getting Started
#### Step 1: Install Docker

1. **Go to the Docker website**:
   - Open your web browser and visit the [Docker download page](https://www.docker.com/get-started).

2. **Download Docker Desktop**:
   - On the page, you’ll see the option to download Docker for various platforms (Windows, macOS, and Linux).
   - Choose your operating system (Windows or macOS) and click the "Download Docker Desktop" button.

3. **Run the Installer**:
   - Once the download is complete, open the installer and follow the installation steps.
   - On Windows, the Docker Desktop installation process will include installing WSL 2 (Windows Subsystem for Linux) if you haven't done so already.
   - On macOS, simply drag and drop Docker into your Applications folder.

4. **Start Docker**:
   - After installation, launch Docker Desktop from your applications menu.
   - Docker should start automatically, and you should see the Docker icon in your system tray (Windows) or menu bar (macOS).

#### Step 2: Install Docker Compose

1. **Go to the Docker Compose GitHub Release Page**:
   - Open your browser and go to the [Docker Compose releases page](https://github.com/docker/compose/releases).

2. **Download the Latest Version**:
   - Find the latest version of Docker Compose and download the appropriate installer for your operating system.
     - For Windows, you can download a `.exe` file.
     - For macOS, the Compose CLI is included with Docker Desktop, so no separate installation is required.
   
3. **Install Docker Compose**:
   - For **Windows**, Docker Compose will be installed automatically as part of the Docker Desktop installation.
   - For **macOS**, Docker Compose is included in Docker Desktop by default, so you don’t need to do anything extra.

#### Step 4: Installation
1. Clone the repo
  ```sh
  git clone https://github.com/vinsgit/dynamic_pricing_engine.git
  ```
2. Build and launch the application by
   ```sh
    docker-compose up
   ```
3. Create user seed data
   ```sh
   docker exec -it dynamic_pricing_engine-web-1 bash
   rake admin_user:create[123123] # 123123 is the Password!
   ```

4. Rspec
  ```sh
    docker exec -it dynamic_pricing_engine-web-1 bash
    bundle exec rspec
  ```
