From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Apr 2019 09:28:00 +0200
Subject: [LTP] [PATCH 2/2] net/tracepath: Rewrite into new API
In-Reply-To: <20190429072800.23067-1-pvorel@suse.cz>
References: <20190429072800.23067-1-pvorel@suse.cz>
Message-ID: <20190429072800.23067-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

enhancements:
* Check for tracepath -6 when tracepath6 not available
  tracepath6 was removed in iputils s20161105 and replaced by tracepath -6,
  this way it's portable for both all iputils releases

* Print tracepath version if -V is available (added in inputils s20190324)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../network/tcp_cmds/tracepath/tracepath01.sh | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/testcases/network/tcp_cmds/tracepath/tracepath01.sh b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
index fcfd54afb..037fca066 100755
--- a/testcases/network/tcp_cmds/tracepath/tracepath01.sh
+++ b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
@@ -1,58 +1,56 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
-#
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 
-TCID=tracepath01
-TST_TOTAL=1
-TST_USE_LEGACY_API=1
+TST_TESTFUNC="do_test"
+TST_SETUP="setup"
 . tst_net.sh
 
-test_tracepath()
+setup()
+{
+	cmd="tracepath"
+
+	if [ "$TST_IPV6" ]; then
+		cmd="tracepath$TST_IPVER"
+		tst_cmd_available $cmd || cmd="tracepath -6"
+	fi
+	tst_test_cmds $(echo $cmd | cut -f 1 -d' ')
+
+	if $cmd -V >/dev/null 2>&1; then
+		tst_res TINFO "traceroute version:"
+		tst_res TINFO $($cmd -V 2>&1)
+	fi
+}
+
+do_test()
 {
-	local cmd="$1"
 	local len=1280
-	local output=
-	local ret=0
-	local rhost="$2"
-	tst_test_cmds "$cmd"
+	local output
+	local rhost="$(tst_ipaddr rhost)"
 
-	tst_resm TINFO "test $cmd with $rhost, pmtu is $len"
+	tst_res TINFO "test $cmd with $rhost, pmtu is $len"
 
 	output=$($cmd $rhost -l $len | grep "pmtu $len")
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "$cmd failed: pmtu $len not found in output"
+		tst_res TFAIL "$cmd failed: pmtu $len not found in output"
 		return
 	fi
 
 	# Usually only one hop is required to get to remote test machine
 	hops_num=$(echo "$output" | sed -nE 's/.*hops ([0-9]+).*/\1/p')
 	if [ -z "$hops_num" ]; then
-		tst_resm TFAIL "failed to trace path to '$rhost'"
+		tst_res TFAIL "failed to trace path to '$rhost'"
 		return
 	fi
 
 	if [ "$hops_num" -eq 0 ]; then
-		tst_resm TFAIL "can't trace path to '$rhost' in 1+ hops"
+		tst_res TFAIL "can't trace path to '$rhost' in 1+ hops"
 		return
 	fi
 
-	tst_resm TPASS "traced path to '$rhost' in $hops_num hops"
+	tst_res TPASS "traced path to '$rhost' in $hops_num hops"
 }
 
-test_tracepath tracepath$TST_IPV6 $(tst_ipaddr rhost)
-
-tst_exit
+tst_run
-- 
2.20.1

