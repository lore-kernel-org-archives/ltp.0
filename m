From: Pankaj Vinodrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Fri, 28 May 2021 14:09:52 +0000
Subject: [LTP] Networking testcase failure
Message-ID: <BMXPR01MB28709F3E93557EBD46666858EE229@BMXPR01MB2870.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
i am running ltp on kernel 5.10.19 custom kernel with LTP version 20200515 but following networking tests are getting failed.

I have enabled following kernel configs w.r.t. network tests

CONFIG_VETH=y
CONFIG_MACVLAN=y
CONFIG_TUN=y
CONFIG_TAP=y
CONFIG_VETH=y

1) netns_netlink

proc/cmdline
earlycon=sbi earlycon=sbi root=/dev/mmcblk0p3 rootwait console=ttySIF0 console=tty0

Gnu C                  gcc (GCC) 10.2.0
Clang
Gnu make               4.3
util-linux             2.36
mount                  linux 2.36 (libmount 2.36.0: btrfs, namespaces, assert, debug)
modutils               27
Linux C Library        > libc.2.32
Dynamic linker (ldd)   2.32
Linux C++ Library      6.0.28
Procps                 3.3.16
iproute2               iproute2-v5.7.0-77-gb687d1067169
iputils                'V'
/opt/ltp/ver_linux: line 115: ethtool: command not found
Sh-utils               8.32
Modules Loaded         snd_timer snd sha1_generic hmac dummy veth overlay ntfs btrfs blake2b_generic xor zstd_compress lzo_compress zlib_deflate raid6_pq xfs libcrc32c ofpart cmdlinepart spi_nor drm fuse drm_panel_orientation_quirks

free reports:
              total        used        free      shared  buff/cache   available
Mem:        8159408       84208     7874656       50964      200544     7944964
Swap:             0           0           0



netns_netlink    1 TCONF :  netns_helper.h:48: Failed while obtaining version for iproute check
netns_netlink    2 TCONF  :  netns_helper.h:48: Remaining cases not appropriate for configuration


2) netns_breakns_ip_ipv4_ioctl
3) netns_breakns_ns_exec_ipv4_ioctl
4) netns_breakns_ns_exec_ipv6_ioctl
5) netns_comm_ip_ipv4_ioctl
6) netns_comm_ip_ipv6_ioctl
7) netns_comm_ns_exec_ipv4_ioctl
8) netns_comm_ns_exec_ipv6_ioctl

Failure log:-

/opt/ltp/testcases/bin/netns_helper.sh: line 71: [: too many arguments
/opt/ltp/testcases/bin/netns_helper.sh: line 75: [: too many arguments
ifconfig: bad address '192.168.0.2/24'
netns_breakns_ip_ipv4_ioctl 1 TBROK: adding address to veth0 failed
<<<execution_status>>>

Can someone help me what could be the reason behind failure of all ??


Thanks

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210528/551c9da3/attachment.htm>
