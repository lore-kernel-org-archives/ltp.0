From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Dec 2019 08:26:38 +0100
Subject: [LTP] [PATCH 1/1] iptables: Reduce code duplicity
Message-ID: <20191219072638.31824-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

feel free to not ack this as not needed syntax optimalization.
This way the most of variables is set in the library,
so people would hopefuly search for them there.

0 is the default in [ "$foo" = 1 ], but maybe use_iptables=0 in
nft01.sh is better for readability.

Kind regards,
Petr

 testcases/network/iptables/iptables01.sh   |  5 -----
 testcases/network/iptables/iptables_lib.sh | 10 ++++++++++
 testcases/network/iptables/nft01.sh        |  6 ------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/testcases/network/iptables/iptables01.sh b/testcases/network/iptables/iptables01.sh
index e6ed4afab..b788b919a 100755
--- a/testcases/network/iptables/iptables01.sh
+++ b/testcases/network/iptables/iptables01.sh
@@ -2,13 +2,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018-2019 Oracle and/or its affiliates. All Rights Reserved.
 
-TST_SETUP="init"
-TST_CLEANUP="cleanup"
-TST_NEEDS_CMDS="iptables grep ping telnet"
-TST_NEEDS_DRIVERS="ip_tables"
 use_iptables=1
 
 . iptables_lib.sh
-. tst_test.sh
 
 tst_run
diff --git a/testcases/network/iptables/iptables_lib.sh b/testcases/network/iptables/iptables_lib.sh
index b098479e4..b029950f9 100755
--- a/testcases/network/iptables/iptables_lib.sh
+++ b/testcases/network/iptables/iptables_lib.sh
@@ -10,13 +10,23 @@ TST_CNT=6
 TST_TESTFUNC="test"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
+TST_SETUP="${TST_SETUP:-init}"
+TST_CLEANUP="${TST_CLEANUP:-cleanup}"
 
 if [ "$use_iptables" = 1 ]; then
 	toolname=iptables
+	cmds="$toolname"
+	TST_NEEDS_DRIVERS="ip_tables"
 else
 	toolname=nft
+	cmds="$toolname iptables-translate"
+	TST_NEEDS_DRIVERS="nf_tables"
 fi
 
+TST_NEEDS_CMDS="$cmds grep ping telnet"
+
+. tst_test.sh
+
 NFRUN()
 {
 	local rule
diff --git a/testcases/network/iptables/nft01.sh b/testcases/network/iptables/nft01.sh
index 9bd10a7f5..7d3fc4e0d 100755
--- a/testcases/network/iptables/nft01.sh
+++ b/testcases/network/iptables/nft01.sh
@@ -4,14 +4,8 @@
 
 TST_SETUP="do_setup"
 TST_CLEANUP="do_cleanup"
-TST_NEEDS_CMDS="nft iptables-translate grep ping telnet"
-TST_NEEDS_DRIVERS="nf_tables"
-use_iptables=0
-cleanup_table=0
-cleanup_chain=0
 
 . iptables_lib.sh
-. tst_test.sh
 
 do_setup()
 {
-- 
2.24.0

