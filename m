From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:09 +0200
Subject: [LTP] [PATCH v3 9/9] net/virt: Introduce macsec_lib.sh to reduce
	duplicity
In-Reply-To: <20180703074209.911-1-pvorel@suse.cz>
References: <20180703074209.911-1-pvorel@suse.cz>
Message-ID: <20180703074209.911-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/macsec01.sh   | 27 +-------------
 testcases/network/virt/macsec02.sh   | 28 +-------------
 testcases/network/virt/macsec_lib.sh | 55 ++++++++++++++++++++++++++++
 testcases/network/virt/virt_lib.sh   | 27 --------------
 4 files changed, 58 insertions(+), 79 deletions(-)
 create mode 100755 testcases/network/virt/macsec_lib.sh

diff --git a/testcases/network/virt/macsec01.sh b/testcases/network/virt/macsec01.sh
index 725d469e7..d9d6e73a6 100755
--- a/testcases/network/virt/macsec01.sh
+++ b/testcases/network/virt/macsec01.sh
@@ -8,33 +8,8 @@
 # with default MACsec configuration, compare performance with similar
 # IPsec configuration on master interface.
 
-virt_type="macsec"
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
-IPSEC_MODE="transport"
 IPSEC_PROTO="ah"
 
-TST_NEEDS_TMPDIR=1
-TST_TESTFUNC=virt_netperf_msg_sizes
-TST_SETUP=do_setup
-TST_CLEANUP=do_cleanup
-. ipsec_lib.sh
-. virt_lib.sh
-
-do_setup()
-{
-	ipsec_lib_setup
-
-	tst_res TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
-	tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-	tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-
-	virt_macsec_setup
-}
-
-do_cleanup()
-{
-	virt_cleanup
-	tst_ipsec_cleanup
-}
+. macsec_lib.sh
 
 tst_run
diff --git a/testcases/network/virt/macsec02.sh b/testcases/network/virt/macsec02.sh
index 575b5c4e0..0c40b25a1 100755
--- a/testcases/network/virt/macsec02.sh
+++ b/testcases/network/virt/macsec02.sh
@@ -8,34 +8,10 @@
 # with enabled frame encryption and replay protection, compare
 # performance with similar IPsec configuration on master interface.
 
-virt_type="macsec"
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
-IPSEC_MODE="transport"
 IPSEC_PROTO="esp_aead"
 EALGO="aes"
+MACSEC_LIB_SETUP="replay on window 300 encrypt on protect on"
 
-TST_NEEDS_TMPDIR=1
-TST_TESTFUNC=virt_netperf_msg_sizes
-TST_SETUP=do_setup
-TST_CLEANUP=do_cleanup
-. ipsec_lib.sh
-. virt_lib.sh
-
-do_setup()
-{
-	ipsec_lib_setup
-
-	tst_res TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
-	tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
-	tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
-
-	virt_macsec_setup "replay on window 300 encrypt on protect on"
-}
-
-do_cleanup()
-{
-	virt_cleanup
-	tst_ipsec_cleanup
-}
+. macsec_lib.sh
 
 tst_run
diff --git a/testcases/network/virt/macsec_lib.sh b/testcases/network/virt/macsec_lib.sh
new file mode 100755
index 000000000..9b21af7d6
--- /dev/null
+++ b/testcases/network/virt/macsec_lib.sh
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Author: Alexey Kodanev <alexey.kodanev@oracle.com>
+
+virt_type="macsec"
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-100}
+IPSEC_MODE="transport"
+
+TST_NEEDS_TMPDIR=1
+TST_TESTFUNC=virt_netperf_msg_sizes
+TST_SETUP=macsec_lib_setup
+TST_CLEANUP=macsec_lib_cleanup
+. ipsec_lib.sh
+. virt_lib.sh
+
+# MACSEC_LIB_SETUP:
+# [ cipher { default | gcm-aes-128 } ] [ encrypt { on | off } ]
+# [ protect { on | off } ] [ replay { on | off } ] [ window WINDOW ]
+# [ validate { strict | check | disabled } ]
+macsec_lib_setup()
+{
+	local keyid0="01"
+	local keyid1="02"
+	local sa=0
+	local h0=$(tst_hwaddr)
+	local h1=$(tst_hwaddr rhost)
+	local cmd="ip macsec add ltp_v0"
+	local key0="01234567890123456789012345678901"
+	local key1="98765432109876543210987612343434"
+
+	ipsec_lib_setup
+
+	tst_res TINFO "setup IPsec $IPSEC_MODE/$IPSEC_PROTO $EALGO"
+	tst_ipsec lhost $(tst_ipaddr) $(tst_ipaddr rhost)
+	tst_ipsec rhost $(tst_ipaddr rhost) $(tst_ipaddr)
+
+	virt_setup "icvlen 16 encodingsa $sa $MACSEC_LIB_SETUP"
+
+	ROD $cmd tx sa $sa pn 100 on key $keyid0 $key0
+	ROD $cmd rx address $h1 port 1
+	ROD $cmd rx address $h1 port 1 sa $sa pn 100 on key $keyid1 $key1
+
+	tst_rhost_run -s -c "$cmd tx sa $sa pn 100 on key $keyid1 $key1"
+	tst_rhost_run -s -c "$cmd rx address $h0 port 1"
+	tst_rhost_run -s -c \
+		"$cmd rx address $h0 port 1 sa $sa pn 100 on key $keyid0 $key0"
+}
+
+macsec_lib_cleanup()
+{
+	virt_cleanup
+	tst_ipsec_cleanup
+}
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index c40747ac4..e4b24822f 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -320,33 +320,6 @@ virt_check_cmd()
 	return 0
 }
 
-# virt_macsec_setup [OPTIONS]
-# OPTIONS - [ cipher { default | gcm-aes-128 } ] [ encrypt { on | off } ]
-#           [ protect { on | off } ] [ replay { on | off } ] [ window WINDOW ]
-#           [ validate { strict | check | disabled } ]
-virt_macsec_setup()
-{
-	local keyid0=01
-	local keyid1=02
-	local sa=0
-	local h0=$(tst_hwaddr)
-	local h1=$(tst_hwaddr rhost)
-	local cmd="ip macsec add ltp_v0"
-	local key0="01234567890123456789012345678901"
-	local key1="98765432109876543210987612343434"
-
-	virt_setup "icvlen 16 encodingsa $sa $@"
-
-	ROD $cmd tx sa $sa pn 100 on key $keyid0 $key0
-	ROD $cmd rx address $h1 port 1
-	ROD $cmd rx address $h1 port 1 sa $sa pn 100 on key $keyid1 $key1
-
-	tst_rhost_run -s -c "$cmd tx sa $sa pn 100 on key $keyid1 $key1"
-	tst_rhost_run -s -c "$cmd rx address $h0 port 1"
-	tst_rhost_run -s -c \
-		"$cmd rx address $h0 port 1 sa $sa pn 100 on key $keyid0 $key0"
-}
-
 virt_netperf_msg_sizes()
 {
 	local sizes="100 1000 2000 10000"
-- 
2.18.0

