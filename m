From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 16:58:40 +0100
Subject: [LTP] Networking test failing
In-Reply-To: <MAXPR0101MB146826599C0BAB5162CFDD3FEE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB146826599C0BAB5162CFDD3FEE160@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200217155840.GA4424@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> i am running ltp test when i checked log files i found following errors in networking tests. I am not getting how to run these test individually????

export PATH="/opt/ltp/testcases/bin:$PATH"
netns_breakns.sh ns_exec ipv4 netlink
on properly installed LTP, to default path /opt/ltp
(that's from runtest/containers).

> netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed
> netns_netlink    2  TBROK  :  netns_netlink.c:143: Remaining cases broken

> netns_breakns_ns_exec_ipv4_netlink 1 TBROK: unable to create veth pair devices
> Cannot find device "veth0"

It fails on  ip link add veth0 type veth peer name veth1.
Do you have CONFIG_VETH=m or CONFIG_VETH=y in your kernel config (in /boot/config-$(uname -r)).


> I am attaching log file report

> netns_netlink                                                       FAIL       2
> netns_breakns_ns_exec_ipv4_netlink                 FAIL       2
> netns_breakns_ns_exec_ipv6_netlink                 FAIL       2
> netns_breakns_ns_exec_ipv4_ioctl                   FAIL       2
> netns_breakns_ns_exec_ipv6_ioctl                   FAIL       2
> netns_breakns_ip_ipv4_netlink                          FAIL       2
> netns_breakns_ip_ipv6_netlink                          FAIL       2
> netns_breakns_ip_ipv4_ioctl                              FAIL       2
> netns_breakns_ip_ipv6_ioctl                               FAIL       2
> netns_comm_ns_exec_ipv4_netlink                    FAIL       2
> netns_comm_ns_exec_ipv6_netlink                    FAIL       2
> netns_comm_ns_exec_ipv4_ioctl                         FAIL       2
> netns_comm_ns_exec_ipv6_ioctl                         FAIL       2
> netns_comm_ip_ipv4_netlink                              FAIL       2
> netns_comm_ip_ipv6_netlink                               FAIL       2
> netns_comm_ip_ipv4_ioctl                           FAIL       2
> netns_comm_ip_ipv6_ioctl                           FAIL       2
> netns_sysfs                                        FAIL       2

Well, next time a bit more info about the kernel and distro you run might help :).

> How i can resolve these errors please guide me how these tests needs to run and from which path.

> Thank you

Kind regards,
Petr
