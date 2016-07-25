From peihsinsu/nodejs

RUN apt-get update -y && apt-get install apache2 -y && \
  cd / && \
  wget https://prdownloads.sourceforge.net/awstats/awstats-7.5.tar.gz && \
  tar zxvf awstats-7.5.tar.gz && \
  chmod 755 awstats-7.5/tools/*.pl \
  cd awstats-7.5/wwwroot/ && \
  mkdir -p /var/www/html/awstats && \
  mkdir -p /var/www/html/icon && \
  cp -r /awstats-7.5/wwwroot/icon /var/www/html/ && \
  chown www-data:www-data -R /var/www/html/icon/ && \
#  service apache2 restart && \
  a2enmod cgi && \
  mv cgi-bin awstats && \
  chown www-data:www-data -R awstats && \ 
  mv awstats /usr/lib/cgi-bin 

ADD ./awstats.awsstats.conf /usr/lib/cgi-bin/awstats/awstats.awsstats.conf
ADD ./run.sh /

WORKDIR /

CMD /run.sh
