From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 17 Feb 2020 05:24:57 +0000
Subject: [LTP] Networking test failing
Message-ID: <MAXPR0101MB146826599C0BAB5162CFDD3FEE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running ltp test when i checked log files i found following errors in networking tests. I am not getting how to run these test individually????

netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed
netns_netlink    2  TBROK  :  netns_netlink.c:143: Remaining cases broken

netns_breakns_ns_exec_ipv4_netlink 1 TBROK: unable to create veth pair devices
Cannot find device "veth0"

I am attaching log file report

netns_netlink                                                       FAIL       2
netns_breakns_ns_exec_ipv4_netlink                 FAIL       2
netns_breakns_ns_exec_ipv6_netlink                 FAIL       2
netns_breakns_ns_exec_ipv4_ioctl                   FAIL       2
netns_breakns_ns_exec_ipv6_ioctl                   FAIL       2
netns_breakns_ip_ipv4_netlink                          FAIL       2
netns_breakns_ip_ipv6_netlink                          FAIL       2
netns_breakns_ip_ipv4_ioctl                              FAIL       2
netns_breakns_ip_ipv6_ioctl                               FAIL       2
netns_comm_ns_exec_ipv4_netlink                    FAIL       2
netns_comm_ns_exec_ipv6_netlink                    FAIL       2
netns_comm_ns_exec_ipv4_ioctl                         FAIL       2
netns_comm_ns_exec_ipv6_ioctl                         FAIL       2
netns_comm_ip_ipv4_netlink                              FAIL       2
netns_comm_ip_ipv6_netlink                               FAIL       2
netns_comm_ip_ipv4_ioctl                           FAIL       2
netns_comm_ip_ipv6_ioctl                           FAIL       2
netns_sysfs                                        FAIL       2


How i can resolve these errors please guide me how these tests needs to run and from which path.

Thank you







-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200217/4df52ed2/attachment.htm>
