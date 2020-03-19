# ☎️ asterisk-alticelabs
> asterisk-alticelabs is a Docker container for painlessly running an Asterisk 16.9 server, an open-source PBX solution, on CentOS7.

---

## 🏗️ Building

```sh
git clone https://github.com/carlos-menezes/asterisk-alticelabs.git

cd asterisk-alticelabs

docker build -t asterisk-alticelabs:yourtag .
```

---

## 🧰 Running
To run this container, you simply have to map a port on your server to the container's 5060 port (1), the default SIP port, and forward some ports in the host (2):

(1) `docker run -p 5060:5060/udp -it cmenezes98/alb-asterisk`

Aftewards, simply run `asterisk -c` (aditionally, `asterisk -cvvvvv`, -v matching the verbosity level) to start the Asterisk server.

(2) `UDP 5060,4569,5036,10000-20000,2727`

If you connect to your localhost in a softphone (i.e. MicroSIP), configure an account (read `/etc/asterisk/sip.conf`) and dial another configured extension (in another softphone/real phone; read `/etc/asterisk/extensions.conf` for example extensions), you should be able to make a phone call.

---

## 🛠️ Configuração MicroSIP
![](https://i.imgur.com/xOvH9Cn.png)

---

## 👨‍💻 Contributors
[Carlos Menezes](https://github.com/carlos-menezes) - https://github.com/carlos-menezes