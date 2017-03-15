From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 15 Mar 2017 15:04:50 +0300
Subject: [LTP] [PATCH 2/2] dccp: new test that compares DCCP and UDP
In-Reply-To: <1489579490-24154-1-git-send-email-alexey.kodanev@oracle.com>
References: <1489579490-24154-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1489579490-24154-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Let's make an assumption based on empiric data that performance
of DCCP is in the range from -100% till 100% against UDP under
the same conditions.

Results:
  * on the same host getting about 40% performance loss,
  * between two hosts over direct link about 10% perf. loss.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.features             |    3 ++
 testcases/lib/test_net.sh        |    7 ++--
 testcases/network/dccp/Makefile  |   22 ++++++++++++++
 testcases/network/dccp/dccp01.sh |   58 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+), 3 deletions(-)
 create mode 100644 testcases/network/dccp/Makefile
 create mode 100755 testcases/network/dccp/dccp01.sh

diff --git a/runtest/net.features b/runtest/net.features
index 6de9a9e..f7f4b87 100644
--- a/runtest/net.features
+++ b/runtest/net.features
@@ -11,6 +11,9 @@ busy_poll02_ipv6 busy_poll02.sh -6
 busy_poll03 busy_poll03.sh
 busy_poll03_ipv6 busy_poll03.sh -6
 
+dccp01 dccp01.sh
+dccp01_ipv6 dccp01.sh -6
+
 tcp_fastopen tcp_fastopen_run.sh
 tcp_fastopen6 tcp_fastopen_run.sh -6
 
diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index e4336d3..7b120f2 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -320,7 +320,7 @@ tst_netload()
 	local s_opts=
 
 	OPTIND=0
-	while getopts :a:H:d:n:N:r:R:b:t:Ufe: opt; do
+	while getopts :a:H:d:n:N:r:R:b:t:UDfe: opt; do
 		case "$opt" in
 		a) c_num="$OPTARG" ;;
 		H) c_opts="${c_opts}-H $OPTARG " ;;
@@ -332,6 +332,7 @@ tst_netload()
 		b) cs_opts="${cs_opts}-b $OPTARG " ;;
 		t) cs_opts="${cs_opts}-t $OPTARG " ;;
 		U) cs_opts="${cs_opts}-U " ;;
+		D) cs_opts="${cs_opts}-D " ;;
 		f) cs_opts="${cs_opts}-f " ;;
 
 		e) expect_res="$OPTARG" ;;
@@ -357,9 +358,9 @@ tst_netload()
 	tst_resm TINFO "check that server port in 'LISTEN' state"
 	local sec_waited=
 	for sec_waited in $(seq 1 600); do
-		tst_rhost_run -c "ss -lutn | grep -q $port" && break
+		tst_rhost_run -c "ss -ldutn | grep -q $port" && break
 		if [ $sec_waited -eq 600 ]; then
-			tst_rhost_run -c "ss -utnp | grep $port"
+			tst_rhost_run -c "ss -dutnp | grep $port"
 			tst_brkm TFAIL "server not in LISTEN state"
 		fi
 		tst_sleep 100ms
diff --git a/testcases/network/dccp/Makefile b/testcases/network/dccp/Makefile
new file mode 100644
index 0000000..23b7772
--- /dev/null
+++ b/testcases/network/dccp/Makefile
@@ -0,0 +1,22 @@
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+top_srcdir		?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_TARGETS		:= dccp01.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
new file mode 100755
index 0000000..27027a5
--- /dev/null
+++ b/testcases/network/dccp/dccp01.sh
@@ -0,0 +1,58 @@
+#!/bin/sh
+# Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
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
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
+#
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+TCID=dccp01
+TST_TOTAL=3
+TST_CLEANUP="cleanup"
+
+. test_net.sh
+
+cleanup()
+{
+	tst_rmdir
+}
+
+setup()
+{
+	tst_require_root
+	tst_tmpdir
+}
+
+test_run()
+{
+	tst_resm TINFO "compare UDP/DCCP performance"
+
+	tst_netload -H $(tst_ipaddr rhost) -U
+	local res0="$(cat tst_netload.res)"
+
+	tst_netload -H $(tst_ipaddr rhost) -D
+	local res1="$(cat tst_netload.res)"
+
+	local per=$(( $res0 * 100 / $res1 - 100 ))
+
+	if [ "$per" -gt "100" -o "$per" -lt "-100" ]; then
+		tst_resm TFAIL "dccp performance $per %"
+	else
+		tst_resm TPASS "dccp performance $per % in range -100 ... 100 %"
+	fi
+}
+
+setup
+test_run
+
+tst_exit
-- 
1.7.1

