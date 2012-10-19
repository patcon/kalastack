################################################################################

KALABOX 
=====================
Kalabox is a local server environment optimized for PHP development. It was 
built with Drupal and Pantheon in mind but, with small tweaks, can be used for 
any PHP development. It currently ships with the following packages, all 
configured, tuned and optimized for a fast, best-practices local development 
experience.

1.  nginx
2.  PHP5 (with common extensions including apc and xdebug)
3.  MySQL
4.  Apache Solr
5.  Apache Tomcat
6.  SSH
7.  git
8.  drush (with custom commands for Pantheon integration)
9.  PHPMyAdmin
10. samba (to expose your webroot, drush and home to your VB host)

Kalabox is a local server environment only and is not meant to be run as a
production server. 

Kalabox is meant to be run either natively in Ubuntu 12.04 or in a Virtual 
Box. It has been tested with Ubuntu 12.04 and MacOSX 10.7 - 10.8 as the host
machine. It should theoretically work with Windows but has not been tested.


Supported 
=====================
Drupal 6
Drupal 7
Pantheon Systems V2

Useful Locations
=====================

1. Home/phpinfo()   - http://kala
2. phpMyAdmin       - http://php.kala
3. solr             - http://kala:8080/solr
4. drush            - /usr/share/drush
5. SSH public key   - ~/.ssh/id_rsa.pub
6. Pantheon aliases - ~/.drush/pantheon.aliases.drushrc.php

