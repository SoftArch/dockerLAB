# Docker Labs

- ## Docker CLI
    Docker CLI ortamı kod çalıştırma
    
    ```docker
    docker ps
    docker container ls
    ```
    
    ```docker
    docker images
    docker image ls
    ```
    
    ```docker
    docker volume ls
    ```
    
    ```docker
    docker system df # Show docker disk usage
    
    docker system info # Display system-wide information
    ```
    
    Image indirme
    
    ```docker
    docker pull alpine
    ```
    
- ## Container
    Container çalıştırma/oluşturma
    
    ```bash
    docker run alpine
    
    echo selamlar
    
    docker run alpine echo selamlar 
    ```
    
    Interaktif modda çalıştırma
    
    ```bash
    docker run -it alpine
    
    # Ctrl + d      # Çıkış yapar ve Container durur
    # Ctrl + p + q  # Çıkış yapar ve Container çalışmaya devam eder
    ```
    
    Çalışan Container'a tekrar bağlanmak
    
    ```bash
    docker attach <container_id>
    ```
    
    Container'ı arka planda çalıştırma
    
    ```bash
    docker run -d alpine
    # Burada docker run alpine ile bir farkı olmaz
    # çünkü bir servis gibi devamlı çalışacak bir process yok
    
    docker run alpine sh -c "while true;do $(echo date); sleep 1; done;"
    # bu durumda containerdan çıkılmıyor
    
    docker run -d alpine sh -c "while true;do $(echo date); sleep 1; done;"clear
    
    ```
    
    Container'ın loglarına bakma
    
    ```bash
    docker logs <container_id>
    # Tüm logları getirir
    
    docker logs -f <container_id>
    # Tüm logları getirir ve canlı akışa devam eder
    
    docker logs -n 10 <container_id>
    # sayı ile belirtilen adet kadar son logları getirir
    
    docker logs -f -n 10 <container_id>
    docker logs -fn 10 <container_id>
    # sayı ile belirtilen adet kadar son logları getirir
    # ve canlı akışa devam eder
    ```
    
    Çalışan Container'ı durdurma / Durmuş Container'ı çalıştırma
    
    ```bash
    docker stop <container_id>
    # 10 sn bekler ve container kapanmaz ise kill eder
    
    docker kill <container_id>
    # çalışan container'ı direk öldürür
    
    docker start <container_id>
    ```
    
    Container'ı silme
    
    ```bash
    docker rm <container_id>
    
    docker rm <container_id> <container_id> ...
    
    docker rm $(docker ps -aq)
    # tüm containerların listesini rm komutuna verir
    
    docker container ls -aq --filter status=exited
    # Çalışmayan tüm containerları listeler
    
    docker container rm $(docker container ls -aq --filter status=exited)
    # çalışmayan bütün Containerları siler
    ```
    
    Container'ın işi bittiğinde direk silinmesi
    
    ```bash
    docker run --rm alpine echo selamlarr
    
    docker run --rm -it alpine
    ```
    
- ## Docker Image
    
    Image detaylarına bakılması
    
    ```bash
    # "docker pull alpine" komutu ile bir docker image indirmiştik
    
    docker inspect alpine
    # Image'a ait tüm bilgiler gelir
    
    docker inspect alpine
    
    docker history alpine
    ```
    
    Image'ın silinmesi
    
    ```bash
    docker image rm <container_id>
    ```
    
    Dockerfile ile Image oluşturma
    
    ```bash
    while true;
    do
    $(echo date);
    sleep 1;
    done;
    
    #sample.sh olarak kaydedilecek
    ```
    
    ```docker
    FROM ubuntu:18.04
    COPY . /app
    RUN chmod +x app/sample.sh
    CMD app/sample.sh
    
    # Dockerfile olarak kaydedilecek
    ```
    
    ```bash
    docker build . -t show_time
    ```
    
    Çalışan container'dan Image oluşturma
    
    ```docker
    docker run -it --name alwg alpine
    # alpine çalıştırıldıktan sorna git kurulur.
    # apk add git
    # apk add nano
    #https://pkgs.alpinelinux.org/packages
    
    #CTRL + D ile çıkılır.
    
    docker commit alwg alpg
    # docker images ile kontrol edilir
    
    docker history alpg
    ```
    
- ## Docker Volume
    
    Volume Oluşturma

    ```docker
    docker volume ls
    # Volume var mı?kontrolü yapılır
    
    docker volume create alpg-vol
    
    docker volume ls # oluşmuşmu kontrolü
    ```
    
    Volume olmadan dosya oluşturma ve volume ile oluşturma
    
    ```docker
    docker run -it alpg
    # Dosya oluşturalım
    # touch test.txt
    # CTRL + D ile çıkış yapalım.
    
    docker run -it alpg # tekrar çalıştırıp ls ile kontrol edelim
    
    docker run -it -v alpg-vol:/myfiles alpg
    # bu kodu 2 farklı teminalde çalıştırıp dosyalarıp
    # her ikisinde de aynı olduğunu kontrol edelim
    
    ```
    
    Host üzerindenki dosyayı Bind etme
    
    ```docker
    docker run -it -v /root/Desktop/source/VolumeTest:/myfiles alpg
    ```
    
- ## Dockerfile
    CMD ve ENTRYPOINT farkı
    
    ```docker
    # birden fazla versiyonu yazılacak
    FROM alpine
    # CMD Test
    CMD echo selamlarr
    #---
    
    # ENTRYPOINT Test
    #ENTRYPOINT echo selamlarr
    #---
    
    # ENTRYPOINT döver CMD
    #ENTRYPOINT echo selamlarr-ENT
    #CMD echo selamlarr-CMD
    #---
    
    # ENTRYPOINT sadece sondaki Çalışır.
    #ENTRYPOINT echo selamlarr-ENT1
    #ENTRYPOINT echo selamlarr-ENT2
    #---
    
    # CMD sadece sondaki Çalışır.
    #CMD echo selamlarr-CMD1
    #CMD echo selamlarr-CMD2
    #---
    
    # ENTRYPOINT Shell vs Exec
    #ENTRYPOINT echo selamlarr
    #ENTRYPOINT ["echo","selamlarr"]
    #---
    
    # ENTRYPOINT Shell vs Exec
    #CMD echo selamlarr
    #CMD ["echo","selamlarr"]
    #---
    
    # CMD Parameter kullanımı
    #CMD ["echo","selamlarr"]
    #ENTRYPOINT ["echo","selamlarr"]
    #--
    ```
    
    Volume komutunun kullanımı + LABEL
    
    ```docker
    FROM alpine
    
    LABEL "version"="1.0"
    LABEL "/myfiles"="Log dosyaları burada tutuluyor"
    
    VOLUME /myfiles
    ```
    
- ## Docker Compose
    alpine'ı docker compose ile ayağa kaldırmak
    
    ```yaml
    version: "3"
    
    services:
    	alp:
    		image: alpine
    		volumes:
    			- "alp-vol:/myfiles"
    
    volumes:
    	alp-vol:
    ```
    
    ```bash
    docker-compose ps
    
    docker-compose logs
    
    ```
    
    Postgres örneği çalıştırma
    
    ```yaml
    https://github.com/SoftArch/Docker/blob/master/PostgreSQL/docker-compose.yml
    
    # github üzerinde docker-compose dosyası alınır ve çalıştırılır
    
    #hıslıca kopyalamak için
    wget **https://raw.githubusercontent.com/SoftArch/Docker/master/PostgreSQL/docker-compose.yml**
    
    docker-compose up
    
    # CTRL + C ile durdurulur
    
    docker-compose up -d
    # bu komut ile bir servis olarak çalışması sağlanır.
    
    docker-compose down
    # çalışan containerları durdurur
    
    # GitHub CodeSpace çöaüm
    https://github.com/community/community/discussions/17918#discussioncomment-3005294
    ```