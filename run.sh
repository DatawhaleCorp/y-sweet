docker stop y-sweet-container
docker rm y-sweet-container

docker build --build-arg ALI_ACCESS_KEY=$(grep ALI_ACCESS_KEY .env | cut -d '=' -f2) \
             --build-arg ALI_SECRET_KEY=$(grep ALI_SECRET_KEY .env | cut -d '=' -f2) \
             -t y-sweet-image crates/.
docker run --env-file .env -d -p 8080:8080 --name y-sweet-container y-sweet-image

cd examples/nextjs
CONNECTION_STRING=ys://127.0.0.1:8080 npm run dev
