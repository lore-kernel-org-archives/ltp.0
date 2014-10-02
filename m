Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XZhDG-0007d6-MI
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:18:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XZhDD-0001Dh-Ug
	for ltp-list@lists.sourceforge.net; Thu, 02 Oct 2014 14:18:34 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s92EIP4K009857
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:18:26 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s92EIOgn031992
	for <ltp-list@lists.sourceforge.net>; Thu, 2 Oct 2014 10:18:24 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Thu,  2 Oct 2014 16:18:08 +0200
Message-Id: <1412259488-25226-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
References: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v4] containers: added netns/netns_devices.sh and
	netns/netns_devices2.sh
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

* Tests that a separate network namespace can configure and communicate
  over the devices it sees
* netns/netns_devices.sh  -- uses netlink(7) for configuration
* netns/netns_devices2.sh -- uses ioctl(2) for configuration

Signed-off-by: Matus Marhefka <mmarhefk@redhat.com>
---
 runtest/containers                                 |   2 +
 testcases/kernel/containers/netns/netns_devices.sh | 115 +++++++++++++++++++++
 .../kernel/containers/netns/netns_devices2.sh      | 115 +++++++++++++++++++++
 3 files changed, 232 insertions(+)
 create mode 100755 testcases/kernel/containers/netns/netns_devices.sh
 create mode 100755 testcases/kernel/containers/netns/netns_devices2.sh

diff --git a/runtest/containers b/runtest/containers
index 7d01a44..69eac82 100644
--- a/runtest/containers
+++ b/runtest/containers
@@ -29,6 +29,8 @@ netns_crtchild_delchild netns_crtchild_delchild
 netns_par_chld_ipv6 netns_par_chld_ipv6
 netns_par_chld_ftp netns_par_chld_ftp.sh
 netns_netlink netns_netlink
+netns_devices netns_devices.sh
+netns_devices2 netns_devices2.sh
 
 shmnstest_none shmnstest none
 shmnstest_clone shmnstest clone
diff --git a/testcases/kernel/containers/netns/netns_devices.sh b/testcases/kernel/containers/netns/netns_devices.sh
new file mode 100755
index 0000000..7126267
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_devices.sh
@@ -0,0 +1,115 @@
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
+# File: netns_devices.sh
+#
+# Tests that a separate network namespace can configure and communicate
+# over the devices it sees. Tests are done using ip command which uses
+# netlink(7) sockets to control devices. There are three test cases:
+# 1,2. communication over paired veth (virtual ethernet) devices
+#      from two different network namespaces (each namespace has
+#      one device)
+#   3. communication over the lo (localhost) device in a separate
+#      network namespace
+#
+
+TCID=netns_devices
+TST_TOTAL=3
+. test.sh
+IP0=192.168.0.1
+IP1=192.168.0.2
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
+# setup for veth0 device (which is inside myns0 namespace)
+ip netns exec myns0 ip address add $IP0/24 dev veth0 || \
+	tst_brkm TBROK "adding address to veth0 failed"
+ip netns exec myns0 ip link set dev veth0 up || \
+	tst_brkm TBROK "enabling veth0 device failed"
+
+# setup for veth1 (which is inside myns1 namespace)
+ip netns exec myns1 ip address add $IP1/24 dev veth1 || \
+	tst_brkm TBROK "adding address to veth1 failed"
+ip netns exec myns1 ip link set dev veth1 up || \
+	tst_brkm TBROK "enabling veth1 device failed"
+
+
+# TEST CASE #1
+ip netns exec myns0 ping -q -c 2 -I veth0 $IP1 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "netlink configuration and communication over veth0 device"
+else
+	tst_resm TFAIL "netlink configuration and communication over veth0 device"
+fi
+
+
+# TEST CASE #2
+ip netns exec myns1 ping -q -c 2 -I veth1 $IP0 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "netlink configuration and communication over veth1 device"
+else
+	tst_resm TFAIL "netlink configuration and communication over veth1 device"
+fi
+
+
+# TEST CASE #3
+# enables lo device
+ip netns exec myns0 ip link set dev lo up || \
+	tst_brkm TBROK "enabling lo device failed"
+
+ip netns exec myns0 ping -q -c 2 -I lo 127.0.0.1 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "netlink configuration and communication over lo device"
+else
+	tst_resm TFAIL "netlink configuration and communication over lo device"
+fi
+
+
+tst_exit
diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
new file mode 100755
index 0000000..f0d0651
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_devices2.sh
@@ -0,0 +1,115 @@
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
+# File: netns_devices2.sh
+#
+# Tests that a separate network namespace can configure and communicate
+# over the devices it sees. Tests are done using ifconfig command which
+# uses ioctl(2) to control devices. There are three test cases:
+# 1,2. communication over paired veth (virtual ethernet) devices
+#      from two different network namespaces (each namespace has
+#      one device)
+#   3. communication over the lo (localhost) device in a separate
+#      network namespace
+#
+
+TCID=netns_devices2
+TST_TOTAL=3
+. test.sh
+IP0=192.168.0.1
+IP1=192.168.0.2
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
+tst_check_cmds ip ifconfig
+TST_CLEANUP=cleanup
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
+# setup for veth0 device (which is inside myns0 namespace)
+ip netns exec myns0 ifconfig veth0 $IP0/24 || \
+	tst_brkm TBROK "adding address to veth0 failed"
+ip netns exec myns0 ifconfig veth0 up || \
+	tst_brkm TBROK "enabling veth0 device failed"
+
+# setup for veth1 (which is inside myns1 namespace)
+ip netns exec myns1 ifconfig veth1 $IP1/24 || \
+	tst_brkm TBROK "adding address to veth1 failed"
+ip netns exec myns1 ifconfig veth1 up || \
+	tst_brkm TBROK "enabling veth1 device failed"
+
+
+# TEST CASE #1
+ip netns exec myns0 ping -q -c 2 -I veth0 $IP1 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "ioctl configuration and communication over veth0 device"
+else
+	tst_resm TFAIL "ioctl configuration and communication over veth0 device"
+fi
+
+
+# TEST CASE #2
+ip netns exec myns1 ping -q -c 2 -I veth1 $IP0 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "ioctl configuration and communication over veth1 device"
+else
+	tst_resm TFAIL "ioctl configuration and communication over veth1 device"
+fi
+
+
+# TEST CASE #3
+# enables lo device
+ip netns exec myns0 ifconfig lo up || \
+	tst_brkm TBROK "enabling lo device failed"
+
+ip netns exec myns0 ping -q -c 2 -I lo 127.0.0.1 >/dev/null
+ret=$?
+if [ $ret -eq 0 ]; then
+	tst_resm TPASS "ioctl configuration and communication over lo device"
+else
+	tst_resm TFAIL "ioctl configuration and communication over lo device"
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
