From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 18 Oct 2017 15:49:57 +0200
Subject: [LTP] [RFC PATCH 3/7] net/tcp_cmds: Remove rlogin test
In-Reply-To: <20171018135001.30382-1-pvorel@suse.cz>
References: <20171018135001.30382-1-pvorel@suse.cz>
Message-ID: <20171018135001.30382-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rlogin is way too old to bother to test it and has been
deprecated for many years in favour of ssh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.tcp_cmds                       |  1 -
 testcases/network/tcp_cmds/rlogin/Makefile | 31 ----------
 testcases/network/tcp_cmds/rlogin/rlogin01 | 90 ------------------------------
 3 files changed, 122 deletions(-)
 delete mode 100644 testcases/network/tcp_cmds/rlogin/Makefile
 delete mode 100755 testcases/network/tcp_cmds/rlogin/rlogin01

diff --git a/runtest/net.tcp_cmds b/runtest/net.tcp_cmds
index 151b7d22f..0bbf95edd 100644
--- a/runtest/net.tcp_cmds
+++ b/runtest/net.tcp_cmds
@@ -13,7 +13,6 @@ netstat netstat01
 ping01 ping01.sh
 ping02 ping02.sh
 rcp export TCbin=$LTPROOT/testcases/network/tcp_cmds/rcp; rcp01
-rlogin rlogin01
 rsh rsh01
 sendfile export TCbin=$LTPROOT/testcases/network/tcp_cmds/sendfile; sendfile01
 tcpdump tcpdump01
diff --git a/testcases/network/tcp_cmds/rlogin/Makefile b/testcases/network/tcp_cmds/rlogin/Makefile
deleted file mode 100644
index 97acadb1e..000000000
--- a/testcases/network/tcp_cmds/rlogin/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    network/tcp_cmds/rlogin testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../..
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_TARGETS		:= rlogin01
-
-MAKE_TARGETS		:=
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01 b/testcases/network/tcp_cmds/rlogin/rlogin01
deleted file mode 100755
index 162b8f0d8..000000000
--- a/testcases/network/tcp_cmds/rlogin/rlogin01
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/bin/sh
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-#    03/01 Robbie Williamson (robbiew@us.ibm.com)
-
-TCID="rlogin01"
-TST_TOTAL=1
-
-. test_net.sh
-
-setup()
-{
-	tst_check_cmds rlogin expect
-
-	if [ -z $RUSER ]; then
-		RUSER=root
-	fi
-
-	if [ -z $PASSWD ]; then
-		tst_brkm TCONF "Please set PASSWD for $RUSER."
-	fi
-
-	if [ -z $RHOST ]; then
-		tst_brkm TCONF "Please set RHOST."
-	fi
-
-	if [ -z $LOOPCOUNT ]; then
-		LOOPCOUNT=25
-	fi
-}
-
-do_test()
-{
-	tst_resm TINFO "Starting"
-
-	for i in $(seq 1 ${LOOPCOUNT})
-	do
-		rlogin_test || return 1
-	done
-}
-
-rlogin_test()
-{
-	tst_resm TINFO "login with rlogin($i/$LOOPCOUNT)"
-
-	expect -c "
-		spawn rlogin $RHOST -l $RUSER
-
-		expect {
-			\"Password:\" {
-				send \"$PASSWD\r\"; exp_continue
-			} \"incorrect\" {
-				exit 1
-			} \"$RUSER@\" {
-				send \"LC_ALL=C; ls -l /etc/hosts | \\
-				       wc -w > $RUSER.$RHOST\rexit\r\";
-				exp_continue
-			}
-		}
-	" > /dev/null || return 1
-
-	tst_resm TINFO "checking telnet status($i/$LOOPCOUNT)"
-	tst_rhost_run -u $RUSER -c "grep -q 9 $RUSER.$RHOST" || return 1
-	tst_rhost_run -u $RUSER -c "rm -f $RUSER.$RHOST"
-}
-
-setup
-
-do_test
-if [ $? -ne 0 ]; then
-	tst_resm TFAIL "Test $TCID failed."
-else
-	tst_resm TPASS "Test $TCID succeeded."
-fi
-
-tst_exit
-- 
2.14.2

