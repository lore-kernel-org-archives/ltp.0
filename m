Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Xo58n-0003mi-Lu
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 06:41:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xo58m-0005av-5d
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 06:41:25 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAB6f4oW006629
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Nov 2014 14:41:04 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 11 Nov 2014 14:38:16 +0800
Message-ID: <1415687896-19753-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1415251889-10596-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] containers: fix three cases' exit status
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In iproute2 whose version is earlier than v3.0.0, ip
command doesn't support netns object. In this condition,
running three cases (netns_devices.sh, netns_devices2.sh
and netns_isolation.sh) will exit with TFAIL. It is not
suitable, so fix these cases' exit status with TCONF.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_devices.sh |  5 +++
 .../kernel/containers/netns/netns_devices2.sh      |  5 +++
 testcases/kernel/containers/netns/netns_helper.sh  | 45 ++++++++++++++++++++++
 .../kernel/containers/netns/netns_isolation.sh     |  5 +++
 4 files changed, 60 insertions(+)
 create mode 100755 testcases/kernel/containers/netns/netns_helper.sh

diff --git a/testcases/kernel/containers/netns/netns_devices.sh b/testcases/kernel/containers/netns/netns_devices.sh
index 7126267..01f7056 100755
--- a/testcases/kernel/containers/netns/netns_devices.sh
+++ b/testcases/kernel/containers/netns/netns_devices.sh
@@ -29,6 +29,7 @@
 TCID=netns_devices
 TST_TOTAL=3
 . test.sh
+. netns_helper.sh
 IP0=192.168.0.1
 IP1=192.168.0.2
 
@@ -46,6 +47,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip
+tst_check_iproute 111010
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF "ip command does not support netns object"
+fi
 TST_CLEANUP=cleanup
 
 # creates a new network namespace "myns0" (man 8 ip-netns)
diff --git a/testcases/kernel/containers/netns/netns_devices2.sh b/testcases/kernel/containers/netns/netns_devices2.sh
index f0d0651..3fc38b5 100755
--- a/testcases/kernel/containers/netns/netns_devices2.sh
+++ b/testcases/kernel/containers/netns/netns_devices2.sh
@@ -29,6 +29,7 @@
 TCID=netns_devices2
 TST_TOTAL=3
 . test.sh
+. netns_helper.sh
 IP0=192.168.0.1
 IP1=192.168.0.2
 
@@ -46,6 +47,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip ifconfig
+tst_check_iproute 111010
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF "ip command does not support netns object"
+fi
 TST_CLEANUP=cleanup
 
 # creates a new network namespace "myns0" (man 8 ip-netns)
diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
new file mode 100755
index 0000000..401b795
--- /dev/null
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+#
+# Copyright (c) Linux Test Project, 2014
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# This is a LTP shell test library for iproute.
+#
+
+. test.sh
+
+# Check whether the current iproute version matches specified
+# iproute. It returns 0, 1, or 2 if cur_ipver is found, to be
+# less than, to match, or be greater than spe_ipver.
+tst_check_iproute()
+{
+	local cur_ipver=`ip -V`
+	local spe_ipver=$1
+
+	cur_ipver=${cur_ipver##*s}
+
+	if [ -z $cur_ipver ] || [ -z $spe_ipver ]; then
+		tst_brkm TBROK "don't obtain valid iproute version"
+	fi
+
+	if [ $cur_ipver -lt $spe_ipver ]; then
+		return 0;
+	elif [ $cur_ipver -eq $spe_ipver ]; then
+		return 1;
+	else
+		return 2;
+	fi
+}
diff --git a/testcases/kernel/containers/netns/netns_isolation.sh b/testcases/kernel/containers/netns/netns_isolation.sh
index f1ddf2c..06e91db 100755
--- a/testcases/kernel/containers/netns/netns_isolation.sh
+++ b/testcases/kernel/containers/netns/netns_isolation.sh
@@ -24,6 +24,7 @@
 TCID=netns_isolation
 TST_TOTAL=3
 . test.sh
+. netns_helper.sh
 IP=192.168.0.2
 
 
@@ -40,6 +41,10 @@ cleanup()
 # SETUP
 tst_require_root
 tst_check_cmds ip
+tst_check_iproute 111010
+if [ $? -eq 0 ]; then
+	tst_brkm TCONF "ip command does not support netns object"
+fi
 TST_CLEANUP=cleanup
 
 
-- 
1.9.3


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
