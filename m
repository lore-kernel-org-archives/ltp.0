From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Feb 2019 17:47:50 +0300
Subject: [LTP] [PATCH 1/4] network/gre01: move setup to library
In-Reply-To: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1550587673-7995-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The same setup can be used with the other gre tests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/gre01.sh    |   19 ++-----------------
 testcases/network/virt/virt_lib.sh |   15 +++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index 27373fd..db5be6d 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
-# Copyright (c) 2015-2017 Oracle and/or its affiliates.
+# Copyright (c) 2015-2019 Oracle and/or its affiliates.
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 # It requires remote host. Test will setup IPv4 and IPv6 virtual
@@ -10,23 +10,8 @@
 
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=virt_netperf_msg_sizes
-TST_SETUP=do_setup
+TST_SETUP=virt_gre_setup
 TST_CLEANUP=virt_cleanup
 . virt_lib.sh
 
-do_setup()
-{
-	virt_type="gre"
-	[ "$TST_IPV6" ] && virt_type="ip6gre"
-	virt_lib_setup
-
-	if [ -z $ip_local -o -z $ip_remote ]; then
-		tst_brk TBROK "you must specify IP address"
-	fi
-
-	tst_res TINFO "test $virt_type"
-	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
-	"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
-}
-
 tst_run
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index c9fe80c..eb9d052 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -355,3 +355,18 @@ virt_test_02()
 	virt_add_delete_test "$2"
 	start_id=$(($start_id + $NS_TIMES))
 }
+
+virt_gre_setup()
+{
+	virt_type="gre"
+	[ "$TST_IPV6" ] && virt_type="ip6gre"
+	virt_lib_setup
+
+	if [ -z $ip_local -o -z $ip_remote ]; then
+		tst_brk TBROK "you must specify IP address"
+	fi
+
+	tst_res TINFO "test $virt_type"
+	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
+	"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
+}
-- 
1.7.1

