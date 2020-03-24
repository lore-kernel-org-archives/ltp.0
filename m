From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Mar 2020 10:36:21 +0100
Subject: [LTP] [PATCH 1/2] xinetd: Rewrite into new API
In-Reply-To: <20200324093622.21091-1-pvorel@suse.cz>
References: <20200324093622.21091-1-pvorel@suse.cz>
Message-ID: <20200324093622.21091-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also check for in.telnetd (the actual telnet daemon).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/xinetd/xinetd_tests.sh | 99 ++++++++----------------
 1 file changed, 33 insertions(+), 66 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index e2c2dfd8d..b7c6273ba 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -1,42 +1,27 @@
 #!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 # Copyright (c) 2016 Oracle and/or its affiliates. All Rights Reserved.
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
-
-TCID=xinetd
-TST_TOTAL=2
+
+TST_SETUP="setup"
 TST_CLEANUP="cleanup"
+TST_NEEDS_CMDS="diff telnet in.telnetd xinetd"
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC="do_test"
+TST_CNT=2
 
 . daemonlib.sh
-TST_USE_LEGACY_API=1
 . tst_net.sh
 
 setup()
 {
 	[ -f "/usr/lib/systemd/system/telnet.socket" ] && \
-		tst_brkm TCONF "xinetd doesn't manage telnet"
-
-	tst_tmpdir
-
-	tst_require_cmds xinetd diff telnet
+		tst_brk TCONF "xinetd doesn't manage telnet"
 
 	check_addr="127.0.0.1"
 	ip a | grep -q inet6 && check_addr="$check_addr ::1"
 
-	# Create custom xinetd.conf file.
-	# tst_xinetd.conf.1 config file has telnet service disabled.
 	cat > tst_xinetd.conf.1 <<-EOF
 defaults
 {
@@ -70,76 +55,58 @@ service telnet
     flags           = IPv6
 }
 EOF
-
-	# create a backup of the original xinetd.conf file.
 	ROD mv /etc/xinetd.conf xinetd.conf.orig
 }
 
 cleanup()
 {
-	# restore the original xinetd.conf if a back up exits.
 	[ -f xinetd.conf.orig ] && \
 		mv xinetd.conf.orig /etc/xinetd.conf
 
-	# restoring original services
 	restart_daemon xinetd
-
-	tst_rmdir
 }
 
 restart_xinetd()
 {
-	tst_resm TINFO "restart xinetd"
-	# restart xinetd to re-start the services
+	tst_res TINFO "restart xinetd"
 	restart_daemon xinetd > tst_xinetd.out 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_xinetd.out
-		tst_brkm TBROK "unable to restart service with telnet disabled"
+		tst_brk TBROK "unable to restart service with telnet disabled"
 	fi
 
-	# even if xinetd restart has zero exit value,
-	# make certain there was no failure.
 	grep -qi "fail" tst_xinetd.out && \
-		tst_brkm TBROK "xinetd failed to restart"
+		tst_brk TBROK "xinetd failed to restart"
 }
 
-# Description:  - Test that xinetd reads the configuration file and starts or
-#                 stops services.
-#               - restart xinetd with configuration file with telnet disabled.
-#               - telnet to locahost should fail.
-#               - restart xinetd with configuration file with telnet enabled.
-#               - telnet to locahost should work.
-test01()
+xinetd_test()
 {
-	tst_resm TINFO "install the new config file with telnet disabled"
-	ROD mv tst_xinetd.conf.1 /etc/xinetd.conf
-	restart_xinetd
+	local cnt=$1
+	local desc="$2"
+	local pattern="$3"
+	local a p
 
-	for a in $check_addr; do
-		echo '' | telnet $a 2>&1 | grep -qi \
-			"telnet: connect to address $a: Connection refused"
-		[ $? -ne 0 ] && \
-			tst_brkm TFAIL "not expected output for 'telnet $a'"
-	done
-
-	tst_resm TPASS "expected output with telnet disabled"
-
-	tst_resm TINFO "install the xinetd config file with telnet enabled"
-	ROD mv tst_xinetd.conf.2 /etc/xinetd.conf
+	tst_res TINFO "install the new config file with telnet $desc"
+	ROD mv tst_xinetd.conf.$cnt /etc/xinetd.conf
 	restart_xinetd
 
 	for a in $check_addr; do
-		echo '' | telnet $a 2>&1 | grep -qi \
-			"Connection closed by foreign host"
+		p=$(echo $pattern | sed "s/ADDR/$a/")
+		echo '' | telnet $a 2>&1 | grep -qi "$p"
 		[ $? -ne 0 ] && \
-			tst_brkm TFAIL "not expected output for 'telnet $a'"
+			tst_brk TFAIL "not expected output for 'telnet $a'"
 	done
-
-	tst_resm TPASS "expected output with telnet enabled"
+	tst_res TPASS "expected output with telnet $desc"
 }
 
-setup
-
-test01
+do_test()
+{
+	case $1 in
+	1) xinetd_test $1 "disabled" \
+			"telnet: connect to address ADDR: Connection refused";;
+	2) xinetd_test $1 "enabled" \
+			"Connection closed by foreign host";;
+	esac
+}
 
-tst_exit
+tst_run
-- 
2.25.1

