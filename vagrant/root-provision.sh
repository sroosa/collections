#!/bin/sh

yum -y install \
  clamav \
  clamav-devel \
  clamav-update \
  java-1.8.0-openjdk \
  libreoffice-calc \
  libreoffice-draw \
  libreoffice-headless \
  libreoffice-impress \
  libreoffice-math \
  libreoffice-writer \
  mariadb-devel \
  openssl-devel \
  readline-devel \
  sqlite-devel \
  zlib-devel \
  ImageMagick \
  redis \
  ruby \
  ruby-devel \
  wget

# Update clamav config file and database
sed -i "s/^Example/#Example/" /etc/freshclam.conf
sed -i "s/^FRESHCLAM_DELAY/#FRESHCLAM_DELAY/" /etc/sysconfig/freshclam
freshclam

# Download and set up FITS
wget -nv -O /tmp/fits.zip http://projects.iq.harvard.edu/files/fits/files/fits-0.6.2.zip
unzip -d /opt/ /tmp/fits.zip
mv /opt/fits-0.6.2 /opt/fits
chmod a+x /opt/fits/fits.sh

# Enable redis service so that it starts on boot
systemctl enable redis.service

# Start redis now
systemctl start redis.service
