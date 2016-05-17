From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 May 2016 12:02:14 +0300
Subject: [LTP] [PATCH v2 1/3] network: merge
	networktests.sh/networkstress.sh into network.sh
Message-ID: <1463475736-25258-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* invoke ltp-pan inside network.sh;
* merge tcp_cmds_additions to tcp_cmds;
* remove not used tcp_cmds_(no)expect runtest files;
* move variables default values to test_net.sh library so we
  can run network tests individually with default parameters.

All network tests can be run from a single script:
e.g. to run 'tcp_cmds' test group

ENV_VARS ./network.sh -t

It is possible to define your own runtest file with '-f' option:

ENV_VARS ./network.sh -f runtest_file

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: move default values to test_net.sh

 runtest/tcp_cmds          |    3 +
 testcases/lib/test_net.sh |   65 +++++++++++++++++++++++++
 testscripts/network.sh    |  115 +++++++++++++++++++++------------------------
 3 files changed, 121 insertions(+), 62 deletions(-)

diff --git a/runtest/tcp_cmds b/runtest/tcp_cmds
index 6c3ace1..466718b 100644
--- a/runtest/tcp_cmds
+++ b/runtest/tcp_cmds
@@ -21,3 +21,6 @@ telnet telnet01
 iptables iptables_tests.sh
 dhcpd dhcpd_tests.sh
 dnsmasq dnsmasq_tests.sh
+iproute ip_tests.sh
+traceroute traceroute_tests.sh
+xinetd xinetd_tests.sh
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index f391302..c7e8508 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -344,3 +344,68 @@ tst_ping()
 	done
 	return $ret
 }
+
+# Management Link
+[ -z "$RHOST" ] && tst_brkm TBROK "RHOST variable not defined"
+export PASSWD=${PASSWD:-""}
+# Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
+export LTP_RSH=${LTP_RSH:-"rsh -n"}
+
+# Test Links
+# Warning: make sure to set valid interface names and IP addresses below.
+# Set names for test interfaces, e.g. "eth0 eth1"
+export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
+export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
+
+# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
+export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
+export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
+
+# Set first three octets of the network address, default is '10.0.0'
+export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+# Set local host last octet, default is '2'
+export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+# Set remote host last octet, default is '1'
+export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+# Set the reverse of IPV4_NETWORK
+export IPV4_NET_REV=${IPV4_NET_REV:-"0.0.10"}
+# Set first three octets of the network address, default is 'fd00:1:1:1'
+export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
+# Set local host last octet, default is '2'
+export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
+# Set remote host last octet, default is '1'
+export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
+# Reverse network portion of the IPv6 address
+export IPV6_NET_REV=${IPV6_NET_REV:-"1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f"}
+# Reverse host portion of the IPv6 address of the local host
+export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
+# Reverse host portion of the IPv6 address of the remote host
+export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
+
+# Networks that aren't reachable through the test links
+export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
+export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
+
+export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-"/var/www/html"}
+export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-"/var/ftp"}
+export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-"/var/ftp/pub"}
+export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-"pub"}
+
+# network/stress tests require additional parameters
+export NS_DURATION=${NS_DURATION:-"3600"}
+export NS_TIMES=${NS_TIMES:-"10000"}
+export CONNECTION_TOTAL=${CONNECTION_TOTAL:-"4000"}
+export IP_TOTAL=${IP_TOTAL:-"10000"}
+export IP_TOTAL_FOR_TCPIP=${IP_TOTAL_FOR_TCPIP:-"100"}
+export ROUTE_TOTAL=${ROUTE_TOTAL:-"10000"}
+export MTU_CHANGE_TIMES=${MTU_CHANGE_TIMES:-"1000"}
+export IF_UPDOWN_TIMES=${IF_UPDOWN_TIMES:-"10000"}
+export DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-"2147483647"}
+export DOWNLOAD_REGFILESIZE=${DOWNLOAD_REGFILESIZE:-"1048576"}
+export UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-"2147483647"}
+export UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-"1024"}
+export MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-"20"}
+export MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-"40000"}
+
+# More information about network parameters can be found
+# in the following document: testcases/network/stress/README
diff --git a/testscripts/network.sh b/testscripts/network.sh
index 7c7e60a..8afccca 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -4,68 +4,6 @@ TST_TOTAL=1
 TCID="network_settings"
 . test_net.sh
 
-# Network Test Parameters
-#
-# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
-
-# Management Link
-export RHOST=${RHOST:-""}
-export PASSWD=${PASSWD:-""}
-
-# Warning:
-# Make sure to set valid interface names and IP addresses below.
-# 'networktests.sh' expects that IP addresses are already added to interface.
-#
-# Please note, that for 'networktests.sh' tests, management link and
-# test link can be the same.
-
-# Test Links
-# Set names for test interfaces, e.g. "eth0 eth1"
-export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
-export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
-
-# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
-export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
-export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
-
-# Set first three octets of the network address, default is '10.0.0'
-export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
-# Set local host last octet, default is '2'
-export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
-# Set remote host last octet, default is '1'
-export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
-# Set the reverse of IPV4_NETWORK
-export IPV4_NET_REV=${IPV4_NET_REV:-"0.0.10"}
-# Set first three octets of the network address, default is 'fd00:1:1:1'
-export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
-# Set local host last octet, default is '2'
-export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
-# Set remote host last octet, default is '1'
-export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
-# Reverse network portion of the IPv6 address
-export IPV6_NET_REV=${IPV6_NET_REV:-"1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f"}
-# Reverse host portion of the IPv6 address of the local host
-export LHOST_IPV6_REV=${LHOST_IPV6_REV:-"2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
-# Reverse host portion of the IPv6 address of the remote host
-export RHOST_IPV6_REV=${RHOST_IPV6_REV:-"1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0"}
-
-# Networks that aren't reachable through the test links
-export IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
-export IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
-
-export HTTP_DOWNLOAD_DIR=${HTTP_DOWNLOAD_DIR:-"/var/www/html"}
-export FTP_DOWNLOAD_DIR=${FTP_DOWNLOAD_DIR:-"/var/ftp"}
-export FTP_UPLOAD_DIR=${FTP_UPLOAD_DIR:-"/var/ftp/pub"}
-export FTP_UPLOAD_URLDIR=${FTP_UPLOAD_URLDIR:-"pub"}
-
-# More information about network parameters can be found
-# in the following document: testcases/network/stress/README
-
-# ---***************************************************---
-
-# Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
-export LTP_RSH=${LTP_RSH:-"rsh -n"}
-
 export TMPDIR=/tmp/netpan-$$
 mkdir -p $TMPDIR
 CMDFILE=${TMPDIR}/network.tests
@@ -84,3 +22,56 @@ export PATH="${PATH}:${LTPROOT}/testcases/bin"
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
 export TCID=
 export TST_LIB_LOADED=
+
+TEST_CASES=
+
+while getopts 6mnrstaebiTURMFf:Vv OPTION
+do
+	case $OPTION in
+	6) TEST_CASES="$TEST_CASES ipv6 ipv6_lib";;
+	m) TEST_CASES="$TEST_CASES multicast" ;;
+	n) TEST_CASES="$TEST_CASES nfs" ;;
+	r) TEST_CASES="$TEST_CASES rpc" ;;
+	s) TEST_CASES="$TEST_CASES sctp" ;;
+	t) TEST_CASES="$TEST_CASES tcp_cmds" ;;
+	a) TEST_CASES="$TEST_CASES network_stress.appl";;
+	e) TEST_CASES="$TEST_CASES network_stress.interface";;
+	b) TEST_CASES="$TEST_CASES network_stress.broken_ip";;
+	i) TEST_CASES="$TEST_CASES network_stress.icmp";;
+	T) TEST_CASES="$TEST_CASES network_stress.tcp";;
+	U) TEST_CASES="$TEST_CASES network_stress.udp";;
+	R) TEST_CASES="$TEST_CASES network_stress.route";;
+	M) TEST_CASES="$TEST_CASES network_stress.multicast";;
+	F) TEST_CASES="$TEST_CASES network_stress.features";;
+	f) TEST_CASES=${OPTARG} ;;
+	V|v) VERBOSE="yes";;
+	*) echo "Error: invalid option..."; exit 1 ;;
+	esac
+done
+
+rm -f $CMDFILE
+
+for t in $TEST_CASES; do
+	cat  ${LTPROOT}/runtest/$t >> $CMDFILE
+done
+
+cd $TMPDIR
+
+if [ ${VERBOSE} = "yes" ]; then
+	echo "Network parameters:"
+	echo " - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})"
+	echo " - ${RHOST_IFACES} remote interface (MAC address: ${RHOST_HWADDRS})"
+
+	cat $TMPDIR/network_stress.tests
+	${LTPROOT}/ver_linux
+	echo ""
+	echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+fi
+
+${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+
+if [ $? -eq "0" ]; then
+	echo ltp-pan reported PASS
+else
+	echo ltp-pan reported FAIL
+fi
-- 
1.7.1

