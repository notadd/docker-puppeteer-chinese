FROM buildkite/puppeteer
COPY ./ /app
WORKDIR /app
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \ 
    apt-get install -y fonts-droid ttf-wqy-zenhei ttf-wqy-microhei fonts-arphic-ukai fonts-arphic-uming
    
RUN  npm set registry https://registry.npm.taobao.org && \
     npm set disturl https://npm.taobao.org/dist && \
     npm set sass_binary_site https://npm.taobao.org/mirrors/node-sass && \
     npm set puppeteer_download_host https://npm.taobao.org/mirrors && \
     npm set chromedriver_cdnurl https://npm.taobao.org/mirrors/chromedriver && \ 
     npm i
CMD ["npm","run","start"]