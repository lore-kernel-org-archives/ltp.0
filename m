From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 31 May 2021 04:16:14 +0000
Subject: [LTP] netns_netlink
Message-ID: <BMXPR01MB28700A1B6BCDCFC7789FF261EE3F9@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

i am running LTP on kernel 5.10.19 custom kermel with  LTP Version: 20210524-15-gf96b8fe15 but few of network tests are getting failed on my distro.

Following 8 testcases are failing, i have attached strace log for one of them kindly find it

  *   netns_breakns_ip_ipv4_ioctl
  *   netns_breakns_ns_exec_ipv4_ioctl
netns_breakns_ns_exec_ipv6_ioctl
  *   netns_comm_ip_ipv4_ioctl
  *   netns_comm_ip_ipv6_ioctl
  *   netns_comm_ns_exec_ipv4_ioctl
  *   netns_comm_ns_exec_ipv6_ioctl

Also attaching the network config


/opt/ltp# ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
link/ether 70:b3:d5:92:f1:27 brd ff:ff:ff:ff:ff:ff
3: sit0@NONE: mtu 1480 qdisc noop state DOWN mode DEFAULT group default qlen 1000
link/sit 0.0.0.0 brd 0.0.0.0


root@semi-3:/opt/ltp# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
inet 127.0.0.1/8 scope host lo
valid_lft forever preferred_lft forever
inet6 ::1/128 scope host
valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
link/ether 70:b3:d5:92:f1:27 brd ff:ff:ff:ff:ff:ff
inet 10.1.1.76/16 brd 10.168.255.255 scope global dynamic eth0
valid_lft 603810sec preferred_lft 603810sec
inet6 fe80::72b3:d5ff:fe92:f127/64 scope link
valid_lft forever preferred_lft forever
3: sit0@NONE: mtu 1480 qdisc noop state DOWN group default qlen 1000
link/sit 0.0.0.0 brd 0.0.0.0


root@semi-3:/opt/ltp# ip route
default via 10.1.1.1 dev eth0 proto dhcp src 10.1.1.76 metric 10
10.1.0.0/16 dev eth0 proto kernel scope link src 10.1.1.76
10.1.1.1 dev eth0 proto dhcp scope link src 10.1.1.76 metric 10



Can you suggest what's going wrong with these testcases ? What could be the failure reason ??


Kindly suggest


Thanks


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210531/8e2834da/attachment-0001.htm>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: strace_netns_breakns.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210531/8e2834da/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: kern_config.txt
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210531/8e2834da/attachment-0003.txt>
