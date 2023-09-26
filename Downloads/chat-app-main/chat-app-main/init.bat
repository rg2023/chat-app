FOR /f "tokens=*" %%i IN ('docker ps -q') DO docker rm -f %%i
docker build -t chat .
docker run  -d -p 5000:5000 chat