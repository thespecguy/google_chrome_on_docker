# Launching Google Chrome on Docker container

![google_chrome_docker](https://miro.medium.com/max/1400/1*Yqlku7qNl5GAVFq85aLfLQ.jpeg)

## Objective
Launch GUI applications(Google Chrome in this case) on top of Docker container.
<br><br>

## Content
- **Project Understanding**
- **Output**
<br><br>

## Project Understanding
Docker containers are by default CLI-based in nature and requires a physical display to run GUI applications. The way to do so involves sharing of Docker host’s display with the container.<br><br>
In order to perform the above operation, two important concepts needs to be understood which are as follows:

1. **X11 or X Server**
2. **DISPLAY environment variable**

Let’s understand each one of them

#### X11 or X Server

**X11** is a client/server windowing system for bitmap displays. It is implemented on most UNIX-like operating systems and has been ported to many other systems.<br>
**X Server** is the program or dedicated terminal that displays the windows and handles input devices such as keyboards, mouse and touchscreens.

#### DISPLAY environment variable

The **DISPLAY** environment variable is used by all X clients to determine what X server to display on. Since any X client can connect to any X server that allows it, all X clients need to know what needs to be displayed upon startup.<br><br>
The format of the DISPLAY variable is

```
hostname:D.S
```

where,

- **hostname:** Name or IP of the host
- **D:** Display number in case of multiple displays (usually 0)
- **S:** Screen number in case of multiple screens (usually 0)

### Implementation: Dockerfile

```dockerfile
FROM centos:latest
LABEL maintainer "Satyam Singh"
RUN dnf update -y 
COPY google-chrome.repo /etc/yum.repos.d/
RUN yum install google-chrome-stable -y
ENTRYPOINT ["google-chrome","--no-sandbox"]
```

The above Dockerfile updates the DNF/YUM repository and copies the repository required for installation of Google Chrome in yum.repos.d directory, then it installs it using yum and then sets an entrypoint for launching Google Chrome.<br><br>
Docker Host : **RHEL 8**

<br>

### Implementation: Command used for building an image

```shell
docker build -t <image_name>:<version_tag> <path_to_Dockerfile>
```

<br>

### Implementation: Command used to run Google Chrome within the container

```shell
docker run -it -e DISPLAY=:0 -v /tmp/.X11-unix:/tmp/.X11-unix -- chrome <URL>
```

where,
- **-e** stands for export and is used for exporting the value of environment variable DISPLAY
- **-v** stands for bind mount to a volume i.e., attaching a volume


<br>
<p align="center"><b>. . .</b></p><br>

## Output

![command_used](https://miro.medium.com/max/1400/1*CVPlfJDj5GqGj42_43Kpsg.png)

<p align="center"><b>Command Used</b></p><br><br>

![command_output](https://miro.medium.com/max/1400/1*ut3JUQTVXmLPqKGo4kpAFQ.png)

<p align="center"><b>Command Output</b></p><br><br>

<br>
<p align="center"><b>. . .</b></p><br>

<h2>Thank You :smiley:<h2>

[![Linkedin](https://i.stack.imgur.com/gVE0j.png) LinkedIn](https://www.linkedin.com/in/satyam-singh-95a266182)
