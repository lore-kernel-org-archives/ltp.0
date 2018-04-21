From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sat, 21 Apr 2018 17:04:05 +0800
Subject: [LTP] [PATCH] add ip6tables test case
Message-ID: <42e1043e-a0b0-a55c-d55f-be5561bbcdb1@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add ip6tables test case base on case of iptables

Signed-off-by: sunlw <sunlw.fnst@cn.fujitsu.com>
---
 runtest/net.tcp_cmds                          |   1 +
 testcases/network/iptables/Makefile           |   2 +-
 testcases/network/iptables/ip6tables_tests.sh | 386 ++++++++++++++++++
 3 files changed, 388 insertions(+), 1 deletion(-)
 create mode 100755 testcases/network/iptables/ip6tables_tests.sh

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 859f48127..0f152f16c 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -17,6 +17,7 @@ sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
 tcpdump tcpdump01
 telnet telnet01
 iptables iptables_tests.sh
+ip6tables ip6tables_tests.sh
 dhcpd dhcpd_tests.sh
 dnsmasq dnsmasq_tests.sh
 iproute ip_tests.sh
diff --git a/testcases/network/iptables/Makefile b/testcases/network/iptables/Makefile
index afb96e9cb..980089841 100644
--- a/testcases/network/iptables/Makefile
+++ b/testcases/network/iptables/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= iptables_tests.sh
+INSTALL_TARGETS		:= iptables_tests.sh ip6tables_tests.sh
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/iptables/ip6tables_tests.sh b/testcases/network/iptables/ip6tables_tests.sh
new file mode 100755
index 000000000..780b9eb29
--- /dev/null
+++ b/testcases/network/iptables/ip6tables_tests.sh
@@ -0,0 +1,386 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2001                 ##
+## Copyright (c) 2018 Lianwen Sun <Sunlw.fnst@cn.fujitsu.com>
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+################################################################################
+#  Author:	Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com>
+#				       <hubertNOSPAAAM@symbio.com.tw>
+#               Apr 21 2018 Lianwen Sun <Sunlw.fnst@cn.fujitsu.com>
+
+
+export TCID="ip6tables"
+export TST_TOTAL=6
+
+. test.sh
+
+init()
+{
+	tst_tmpdir
+
+	tst_resm TINFO "INIT: Inititalizing tests."
+
+	modprobe ip6_tables
+	if [ $? -ne 0 ]; then
+		ip6tables -L > tst_ip6tables.out 2>&1
+		if [ $? -ne 0 ]; then
+			tst_brkm TBROK "no ip6tables support in kernel."
+		fi
+	fi
+
+	tst_resm TINFO "INIT: Flushing all rules."
+	ip6tables -F -t filter > tst_ip6tables.out 2>&1
+	ip6tables -F -t nat > tst_ip6tables.out 2>&1
+	ip6tables -F -t mangle > tst_ip6tables.out 2>&1
+}
+
+cleanup()
+{
+	lsmod | grep "ip6_tables" > tst_ip6tables.out 2>&1
+	if [ $? -eq 0 ]; then
+		ip6tables -F -t filter > tst_ip6tables.out 2>&1
+		ip6tables -F -t nat > tst_ip6tables.out 2>&1
+		ip6tables -F -t mangle > tst_ip6tables.out 2>&1
+	fi
+	tst_rmdir
+}
+
+test01()
+{
+	local chaincnt=0
+
+	local cmd="ip6tables -L -t filter"
+	tst_resm TINFO "$cmd will list all rules in table filter."
+	$cmd > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		cat tst_ip6tables.out
+		return
+	else
+		chaincnt=$(grep -c Chain tst_ip6tables.out)
+		if [ $chaincnt -lt 3 ]; then
+			tst_resm TFAIL "$cmd failed to list rules."
+			cat tst_ip6tables.out
+			return
+		else
+			tst_resm TINFO "$cmd lists rules."
+		fi
+	fi
+
+	local cmd="ip6tables -L -t nat"
+	tst_resm TINFO "$cmd will list all rules in table nat."
+	$cmd > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		cat tst_ip6tables.out
+		return
+	else
+		chaincnt=$(grep -c Chain tst_ip6tables.out)
+		if [ $chaincnt -lt 3 ]; then
+			tst_resm TFAIL "$cmd failed to list rules."
+			cat tst_ip6tables.out
+			return
+		else
+			tst_resm TINFO "$cmd lists rules."
+		fi
+	fi
+
+	local cmd="ip6tables -L -t mangle"
+	tst_resm TINFO "$cmd will list all rules in table mangle."
+	$cmd > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		cat tst_ip6tables.out
+		return
+	else
+		chaincnt=$(grep -c Chain tst_ip6tables.out)
+		if [ $chaincnt -lt 5 ]; then
+			tst_resm TFAIL "$cmd failed to list rules."
+			cat tst_ip6tables.out
+		else
+			tst_resm TINFO "$cmd lists rules."
+		fi
+	fi
+
+	tst_resm TPASS "ip6tables -L lists rules."
+}
+
+test02()
+{
+	tst_resm TINFO "Use ip6tables to DROP packets from particular IP"
+	tst_resm TINFO "Rule to block icmpv6 from ::1/128"
+
+	ip6tables -A INPUT -s ::1/128 -p icmpv6 -j DROP > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Pinging ::1/128"
+	ping6 -c 2 ::1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		grep "100% packet loss" tst_ip6tables.out > tst_ip6tables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "ip6tables did not block packets from loopback"
+			cat tst_ip6tables.err
+			return
+		else
+			tst_resm TINFO "Ping6 ::1/128 not successful."
+		fi
+	else
+		tst_resm TFAIL "ip6tables did not block icmp from ::1/128"
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Deleting icmpv6 DROP from ::1/128 rule."
+	ip6tables -D INPUT 1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables did not remove the rule."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "Pinging ::1/128 again"
+	ping6 -c 2 ::1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables blocking loopback. This is expected" \
+			       "behaviour on certain distributions where" \
+			       "enabling firewall drops all packets by default."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "Ping6 succsess"
+	tst_resm TPASS "ip6tables can DROP packets from particular IP."
+}
+
+test03()
+{
+	tst_resm TINFO "Use ip6tables to REJECT ping request."
+	tst_resm TINFO "Rule to reject ping request."
+
+	ip6tables -A INPUT -p icmpv6 --icmpv6-type echo-request -d ::1/128 -j \
+		 REJECT > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Pinging ::1/128"
+	ping6 -c 2 ::1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		grep "100% packet loss" tst_ip6tables.out > tst_ip6tables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "ip6tables did not block ping request."
+			cat tst_ip6tables.err
+			return
+		else
+			tst_resm TINFO "Ping6 ::1/128  not successful."
+		fi
+	else
+		tst_resm TFAIL "ip6tables did not reject ping request."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Deleting icmp request REJECT rule."
+	ip6tables -D INPUT 1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables did not remove the rule."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "Pinging ::1/128 again"
+	ping6 -c 2 ::1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables blocking ping requests. This is" \
+			       "expected behaviour on certain distributions" \
+			       "where enabling firewall drops all packets by" \
+			       "default."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "Ping6 succsess"
+	tst_resm TPASS "ip6tables can REJECT ping requests."
+}
+
+test04()
+{
+	local dport=45886
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use ip6tables to log packets to particular port."
+	tst_resm TINFO "Rule to log tcp packets to particular port."
+
+	ip6tables -A INPUT -p tcp -d ::1/128 --dport $dport -j LOG \
+		 --log-prefix "$logprefix" > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "telnet -6 ::1 $dport"
+	telnet -6 ::1 $dport > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		sleep 2
+		dmesg | grep "$logprefix" > tst_ip6tables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "ip6tables did not log packets to port $dport"
+			cat tst_ip6tables.err
+			return
+		else
+			tst_resm TINFO "Packets to port $dport logged."
+		fi
+	else
+		tst_resm TFAIL "telnet to ::1/128 $dport should fail."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Deleting the rule to log."
+	ip6tables -D INPUT 1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables did not remove the rule."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "ip6tables logging succsess"
+	tst_resm TPASS "ip6tables can log packets to particular port."
+}
+
+test05()
+{
+	local dport=0
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use ip6tables to log packets to multiple ports."
+	tst_resm TINFO "Rule to log tcp packets to port 45801 - 45803."
+	ip6tables -A INPUT -p tcp -d ::1/128 --dport 45801:45803 -j LOG \
+		 --log-prefix "$logprefix" > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Rule to log tcp packets to port 45804 - 45806."
+	ip6tables -A INPUT -p tcp -d ::1/128 -m multiport --dports \
+		 45804,45806,45805 -j LOG --log-prefix "$logprefix" \
+		 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	for dport in 45801 45802 45803 45804 45805 45806; do
+		tst_resm TINFO "telnet -6 ::1 $dport"
+		telnet -6 ::1 $dport > tst_ip6tables.out 2>&1
+		if [ $? -ne 0 ]; then
+			sleep 2
+			dmesg | grep "$logprefix" | grep "=$dport " \
+				> tst_ip6tables.err 2>&1
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL "ip6tables did not log packets" \
+					       "to port $dport"
+				cat tst_ip6tables.err
+				return
+			else
+				tst_resm TINFO "Packets to port $dport logged."
+			fi
+		else
+			tst_res TFAIL "telnet to ::1 $dport should fail."
+			cat tst_ip6tables.out
+			return
+		fi
+	done
+
+	tst_resm TINFO "Flushing all rules."
+	ip6tables -F > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables did not flush all rules."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "ip6tables logging succsess"
+	tst_resm TPASS "ip6tables can log packets to multiple ports."
+}
+
+test06()
+{
+	local logcnt=0
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use ip6tables to log ping request with limited rate."
+	tst_resm TINFO "Rule to log ping request."
+
+	ip6tables -A INPUT -p icmpv6 --icmpv6-type echo-request -d ::1/128 -m \
+		 limit -j LOG --log-prefix "$logprefix" > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables command failed to append new rule."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "ping6 ::1"
+	ping6 -c 10 ::1 > tst_ip6tables.out 2>&1
+	if [ $? -eq 0 ]; then
+		sleep 2
+		logcnt=$(dmesg | grep -c "$logprefix")
+		if [ $logcnt -ne 5 ]; then
+			tst_resm TFAIL "ip6tables did not log packets with" \
+				       "limited rate."
+			cat tst_ip6tables.out
+			return
+		else
+			tst_resm TINFO "ping requests logged with limited rate."
+		fi
+	else
+		tst_resm TFAIL "ping to ::1 failed. This is expected" \
+			       "behaviour on certain distributions where" \
+			       "enabling firewall drops all packets by default."
+		cat tst_ip6tables.out
+		return
+	fi
+
+	tst_resm TINFO "Deleting the rule to log."
+	ip6tables -D INPUT 1 > tst_ip6tables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "ip6tables did not remove the rule."
+		cat tst_ip6tables.out
+		return
+	fi
+	tst_resm TINFO "ip6tables limited logging succsess"
+	tst_resm TPASS "ip6tables can log packets with limited rate."
+}
+
+init
+TST_CLEANUP=cleanup
+
+test01
+test02
+test03
+test04
+test05
+test06
+
+tst_exit
-- 
2.17.0



