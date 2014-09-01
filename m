Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mmarhefk@redhat.com>) id 1XOOtG-0007Q7-2M
	for ltp-list@lists.sourceforge.net; Mon, 01 Sep 2014 10:31:14 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XOOtD-0006jP-Sd
	for ltp-list@lists.sourceforge.net; Mon, 01 Sep 2014 10:31:14 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s81AV4wL017205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Sep 2014 06:31:04 -0400
Received: from cc-vtoe10.lab.eng.brq.redhat.com
	(cc-vtoe10.lab.eng.brq.redhat.com [10.34.74.245])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s81AV24Q028119
	for <ltp-list@lists.sourceforge.net>; Mon, 1 Sep 2014 06:31:03 -0400
From: Matus Marhefka <mmarhefk@redhat.com>
Date: Mon,  1 Sep 2014 12:30:33 +0200
Message-Id: <1409567433-7381-1-git-send-email-mmarhefk@redhat.com>
In-Reply-To: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
References: <1409153560-10176-1-git-send-email-mmarhefk@redhat.com>
Subject: [LTP] [PATCH v2] containers: added netns/netns_devices.sh and
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
 testcases/kernel/containers/netns/netns_devices.sh | 110 ++++++++++++++++++++
 .../kernel/containers/netns/netns_devices2.sh      | 112 +++++++++++++++++++++
 3 files changed, 224 insertions(+)
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
index 0000000..0be9e02
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_devices.sh
@@ -0,0 +1,110 @@
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
+# netlink(7) sockets to control devices. There are two test cases:
+# 1. communication over paired veth (virtual ethernet) devices
+#    from two different network namespaces (each namespace has
+#    one device)
+# 2. communication over the lo (localhost) device in a separate
+#    network namespace
+#
+
+TCID=netns_devices
+TST_TOTAL=2
+. test.sh
+IP0=192.168.0.1
+IP1=192.168.0.2
+
+
+cleanup()
+{
+	# removes veth0 device (which also removes paired veth1 device)
+	ip link delete veth0
+	# removes the network namespace myns
+	ip netns del myns
+}
+
+
+# SETUP
+tst_require_root
+which ip &>/dev/null || tst_brkm TCONF "ip utility is required for this test"
+TST_CLEANUP=cleanup
+
+# creates a pair of virtual ethernet devices
+ip link add veth0 type veth peer name veth1 &>/dev/null || \
+	tst_brkm TBROK "unable to create veth pair devices"
+
+# creates a new network namespace "myns" (man 8 ip-netns)
+ip netns add myns &>/dev/null || \
+	tst_brkm TBROK "unable to create a new network namespace"
+
+# adds device veth1 to myns namespace
+ip link set veth1 netns myns &>/dev/null || \
+	tst_brkm TBROK "unable to add device veth1 to the network namespace myns"
+
+
+# TEST CASE #1
+# setup for veth0 device
+ip address add $IP0/24 dev veth0 || \
+	tst_brkm TBROK "adding address to veth0 failed"
+ip link set dev veth0 up || \
+	tst_brkm TBROK "enabling veth0 device failed"
+
+# setup for veth1 (which is inside myns namespace)
+ip netns exec myns ip address add $IP1/24 dev veth1 || \
+	tst_brkm TBROK "adding address to veth1 failed"
+ip netns exec myns ip link set dev veth1 up || \
+	tst_brkm TBROK "enabling veth1 device failed"
+
+ping -q -c 2 -I veth0 $IP1 &>/dev/null
+ret=$?
+failed=0
+if [ $ret -ne 0 ]; then
+	failed=1
+fi
+
+ip netns exec myns ping -q -c 2 -I veth1 $IP0 &>/dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	failed=1
+fi
+
+if [ $failed -eq 0 ]; then
+	tst_resm TPASS "netlink configuration and communication over veth devices"
+else
+	tst_resm TFAIL "netlink configuration and communication over veth devices"
+fi
+
+
+# TEST CASE #2
+# enables lo device
+ip netns exec myns ip link set dev lo up || \
+	tst_brkm TBROK "enabling lo device failed"
+
+ip netns exec myns ping -q -c 2 -I lo 127.0.0.1 &>/dev/null
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
index 0000000..ca08c1d
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_devices2.sh
@@ -0,0 +1,112 @@
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
+# uses ioctl(2) to control devices. There are two test cases:
+# 1. communication over paired veth (virtual ethernet) devices
+#    from two different network namespaces (each namespace has
+#    one device)
+# 2. communication over the lo (localhost) device in a separate
+#    network namespace
+#
+
+TCID=netns_devices2
+TST_TOTAL=2
+. test.sh
+IP0=192.168.0.1
+IP1=192.168.0.2
+
+
+cleanup()
+{
+	# removes veth0 device (which also removes paired veth1 device)
+	ip link delete veth0
+	# removes the network namespace myns
+	ip netns del myns
+}
+
+
+# SETUP
+tst_require_root
+which ifconfig &>/dev/null ||
+	tst_brkm TCONF "ifconfig utility is required for this test"
+which ip &>/dev/null || tst_brkm TCONF "ip utility is required for this test"
+TST_CLEANUP=cleanup
+
+# creates a pair of virtual ethernet devices
+ip link add veth0 type veth peer name veth1 &>/dev/null || \
+	tst_brkm TBROK "unable to create veth pair devices"
+
+# creates a new network namespace "myns" (man 8 ip-netns)
+ip netns add myns &>/dev/null || \
+	tst_brkm TBROK "unable to create a new network namespace"
+
+# adds device veth1 to myns namespace
+ip link set veth1 netns myns &>/dev/null || \
+	tst_brkm TBROK "unable to add device veth1 to the network namespace myns"
+
+
+# TEST CASE #1
+# setup for veth0 device
+ifconfig veth0 $IP0/24 || \
+	tst_brkm TBROK "adding address to veth0 failed"
+ifconfig veth0 up || \
+	tst_brkm TBROK "enabling veth0 device failed"
+
+# setup for veth1 (which is inside myns namespace)
+ip netns exec myns ifconfig veth1 $IP1/24 || \
+	tst_brkm TBROK "adding address to veth1 failed"
+ip netns exec myns ifconfig veth1 up || \
+	tst_brkm TBROK "enabling veth1 device failed"
+
+ping -q -c 2 -I veth0 $IP1 &>/dev/null
+ret=$?
+failed=0
+if [ $ret -ne 0 ]; then
+	failed=1
+fi
+
+ip netns exec myns ping -q -c 2 -I veth1 $IP0 &>/dev/null
+ret=$?
+if [ $ret -ne 0 ]; then
+	failed=1
+fi
+
+if [ $failed -eq 0 ]; then
+	tst_resm TPASS "ioctl configuration and communication over veth devices"
+else
+	tst_resm TFAIL "ioctl configuration and communication over veth devices"
+fi
+
+
+# TEST CASE #2
+# enables lo device
+ip netns exec myns ifconfig lo up || \
+	tst_brkm TBROK "enabling lo device failed"
+
+ip netns exec myns ping -q -c 2 -I lo 127.0.0.1 &>/dev/null
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
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
