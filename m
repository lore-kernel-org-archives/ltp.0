Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WS71M-0003qP-24
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 15:42:40 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WS71L-0008Os-3s
	for ltp-list@lists.sourceforge.net; Mon, 24 Mar 2014 15:42:40 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2OFgWlE022214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 15:42:33 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2OFgVjj027134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 15:42:31 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2OFgU40026793
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Mar 2014 15:42:30 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 24 Mar 2014 19:42:53 +0400
Message-Id: <1395675773-7835-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH] lib/test_net.sh: add network help script
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

Add tst_rhost_run() library function to run commands on remote host.
Supported options:
-b run in background
-s safe option, if something goes wrong, will exit with TBROK
-c specify command to run

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test.sh     |    1 +
 testcases/lib/test_net.sh |   78 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 testcases/lib/test_net.sh

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 3f8a0f4..25248d9 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -23,6 +23,7 @@
 
 export LTP_RET_VAL=0
 export TST_COUNT=1
+export TST_LIB_LOADED=1
 
 # Exit values map
 tst_flag2mask()
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
new file mode 100644
index 0000000..f7c21df
--- /dev/null
+++ b/testcases/lib/test_net.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
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
+#
+
+[ -z "$TST_LIB_LOADED" ] && . test.sh
+
+# Run command on remote host.
+# Options:
+# -b run in background
+# -s safe option, if something goes wrong, will exit with TBROK
+# -c specify command to run
+
+tst_rhost_run()
+{
+	# this is needed to run tools/apicmds or LTP tests on remote host
+	local pre_cmd="PATH=$LTPROOT/testcases/bin:$PATH \
+		TCID=$TCID TST_COUNT=1 TST_TOTAL=1"
+	local post_cmd=
+	local out=
+	local user="root"
+	local cmd=
+	local safe=0
+
+	[ -z "$TST_USE_SSH" ] && tst_brkm TBROK "'TST_USE_SSH' not defined"
+
+	while getopts :bsc:u: opt; do
+		case "$opt" in
+		b)
+			pre_cmd="$pre_cmd nohup"
+			post_cmd="&"
+			out="1> /dev/null"
+		;;
+		s) safe=1 ;;
+		c) cmd=$OPTARG ;;
+		u) user=$OPTARG ;;
+		*)
+			tst_brkm TBROK "tst_rhost_run: unknown option: $opt"
+		;;
+		esac
+	done
+
+	OPTIND=0
+
+	[ -z "$cmd" ] && tst_brkm TBROK "command not defined"
+
+	local output=
+	local ret=
+	if [ "$TST_USE_SSH" -eq 1 ]; then
+		output=`ssh -n -q $user@$RHOST "sh -c \
+			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
+	else
+		output=`rsh -n -l $user $RHOST "sh -c \
+			'$pre_cmd $cmd $post_cmd'" $out 2> /dev/null`
+	fi
+	ret=$?
+	[ $ret -ne 0 -a "$safe" -eq 1 ] && \
+		tst_brkm TBROK "failed to run '$cmd' on '$RHOST'"
+
+	[ -z "$out" ] && echo "$output"
+
+	return $ret
+}
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
