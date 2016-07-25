From peihsinsu/nodejs

RUN echo 'Acquire::http { Proxy "http://10.229.201.230:3128"; };' >> /etc/apt/apt.conf.d/01proxy
ENV HTTP_PROXY http://10.229.201.230:3128
ENV http_proxy http://10.229.201.230:3128
ENV HTTPS_PROXY http://10.229.201.230:3128
ENV https_proxy http://10.229.201.230:3128

RUN apt-get update -y && apt-get install apache2 -y && \
  cd / && \
  wget https://prdownloads.sourceforge.net/awstats/awstats-7.5.tar.gz && \
  tar zxvf awstats-7.5.tar.gz && \
  chmod 755 awstats-7.5/tools/*.pl && \
  cd awstats-7.5/wwwroot/ && \
  mkdir -p /var/www/html/awstats && \
  mkdir -p /var/www/html/icon && \
  cp -r /awstats-7.5/wwwroot/icon /var/www/html/ && \
  chown www-data:www-data -R /var/www/html/icon/ && \
  service apache2 restart && \
  a2enmod cgi && \
  mv cgi-bin awstats && \
  chown www-data:www-data -R awstats && \ 
  mv awstats /usr/lib/cgi-bin 

ADD ./awstats.awstats.conf /usr/lib/cgi-bin/awstats/awstats.awstats.conf
ADD ./run.sh /

WORKDIR /

CMD /run.sh
