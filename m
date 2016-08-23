From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 23 Aug 2016 14:16:03 +0300
Subject: [LTP] [PATCH 2/2] network/tcp_cmds/arp01: rename to ipneigh01
In-Reply-To: <1471950963-7711-1-git-send-email-alexey.kodanev@oracle.com>
References: <1471950963-7711-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1471950963-7711-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'ipneigh' is more appropriate name for the test as it covers
IPv4 and IPv6 cache entries with 'ip neigh' command and arp
command is obsolete.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.ipv6                                |    1 +
 runtest/net.tcp_cmds                            |    2 +-
 testcases/network/tcp_cmds/arp/Makefile         |   31 ---------
 testcases/network/tcp_cmds/arp/arp01            |   83 -----------------------
 testcases/network/tcp_cmds/ipneigh/Makefile     |   31 +++++++++
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh |   83 +++++++++++++++++++++++
 6 files changed, 116 insertions(+), 115 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/arp/Makefile
 delete mode 100755 testcases/network/tcp_cmds/arp/arp01
 create mode 100644 testcases/network/tcp_cmds/ipneigh/Makefile
 create mode 100755 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh

diff --git a/runtest/net.ipv6 b/runtest/net.ipv6
index bc16fb0..5f42e01 100644
--- a/runtest/net.ipv6
+++ b/runtest/net.ipv6
@@ -5,3 +5,4 @@ tcpdump601 tcpdump01 -6
 tracepath601 tracepath01.sh -6
 dhcpd6 dhcpd_tests.sh -6
 dnsmasq6 dnsmasq_tests.sh -6
+ipneigh601 ipneigh01.sh -6
diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index c975e69..9801fef 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -2,7 +2,7 @@
 #
 # PLEASE READ THE README FILE IN /tcp_cmds BEFORE RUNNING THESE.
 #
-arp arp01
+ipneigh01 ipneigh01.sh
 arping01 arping01.sh
 clockdiff01 clockdiff01.sh
 echo export TCbin=$LTPROOT/testcases/network/tcp_cmds/echo; echo01
diff --git a/testcases/network/tcp_cmds/arp/Makefile b/testcases/network/tcp_cmds/arp/Makefile
deleted file mode 100644
index bfaba19..0000000
--- a/testcases/network/tcp_cmds/arp/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/arp testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Garrett Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= arp01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/arp/arp01 b/testcases/network/tcp_cmds/arp/arp01
deleted file mode 100755
index 5357db9..0000000
--- a/testcases/network/tcp_cmds/arp/arp01
+++ /dev/null
@@ -1,83 +0,0 @@
-#!/bin/sh
-# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) International Business Machines  Corp., 2000
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program. If not, see <http://www.gnu.org/licenses/>.
-#
-# Test basic functionality of 'arp' and 'ip neigh'.
-
-TCID=arp01
-NUMLOOPS=${NUMLOOPS:-50}
-TST_TOTAL=2
-. test_net.sh
-
-do_setup()
-{
-	tst_require_root
-	tst_check_cmds ip arp grep ping$TST_IPV6
-}
-
-do_test()
-{
-	local arp_show_cmd=$1
-	local arp_del_cmd=$2
-
-	local entry_name
-	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
-
-	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
-	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
-	tst_resm TINFO "with '$arp_del_cmd'"
-
-	for i in $(seq 1 $NUMLOOPS); do
-
-		ping$TST_IPV6 -q -c1 $rhost > /dev/null
-
-		local k
-		local ret=1
-		# wait for arp entry at least 3 seconds
-		for k in $(seq 1 30); do
-			$arp_show_cmd | grep -q $rhost
-			if [ $? -eq 0 ]; then
-				ret=0
-				break;
-			fi
-			usleep 100
-		done
-
-		[ "$ret" -ne 0 ] && \
-			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
-
-		$arp_del_cmd
-
-		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
-			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
-				       "$(tst_hwaddr rhost)' $i/$NUMLOOPS"
-	done
-
-	tst_resm TPASS "verified adding/removing of $entry_name cache entry"
-}
-
-do_setup
-
-rhost=$(tst_ipaddr rhost)
-
-if [ -z "$TST_IPV6" ]; then
-	do_test "arp -a" "arp -d $rhost"
-else
-	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
-fi
-
-do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
-
-tst_exit
diff --git a/testcases/network/tcp_cmds/ipneigh/Makefile b/testcases/network/tcp_cmds/ipneigh/Makefile
new file mode 100644
index 0000000..baab67b
--- /dev/null
+++ b/testcases/network/tcp_cmds/ipneigh/Makefile
@@ -0,0 +1,31 @@
+#
+#    network/tcp_cmds/arp testcases Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Garrett Cooper, July 2009
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= ipneigh01.sh
+
+MAKE_TARGETS		:=
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
new file mode 100755
index 0000000..5357db9
--- /dev/null
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -0,0 +1,83 @@
+#!/bin/sh
+# Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) International Business Machines  Corp., 2000
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Test basic functionality of 'arp' and 'ip neigh'.
+
+TCID=arp01
+NUMLOOPS=${NUMLOOPS:-50}
+TST_TOTAL=2
+. test_net.sh
+
+do_setup()
+{
+	tst_require_root
+	tst_check_cmds ip arp grep ping$TST_IPV6
+}
+
+do_test()
+{
+	local arp_show_cmd=$1
+	local arp_del_cmd=$2
+
+	local entry_name
+	[ "$TST_IPV6" ] && entry_name="NDISC" || entry_name="ARP"
+
+	tst_resm TINFO "Stress auto-creation of $entry_name cache entry"
+	tst_resm TINFO "by pinging '$rhost' and deleting entry again"
+	tst_resm TINFO "with '$arp_del_cmd'"
+
+	for i in $(seq 1 $NUMLOOPS); do
+
+		ping$TST_IPV6 -q -c1 $rhost > /dev/null
+
+		local k
+		local ret=1
+		# wait for arp entry at least 3 seconds
+		for k in $(seq 1 30); do
+			$arp_show_cmd | grep -q $rhost
+			if [ $? -eq 0 ]; then
+				ret=0
+				break;
+			fi
+			usleep 100
+		done
+
+		[ "$ret" -ne 0 ] && \
+			tst_brkm TFAIL "$entry_name entry '$rhost' not listed"
+
+		$arp_del_cmd
+
+		$arp_show_cmd | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
+			tst_brkm TFAIL "'$arp_del_cmd' failed, entry has " \
+				       "$(tst_hwaddr rhost)' $i/$NUMLOOPS"
+	done
+
+	tst_resm TPASS "verified adding/removing of $entry_name cache entry"
+}
+
+do_setup
+
+rhost=$(tst_ipaddr rhost)
+
+if [ -z "$TST_IPV6" ]; then
+	do_test "arp -a" "arp -d $rhost"
+else
+	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
+fi
+
+do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
+
+tst_exit
-- 
1.7.1

