From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 May 2016 11:46:05 +0300
Subject: [LTP] [RFC][PATCH 3/3] network: rename runtest files,
	use 'net.' & 'net_stress.' prefix
In-Reply-To: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
References: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1462869965-25841-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/ipv6                     |    6 -
 runtest/ipv6_lib                 |    7 -
 runtest/multicast                |    8 -
 runtest/net.features             |   36 ++++
 runtest/net.ipv6                 |    6 +
 runtest/net.ipv6_lib             |    7 +
 runtest/net.multicast            |    8 +
 runtest/net.nfs                  |   33 ++++
 runtest/net.rpc                  |    8 +
 runtest/net.sctp                 |   43 +++++
 runtest/net.tcp_cmds             |   26 +++
 runtest/net_stress.appl          |   18 ++
 runtest/net_stress.broken_ip     |   17 ++
 runtest/net_stress.interfaces    |   19 +++
 runtest/net_stress.ipsec_icmp    |   69 ++++++++
 runtest/net_stress.ipsec_tcp     |  333 ++++++++++++++++++++++++++++++++++++++
 runtest/net_stress.ipsec_udp     |   67 ++++++++
 runtest/net_stress.multicast     |   29 ++++
 runtest/net_stress.route         |   17 ++
 runtest/network_stress.appl      |   18 --
 runtest/network_stress.broken_ip |   17 --
 runtest/network_stress.features  |   36 ----
 runtest/network_stress.icmp      |   69 --------
 runtest/network_stress.interface |   19 ---
 runtest/network_stress.multicast |   29 ----
 runtest/network_stress.route     |   17 --
 runtest/network_stress.tcp       |  333 --------------------------------------
 runtest/network_stress.udp       |   67 --------
 runtest/nfs                      |   33 ----
 runtest/rpc                      |    8 -
 runtest/sctp                     |   43 -----
 runtest/tcp_cmds                 |   26 ---
 scenario_groups/default          |    2 +-
 scenario_groups/network          |    8 +-
 testscripts/network.sh           |   30 ++--
 35 files changed, 756 insertions(+), 756 deletions(-)
 delete mode 100644 runtest/ipv6
 delete mode 100644 runtest/ipv6_lib
 delete mode 100644 runtest/multicast
 create mode 100644 runtest/net.features
 create mode 100644 runtest/net.ipv6
 create mode 100644 runtest/net.ipv6_lib
 create mode 100644 runtest/net.multicast
 create mode 100644 runtest/net.nfs
 create mode 100644 runtest/net.rpc
 create mode 100644 runtest/net.sctp
 create mode 100644 runtest/net.tcp_cmds
 create mode 100644 runtest/net_stress.appl
 create mode 100644 runtest/net_stress.broken_ip
 create mode 100644 runtest/net_stress.interfaces
 create mode 100644 runtest/net_stress.ipsec_icmp
 create mode 100644 runtest/net_stress.ipsec_tcp
 create mode 100644 runtest/net_stress.ipsec_udp
 create mode 100644 runtest/net_stress.multicast
 create mode 100644 runtest/net_stress.route
 delete mode 100644 runtest/network_stress.appl
 delete mode 100644 runtest/network_stress.broken_ip
 delete mode 100644 runtest/network_stress.features
 delete mode 100644 runtest/network_stress.icmp
 delete mode 100644 runtest/network_stress.interface
 delete mode 100644 runtest/network_stress.multicast
 delete mode 100644 runtest/network_stress.route
 delete mode 100644 runtest/network_stress.tcp
 delete mode 100644 runtest/network_stress.udp
 delete mode 100644 runtest/nfs
 delete mode 100644 runtest/rpc
 delete mode 100644 runtest/sctp
 delete mode 100644 runtest/tcp_cmds

diff --git a/runtest/ipv6 b/runtest/ipv6
deleted file mode 100644
index f910684..0000000
--- a/runtest/ipv6
+++ /dev/null
@@ -1,6 +0,0 @@
-#DESCRIPTION:IPV6 related tests
-ping601 ping01 -6
-sendfile601 sendfile01 -6
-tcpdump601 tcpdump01 -6
-dhcpd6 dhcpd_tests.sh -6
-dnsmasq6 dnsmasq_tests.sh -6
diff --git a/runtest/ipv6_lib b/runtest/ipv6_lib
deleted file mode 100644
index 636232b..0000000
--- a/runtest/ipv6_lib
+++ /dev/null
@@ -1,7 +0,0 @@
-#DESCRIPTION:IPV6 related tests
-in6_01 in6_01
-in6_02 in6_02
-getaddrinfo_01 getaddrinfo_01
-asapi_01 asapi_01
-asapi_02 asapi_02
-asapi_03 asapi_03
diff --git a/runtest/multicast b/runtest/multicast
deleted file mode 100644
index 44c384a..0000000
--- a/runtest/multicast
+++ /dev/null
@@ -1,8 +0,0 @@
-#DESCRIPTION:Multicast networking tests
-#
-# PLEASE READ THE README FILE IN /multicast BEFORE RUNNING THESE.
-#
-mc_cmds mc_cmds
-mc_commo mc_commo
-mc_member mc_member
-mc_opts mc_opts
diff --git a/runtest/net.features b/runtest/net.features
new file mode 100644
index 0000000..bb907e5
--- /dev/null
+++ b/runtest/net.features
@@ -0,0 +1,36 @@
+#
+# Stress tests for various network features
+#
+
+busy_poll01 busy_poll01.sh
+busy_poll01_ipv6 busy_poll01.sh -6
+
+busy_poll02 busy_poll02.sh
+busy_poll02_ipv6 busy_poll02.sh -6
+
+tcp_fastopen tcp_fastopen_run.sh
+tcp_fastopen6 tcp_fastopen_run.sh -6
+
+vxlan01 vxlan01.sh
+vxlan02 vxlan02.sh
+
+vxlan_multi_03 vxlan03.sh -d multi
+vxlan_uni_03 vxlan03.sh -d uni
+
+vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
+vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
+
+vlan01 vlan01.sh
+vlan02 vlan02.sh
+vlan03 vlan03.sh
+
+macvlan01 macvlan01.sh
+macvtap01 macvtap01.sh
+
+ipvlan01 ipvlan01.sh
+
+gre_ipv4_01 gre01.sh
+gre_ipv6_01 gre01.sh -6
+
+dctcp_ipv4_01 dctcp01.sh
+dctcp_ipv6_01 dctcp01.sh -6
diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
new file mode 100644
index 0000000..f910684
--- /dev/null
+++ b/runtest/net.ipv6
@@ -0,0 +1,6 @@
+#DESCRIPTION:IPV6 related tests
+ping601 ping01 -6
+sendfile601 sendfile01 -6
+tcpdump601 tcpdump01 -6
+dhcpd6 dhcpd_tests.sh -6
+dnsmasq6 dnsmasq_tests.sh -6
diff --git a/runtest/net.ipv6_lib b/runtest/net.ipv6_lib
new file mode 100644
index 0000000..636232b
--- /dev/null
+++ b/runtest/net.ipv6_lib
@@ -0,0 +1,7 @@
+#DESCRIPTION:IPV6 related tests
+in6_01 in6_01
+in6_02 in6_02
+getaddrinfo_01 getaddrinfo_01
+asapi_01 asapi_01
+asapi_02 asapi_02
+asapi_03 asapi_03
diff --git a/runtest/net.multicast b/runtest/net.multicast
new file mode 100644
index 0000000..44c384a
--- /dev/null
+++ b/runtest/net.multicast
@@ -0,0 +1,8 @@
+#DESCRIPTION:Multicast networking tests
+#
+# PLEASE READ THE README FILE IN /multicast BEFORE RUNNING THESE.
+#
+mc_cmds mc_cmds
+mc_commo mc_commo
+mc_member mc_member
+mc_opts mc_opts
diff --git a/runtest/net.nfs b/runtest/net.nfs
new file mode 100644
index 0000000..43cf504
--- /dev/null
+++ b/runtest/net.nfs
@@ -0,0 +1,33 @@
+#DESCRIPTION:Network filesystem stress
+#
+# PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
+#
+nfs3_01 export VERSION=3 SOCKET_TYPE=udp; nfs01
+nfs4_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01
+nfs3_ipv6_01 export VERSION=3 SOCKET_TYPE=udp; nfs01 -6
+nfs4_ipv6_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01 -6
+
+nfs3_02 export VERSION=3 SOCKET_TYPE=udp; nfs02
+nfs4_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02
+nfs3_ipv6_02 export VERSION=3 SOCKET_TYPE=udp; nfs02 -6
+nfs4_ipv6_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02 -6
+
+nfs3_03 export VERSION=3 SOCKET_TYPE=udp; nfs03
+nfs4_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03
+nfs3_ipv6_03 export VERSION=3 SOCKET_TYPE=udp; nfs03 -6
+nfs4_ipv6_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03 -6
+
+nfs3_04 export VERSION=3 SOCKET_TYPE=udp; nfs04
+nfs4_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04
+nfs3_ipv6_04 export VERSION=3 SOCKET_TYPE=udp; nfs04 -6
+nfs4_ipv6_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04 -6
+
+nfs3_05 export VERSION=3 SOCKET_TYPE=udp; nfs05
+nfs4_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05
+nfs3_ipv6_05 export VERSION=3 SOCKET_TYPE=udp; nfs05 -6
+nfs4_ipv6_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05 -6
+
+nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
+
+nfsstat01 export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01
+nfsx-linux export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin fsx.sh
diff --git a/runtest/net.rpc b/runtest/net.rpc
new file mode 100644
index 0000000..b65268c
--- /dev/null
+++ b/runtest/net.rpc
@@ -0,0 +1,8 @@
+#DESCRIPTION:Remote Procedure Call
+#
+# PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
+#
+rpc01 rpc01
+rpcinfo rpcinfo01
+rup rup01
+rusers rusers01
diff --git a/runtest/net.sctp b/runtest/net.sctp
new file mode 100644
index 0000000..71cc0d1
--- /dev/null
+++ b/runtest/net.sctp
@@ -0,0 +1,43 @@
+#DESCRIPTION:Stream Control Transmission Protocol (SCTP) Tests
+#
+test_1_to_1_accept_close test_1_to_1_accept_close
+test_1_to_1_addrs test_1_to_1_addrs
+test_1_to_1_connect test_1_to_1_connect
+test_1_to_1_connectx test_1_to_1_connectx
+test_1_to_1_events test_1_to_1_events
+test_1_to_1_initmsg_connect test_1_to_1_initmsg_connect
+test_1_to_1_nonblock test_1_to_1_nonblock
+test_1_to_1_recvfrom test_1_to_1_recvfrom
+test_1_to_1_recvmsg test_1_to_1_recvmsg
+test_1_to_1_rtoinfo test_1_to_1_rtoinfo
+test_1_to_1_send test_1_to_1_send
+test_1_to_1_sendmsg test_1_to_1_sendmsg
+test_1_to_1_sendto test_1_to_1_sendto
+test_1_to_1_shutdown test_1_to_1_shutdown
+test_1_to_1_socket_bind_listen test_1_to_1_socket_bind_listen
+test_1_to_1_sockopt test_1_to_1_sockopt
+test_1_to_1_threads test_1_to_1_threads
+test_assoc_abort test_assoc_abort
+test_assoc_shutdown test_assoc_shutdown
+test_autoclose test_autoclose
+test_basic test_basic
+test_basic_v6 test_basic_v6
+test_connect test_connect
+test_connectx test_connectx
+test_fragments test_fragments
+test_fragments_v6 test_fragments_v6
+test_getname test_getname
+test_getname_v6 test_getname_v6
+test_inaddr_any test_inaddr_any
+test_inaddr_any_v6 test_inaddr_any_v6
+test_peeloff test_peeloff
+test_peeloff_v6 test_peeloff_v6
+test_recvmsg test_recvmsg
+test_sctp_sendrecvmsg test_sctp_sendrecvmsg
+test_sctp_sendrecvmsg_v6 test_sctp_sendrecvmsg_v6
+test_sockopt test_sockopt
+test_sockopt_v6 test_sockopt_v6
+test_tcp_style test_tcp_style
+test_tcp_style_v6 test_tcp_style_v6
+test_timetolive test_timetolive
+test_timetolive_v6 test_timetolive_v6
diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
new file mode 100644
index 0000000..466718b
--- /dev/null
+++ b/runtest/net.tcp_cmds
@@ -0,0 +1,26 @@
+#DESCRIPTION:TCP/IP commands tests
+#
+# PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
+#
+arp arp01
+echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
+finger finger01
+ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
+host host01
+netstat netstat01
+perf_lan export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
+ping export LTPROOT; ping01
+rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
+rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
+rlogin rlogin01
+rsh rsh01
+rwho rwho01
+sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
+tcpdump tcpdump01
+telnet telnet01
+iptables iptables_tests.sh
+dhcpd dhcpd_tests.sh
+dnsmasq dnsmasq_tests.sh
+iproute ip_tests.sh
+traceroute traceroute_tests.sh
+xinetd xinetd_tests.sh
diff --git a/runtest/net_stress.appl b/runtest/net_stress.appl
new file mode 100644
index 0000000..c06af71
--- /dev/null
+++ b/runtest/net_stress.appl
@@ -0,0 +1,18 @@
+#
+# Stress test for major application protocol (ssh, dns, http, ftp)
+#
+
+ssh4-stress ssh-stress
+ssh6-stress ssh-stress -6
+
+dns4-stress dns-stress
+dns6-stress dns-stress -6
+
+http4-stress http-stress
+http6-stress http-stress -6
+
+ftp4-download-stress ftp-download-stress
+ftp6-download-stress ftp-download-stress -6
+
+ftp4-upload-stress ftp-upload-stress
+ftp6-upload-stress ftp-upload-stress -6
diff --git a/runtest/net_stress.broken_ip b/runtest/net_stress.broken_ip
new file mode 100644
index 0000000..c037f3e
--- /dev/null
+++ b/runtest/net_stress.broken_ip
@@ -0,0 +1,17 @@
+#
+# Stress test for TCP/IP protocol stack
+#
+
+# Broken IP packet
+broken_ip4-version broken_ip4-version
+broken_ip4-ihl broken_ip4-ihl
+broken_ip4-totlen broken_ip4-totlen
+broken_ip4-fragment broken_ip4-fragment
+broken_ip4-protcol broken_ip4-protcol
+broken_ip4-checksum broken_ip4-checksum
+broken_ip4-dstaddr broken_ip4-dstaddr
+
+broken_ip6-dstaddr broken_ip6-dstaddr
+broken_ip6-nexthdr broken_ip6-nexthdr
+broken_ip6-plen broken_ip6-plen
+broken_ip6-version broken_ip6-version
diff --git a/runtest/net_stress.interfaces b/runtest/net_stress.interfaces
new file mode 100644
index 0000000..97e9ce3
--- /dev/null
+++ b/runtest/net_stress.interfaces
@@ -0,0 +1,19 @@
+#
+# Stress test for interface
+#
+
+if4-addr-change if4-addr-change
+
+if4-updown if-updown
+if4-addr-adddel if-addr-adddel
+if4-addr-addlarge if-addr-addlarge
+if4-route-adddel if-route-adddel
+if4-route-addlarge if-route-addlarge
+if4-mtu-change if-mtu-change
+
+if6-updown if-updown -6
+if6-addr-adddel if-addr-adddel -6
+if6-addr-addlarge if-addr-addlarge -6
+if6-route-adddel if-route-adddel -6
+if6-route-addlarge if-route-addlarge -6
+if6-mtu-change if-mtu-change -6
diff --git a/runtest/net_stress.ipsec_icmp b/runtest/net_stress.ipsec_icmp
new file mode 100644
index 0000000..2b989b1
--- /dev/null
+++ b/runtest/net_stress.ipsec_icmp
@@ -0,0 +1,69 @@
+#
+# Stress test for TCP/IP protocol stack (ICMP)
+#
+
+# MAX_LENGTH(65535) - IP(20) - ICMP(8) = MAX_SIZE(65507)
+icmp4-uni-basic01 icmp-uni-basic.sh -s "10 100 1000 10000 65507"
+# MAX_LENGTH(65535) - IP(20) - AH(24) - ICMP(8) = MAX_SIZE(65483)
+icmp4-uni-basic02 icmp-uni-basic.sh -p ah -m transport -s "10 100 1000 10000 65483"
+# MAX_LENGTH(65535) - IP(20) - AH(24) - Tunnel(IPv4 20) - ICMP(8) = MAX_SIZE(65463)
+icmp4-uni-basic03 icmp-uni-basic.sh -p ah -m tunnel -s "10 100 1000 10000 65463"
+# MAX_LENGTH(65535) - IP(20) - ESP (37) - ICMP(8) = MAX_SIZE(65470)
+# ESP Header has pad payload, so the ESP length is variable
+icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s "10 100 1000 10000 65470"
+# MAX_LENGTH(65535) - IP(20) - ESP (37) - Tunnel(20) - ICMP(8) = MAX_SIZE(65450)
+icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s "10 100 1000 10000 65450"
+# Same message size but different content will result in different data size
+# after compression. So we just use a large enough message size(65000) for testing
+icmp4-uni-basic06 icmp-uni-basic.sh -p ipcomp -m transport -s "10 100 1000 10000 65000"
+icmp4-uni-basic07 icmp-uni-basic.sh -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
+
+# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
+icmp6-uni-basic01 icmp-uni-basic.sh -6 -s "10 100 1000 10000 65527"
+# MAX_LENGTH(65535) - AH(24) - ICMP(8) = MAX_SIZE(65503)
+icmp6-uni-basic02 icmp-uni-basic.sh -6 -p ah -m transport -s "10 100 1000 10000 65503"
+# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
+# When receive, we drop the tunnel header first and only leave the inside IPv6
+# Header and icmp message. That's why we can have so large message size.
+icmp6-uni-basic03 icmp-uni-basic.sh -6 -p ah -m tunnel -s "10 100 1000 10000 65527"
+# MAX_LENGTH(65535) - ESP (33) - ICMP(8) = MAX_SIZE(65494)
+# ESP Header has pad payload, so the ESP length is variable
+icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000 65494"
+# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
+icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65527"
+# Same message size but different content will result in different data size
+# after compression. So we just use a large enough message size(65000) for testing
+icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
+icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
+
+icmp4-multi-diffip01 icmp4-multi-diffip01
+icmp4-multi-diffip02 icmp4-multi-diffip02
+icmp4-multi-diffip03 icmp4-multi-diffip03
+icmp4-multi-diffip04 icmp4-multi-diffip04
+icmp4-multi-diffip05 icmp4-multi-diffip05
+icmp4-multi-diffip06 icmp4-multi-diffip06
+icmp4-multi-diffip07 icmp4-multi-diffip07
+
+icmp6-multi-diffip01 icmp6-multi-diffip01
+icmp6-multi-diffip02 icmp6-multi-diffip02
+icmp6-multi-diffip03 icmp6-multi-diffip03
+icmp6-multi-diffip04 icmp6-multi-diffip04
+icmp6-multi-diffip05 icmp6-multi-diffip05
+icmp6-multi-diffip06 icmp6-multi-diffip06
+icmp6-multi-diffip07 icmp6-multi-diffip07
+
+icmp4-multi-diffnic01 icmp4-multi-diffnic01
+icmp4-multi-diffnic02 icmp4-multi-diffnic02
+icmp4-multi-diffnic03 icmp4-multi-diffnic03
+icmp4-multi-diffnic04 icmp4-multi-diffnic04
+icmp4-multi-diffnic05 icmp4-multi-diffnic05
+icmp4-multi-diffnic06 icmp4-multi-diffnic06
+icmp4-multi-diffnic07 icmp4-multi-diffnic07
+
+icmp6-multi-diffnic01 icmp6-multi-diffnic01
+icmp6-multi-diffnic02 icmp6-multi-diffnic02
+icmp6-multi-diffnic03 icmp6-multi-diffnic03
+icmp6-multi-diffnic04 icmp6-multi-diffnic04
+icmp6-multi-diffnic05 icmp6-multi-diffnic05
+icmp6-multi-diffnic06 icmp6-multi-diffnic06
+icmp6-multi-diffnic07 icmp6-multi-diffnic07
diff --git a/runtest/net_stress.ipsec_tcp b/runtest/net_stress.ipsec_tcp
new file mode 100644
index 0000000..7206b3a
--- /dev/null
+++ b/runtest/net_stress.ipsec_tcp
@@ -0,0 +1,333 @@
+#
+# Stress test for TCP/IP protocol stack (TCP)
+#
+
+tcp4-uni-basic01 tcp4-uni-basic01
+tcp4-uni-basic02 tcp4-uni-basic02
+tcp4-uni-basic03 tcp4-uni-basic03
+tcp4-uni-basic04 tcp4-uni-basic04
+tcp4-uni-basic05 tcp4-uni-basic05
+tcp4-uni-basic06 tcp4-uni-basic06
+tcp4-uni-basic07 tcp4-uni-basic07
+tcp4-uni-basic08 tcp4-uni-basic08
+tcp4-uni-basic09 tcp4-uni-basic09
+tcp4-uni-basic10 tcp4-uni-basic10
+tcp4-uni-basic11 tcp4-uni-basic11
+tcp4-uni-basic12 tcp4-uni-basic12
+tcp4-uni-basic13 tcp4-uni-basic13
+tcp4-uni-basic14 tcp4-uni-basic14
+
+tcp6-uni-basic01 tcp6-uni-basic01
+tcp6-uni-basic02 tcp6-uni-basic02
+tcp6-uni-basic03 tcp6-uni-basic03
+tcp6-uni-basic04 tcp6-uni-basic04
+tcp6-uni-basic05 tcp6-uni-basic05
+tcp6-uni-basic06 tcp6-uni-basic06
+tcp6-uni-basic07 tcp6-uni-basic07
+tcp6-uni-basic08 tcp6-uni-basic08
+tcp6-uni-basic09 tcp6-uni-basic09
+tcp6-uni-basic10 tcp6-uni-basic10
+tcp6-uni-basic11 tcp6-uni-basic11
+tcp6-uni-basic12 tcp6-uni-basic12
+tcp6-uni-basic13 tcp6-uni-basic13
+tcp6-uni-basic14 tcp6-uni-basic14
+
+tcp4-uni-smallsend01 tcp4-uni-smallsend01
+tcp4-uni-smallsend02 tcp4-uni-smallsend02
+tcp4-uni-smallsend03 tcp4-uni-smallsend03
+tcp4-uni-smallsend04 tcp4-uni-smallsend04
+tcp4-uni-smallsend05 tcp4-uni-smallsend05
+tcp4-uni-smallsend06 tcp4-uni-smallsend06
+tcp4-uni-smallsend07 tcp4-uni-smallsend07
+tcp4-uni-smallsend08 tcp4-uni-smallsend08
+tcp4-uni-smallsend09 tcp4-uni-smallsend09
+tcp4-uni-smallsend10 tcp4-uni-smallsend10
+tcp4-uni-smallsend11 tcp4-uni-smallsend11
+tcp4-uni-smallsend12 tcp4-uni-smallsend12
+tcp4-uni-smallsend13 tcp4-uni-smallsend13
+tcp4-uni-smallsend14 tcp4-uni-smallsend14
+
+tcp6-uni-smallsend01 tcp6-uni-smallsend01
+tcp6-uni-smallsend02 tcp6-uni-smallsend02
+tcp6-uni-smallsend03 tcp6-uni-smallsend03
+tcp6-uni-smallsend04 tcp6-uni-smallsend04
+tcp6-uni-smallsend05 tcp6-uni-smallsend05
+tcp6-uni-smallsend06 tcp6-uni-smallsend06
+tcp6-uni-smallsend07 tcp6-uni-smallsend07
+tcp6-uni-smallsend08 tcp6-uni-smallsend08
+tcp6-uni-smallsend09 tcp6-uni-smallsend09
+tcp6-uni-smallsend10 tcp6-uni-smallsend10
+tcp6-uni-smallsend11 tcp6-uni-smallsend11
+tcp6-uni-smallsend12 tcp6-uni-smallsend12
+tcp6-uni-smallsend13 tcp6-uni-smallsend13
+tcp6-uni-smallsend14 tcp6-uni-smallsend14
+
+tcp4-uni-winscale01 tcp4-uni-winscale01
+tcp4-uni-winscale02 tcp4-uni-winscale02
+tcp4-uni-winscale03 tcp4-uni-winscale03
+tcp4-uni-winscale04 tcp4-uni-winscale04
+tcp4-uni-winscale05 tcp4-uni-winscale05
+tcp4-uni-winscale06 tcp4-uni-winscale06
+tcp4-uni-winscale07 tcp4-uni-winscale07
+tcp4-uni-winscale08 tcp4-uni-winscale08
+tcp4-uni-winscale09 tcp4-uni-winscale09
+tcp4-uni-winscale10 tcp4-uni-winscale10
+tcp4-uni-winscale11 tcp4-uni-winscale11
+tcp4-uni-winscale12 tcp4-uni-winscale12
+tcp4-uni-winscale13 tcp4-uni-winscale13
+tcp4-uni-winscale14 tcp4-uni-winscale14
+
+tcp6-uni-winscale01 tcp6-uni-winscale01
+tcp6-uni-winscale02 tcp6-uni-winscale02
+tcp6-uni-winscale03 tcp6-uni-winscale03
+tcp6-uni-winscale04 tcp6-uni-winscale04
+tcp6-uni-winscale05 tcp6-uni-winscale05
+tcp6-uni-winscale06 tcp6-uni-winscale06
+tcp6-uni-winscale07 tcp6-uni-winscale07
+tcp6-uni-winscale08 tcp6-uni-winscale08
+tcp6-uni-winscale09 tcp6-uni-winscale09
+tcp6-uni-winscale10 tcp6-uni-winscale10
+tcp6-uni-winscale11 tcp6-uni-winscale11
+tcp6-uni-winscale12 tcp6-uni-winscale12
+tcp6-uni-winscale13 tcp6-uni-winscale13
+tcp6-uni-winscale14 tcp6-uni-winscale14
+
+tcp4-uni-tso01 tcp4-uni-tso01
+tcp4-uni-tso02 tcp4-uni-tso02
+tcp4-uni-tso03 tcp4-uni-tso03
+tcp4-uni-tso04 tcp4-uni-tso04
+tcp4-uni-tso05 tcp4-uni-tso05
+tcp4-uni-tso06 tcp4-uni-tso06
+tcp4-uni-tso07 tcp4-uni-tso07
+tcp4-uni-tso08 tcp4-uni-tso08
+tcp4-uni-tso09 tcp4-uni-tso09
+tcp4-uni-tso10 tcp4-uni-tso10
+tcp4-uni-tso11 tcp4-uni-tso11
+tcp4-uni-tso12 tcp4-uni-tso12
+tcp4-uni-tso13 tcp4-uni-tso13
+tcp4-uni-tso14 tcp4-uni-tso14
+
+tcp6-uni-tso01 tcp6-uni-tso01
+tcp6-uni-tso02 tcp6-uni-tso02
+tcp6-uni-tso03 tcp6-uni-tso03
+tcp6-uni-tso04 tcp6-uni-tso04
+tcp6-uni-tso05 tcp6-uni-tso05
+tcp6-uni-tso06 tcp6-uni-tso06
+tcp6-uni-tso07 tcp6-uni-tso07
+tcp6-uni-tso08 tcp6-uni-tso08
+tcp6-uni-tso09 tcp6-uni-tso09
+tcp6-uni-tso10 tcp6-uni-tso10
+tcp6-uni-tso11 tcp6-uni-tso11
+tcp6-uni-tso12 tcp6-uni-tso12
+tcp6-uni-tso13 tcp6-uni-tso13
+tcp6-uni-tso14 tcp6-uni-tso14
+
+tcp4-uni-pktlossdup01 tcp4-uni-pktlossdup01
+tcp4-uni-pktlossdup02 tcp4-uni-pktlossdup02
+tcp4-uni-pktlossdup03 tcp4-uni-pktlossdup03
+tcp4-uni-pktlossdup04 tcp4-uni-pktlossdup04
+tcp4-uni-pktlossdup05 tcp4-uni-pktlossdup05
+tcp4-uni-pktlossdup06 tcp4-uni-pktlossdup06
+tcp4-uni-pktlossdup07 tcp4-uni-pktlossdup07
+tcp4-uni-pktlossdup08 tcp4-uni-pktlossdup08
+tcp4-uni-pktlossdup09 tcp4-uni-pktlossdup09
+tcp4-uni-pktlossdup10 tcp4-uni-pktlossdup10
+tcp4-uni-pktlossdup11 tcp4-uni-pktlossdup11
+tcp4-uni-pktlossdup12 tcp4-uni-pktlossdup12
+tcp4-uni-pktlossdup13 tcp4-uni-pktlossdup13
+tcp4-uni-pktlossdup14 tcp4-uni-pktlossdup14
+
+tcp6-uni-pktlossdup01 tcp6-uni-pktlossdup01
+tcp6-uni-pktlossdup02 tcp6-uni-pktlossdup02
+tcp6-uni-pktlossdup03 tcp6-uni-pktlossdup03
+tcp6-uni-pktlossdup04 tcp6-uni-pktlossdup04
+tcp6-uni-pktlossdup05 tcp6-uni-pktlossdup05
+tcp6-uni-pktlossdup06 tcp6-uni-pktlossdup06
+tcp6-uni-pktlossdup07 tcp6-uni-pktlossdup07
+tcp6-uni-pktlossdup08 tcp6-uni-pktlossdup08
+tcp6-uni-pktlossdup09 tcp6-uni-pktlossdup09
+tcp6-uni-pktlossdup10 tcp6-uni-pktlossdup10
+tcp6-uni-pktlossdup11 tcp6-uni-pktlossdup11
+tcp6-uni-pktlossdup12 tcp6-uni-pktlossdup12
+tcp6-uni-pktlossdup13 tcp6-uni-pktlossdup13
+tcp6-uni-pktlossdup14 tcp6-uni-pktlossdup14
+
+tcp4-uni-dsackoff01 tcp4-uni-dsackoff01
+tcp4-uni-dsackoff02 tcp4-uni-dsackoff02
+tcp4-uni-dsackoff03 tcp4-uni-dsackoff03
+tcp4-uni-dsackoff04 tcp4-uni-dsackoff04
+tcp4-uni-dsackoff05 tcp4-uni-dsackoff05
+tcp4-uni-dsackoff06 tcp4-uni-dsackoff06
+tcp4-uni-dsackoff07 tcp4-uni-dsackoff07
+tcp4-uni-dsackoff08 tcp4-uni-dsackoff08
+tcp4-uni-dsackoff09 tcp4-uni-dsackoff09
+tcp4-uni-dsackoff10 tcp4-uni-dsackoff10
+tcp4-uni-dsackoff11 tcp4-uni-dsackoff11
+tcp4-uni-dsackoff12 tcp4-uni-dsackoff12
+tcp4-uni-dsackoff13 tcp4-uni-dsackoff13
+tcp4-uni-dsackoff14 tcp4-uni-dsackoff14
+
+tcp6-uni-dsackoff01 tcp6-uni-dsackoff01
+tcp6-uni-dsackoff02 tcp6-uni-dsackoff02
+tcp6-uni-dsackoff03 tcp6-uni-dsackoff03
+tcp6-uni-dsackoff04 tcp6-uni-dsackoff04
+tcp6-uni-dsackoff05 tcp6-uni-dsackoff05
+tcp6-uni-dsackoff06 tcp6-uni-dsackoff06
+tcp6-uni-dsackoff07 tcp6-uni-dsackoff07
+tcp6-uni-dsackoff08 tcp6-uni-dsackoff08
+tcp6-uni-dsackoff09 tcp6-uni-dsackoff09
+tcp6-uni-dsackoff10 tcp6-uni-dsackoff10
+tcp6-uni-dsackoff11 tcp6-uni-dsackoff11
+tcp6-uni-dsackoff12 tcp6-uni-dsackoff12
+tcp6-uni-dsackoff13 tcp6-uni-dsackoff13
+tcp6-uni-dsackoff14 tcp6-uni-dsackoff14
+
+tcp4-uni-sackoff01 tcp4-uni-sackoff01
+tcp4-uni-sackoff02 tcp4-uni-sackoff02
+tcp4-uni-sackoff03 tcp4-uni-sackoff03
+tcp4-uni-sackoff04 tcp4-uni-sackoff04
+tcp4-uni-sackoff05 tcp4-uni-sackoff05
+tcp4-uni-sackoff06 tcp4-uni-sackoff06
+tcp4-uni-sackoff07 tcp4-uni-sackoff07
+tcp4-uni-sackoff08 tcp4-uni-sackoff08
+tcp4-uni-sackoff09 tcp4-uni-sackoff09
+tcp4-uni-sackoff10 tcp4-uni-sackoff10
+tcp4-uni-sackoff11 tcp4-uni-sackoff11
+tcp4-uni-sackoff12 tcp4-uni-sackoff12
+tcp4-uni-sackoff13 tcp4-uni-sackoff13
+tcp4-uni-sackoff14 tcp4-uni-sackoff14
+
+tcp6-uni-sackoff01 tcp6-uni-sackoff01
+tcp6-uni-sackoff02 tcp6-uni-sackoff02
+tcp6-uni-sackoff03 tcp6-uni-sackoff03
+tcp6-uni-sackoff04 tcp6-uni-sackoff04
+tcp6-uni-sackoff05 tcp6-uni-sackoff05
+tcp6-uni-sackoff06 tcp6-uni-sackoff06
+tcp6-uni-sackoff07 tcp6-uni-sackoff07
+tcp6-uni-sackoff08 tcp6-uni-sackoff08
+tcp6-uni-sackoff09 tcp6-uni-sackoff09
+tcp6-uni-sackoff10 tcp6-uni-sackoff10
+tcp6-uni-sackoff11 tcp6-uni-sackoff11
+tcp6-uni-sackoff12 tcp6-uni-sackoff12
+tcp6-uni-sackoff13 tcp6-uni-sackoff13
+tcp6-uni-sackoff14 tcp6-uni-sackoff14
+
+tcp4-multi-sameport01 tcp4-multi-sameport01
+tcp4-multi-sameport02 tcp4-multi-sameport02
+tcp4-multi-sameport03 tcp4-multi-sameport03
+tcp4-multi-sameport04 tcp4-multi-sameport04
+tcp4-multi-sameport05 tcp4-multi-sameport05
+tcp4-multi-sameport06 tcp4-multi-sameport06
+tcp4-multi-sameport07 tcp4-multi-sameport07
+tcp4-multi-sameport08 tcp4-multi-sameport08
+tcp4-multi-sameport09 tcp4-multi-sameport09
+tcp4-multi-sameport10 tcp4-multi-sameport10
+tcp4-multi-sameport11 tcp4-multi-sameport11
+tcp4-multi-sameport12 tcp4-multi-sameport12
+tcp4-multi-sameport13 tcp4-multi-sameport13
+tcp4-multi-sameport14 tcp4-multi-sameport14
+
+tcp6-multi-sameport01 tcp6-multi-sameport01
+tcp6-multi-sameport02 tcp6-multi-sameport02
+tcp6-multi-sameport03 tcp6-multi-sameport03
+tcp6-multi-sameport04 tcp6-multi-sameport04
+tcp6-multi-sameport05 tcp6-multi-sameport05
+tcp6-multi-sameport06 tcp6-multi-sameport06
+tcp6-multi-sameport07 tcp6-multi-sameport07
+tcp6-multi-sameport08 tcp6-multi-sameport08
+tcp6-multi-sameport09 tcp6-multi-sameport09
+tcp6-multi-sameport10 tcp6-multi-sameport10
+tcp6-multi-sameport11 tcp6-multi-sameport11
+tcp6-multi-sameport12 tcp6-multi-sameport12
+tcp6-multi-sameport13 tcp6-multi-sameport13
+tcp6-multi-sameport14 tcp6-multi-sameport14
+
+tcp4-multi-diffport01 tcp4-multi-diffport01
+tcp4-multi-diffport02 tcp4-multi-diffport02
+tcp4-multi-diffport03 tcp4-multi-diffport03
+tcp4-multi-diffport04 tcp4-multi-diffport04
+tcp4-multi-diffport05 tcp4-multi-diffport05
+tcp4-multi-diffport06 tcp4-multi-diffport06
+tcp4-multi-diffport07 tcp4-multi-diffport07
+tcp4-multi-diffport08 tcp4-multi-diffport08
+tcp4-multi-diffport09 tcp4-multi-diffport09
+tcp4-multi-diffport10 tcp4-multi-diffport10
+tcp4-multi-diffport11 tcp4-multi-diffport11
+tcp4-multi-diffport12 tcp4-multi-diffport12
+tcp4-multi-diffport13 tcp4-multi-diffport13
+tcp4-multi-diffport14 tcp4-multi-diffport14
+
+tcp6-multi-diffport01 tcp6-multi-diffport01
+tcp6-multi-diffport02 tcp6-multi-diffport02
+tcp6-multi-diffport03 tcp6-multi-diffport03
+tcp6-multi-diffport04 tcp6-multi-diffport04
+tcp6-multi-diffport05 tcp6-multi-diffport05
+tcp6-multi-diffport06 tcp6-multi-diffport06
+tcp6-multi-diffport07 tcp6-multi-diffport07
+tcp6-multi-diffport08 tcp6-multi-diffport08
+tcp6-multi-diffport09 tcp6-multi-diffport09
+tcp6-multi-diffport10 tcp6-multi-diffport10
+tcp6-multi-diffport11 tcp6-multi-diffport11
+tcp6-multi-diffport12 tcp6-multi-diffport12
+tcp6-multi-diffport13 tcp6-multi-diffport13
+tcp6-multi-diffport14 tcp6-multi-diffport14
+
+tcp4-multi-diffip01 tcp4-multi-diffip01
+tcp4-multi-diffip02 tcp4-multi-diffip02
+tcp4-multi-diffip03 tcp4-multi-diffip03
+tcp4-multi-diffip04 tcp4-multi-diffip04
+tcp4-multi-diffip05 tcp4-multi-diffip05
+tcp4-multi-diffip06 tcp4-multi-diffip06
+tcp4-multi-diffip07 tcp4-multi-diffip07
+tcp4-multi-diffip08 tcp4-multi-diffip08
+tcp4-multi-diffip09 tcp4-multi-diffip09
+tcp4-multi-diffip10 tcp4-multi-diffip10
+tcp4-multi-diffip11 tcp4-multi-diffip11
+tcp4-multi-diffip12 tcp4-multi-diffip12
+tcp4-multi-diffip13 tcp4-multi-diffip13
+tcp4-multi-diffip14 tcp4-multi-diffip14
+
+tcp6-multi-diffip01 tcp6-multi-diffip01
+tcp6-multi-diffip02 tcp6-multi-diffip02
+tcp6-multi-diffip03 tcp6-multi-diffip03
+tcp6-multi-diffip04 tcp6-multi-diffip04
+tcp6-multi-diffip05 tcp6-multi-diffip05
+tcp6-multi-diffip06 tcp6-multi-diffip06
+tcp6-multi-diffip07 tcp6-multi-diffip07
+tcp6-multi-diffip08 tcp6-multi-diffip08
+tcp6-multi-diffip09 tcp6-multi-diffip09
+tcp6-multi-diffip10 tcp6-multi-diffip10
+tcp6-multi-diffip11 tcp6-multi-diffip11
+tcp6-multi-diffip12 tcp6-multi-diffip12
+tcp6-multi-diffip13 tcp6-multi-diffip13
+tcp6-multi-diffip14 tcp6-multi-diffip14
+
+tcp4-multi-diffnic01 tcp4-multi-diffnic01
+tcp4-multi-diffnic02 tcp4-multi-diffnic02
+tcp4-multi-diffnic03 tcp4-multi-diffnic03
+tcp4-multi-diffnic04 tcp4-multi-diffnic04
+tcp4-multi-diffnic05 tcp4-multi-diffnic05
+tcp4-multi-diffnic06 tcp4-multi-diffnic06
+tcp4-multi-diffnic07 tcp4-multi-diffnic07
+tcp4-multi-diffnic08 tcp4-multi-diffnic08
+tcp4-multi-diffnic09 tcp4-multi-diffnic09
+tcp4-multi-diffnic10 tcp4-multi-diffnic10
+tcp4-multi-diffnic11 tcp4-multi-diffnic11
+tcp4-multi-diffnic12 tcp4-multi-diffnic12
+tcp4-multi-diffnic13 tcp4-multi-diffnic13
+tcp4-multi-diffnic14 tcp4-multi-diffnic14
+
+tcp6-multi-diffnic01 tcp6-multi-diffnic01
+tcp6-multi-diffnic02 tcp6-multi-diffnic02
+tcp6-multi-diffnic03 tcp6-multi-diffnic03
+tcp6-multi-diffnic04 tcp6-multi-diffnic04
+tcp6-multi-diffnic05 tcp6-multi-diffnic05
+tcp6-multi-diffnic06 tcp6-multi-diffnic06
+tcp6-multi-diffnic07 tcp6-multi-diffnic07
+tcp6-multi-diffnic08 tcp6-multi-diffnic08
+tcp6-multi-diffnic09 tcp6-multi-diffnic09
+tcp6-multi-diffnic10 tcp6-multi-diffnic10
+tcp6-multi-diffnic11 tcp6-multi-diffnic11
+tcp6-multi-diffnic12 tcp6-multi-diffnic12
+tcp6-multi-diffnic13 tcp6-multi-diffnic13
+tcp6-multi-diffnic14 tcp6-multi-diffnic14
diff --git a/runtest/net_stress.ipsec_udp b/runtest/net_stress.ipsec_udp
new file mode 100644
index 0000000..bfe9d85
--- /dev/null
+++ b/runtest/net_stress.ipsec_udp
@@ -0,0 +1,67 @@
+#
+# Stress test for TCP/IP protocol stack (UDP)
+#
+
+udp4-uni-basic01 udp4-uni-basic01
+udp4-uni-basic02 udp4-uni-basic02
+udp4-uni-basic03 udp4-uni-basic03
+udp4-uni-basic04 udp4-uni-basic04
+udp4-uni-basic05 udp4-uni-basic05
+udp4-uni-basic06 udp4-uni-basic06
+udp4-uni-basic07 udp4-uni-basic07
+
+udp6-uni-basic01 udp6-uni-basic01
+udp6-uni-basic02 udp6-uni-basic02
+udp6-uni-basic03 udp6-uni-basic03
+udp6-uni-basic04 udp6-uni-basic04
+udp6-uni-basic05 udp6-uni-basic05
+udp6-uni-basic06 udp6-uni-basic06
+udp6-uni-basic07 udp6-uni-basic07
+
+udp4-multi-diffport01 udp4-multi-diffport01
+udp4-multi-diffport02 udp4-multi-diffport02
+udp4-multi-diffport03 udp4-multi-diffport03
+udp4-multi-diffport04 udp4-multi-diffport04
+udp4-multi-diffport05 udp4-multi-diffport05
+udp4-multi-diffport06 udp4-multi-diffport06
+udp4-multi-diffport07 udp4-multi-diffport07
+
+udp6-multi-diffport01 udp6-multi-diffport01
+udp6-multi-diffport02 udp6-multi-diffport02
+udp6-multi-diffport03 udp6-multi-diffport03
+udp6-multi-diffport04 udp6-multi-diffport04
+udp6-multi-diffport05 udp6-multi-diffport05
+udp6-multi-diffport06 udp6-multi-diffport06
+udp6-multi-diffport07 udp6-multi-diffport07
+
+udp4-multi-diffip01 udp4-multi-diffip01
+udp4-multi-diffip02 udp4-multi-diffip02
+udp4-multi-diffip03 udp4-multi-diffip03
+udp4-multi-diffip04 udp4-multi-diffip04
+udp4-multi-diffip05 udp4-multi-diffip05
+udp4-multi-diffip06 udp4-multi-diffip06
+udp4-multi-diffip07 udp4-multi-diffip07
+
+udp6-multi-diffip01 udp6-multi-diffip01
+udp6-multi-diffip02 udp6-multi-diffip02
+udp6-multi-diffip03 udp6-multi-diffip03
+udp6-multi-diffip04 udp6-multi-diffip04
+udp6-multi-diffip05 udp6-multi-diffip05
+udp6-multi-diffip06 udp6-multi-diffip06
+udp6-multi-diffip07 udp6-multi-diffip07
+
+udp4-multi-diffnic01 udp4-multi-diffnic01
+udp4-multi-diffnic02 udp4-multi-diffnic02
+udp4-multi-diffnic03 udp4-multi-diffnic03
+udp4-multi-diffnic04 udp4-multi-diffnic04
+udp4-multi-diffnic05 udp4-multi-diffnic05
+udp4-multi-diffnic06 udp4-multi-diffnic06
+udp4-multi-diffnic07 udp4-multi-diffnic07
+
+udp6-multi-diffnic01 udp6-multi-diffnic01
+udp6-multi-diffnic02 udp6-multi-diffnic02
+udp6-multi-diffnic03 udp6-multi-diffnic03
+udp6-multi-diffnic04 udp6-multi-diffnic04
+udp6-multi-diffnic05 udp6-multi-diffnic05
+udp6-multi-diffnic06 udp6-multi-diffnic06
+udp6-multi-diffnic07 udp6-multi-diffnic07
diff --git a/runtest/net_stress.multicast b/runtest/net_stress.multicast
new file mode 100644
index 0000000..445b08f
--- /dev/null
+++ b/runtest/net_stress.multicast
@@ -0,0 +1,29 @@
+#
+# Stress test for TCP/IP protocol stack (Multicast)
+#
+
+mcast4-grpope01 mcast4-grpope01
+mcast4-grpope02 mcast4-grpope02
+mcast4-grpope03 mcast4-grpope03
+mcast4-grpope04 mcast4-grpope04
+mcast4-pktfld01 mcast4-pktfld01
+mcast4-pktfld02 mcast4-pktfld02
+mcast4-queryfld01 mcast4-queryfld01
+mcast4-queryfld02 mcast4-queryfld02
+mcast4-queryfld03 mcast4-queryfld03
+mcast4-queryfld04 mcast4-queryfld04
+mcast4-queryfld05 mcast4-queryfld05
+mcast4-queryfld06 mcast4-queryfld06
+
+mcast6-grpope01 mcast6-grpope01
+mcast6-grpope02 mcast6-grpope02
+mcast6-grpope03 mcast6-grpope03
+mcast6-grpope04 mcast6-grpope04
+mcast6-pktfld01 mcast6-pktfld01
+mcast6-pktfld02 mcast6-pktfld02
+mcast6-queryfld01 mcast6-queryfld01
+mcast6-queryfld02 mcast6-queryfld02
+mcast6-queryfld03 mcast6-queryfld03
+mcast6-queryfld04 mcast6-queryfld04
+mcast6-queryfld05 mcast6-queryfld05
+mcast6-queryfld06 mcast6-queryfld06
diff --git a/runtest/net_stress.route b/runtest/net_stress.route
new file mode 100644
index 0000000..00ce52f
--- /dev/null
+++ b/runtest/net_stress.route
@@ -0,0 +1,17 @@
+#
+# Stress test for routing table
+#
+
+route4-change-dst route4-change-dst
+route4-change-gw route4-change-gw
+route4-change-if route4-change-if
+route4-redirect route4-redirect
+route4-ifdown route4-ifdown
+route4-rmmod route4-rmmod
+
+route6-change-dst route6-change-dst
+route6-change-gw route6-change-gw
+route6-change-if route6-change-if
+route6-redirect route6-redirect
+route6-ifdown route6-ifdown
+route6-rmmod route6-rmmod
diff --git a/runtest/network_stress.appl b/runtest/network_stress.appl
deleted file mode 100644
index c06af71..0000000
--- a/runtest/network_stress.appl
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Stress test for major application protocol (ssh, dns, http, ftp)
-#
-
-ssh4-stress ssh-stress
-ssh6-stress ssh-stress -6
-
-dns4-stress dns-stress
-dns6-stress dns-stress -6
-
-http4-stress http-stress
-http6-stress http-stress -6
-
-ftp4-download-stress ftp-download-stress
-ftp6-download-stress ftp-download-stress -6
-
-ftp4-upload-stress ftp-upload-stress
-ftp6-upload-stress ftp-upload-stress -6
diff --git a/runtest/network_stress.broken_ip b/runtest/network_stress.broken_ip
deleted file mode 100644
index c037f3e..0000000
--- a/runtest/network_stress.broken_ip
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Stress test for TCP/IP protocol stack
-#
-
-# Broken IP packet
-broken_ip4-version broken_ip4-version
-broken_ip4-ihl broken_ip4-ihl
-broken_ip4-totlen broken_ip4-totlen
-broken_ip4-fragment broken_ip4-fragment
-broken_ip4-protcol broken_ip4-protcol
-broken_ip4-checksum broken_ip4-checksum
-broken_ip4-dstaddr broken_ip4-dstaddr
-
-broken_ip6-dstaddr broken_ip6-dstaddr
-broken_ip6-nexthdr broken_ip6-nexthdr
-broken_ip6-plen broken_ip6-plen
-broken_ip6-version broken_ip6-version
diff --git a/runtest/network_stress.features b/runtest/network_stress.features
deleted file mode 100644
index bb907e5..0000000
--- a/runtest/network_stress.features
+++ /dev/null
@@ -1,36 +0,0 @@
-#
-# Stress tests for various network features
-#
-
-busy_poll01 busy_poll01.sh
-busy_poll01_ipv6 busy_poll01.sh -6
-
-busy_poll02 busy_poll02.sh
-busy_poll02_ipv6 busy_poll02.sh -6
-
-tcp_fastopen tcp_fastopen_run.sh
-tcp_fastopen6 tcp_fastopen_run.sh -6
-
-vxlan01 vxlan01.sh
-vxlan02 vxlan02.sh
-
-vxlan_multi_03 vxlan03.sh -d multi
-vxlan_uni_03 vxlan03.sh -d uni
-
-vxlan_ipv6_multi_03 vxlan03.sh -6 -d multi
-vxlan_ipv6_uni_03 vxlan03.sh -6 -d uni
-
-vlan01 vlan01.sh
-vlan02 vlan02.sh
-vlan03 vlan03.sh
-
-macvlan01 macvlan01.sh
-macvtap01 macvtap01.sh
-
-ipvlan01 ipvlan01.sh
-
-gre_ipv4_01 gre01.sh
-gre_ipv6_01 gre01.sh -6
-
-dctcp_ipv4_01 dctcp01.sh
-dctcp_ipv6_01 dctcp01.sh -6
diff --git a/runtest/network_stress.icmp b/runtest/network_stress.icmp
deleted file mode 100644
index 2b989b1..0000000
--- a/runtest/network_stress.icmp
+++ /dev/null
@@ -1,69 +0,0 @@
-#
-# Stress test for TCP/IP protocol stack (ICMP)
-#
-
-# MAX_LENGTH(65535) - IP(20) - ICMP(8) = MAX_SIZE(65507)
-icmp4-uni-basic01 icmp-uni-basic.sh -s "10 100 1000 10000 65507"
-# MAX_LENGTH(65535) - IP(20) - AH(24) - ICMP(8) = MAX_SIZE(65483)
-icmp4-uni-basic02 icmp-uni-basic.sh -p ah -m transport -s "10 100 1000 10000 65483"
-# MAX_LENGTH(65535) - IP(20) - AH(24) - Tunnel(IPv4 20) - ICMP(8) = MAX_SIZE(65463)
-icmp4-uni-basic03 icmp-uni-basic.sh -p ah -m tunnel -s "10 100 1000 10000 65463"
-# MAX_LENGTH(65535) - IP(20) - ESP (37) - ICMP(8) = MAX_SIZE(65470)
-# ESP Header has pad payload, so the ESP length is variable
-icmp4-uni-basic04 icmp-uni-basic.sh -p esp -m transport -s "10 100 1000 10000 65470"
-# MAX_LENGTH(65535) - IP(20) - ESP (37) - Tunnel(20) - ICMP(8) = MAX_SIZE(65450)
-icmp4-uni-basic05 icmp-uni-basic.sh -p esp -m tunnel -s "10 100 1000 10000 65450"
-# Same message size but different content will result in different data size
-# after compression. So we just use a large enough message size(65000) for testing
-icmp4-uni-basic06 icmp-uni-basic.sh -p ipcomp -m transport -s "10 100 1000 10000 65000"
-icmp4-uni-basic07 icmp-uni-basic.sh -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
-
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
-icmp6-uni-basic01 icmp-uni-basic.sh -6 -s "10 100 1000 10000 65527"
-# MAX_LENGTH(65535) - AH(24) - ICMP(8) = MAX_SIZE(65503)
-icmp6-uni-basic02 icmp-uni-basic.sh -6 -p ah -m transport -s "10 100 1000 10000 65503"
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
-# When receive, we drop the tunnel header first and only leave the inside IPv6
-# Header and icmp message. That's why we can have so large message size.
-icmp6-uni-basic03 icmp-uni-basic.sh -6 -p ah -m tunnel -s "10 100 1000 10000 65527"
-# MAX_LENGTH(65535) - ESP (33) - ICMP(8) = MAX_SIZE(65494)
-# ESP Header has pad payload, so the ESP length is variable
-icmp6-uni-basic04 icmp-uni-basic.sh -6 -p esp -m transport -s "10 100 1000 10000 65494"
-# MAX_LENGTH(65535) - ICMP(8) = MAX_SIZE(65527)
-icmp6-uni-basic05 icmp-uni-basic.sh -6 -p esp -m tunnel -s "10 100 1000 10000 65527"
-# Same message size but different content will result in different data size
-# after compression. So we just use a large enough message size(65000) for testing
-icmp6-uni-basic06 icmp-uni-basic.sh -6 -p ipcomp -m transport -s "10 100 1000 10000 65000"
-icmp6-uni-basic07 icmp-uni-basic.sh -6 -p ipcomp -m tunnel -s "10 100 1000 10000 65000"
-
-icmp4-multi-diffip01 icmp4-multi-diffip01
-icmp4-multi-diffip02 icmp4-multi-diffip02
-icmp4-multi-diffip03 icmp4-multi-diffip03
-icmp4-multi-diffip04 icmp4-multi-diffip04
-icmp4-multi-diffip05 icmp4-multi-diffip05
-icmp4-multi-diffip06 icmp4-multi-diffip06
-icmp4-multi-diffip07 icmp4-multi-diffip07
-
-icmp6-multi-diffip01 icmp6-multi-diffip01
-icmp6-multi-diffip02 icmp6-multi-diffip02
-icmp6-multi-diffip03 icmp6-multi-diffip03
-icmp6-multi-diffip04 icmp6-multi-diffip04
-icmp6-multi-diffip05 icmp6-multi-diffip05
-icmp6-multi-diffip06 icmp6-multi-diffip06
-icmp6-multi-diffip07 icmp6-multi-diffip07
-
-icmp4-multi-diffnic01 icmp4-multi-diffnic01
-icmp4-multi-diffnic02 icmp4-multi-diffnic02
-icmp4-multi-diffnic03 icmp4-multi-diffnic03
-icmp4-multi-diffnic04 icmp4-multi-diffnic04
-icmp4-multi-diffnic05 icmp4-multi-diffnic05
-icmp4-multi-diffnic06 icmp4-multi-diffnic06
-icmp4-multi-diffnic07 icmp4-multi-diffnic07
-
-icmp6-multi-diffnic01 icmp6-multi-diffnic01
-icmp6-multi-diffnic02 icmp6-multi-diffnic02
-icmp6-multi-diffnic03 icmp6-multi-diffnic03
-icmp6-multi-diffnic04 icmp6-multi-diffnic04
-icmp6-multi-diffnic05 icmp6-multi-diffnic05
-icmp6-multi-diffnic06 icmp6-multi-diffnic06
-icmp6-multi-diffnic07 icmp6-multi-diffnic07
diff --git a/runtest/network_stress.interface b/runtest/network_stress.interface
deleted file mode 100644
index 97e9ce3..0000000
--- a/runtest/network_stress.interface
+++ /dev/null
@@ -1,19 +0,0 @@
-#
-# Stress test for interface
-#
-
-if4-addr-change if4-addr-change
-
-if4-updown if-updown
-if4-addr-adddel if-addr-adddel
-if4-addr-addlarge if-addr-addlarge
-if4-route-adddel if-route-adddel
-if4-route-addlarge if-route-addlarge
-if4-mtu-change if-mtu-change
-
-if6-updown if-updown -6
-if6-addr-adddel if-addr-adddel -6
-if6-addr-addlarge if-addr-addlarge -6
-if6-route-adddel if-route-adddel -6
-if6-route-addlarge if-route-addlarge -6
-if6-mtu-change if-mtu-change -6
diff --git a/runtest/network_stress.multicast b/runtest/network_stress.multicast
deleted file mode 100644
index 445b08f..0000000
--- a/runtest/network_stress.multicast
+++ /dev/null
@@ -1,29 +0,0 @@
-#
-# Stress test for TCP/IP protocol stack (Multicast)
-#
-
-mcast4-grpope01 mcast4-grpope01
-mcast4-grpope02 mcast4-grpope02
-mcast4-grpope03 mcast4-grpope03
-mcast4-grpope04 mcast4-grpope04
-mcast4-pktfld01 mcast4-pktfld01
-mcast4-pktfld02 mcast4-pktfld02
-mcast4-queryfld01 mcast4-queryfld01
-mcast4-queryfld02 mcast4-queryfld02
-mcast4-queryfld03 mcast4-queryfld03
-mcast4-queryfld04 mcast4-queryfld04
-mcast4-queryfld05 mcast4-queryfld05
-mcast4-queryfld06 mcast4-queryfld06
-
-mcast6-grpope01 mcast6-grpope01
-mcast6-grpope02 mcast6-grpope02
-mcast6-grpope03 mcast6-grpope03
-mcast6-grpope04 mcast6-grpope04
-mcast6-pktfld01 mcast6-pktfld01
-mcast6-pktfld02 mcast6-pktfld02
-mcast6-queryfld01 mcast6-queryfld01
-mcast6-queryfld02 mcast6-queryfld02
-mcast6-queryfld03 mcast6-queryfld03
-mcast6-queryfld04 mcast6-queryfld04
-mcast6-queryfld05 mcast6-queryfld05
-mcast6-queryfld06 mcast6-queryfld06
diff --git a/runtest/network_stress.route b/runtest/network_stress.route
deleted file mode 100644
index 00ce52f..0000000
--- a/runtest/network_stress.route
+++ /dev/null
@@ -1,17 +0,0 @@
-#
-# Stress test for routing table
-#
-
-route4-change-dst route4-change-dst
-route4-change-gw route4-change-gw
-route4-change-if route4-change-if
-route4-redirect route4-redirect
-route4-ifdown route4-ifdown
-route4-rmmod route4-rmmod
-
-route6-change-dst route6-change-dst
-route6-change-gw route6-change-gw
-route6-change-if route6-change-if
-route6-redirect route6-redirect
-route6-ifdown route6-ifdown
-route6-rmmod route6-rmmod
diff --git a/runtest/network_stress.tcp b/runtest/network_stress.tcp
deleted file mode 100644
index 7206b3a..0000000
--- a/runtest/network_stress.tcp
+++ /dev/null
@@ -1,333 +0,0 @@
-#
-# Stress test for TCP/IP protocol stack (TCP)
-#
-
-tcp4-uni-basic01 tcp4-uni-basic01
-tcp4-uni-basic02 tcp4-uni-basic02
-tcp4-uni-basic03 tcp4-uni-basic03
-tcp4-uni-basic04 tcp4-uni-basic04
-tcp4-uni-basic05 tcp4-uni-basic05
-tcp4-uni-basic06 tcp4-uni-basic06
-tcp4-uni-basic07 tcp4-uni-basic07
-tcp4-uni-basic08 tcp4-uni-basic08
-tcp4-uni-basic09 tcp4-uni-basic09
-tcp4-uni-basic10 tcp4-uni-basic10
-tcp4-uni-basic11 tcp4-uni-basic11
-tcp4-uni-basic12 tcp4-uni-basic12
-tcp4-uni-basic13 tcp4-uni-basic13
-tcp4-uni-basic14 tcp4-uni-basic14
-
-tcp6-uni-basic01 tcp6-uni-basic01
-tcp6-uni-basic02 tcp6-uni-basic02
-tcp6-uni-basic03 tcp6-uni-basic03
-tcp6-uni-basic04 tcp6-uni-basic04
-tcp6-uni-basic05 tcp6-uni-basic05
-tcp6-uni-basic06 tcp6-uni-basic06
-tcp6-uni-basic07 tcp6-uni-basic07
-tcp6-uni-basic08 tcp6-uni-basic08
-tcp6-uni-basic09 tcp6-uni-basic09
-tcp6-uni-basic10 tcp6-uni-basic10
-tcp6-uni-basic11 tcp6-uni-basic11
-tcp6-uni-basic12 tcp6-uni-basic12
-tcp6-uni-basic13 tcp6-uni-basic13
-tcp6-uni-basic14 tcp6-uni-basic14
-
-tcp4-uni-smallsend01 tcp4-uni-smallsend01
-tcp4-uni-smallsend02 tcp4-uni-smallsend02
-tcp4-uni-smallsend03 tcp4-uni-smallsend03
-tcp4-uni-smallsend04 tcp4-uni-smallsend04
-tcp4-uni-smallsend05 tcp4-uni-smallsend05
-tcp4-uni-smallsend06 tcp4-uni-smallsend06
-tcp4-uni-smallsend07 tcp4-uni-smallsend07
-tcp4-uni-smallsend08 tcp4-uni-smallsend08
-tcp4-uni-smallsend09 tcp4-uni-smallsend09
-tcp4-uni-smallsend10 tcp4-uni-smallsend10
-tcp4-uni-smallsend11 tcp4-uni-smallsend11
-tcp4-uni-smallsend12 tcp4-uni-smallsend12
-tcp4-uni-smallsend13 tcp4-uni-smallsend13
-tcp4-uni-smallsend14 tcp4-uni-smallsend14
-
-tcp6-uni-smallsend01 tcp6-uni-smallsend01
-tcp6-uni-smallsend02 tcp6-uni-smallsend02
-tcp6-uni-smallsend03 tcp6-uni-smallsend03
-tcp6-uni-smallsend04 tcp6-uni-smallsend04
-tcp6-uni-smallsend05 tcp6-uni-smallsend05
-tcp6-uni-smallsend06 tcp6-uni-smallsend06
-tcp6-uni-smallsend07 tcp6-uni-smallsend07
-tcp6-uni-smallsend08 tcp6-uni-smallsend08
-tcp6-uni-smallsend09 tcp6-uni-smallsend09
-tcp6-uni-smallsend10 tcp6-uni-smallsend10
-tcp6-uni-smallsend11 tcp6-uni-smallsend11
-tcp6-uni-smallsend12 tcp6-uni-smallsend12
-tcp6-uni-smallsend13 tcp6-uni-smallsend13
-tcp6-uni-smallsend14 tcp6-uni-smallsend14
-
-tcp4-uni-winscale01 tcp4-uni-winscale01
-tcp4-uni-winscale02 tcp4-uni-winscale02
-tcp4-uni-winscale03 tcp4-uni-winscale03
-tcp4-uni-winscale04 tcp4-uni-winscale04
-tcp4-uni-winscale05 tcp4-uni-winscale05
-tcp4-uni-winscale06 tcp4-uni-winscale06
-tcp4-uni-winscale07 tcp4-uni-winscale07
-tcp4-uni-winscale08 tcp4-uni-winscale08
-tcp4-uni-winscale09 tcp4-uni-winscale09
-tcp4-uni-winscale10 tcp4-uni-winscale10
-tcp4-uni-winscale11 tcp4-uni-winscale11
-tcp4-uni-winscale12 tcp4-uni-winscale12
-tcp4-uni-winscale13 tcp4-uni-winscale13
-tcp4-uni-winscale14 tcp4-uni-winscale14
-
-tcp6-uni-winscale01 tcp6-uni-winscale01
-tcp6-uni-winscale02 tcp6-uni-winscale02
-tcp6-uni-winscale03 tcp6-uni-winscale03
-tcp6-uni-winscale04 tcp6-uni-winscale04
-tcp6-uni-winscale05 tcp6-uni-winscale05
-tcp6-uni-winscale06 tcp6-uni-winscale06
-tcp6-uni-winscale07 tcp6-uni-winscale07
-tcp6-uni-winscale08 tcp6-uni-winscale08
-tcp6-uni-winscale09 tcp6-uni-winscale09
-tcp6-uni-winscale10 tcp6-uni-winscale10
-tcp6-uni-winscale11 tcp6-uni-winscale11
-tcp6-uni-winscale12 tcp6-uni-winscale12
-tcp6-uni-winscale13 tcp6-uni-winscale13
-tcp6-uni-winscale14 tcp6-uni-winscale14
-
-tcp4-uni-tso01 tcp4-uni-tso01
-tcp4-uni-tso02 tcp4-uni-tso02
-tcp4-uni-tso03 tcp4-uni-tso03
-tcp4-uni-tso04 tcp4-uni-tso04
-tcp4-uni-tso05 tcp4-uni-tso05
-tcp4-uni-tso06 tcp4-uni-tso06
-tcp4-uni-tso07 tcp4-uni-tso07
-tcp4-uni-tso08 tcp4-uni-tso08
-tcp4-uni-tso09 tcp4-uni-tso09
-tcp4-uni-tso10 tcp4-uni-tso10
-tcp4-uni-tso11 tcp4-uni-tso11
-tcp4-uni-tso12 tcp4-uni-tso12
-tcp4-uni-tso13 tcp4-uni-tso13
-tcp4-uni-tso14 tcp4-uni-tso14
-
-tcp6-uni-tso01 tcp6-uni-tso01
-tcp6-uni-tso02 tcp6-uni-tso02
-tcp6-uni-tso03 tcp6-uni-tso03
-tcp6-uni-tso04 tcp6-uni-tso04
-tcp6-uni-tso05 tcp6-uni-tso05
-tcp6-uni-tso06 tcp6-uni-tso06
-tcp6-uni-tso07 tcp6-uni-tso07
-tcp6-uni-tso08 tcp6-uni-tso08
-tcp6-uni-tso09 tcp6-uni-tso09
-tcp6-uni-tso10 tcp6-uni-tso10
-tcp6-uni-tso11 tcp6-uni-tso11
-tcp6-uni-tso12 tcp6-uni-tso12
-tcp6-uni-tso13 tcp6-uni-tso13
-tcp6-uni-tso14 tcp6-uni-tso14
-
-tcp4-uni-pktlossdup01 tcp4-uni-pktlossdup01
-tcp4-uni-pktlossdup02 tcp4-uni-pktlossdup02
-tcp4-uni-pktlossdup03 tcp4-uni-pktlossdup03
-tcp4-uni-pktlossdup04 tcp4-uni-pktlossdup04
-tcp4-uni-pktlossdup05 tcp4-uni-pktlossdup05
-tcp4-uni-pktlossdup06 tcp4-uni-pktlossdup06
-tcp4-uni-pktlossdup07 tcp4-uni-pktlossdup07
-tcp4-uni-pktlossdup08 tcp4-uni-pktlossdup08
-tcp4-uni-pktlossdup09 tcp4-uni-pktlossdup09
-tcp4-uni-pktlossdup10 tcp4-uni-pktlossdup10
-tcp4-uni-pktlossdup11 tcp4-uni-pktlossdup11
-tcp4-uni-pktlossdup12 tcp4-uni-pktlossdup12
-tcp4-uni-pktlossdup13 tcp4-uni-pktlossdup13
-tcp4-uni-pktlossdup14 tcp4-uni-pktlossdup14
-
-tcp6-uni-pktlossdup01 tcp6-uni-pktlossdup01
-tcp6-uni-pktlossdup02 tcp6-uni-pktlossdup02
-tcp6-uni-pktlossdup03 tcp6-uni-pktlossdup03
-tcp6-uni-pktlossdup04 tcp6-uni-pktlossdup04
-tcp6-uni-pktlossdup05 tcp6-uni-pktlossdup05
-tcp6-uni-pktlossdup06 tcp6-uni-pktlossdup06
-tcp6-uni-pktlossdup07 tcp6-uni-pktlossdup07
-tcp6-uni-pktlossdup08 tcp6-uni-pktlossdup08
-tcp6-uni-pktlossdup09 tcp6-uni-pktlossdup09
-tcp6-uni-pktlossdup10 tcp6-uni-pktlossdup10
-tcp6-uni-pktlossdup11 tcp6-uni-pktlossdup11
-tcp6-uni-pktlossdup12 tcp6-uni-pktlossdup12
-tcp6-uni-pktlossdup13 tcp6-uni-pktlossdup13
-tcp6-uni-pktlossdup14 tcp6-uni-pktlossdup14
-
-tcp4-uni-dsackoff01 tcp4-uni-dsackoff01
-tcp4-uni-dsackoff02 tcp4-uni-dsackoff02
-tcp4-uni-dsackoff03 tcp4-uni-dsackoff03
-tcp4-uni-dsackoff04 tcp4-uni-dsackoff04
-tcp4-uni-dsackoff05 tcp4-uni-dsackoff05
-tcp4-uni-dsackoff06 tcp4-uni-dsackoff06
-tcp4-uni-dsackoff07 tcp4-uni-dsackoff07
-tcp4-uni-dsackoff08 tcp4-uni-dsackoff08
-tcp4-uni-dsackoff09 tcp4-uni-dsackoff09
-tcp4-uni-dsackoff10 tcp4-uni-dsackoff10
-tcp4-uni-dsackoff11 tcp4-uni-dsackoff11
-tcp4-uni-dsackoff12 tcp4-uni-dsackoff12
-tcp4-uni-dsackoff13 tcp4-uni-dsackoff13
-tcp4-uni-dsackoff14 tcp4-uni-dsackoff14
-
-tcp6-uni-dsackoff01 tcp6-uni-dsackoff01
-tcp6-uni-dsackoff02 tcp6-uni-dsackoff02
-tcp6-uni-dsackoff03 tcp6-uni-dsackoff03
-tcp6-uni-dsackoff04 tcp6-uni-dsackoff04
-tcp6-uni-dsackoff05 tcp6-uni-dsackoff05
-tcp6-uni-dsackoff06 tcp6-uni-dsackoff06
-tcp6-uni-dsackoff07 tcp6-uni-dsackoff07
-tcp6-uni-dsackoff08 tcp6-uni-dsackoff08
-tcp6-uni-dsackoff09 tcp6-uni-dsackoff09
-tcp6-uni-dsackoff10 tcp6-uni-dsackoff10
-tcp6-uni-dsackoff11 tcp6-uni-dsackoff11
-tcp6-uni-dsackoff12 tcp6-uni-dsackoff12
-tcp6-uni-dsackoff13 tcp6-uni-dsackoff13
-tcp6-uni-dsackoff14 tcp6-uni-dsackoff14
-
-tcp4-uni-sackoff01 tcp4-uni-sackoff01
-tcp4-uni-sackoff02 tcp4-uni-sackoff02
-tcp4-uni-sackoff03 tcp4-uni-sackoff03
-tcp4-uni-sackoff04 tcp4-uni-sackoff04
-tcp4-uni-sackoff05 tcp4-uni-sackoff05
-tcp4-uni-sackoff06 tcp4-uni-sackoff06
-tcp4-uni-sackoff07 tcp4-uni-sackoff07
-tcp4-uni-sackoff08 tcp4-uni-sackoff08
-tcp4-uni-sackoff09 tcp4-uni-sackoff09
-tcp4-uni-sackoff10 tcp4-uni-sackoff10
-tcp4-uni-sackoff11 tcp4-uni-sackoff11
-tcp4-uni-sackoff12 tcp4-uni-sackoff12
-tcp4-uni-sackoff13 tcp4-uni-sackoff13
-tcp4-uni-sackoff14 tcp4-uni-sackoff14
-
-tcp6-uni-sackoff01 tcp6-uni-sackoff01
-tcp6-uni-sackoff02 tcp6-uni-sackoff02
-tcp6-uni-sackoff03 tcp6-uni-sackoff03
-tcp6-uni-sackoff04 tcp6-uni-sackoff04
-tcp6-uni-sackoff05 tcp6-uni-sackoff05
-tcp6-uni-sackoff06 tcp6-uni-sackoff06
-tcp6-uni-sackoff07 tcp6-uni-sackoff07
-tcp6-uni-sackoff08 tcp6-uni-sackoff08
-tcp6-uni-sackoff09 tcp6-uni-sackoff09
-tcp6-uni-sackoff10 tcp6-uni-sackoff10
-tcp6-uni-sackoff11 tcp6-uni-sackoff11
-tcp6-uni-sackoff12 tcp6-uni-sackoff12
-tcp6-uni-sackoff13 tcp6-uni-sackoff13
-tcp6-uni-sackoff14 tcp6-uni-sackoff14
-
-tcp4-multi-sameport01 tcp4-multi-sameport01
-tcp4-multi-sameport02 tcp4-multi-sameport02
-tcp4-multi-sameport03 tcp4-multi-sameport03
-tcp4-multi-sameport04 tcp4-multi-sameport04
-tcp4-multi-sameport05 tcp4-multi-sameport05
-tcp4-multi-sameport06 tcp4-multi-sameport06
-tcp4-multi-sameport07 tcp4-multi-sameport07
-tcp4-multi-sameport08 tcp4-multi-sameport08
-tcp4-multi-sameport09 tcp4-multi-sameport09
-tcp4-multi-sameport10 tcp4-multi-sameport10
-tcp4-multi-sameport11 tcp4-multi-sameport11
-tcp4-multi-sameport12 tcp4-multi-sameport12
-tcp4-multi-sameport13 tcp4-multi-sameport13
-tcp4-multi-sameport14 tcp4-multi-sameport14
-
-tcp6-multi-sameport01 tcp6-multi-sameport01
-tcp6-multi-sameport02 tcp6-multi-sameport02
-tcp6-multi-sameport03 tcp6-multi-sameport03
-tcp6-multi-sameport04 tcp6-multi-sameport04
-tcp6-multi-sameport05 tcp6-multi-sameport05
-tcp6-multi-sameport06 tcp6-multi-sameport06
-tcp6-multi-sameport07 tcp6-multi-sameport07
-tcp6-multi-sameport08 tcp6-multi-sameport08
-tcp6-multi-sameport09 tcp6-multi-sameport09
-tcp6-multi-sameport10 tcp6-multi-sameport10
-tcp6-multi-sameport11 tcp6-multi-sameport11
-tcp6-multi-sameport12 tcp6-multi-sameport12
-tcp6-multi-sameport13 tcp6-multi-sameport13
-tcp6-multi-sameport14 tcp6-multi-sameport14
-
-tcp4-multi-diffport01 tcp4-multi-diffport01
-tcp4-multi-diffport02 tcp4-multi-diffport02
-tcp4-multi-diffport03 tcp4-multi-diffport03
-tcp4-multi-diffport04 tcp4-multi-diffport04
-tcp4-multi-diffport05 tcp4-multi-diffport05
-tcp4-multi-diffport06 tcp4-multi-diffport06
-tcp4-multi-diffport07 tcp4-multi-diffport07
-tcp4-multi-diffport08 tcp4-multi-diffport08
-tcp4-multi-diffport09 tcp4-multi-diffport09
-tcp4-multi-diffport10 tcp4-multi-diffport10
-tcp4-multi-diffport11 tcp4-multi-diffport11
-tcp4-multi-diffport12 tcp4-multi-diffport12
-tcp4-multi-diffport13 tcp4-multi-diffport13
-tcp4-multi-diffport14 tcp4-multi-diffport14
-
-tcp6-multi-diffport01 tcp6-multi-diffport01
-tcp6-multi-diffport02 tcp6-multi-diffport02
-tcp6-multi-diffport03 tcp6-multi-diffport03
-tcp6-multi-diffport04 tcp6-multi-diffport04
-tcp6-multi-diffport05 tcp6-multi-diffport05
-tcp6-multi-diffport06 tcp6-multi-diffport06
-tcp6-multi-diffport07 tcp6-multi-diffport07
-tcp6-multi-diffport08 tcp6-multi-diffport08
-tcp6-multi-diffport09 tcp6-multi-diffport09
-tcp6-multi-diffport10 tcp6-multi-diffport10
-tcp6-multi-diffport11 tcp6-multi-diffport11
-tcp6-multi-diffport12 tcp6-multi-diffport12
-tcp6-multi-diffport13 tcp6-multi-diffport13
-tcp6-multi-diffport14 tcp6-multi-diffport14
-
-tcp4-multi-diffip01 tcp4-multi-diffip01
-tcp4-multi-diffip02 tcp4-multi-diffip02
-tcp4-multi-diffip03 tcp4-multi-diffip03
-tcp4-multi-diffip04 tcp4-multi-diffip04
-tcp4-multi-diffip05 tcp4-multi-diffip05
-tcp4-multi-diffip06 tcp4-multi-diffip06
-tcp4-multi-diffip07 tcp4-multi-diffip07
-tcp4-multi-diffip08 tcp4-multi-diffip08
-tcp4-multi-diffip09 tcp4-multi-diffip09
-tcp4-multi-diffip10 tcp4-multi-diffip10
-tcp4-multi-diffip11 tcp4-multi-diffip11
-tcp4-multi-diffip12 tcp4-multi-diffip12
-tcp4-multi-diffip13 tcp4-multi-diffip13
-tcp4-multi-diffip14 tcp4-multi-diffip14
-
-tcp6-multi-diffip01 tcp6-multi-diffip01
-tcp6-multi-diffip02 tcp6-multi-diffip02
-tcp6-multi-diffip03 tcp6-multi-diffip03
-tcp6-multi-diffip04 tcp6-multi-diffip04
-tcp6-multi-diffip05 tcp6-multi-diffip05
-tcp6-multi-diffip06 tcp6-multi-diffip06
-tcp6-multi-diffip07 tcp6-multi-diffip07
-tcp6-multi-diffip08 tcp6-multi-diffip08
-tcp6-multi-diffip09 tcp6-multi-diffip09
-tcp6-multi-diffip10 tcp6-multi-diffip10
-tcp6-multi-diffip11 tcp6-multi-diffip11
-tcp6-multi-diffip12 tcp6-multi-diffip12
-tcp6-multi-diffip13 tcp6-multi-diffip13
-tcp6-multi-diffip14 tcp6-multi-diffip14
-
-tcp4-multi-diffnic01 tcp4-multi-diffnic01
-tcp4-multi-diffnic02 tcp4-multi-diffnic02
-tcp4-multi-diffnic03 tcp4-multi-diffnic03
-tcp4-multi-diffnic04 tcp4-multi-diffnic04
-tcp4-multi-diffnic05 tcp4-multi-diffnic05
-tcp4-multi-diffnic06 tcp4-multi-diffnic06
-tcp4-multi-diffnic07 tcp4-multi-diffnic07
-tcp4-multi-diffnic08 tcp4-multi-diffnic08
-tcp4-multi-diffnic09 tcp4-multi-diffnic09
-tcp4-multi-diffnic10 tcp4-multi-diffnic10
-tcp4-multi-diffnic11 tcp4-multi-diffnic11
-tcp4-multi-diffnic12 tcp4-multi-diffnic12
-tcp4-multi-diffnic13 tcp4-multi-diffnic13
-tcp4-multi-diffnic14 tcp4-multi-diffnic14
-
-tcp6-multi-diffnic01 tcp6-multi-diffnic01
-tcp6-multi-diffnic02 tcp6-multi-diffnic02
-tcp6-multi-diffnic03 tcp6-multi-diffnic03
-tcp6-multi-diffnic04 tcp6-multi-diffnic04
-tcp6-multi-diffnic05 tcp6-multi-diffnic05
-tcp6-multi-diffnic06 tcp6-multi-diffnic06
-tcp6-multi-diffnic07 tcp6-multi-diffnic07
-tcp6-multi-diffnic08 tcp6-multi-diffnic08
-tcp6-multi-diffnic09 tcp6-multi-diffnic09
-tcp6-multi-diffnic10 tcp6-multi-diffnic10
-tcp6-multi-diffnic11 tcp6-multi-diffnic11
-tcp6-multi-diffnic12 tcp6-multi-diffnic12
-tcp6-multi-diffnic13 tcp6-multi-diffnic13
-tcp6-multi-diffnic14 tcp6-multi-diffnic14
diff --git a/runtest/network_stress.udp b/runtest/network_stress.udp
deleted file mode 100644
index bfe9d85..0000000
--- a/runtest/network_stress.udp
+++ /dev/null
@@ -1,67 +0,0 @@
-#
-# Stress test for TCP/IP protocol stack (UDP)
-#
-
-udp4-uni-basic01 udp4-uni-basic01
-udp4-uni-basic02 udp4-uni-basic02
-udp4-uni-basic03 udp4-uni-basic03
-udp4-uni-basic04 udp4-uni-basic04
-udp4-uni-basic05 udp4-uni-basic05
-udp4-uni-basic06 udp4-uni-basic06
-udp4-uni-basic07 udp4-uni-basic07
-
-udp6-uni-basic01 udp6-uni-basic01
-udp6-uni-basic02 udp6-uni-basic02
-udp6-uni-basic03 udp6-uni-basic03
-udp6-uni-basic04 udp6-uni-basic04
-udp6-uni-basic05 udp6-uni-basic05
-udp6-uni-basic06 udp6-uni-basic06
-udp6-uni-basic07 udp6-uni-basic07
-
-udp4-multi-diffport01 udp4-multi-diffport01
-udp4-multi-diffport02 udp4-multi-diffport02
-udp4-multi-diffport03 udp4-multi-diffport03
-udp4-multi-diffport04 udp4-multi-diffport04
-udp4-multi-diffport05 udp4-multi-diffport05
-udp4-multi-diffport06 udp4-multi-diffport06
-udp4-multi-diffport07 udp4-multi-diffport07
-
-udp6-multi-diffport01 udp6-multi-diffport01
-udp6-multi-diffport02 udp6-multi-diffport02
-udp6-multi-diffport03 udp6-multi-diffport03
-udp6-multi-diffport04 udp6-multi-diffport04
-udp6-multi-diffport05 udp6-multi-diffport05
-udp6-multi-diffport06 udp6-multi-diffport06
-udp6-multi-diffport07 udp6-multi-diffport07
-
-udp4-multi-diffip01 udp4-multi-diffip01
-udp4-multi-diffip02 udp4-multi-diffip02
-udp4-multi-diffip03 udp4-multi-diffip03
-udp4-multi-diffip04 udp4-multi-diffip04
-udp4-multi-diffip05 udp4-multi-diffip05
-udp4-multi-diffip06 udp4-multi-diffip06
-udp4-multi-diffip07 udp4-multi-diffip07
-
-udp6-multi-diffip01 udp6-multi-diffip01
-udp6-multi-diffip02 udp6-multi-diffip02
-udp6-multi-diffip03 udp6-multi-diffip03
-udp6-multi-diffip04 udp6-multi-diffip04
-udp6-multi-diffip05 udp6-multi-diffip05
-udp6-multi-diffip06 udp6-multi-diffip06
-udp6-multi-diffip07 udp6-multi-diffip07
-
-udp4-multi-diffnic01 udp4-multi-diffnic01
-udp4-multi-diffnic02 udp4-multi-diffnic02
-udp4-multi-diffnic03 udp4-multi-diffnic03
-udp4-multi-diffnic04 udp4-multi-diffnic04
-udp4-multi-diffnic05 udp4-multi-diffnic05
-udp4-multi-diffnic06 udp4-multi-diffnic06
-udp4-multi-diffnic07 udp4-multi-diffnic07
-
-udp6-multi-diffnic01 udp6-multi-diffnic01
-udp6-multi-diffnic02 udp6-multi-diffnic02
-udp6-multi-diffnic03 udp6-multi-diffnic03
-udp6-multi-diffnic04 udp6-multi-diffnic04
-udp6-multi-diffnic05 udp6-multi-diffnic05
-udp6-multi-diffnic06 udp6-multi-diffnic06
-udp6-multi-diffnic07 udp6-multi-diffnic07
diff --git a/runtest/nfs b/runtest/nfs
deleted file mode 100644
index 43cf504..0000000
--- a/runtest/nfs
+++ /dev/null
@@ -1,33 +0,0 @@
-#DESCRIPTION:Network filesystem stress
-#
-# PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
-#
-nfs3_01 export VERSION=3 SOCKET_TYPE=udp; nfs01
-nfs4_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01
-nfs3_ipv6_01 export VERSION=3 SOCKET_TYPE=udp; nfs01 -6
-nfs4_ipv6_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01 -6
-
-nfs3_02 export VERSION=3 SOCKET_TYPE=udp; nfs02
-nfs4_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02
-nfs3_ipv6_02 export VERSION=3 SOCKET_TYPE=udp; nfs02 -6
-nfs4_ipv6_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02 -6
-
-nfs3_03 export VERSION=3 SOCKET_TYPE=udp; nfs03
-nfs4_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03
-nfs3_ipv6_03 export VERSION=3 SOCKET_TYPE=udp; nfs03 -6
-nfs4_ipv6_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03 -6
-
-nfs3_04 export VERSION=3 SOCKET_TYPE=udp; nfs04
-nfs4_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04
-nfs3_ipv6_04 export VERSION=3 SOCKET_TYPE=udp; nfs04 -6
-nfs4_ipv6_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04 -6
-
-nfs3_05 export VERSION=3 SOCKET_TYPE=udp; nfs05
-nfs4_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05
-nfs3_ipv6_05 export VERSION=3 SOCKET_TYPE=udp; nfs05 -6
-nfs4_ipv6_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05 -6
-
-nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
-
-nfsstat01 export VERSION; TCbin=$LTPROOT/testcases/bin nfsstat01
-nfsx-linux export VERSION SOCKET_TYPE; TCbin=$LTPROOT/testcases/bin fsx.sh
diff --git a/runtest/rpc b/runtest/rpc
deleted file mode 100644
index b65268c..0000000
--- a/runtest/rpc
+++ /dev/null
@@ -1,8 +0,0 @@
-#DESCRIPTION:Remote Procedure Call
-#
-# PLEASE READ THE README FILE IN /rpc BEFORE RUNNING THESE.
-#
-rpc01 rpc01
-rpcinfo rpcinfo01
-rup rup01
-rusers rusers01
diff --git a/runtest/sctp b/runtest/sctp
deleted file mode 100644
index 71cc0d1..0000000
--- a/runtest/sctp
+++ /dev/null
@@ -1,43 +0,0 @@
-#DESCRIPTION:Stream Control Transmission Protocol (SCTP) Tests
-#
-test_1_to_1_accept_close test_1_to_1_accept_close
-test_1_to_1_addrs test_1_to_1_addrs
-test_1_to_1_connect test_1_to_1_connect
-test_1_to_1_connectx test_1_to_1_connectx
-test_1_to_1_events test_1_to_1_events
-test_1_to_1_initmsg_connect test_1_to_1_initmsg_connect
-test_1_to_1_nonblock test_1_to_1_nonblock
-test_1_to_1_recvfrom test_1_to_1_recvfrom
-test_1_to_1_recvmsg test_1_to_1_recvmsg
-test_1_to_1_rtoinfo test_1_to_1_rtoinfo
-test_1_to_1_send test_1_to_1_send
-test_1_to_1_sendmsg test_1_to_1_sendmsg
-test_1_to_1_sendto test_1_to_1_sendto
-test_1_to_1_shutdown test_1_to_1_shutdown
-test_1_to_1_socket_bind_listen test_1_to_1_socket_bind_listen
-test_1_to_1_sockopt test_1_to_1_sockopt
-test_1_to_1_threads test_1_to_1_threads
-test_assoc_abort test_assoc_abort
-test_assoc_shutdown test_assoc_shutdown
-test_autoclose test_autoclose
-test_basic test_basic
-test_basic_v6 test_basic_v6
-test_connect test_connect
-test_connectx test_connectx
-test_fragments test_fragments
-test_fragments_v6 test_fragments_v6
-test_getname test_getname
-test_getname_v6 test_getname_v6
-test_inaddr_any test_inaddr_any
-test_inaddr_any_v6 test_inaddr_any_v6
-test_peeloff test_peeloff
-test_peeloff_v6 test_peeloff_v6
-test_recvmsg test_recvmsg
-test_sctp_sendrecvmsg test_sctp_sendrecvmsg
-test_sctp_sendrecvmsg_v6 test_sctp_sendrecvmsg_v6
-test_sockopt test_sockopt
-test_sockopt_v6 test_sockopt_v6
-test_tcp_style test_tcp_style
-test_tcp_style_v6 test_tcp_style_v6
-test_timetolive test_timetolive
-test_timetolive_v6 test_timetolive_v6
diff --git a/runtest/tcp_cmds b/runtest/tcp_cmds
deleted file mode 100644
index 466718b..0000000
--- a/runtest/tcp_cmds
+++ /dev/null
@@ -1,26 +0,0 @@
-#DESCRIPTION:TCP/IP commands tests
-#
-# PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
-#
-arp arp01
-echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
-finger finger01
-ftp export TCbin=$LTPROOT/testcases/network/tcp_cmds/ftp; ftp01
-host host01
-netstat netstat01
-perf_lan export TCbin=$LTPROOT/testcases/network/tcp_cmds/perf_lan; perf_lan
-ping export LTPROOT; ping01
-rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rdist export TCbin=$LTPROOT/testcases/network/tcp_cmds/rdist; rdist01
-rlogin rlogin01
-rsh rsh01
-rwho rwho01
-sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
-tcpdump tcpdump01
-telnet telnet01
-iptables iptables_tests.sh
-dhcpd dhcpd_tests.sh
-dnsmasq dnsmasq_tests.sh
-iproute ip_tests.sh
-traceroute traceroute_tests.sh
-xinetd xinetd_tests.sh
diff --git a/scenario_groups/default b/scenario_groups/default
index 5d1c521..0b625bb 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -31,5 +31,5 @@ pipes
 dma_thread_diotest
 can
 cpuhotplug
-ipv6_lib
+net.ipv6_lib
 input
diff --git a/scenario_groups/network b/scenario_groups/network
index 72a4e16..bf857b0 100644
--- a/scenario_groups/network
+++ b/scenario_groups/network
@@ -1,4 +1,4 @@
-tcp_cmds
-multicast
-rpc
-nfs
+net.tcp_cmds
+net.multicast
+net.rpc
+net.nfs
diff --git a/testscripts/network.sh b/testscripts/network.sh
index f7f4f93..826507b 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -107,21 +107,21 @@ TEST_CASES=
 while getopts 6mnrstaebiTURMFf:Vv OPTION
 do
 	case $OPTION in
-	6) TEST_CASES="$TEST_CASES ipv6 ipv6_lib";;
-	m) TEST_CASES="$TEST_CASES multicast" ;;
-	n) TEST_CASES="$TEST_CASES nfs" ;;
-	r) TEST_CASES="$TEST_CASES rpc" ;;
-	s) TEST_CASES="$TEST_CASES sctp" ;;
-	t) TEST_CASES="$TEST_CASES tcp_cmds" ;;
-	a) TEST_CASES="$TEST_CASES network_stress.appl";;
-	e) TEST_CASES="$TEST_CASES network_stress.interface";;
-	b) TEST_CASES="$TEST_CASES network_stress.broken_ip";;
-	i) TEST_CASES="$TEST_CASES network_stress.icmp";;
-	T) TEST_CASES="$TEST_CASES network_stress.tcp";;
-	U) TEST_CASES="$TEST_CASES network_stress.udp";;
-	R) TEST_CASES="$TEST_CASES network_stress.route";;
-	M) TEST_CASES="$TEST_CASES network_stress.multicast";;
-	F) TEST_CASES="$TEST_CASES network_stress.features";;
+	6) TEST_CASES="$TEST_CASES net.ipv6 net.ipv6_lib";;
+	m) TEST_CASES="$TEST_CASES net.multicast" ;;
+	n) TEST_CASES="$TEST_CASES net.nfs" ;;
+	r) TEST_CASES="$TEST_CASES net.rpc" ;;
+	s) TEST_CASES="$TEST_CASES net.sctp" ;;
+	t) TEST_CASES="$TEST_CASES net.tcp_cmds" ;;
+	a) TEST_CASES="$TEST_CASES net_stress.appl";;
+	e) TEST_CASES="$TEST_CASES net_stress.interface";;
+	b) TEST_CASES="$TEST_CASES net_stress.broken_ip";;
+	i) TEST_CASES="$TEST_CASES net_stress.ipsec_icmp";;
+	T) TEST_CASES="$TEST_CASES net_stress.ipsec_tcp";;
+	U) TEST_CASES="$TEST_CASES net_stress.ipsec_udp";;
+	R) TEST_CASES="$TEST_CASES net_stress.route";;
+	M) TEST_CASES="$TEST_CASES net_stress.multicast";;
+	F) TEST_CASES="$TEST_CASES net.features";;
 	f) TEST_CASES=${OPTARG} ;;
 	V|v) VERBOSE="yes";;
 	*) echo "Error: invalid option..."; exit 1 ;;
-- 
1.7.1

