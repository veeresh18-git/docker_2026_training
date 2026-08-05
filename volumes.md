# 🐳 Docker Volumes Hands-on Lab

## 🎯 Objective

In this lab you will learn:

- Why Docker Volumes are required
- Difference between Container Storage and Volume Storage
- Create Docker Volumes
- Attach Volumes to Containers
- Verify Persistent Data
- Remove Containers without Losing Data
- Bind Mount Demo

---

# Lab 1 - Verify Docker Installation

Check Docker version

```bash
docker --version
```

Check Docker Engine

```bash
docker info
```

---

# Lab 2 - Create an Nginx Container (Without Volume)

Run an Nginx container

```bash
docker run -d --name nginx-demo nginx
```

Verify

```bash
docker ps
```

Login to the container

```bash
docker exec -it nginx-demo bash
```

Navigate to the web folder

```bash
cd /usr/share/nginx/html
```

Create a file

```bash
echo "Docker Training Volume Demo" > demo.txt
```

Verify

```bash
ls
```

Output

```
demo.txt
index.html
```

Exit

```bash
exit
```

---

# Lab 3 - Delete the Container

Stop container

```bash
docker stop nginx-demo
```

Remove container

```bash
docker rm nginx-demo
```

Create a new container

```bash
docker run -d --name nginx-demo nginx
```

Login

```bash
docker exec -it nginx-demo bash
```

Check

```bash
ls /usr/share/nginx/html
```

Question

❓ Where is demo.txt?

Answer

Container filesystem is deleted when the container is removed.

---

# Lab 4 - Create Docker Volume

Create volume

```bash
docker volume create training-volume
```

Verify

```bash
docker volume ls
```

Inspect

```bash
docker volume inspect training-volume
```

---

# Lab 5 - Attach Volume to Container

Run

```bash
docker run -d \
--name nginx-volume \
-v training-volume:/usr/share/nginx/html \
nginx
```

Verify

```bash
docker ps
```

---

# Lab 6 - Store Data Inside Volume

Login

```bash
docker exec -it nginx-volume bash
```

Create file

```bash
echo "Docker Volume is Persistent" > /usr/share/nginx/html/demo.txt
```

Verify

```bash
cat /usr/share/nginx/html/demo.txt
```

Exit

```bash
exit
```

---

# Lab 7 - Delete Container

Stop

```bash
docker stop nginx-volume
```

Remove

```bash
docker rm nginx-volume
```

---

# Lab 8 - Create New Container Using Same Volume

```bash
docker run -d \
--name nginx-volume-new \
-v training-volume:/usr/share/nginx/html \
nginx
```

Login

```bash
docker exec -it nginx-volume-new bash
```

Verify

```bash
cat /usr/share/nginx/html/demo.txt
```

Output

```
Docker Volume is Persistent
```

🎉 Congratulations!

The data still exists even though the previous container was deleted.

---

# Lab 9 - Bind Mount Demo

Create a directory

```bash
mkdir website
```

Navigate

```bash
cd website
```

Create webpage

```bash
nano index.html
```

Paste

```html
<h1>Hello Docker Volume</h1>
```

Save

```
CTRL + O
ENTER
CTRL + X
```

Run

```bash
docker run -d \
--name nginx-bind \
-p 8080:80 \
-v $(pwd):/usr/share/nginx/html \
nginx
```

Open Browser

```
http://localhost:8080
```

Modify index.html

```html
<h1>Docker Training Updated</h1>
```

Refresh browser.

Observe:

The webpage updates immediately.

No image rebuild required.

---

# Lab 10 - Inspect Volume

```bash
docker volume inspect training-volume
```

Observe

- Volume Name
- Driver
- Mount Point

---

# Lab 11 - Remove Unused Volumes

List

```bash
docker volume ls
```

Remove

```bash
docker volume rm training-volume
```

Remove unused

```bash
docker volume prune
```

---

# Architecture

Without Volume

```
Container
│
├── app.db
├── data.txt
└── logs

Delete Container

❌ Everything Lost
```

With Volume

```
Container
     │
     ▼
Docker Volume
│
├── app.db
├── data.txt
└── logs

Delete Container

✅ Volume Still Exists

Create New Container

Same Data Available
```

---

# Bind Mount Architecture

```
Ubuntu Host

/home/ubuntu/website
        │
        ▼
Container

/usr/share/nginx/html
```

Editing files on the host immediately updates the application inside the container.

---
---

# Important Commands

List Containers

```bash
docker ps
```

List Images

```bash
docker images
```

List Volumes

```bash
docker volume ls
```

Inspect Volume

```bash
docker volume inspect training-volume
```

Remove Volume

```bash
docker volume rm training-volume
```

Remove Unused Volumes

```bash
docker volume prune
```

---

# Interview Questions

### What is a Docker Volume?

A Docker Volume is persistent storage managed by Docker that exists independently of containers.

---

### Why do we need Volumes?

To preserve data even if containers are deleted or recreated.

---

### Difference between Volume and Bind Mount?

| Docker Volume | Bind Mount |
|---------------|------------|
| Managed by Docker | Managed by User |
| Better for Production | Better for Development |
| Portable | Uses Host Directory |

---


🎉 Congratulations! You have successfully completed the Docker Volumes Hands-on Lab.
