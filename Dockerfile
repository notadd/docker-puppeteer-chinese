FROM buildkite/puppeteer
COPY ./ /app
WORKDIR /app
RUN sed -i 's/deb.debian.org/mirrors.163.com/g' /etc/apt/sources.list && \
    apt update && \
    apt-get install -y dpkg wget unzip
    #fonts-droid fonts-arphic-ukai fonts-arphic-uming
RUN cd /tmp && wget http://ftp.cn.debian.org/debian/pool/main/f/fonts-noto-cjk/fonts-noto-cjk_20170601+repack1-3_all.deb && \
    dpkg -i fonts-noto-cjk_20170601+repack1-3_all.deb    && \
    wget https://github.com/adobe-fonts/source-sans-pro/releases/download/2.040R-ro%2F1.090R-it/source-sans-pro-2.040R-ro-1.090R-it.zip && \
    unzip source-sans-pro-2.040R-ro-1.090R-it.zip && cd source-sans-pro-2.040R-ro-1.090R-it  && mv ./OTF /usr/share/fonts/  && \
    fc-cache -f -v

#ENV  PATH="${PATH}:/node_modules/.bin"
    
RUN  npm set registry https://registry.npm.taobao.org && \
     npm set disturl https://npm.taobao.org/dist && \
     npm set sass_binary_site https://npm.taobao.org/mirrors/node-sass && \
     npm set puppeteer_download_host https://npm.taobao.org/mirrors && \
     npm set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver && \ 
     npm i
CMD ["npm","run","start"]
