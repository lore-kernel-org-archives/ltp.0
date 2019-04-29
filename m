From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 09:27:59 +0200
Subject: [LTP] [PATCH 1/2] net/traceroute: Rewrite into new API
Message-ID: <20190429072800.23067-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add info about traceroute from iputils not being supported

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/traceroute/traceroute01.sh | 63 ++++++++------------
 1 file changed, 25 insertions(+), 38 deletions(-)

diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 1c8b66f55..8e9f46f45 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -1,39 +1,20 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
-#
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
 
-TST_TOTAL=6
-TCID="traceroute01"
-TST_CLEANUP="cleanup"
-
-TST_USE_LEGACY_API=1
+TST_CNT=2
+TST_NEEDS_CMDS="traceroute"
+TST_SETUP="setup"
+TST_TESTFUNC="test"
 . tst_net.sh
 
-cleanup()
-{
-	tst_rmdir
-}
-
 setup()
 {
-	tst_resm TINFO "traceroute version:"
-	tst_resm TINFO $(traceroute --version 2>&1)
-
-	tst_test_cmds traceroute
-	tst_tmpdir
+	tst_res TINFO "traceroute version:"
+	tst_res TINFO $(traceroute --version 2>&1)
+	[ "$TST_IPV6" ] && tst_res TINFO "NOTE: tracepath6 from iputils is not supported"
 }
 
 run_trace()
@@ -51,24 +32,30 @@ run_trace()
 	grep -q "$bytes byte" out.log
 	if [ $? -ne 0 ]; then
 		cat out.log
-		tst_resm TFAIL "'$bytes byte' not found"
+		tst_res TFAIL "'$bytes byte' not found"
 	else
-		tst_resm TPASS "traceroute use $bytes bytes"
+		tst_res TPASS "traceroute use $bytes bytes"
 	fi
 
 	tail -1 out.log | grep -qE "$pattern"
 	if [ $? -ne 0 ]; then
 		cat out.log
-		tst_resm TFAIL "pattern '$pattern' not found in log"
+		tst_res TFAIL "pattern '$pattern' not found in log"
 	else
-		tst_resm TPASS "traceroute test completed with 1 hop"
+		tst_res TPASS "traceroute test completed with 1 hop"
 	fi
 }
 
-setup
-tst_resm TINFO "run traceroute with ICMP ECHO"
-run_trace -I
-tst_resm TINFO "run traceroute with TCP SYN"
-run_trace -T
+test1()
+{
+	tst_res TINFO "run traceroute with ICMP ECHO"
+	run_trace -I
+}
+
+test2()
+{
+	tst_res TINFO "run traceroute with TCP SYN"
+	run_trace -T
+}
 
-tst_exit
+tst_run
-- 
2.20.1

