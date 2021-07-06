FROM centos:latest
LABEL maintainer "Satyam Singh"
RUN dnf update -y 
COPY google-chrome.repo /etc/yum.repos.d/
RUN yum install google-chrome-stable -y
ENTRYPOINT ["google-chrome","--no-sandbox"]