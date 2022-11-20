# Artigo
Baseado em: https://wemakewaves.medium.com/migrating-our-php-applications-to-docker-without-sacrificing-performance-1a69d81dcafb

Mudancas:
* Versoes mais novas
* Testar apontando para processo vs apontando para network (Plus a mais)

## Introdução 
I had an issue with my coalegues while moving an app to docker. The QA responsible for validating the migration said that he was feeling some performance hit when comparing with the old system. And, when we tested the response times were actually almost doubled. After some research we were able to findo the article from <author>. There, they developed a test comparing bare metal FPM nginx with docker 

## Methodologies 
Fork his repo
Add an ansible pb to be able to replicate the baremetal environment easier
Add another nginx conf using process path instead of network
update dockerfiles
change makefile to add more paths
