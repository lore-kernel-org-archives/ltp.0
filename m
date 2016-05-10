From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 10 May 2016 11:46:03 +0300
Subject: [LTP] [RFC][PATCH 1/3] network: run network tests from network.sh
Message-ID: <1462869965-25841-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* include network options from both networktests.sh and networkstress.sh
* invoke ltp-pan inside network.sh
* merge tcp_cmds_additions to tcp_cmds
* remove not used tcp_cmds_(no)expect runtest files

All network tests can be run from a single script:
e.g. to run 'tcp_cmds' test group

ENV_VARS ./network.sh -t

Also it is possible to define your own runtest file with '-f' option:

ENV_VARS ./network.sh -f runtest_file

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/tcp_cmds       |    3 ++
 testscripts/network.sh |   82 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 79 insertions(+), 6 deletions(-)

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
diff --git a/testscripts/network.sh b/testscripts/network.sh
index 7c7e60a..f7f4f93 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -12,12 +12,13 @@ TCID="network_settings"
 export RHOST=${RHOST:-""}
 export PASSWD=${PASSWD:-""}
 
-# Warning:
-# Make sure to set valid interface names and IP addresses below.
-# 'networktests.sh' expects that IP addresses are already added to interface.
-#
-# Please note, that for 'networktests.sh' tests, management link and
-# test link can be the same.
+if [ -z $RHOST ]; then
+	echo "Error: pay attention to configure"
+	echo "  network paramaters before running tests."
+	exit 1
+fi
+
+# Warning: make sure to set valid interface names and IP addresses below.
 
 # Test Links
 # Set names for test interfaces, e.g. "eth0 eth1"
@@ -84,3 +85,72 @@ export PATH="${PATH}:${LTPROOT}/testcases/bin"
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
 export TCID=
 export TST_LIB_LOADED=
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

