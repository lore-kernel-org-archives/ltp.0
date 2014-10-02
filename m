Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZhEs-0007if-SB
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:20:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZhEm-0001Gv-QH
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:20:14 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92EK2iC029875
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:20:02 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92EK0Ln010397
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:20:01 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 16:19:50 +0200
Message-Id: <1412259590-25277-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409569423-15376-1-git-send-email-mmarhefk@redhat.com>
References: <1409569423-15376-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v3] containers: added netns/netns_isolation.sh
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* Tests communication with ifconfig (uses ioctl), ip (uses netlink)
* and ping over a device which is not visible from the current network
* namespace (this communication should not be possible).

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                 |   1 +
 .../kernel/containers/netns/netns_isolation.sh     | 100 +++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100755 testcases/kernel/containers/netns/netns_isolation.sh

diff --git a/runtest/containers b/runtest/containers
index 69eac82..fc61ada 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -31,6 +31,7 @@ netns_par_chld_ftp netns_par_chld_ftp.sh
 netns_netlink netns_netlink
 netns_devices netns_devices.sh
 netns_devices2 netns_devices2.sh
+netns_isolation netns_isolation.sh
 
 shmnstest_none shmnstest none
 shmnstest_clone shmnstest clone
diff --git a/testcases/kernel/containers/netns/netns_isolation.sh b/testcases/kernel/containers/netns/netns_isolation.sh
new file mode 100755
index 0000000..f1ddf2c
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_isolation.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+#==============================================================================
+# Copyright (c) 2014 Red Hat, Inc.
+#
+# This program is free software: you can redistribute it and/or modify
+# it under the terms of version 2 the GNU General Public License as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#==============================================================================
+# File: netns_isolation.sh
+#
+# Tests communication with ifconfig (uses ioctl), ip (uses netlink)
+# and ping over a device which is not visible from the current network
+# namespace (this communication should not be possible).
+#
+
+TCID=netns_isolation
+TST_TOTAL=3
+. test.sh
+IP=192.168.0.2
+
+
+cleanup()
+{
+	# removes veth0 device (which also removes paired veth1 device)
+	ip netns exec myns0 ip link delete veth0
+	# removes the network namespace myns
+	ip netns del myns0
+	ip netns del myns1
+}
+
+
+# SETUP
+tst_require_root
+tst_check_cmds ip
+TST_CLEANUP=cleanup
+
+
+# creates a new network namespace "myns0" (man 8 ip-netns)
+ip netns add myns0 || \
+	tst_brkm TBROK "unable to create a new network namespace (myns0)"
+
+# creates a new network namespace "myns1"
+ip netns add myns1 || \
+	tst_brkm TBROK "unable to create a new network namespace (myns1)"
+
+# creates a pair of virtual ethernet devices
+ip netns exec myns0 ip link add veth0 type veth peer name veth1 || \
+	tst_brkm TBROK "unable to create veth pair devices"
+
+# adds device veth1 to myns1 namespace
+ip netns exec myns0 ip link set veth1 netns myns1 || \
+	tst_brkm TBROK "unable to add device veth1 to the network namespace myns1"
+
+
+# TEST CASE #1
+# setup an ip address on the veth1 device which is not visible
+# from the "myns0" network namespace using ip (netlink)
+ip netns exec myns0 ip address add $IP dev veth1 2>/dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TPASS "controlling a device from a separate NETNS over netlink not possible"
+else
+	tst_resm TFAIL "controlling a device from a separate NETNS over netlink possible"
+fi
+
+
+# TEST CASE #2
+# ping over the veth1 device which is not visible from the "myns0"
+# network namespace
+ip netns exec myns0 ping -q -c 2 -I veth1 $IP 2>/dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TPASS "communication over a device from a separate NETNS not possible"
+else
+	tst_resm TFAIL "communication over a device from a separate NETNS possible"
+fi
+
+
+# TEST CASE #3
+# setup an ip address on the veth1 device which is not visible
+# from the "myns0" network namespace using ifconfig (ioctl)
+tst_check_cmds ifconfig
+ip netns exec myns0 ifconfig veth1 $IP 2>/dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	tst_resm TPASS "ioctl on a device from a separate NETNS not possible"
+else
+	tst_resm TFAIL "ioctl on a device from a separate NETNS possible"
+fi
+
+
+tst_exit
-- 
1.8.3.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
