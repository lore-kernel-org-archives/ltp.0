Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YMEzR-0005Np-Om
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:57 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YMEzQ-0005hV-Sx
	for ltp-list@lists.sourceforge.net; Fri, 13 Feb 2015 12:04:57 +0000
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id t1DC4pni030758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:51 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by aserv0021.oracle.com (8.13.8/8.13.8) with ESMTP id t1DC4oFI024798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:51 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	t1DC4oda009617
	for <ltp-list@lists.sourceforge.net>; Fri, 13 Feb 2015 12:04:50 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 13 Feb 2015 15:07:03 +0300
Message-Id: <1423829229-28963-5-git-send-email-alexey.kodanev@oracle.com>
In-Reply-To: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
References: <1423829229-28963-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH 5/11] network/stress/interface: add local library
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
Cc: vasily.isaenko@oracle.com

It provides the following functions:
* basic setup and cleanup
* making TCP background traffic
* checking connectivity between test hosts

Moreover it defines new IPV4_NET16_UNUSED and IPV6_NET32_UNUSED
variables. They are needed because some of the interface tests
add more then 254 new addresses to interface which could overlap
with existed ones on test network.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/stress/interface/if-lib.sh |   64 ++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/stress/interface/if-lib.sh

diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
new file mode 100644
index 0000000..fde6310
--- /dev/null
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+#
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
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TST_CLEANUP="cleanup"
+
+. test_net.sh
+
+ipver=${TST_IPV6:-4}
+
+IPV4_NET16_UNUSED=${IPV4_NET16_UNUSED:-"10.23"}
+IPV6_NET32_UNUSED=${IPV6_NET32_UNUSED:-"fd00:23"}
+
+setup()
+{
+	tst_require_root
+	tst_check_cmds ip pgrep pkill
+	trap "tst_brkm TBROK 'test interrupted'" INT
+}
+
+cleanup()
+{
+	# Stop the background TCP traffic
+	pkill -13 -x tcp_fastopen
+	tst_rhost_run -c "pkill -13 -x tcp_fastopen"
+	tst_restore_ipaddr
+}
+
+make_background_tcp_traffic()
+{
+	port=$(tst_get_unused_port ipv${ipver} stream)
+	tcp_fastopen -R 3 -g $port > /dev/null 2>&1 &
+	tst_rhost_run -b -c "tcp_fastopen -l -H $(tst_ipaddr) -g $port"
+}
+
+check_connectivity()
+{
+	local cnt=$1
+	[ $CHECK_INTERVAL -eq 0 ] && return
+	[ $(($cnt % $CHECK_INTERVAL)) -ne 0 ] && return
+
+	tst_resm TINFO "check connectivity through $(tst_iface) on step $cnt"
+	check_icmpv${ipver}_connectivity $(tst_iface) $(tst_ipaddr rhost)
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$(tst_iface) is broken"
+		return 1
+	fi
+	return 0
+}
-- 
1.7.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
