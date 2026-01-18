# 🐳 Node.js Backend with MongoDB using Docker

**(Development Setup + Application Dockerization)**

This usecase demonstrates how Docker can be used both during the **development phase** (for running MongoDB without local installation) and during the **deployment phase** (by dockerizing a Node.js backend application and publishing it to Docker Hub).

---

## 📌 Usecase Overview

The usecase is divided into **two main parts** :

1. **Using Docker for MongoDB during development**
2. **Dockerizing the Node.js backend application and pushing it to Docker Hub**

---

## 🧩 Part 1: Using Docker for MongoDB in Development

### 🔹 Problem

The Node.js backend application uses **MongoDB** , but MongoDB is **not installed locally** on the system.

### 🔹 Solution

MongoDB is run using **Docker containers** , allowing database usage without local installation and ensuring a clean development environment.

---

## 🏗️ Architecture Used

- **Node.js backend**
  - Entry file: `server.js`
  - Routes connected to MongoDB
  - UI available to interact with backend APIs
- **MongoDB (Docker image)**
  - Actual database where user data is stored
- **Mongo Express (Docker image)**
  - UI interface to visualize MongoDB data
- **Docker Network**
  - Allows MongoDB and Mongo Express containers to communicate

---

## 🐳 Docker Images Used

- `mongo` → MongoDB database
- `mongo-express` → MongoDB UI interface

---

## 🔗 Docker Network Setup

A custom Docker network is created so both containers can interact with each other.

```bash
docker network create mongo-network
```

---

## 📦 Pull Required Images

```bash
docker pull mongo
docker pull mongo-express
```

---

## 🚀 Running MongoDB Container

```bash
docker run -d \
--name mongodb \
--network mongo-network \
-p 27017:27017 \
-e MONGO_INITDB_ROOT_USERNAME=admin \
-e MONGO_INITDB_ROOT_PASSWORD=qwerty \
mongo
```

---

## 🚀 Running Mongo Express Container

```bash
docker run -d \
--name mongo-express \
--network mongo-network \
-p 8081:8081 \
-e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
-e ME_CONFIG_MONGODB_ADMINPASSWORD=qwerty \
-e ME_CONFIG_MONGODB_SERVER=mongodb \
mongo-express
```

---

## 🌐 Accessing Mongo Express UI

Open browser:

```
http://localhost:8081
```

Login credentials:

- **Username:** admin
- **Password:** qwerty

From the Mongo Express UI:
<img width="1600" height="792" alt="image" src="https://github.com/user-attachments/assets/3e71fedd-f33e-4588-ba81-3624621fad6c" />


- Create databases
- Create collections
- View stored user records

---

## 🟢 Running the Node.js Backend

```bash
node server.js
```

### 🔹 Backend Features

- UI available to **add users**
- <img width="846" height="412" alt="image" src="https://github.com/user-attachments/assets/4dd1e107-99c2-4e2d-8902-5f305a3e94de" />

- User details include:
  - Username
  - Email
  - Password
- MongoDB stores the user data
- `GET /getUsers` route:
- <img width="714" height="372" alt="image" src="https://github.com/user-attachments/assets/163b5774-9e4c-4399-840a-3d929286a4ce" />

  - Fetches **all users**
  - Displays total user data from MongoDB

When new users are added through the UI:

- Data is saved in MongoDB
- Data can be viewed via:
  - Backend API (`getUsers`)
  - Mongo Express UI

✅ This confirms successful MongoDB integration using Docker.

---

## 🔁 Docker Compose Setup (YAML-Based)

Instead of manually creating containers using CLI commands, **Docker Compose** is used to manage the MongoDB setup.

### 🧾 docker-compose.yml

```yaml
version: "3.8"

services:
  mongo:
    image: mongo
    ports:
      - 27017:27017
    environment:
      MONGO_INITDB_ROOT_USERNAME: admin
      MONGO_INITDB_ROOT_PASSWORD: qwerty

  mongo-express:
    image: mongo-express
    ports:
      - 8081:8081
    environment:
      ME_CONFIG_MONGODB_ADMINUSERNAME: admin
      ME_CONFIG_MONGODB_ADMINPASSWORD: qwerty
      ME_CONFIG_MONGODB_URL: mongodb://admin:qwerty@mongo:27017/
```

Run both services using:

```bash
docker compose up
```

This automatically:

- Creates required containers
- Sets up networking
- Exposes ports
- Passes environment variables

---

# 📦 Part 2: Dockerizing the Node.js Backend Application

Once the backend and database setup is validated, the Node.js application itself is dockerized.

---

## 📝 Dockerfile Used

```dockerfile
FROM node

ENV MONGO_DB_USERNAME=admin \
    MONGO_DB_PWD=qwerty

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

CMD ["node", "server.js"]
```

---

## 🏗️ Building the Docker Image

```bash
docker build -t ashu2643/testapp .
```
<img width="1600" height="797" alt="image" src="https://github.com/user-attachments/assets/1fdf3805-4801-4cce-af81-b99f2b2967c0" />


---

## 🔐 Login to Docker Hub

```bash
docker login
```

---

## 🚀 Pushing Image to Docker Hub

```bash
docker push ashu2643/testapp
```

The image is now:

- Publicly available on Docker Hub
- Reusable by anyone
<img width="1543" height="621" alt="image" src="https://github.com/user-attachments/assets/4d28cbfe-6df3-4a67-949c-9e0afd7f0782" />

---

## ▶️ To build a new container from build image

```bash
docker run -d ashu2643/testapp
```

The backend runs successfully in **detached mode** , and it shows server runnong on port 5050..

---

## ✅ Key Learnings

- Used Docker to run MongoDB without local installation
- Connected MongoDB and Mongo Express using Docker networks
- Visualized database data using Mongo Express
- Used Docker Compose for simplified multi-container setup
- Dockerized a Node.js backend application
- Built and published a custom Docker image to Docker Hub
- Ran the application using a public Docker image

---

