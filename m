From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Apr 2018 08:23:42 +0200
Subject: [LTP] [PATCH v2 2/3] network/virt_lib.sh: Process getopts
	parameters with TST_OPTS and TST_PARSE_ARGS
In-Reply-To: <20180430062343.5582-1-pvorel@suse.cz>
References: <20180430062343.5582-1-pvorel@suse.cz>
Message-ID: <20180430062343.5582-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ Move loading tst_net.sh from vxlan03.sh and other virt_lib.sh users to
virt_lib.sh itself.

vxlan03.sh pass getopts parameter to virt_lib.sh (other than -6 which is
handled by tst_net.sh), which causes getopts error:

vxlan03.sh -d uni
/opt/ltp/testcases/bin/vxlan03.sh: illegal option -- d
/opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found

Fix processing parameters with TST_OPTS and TST_PARSE_ARGS (proper way
of handling parameters by API).

Fixes: ba53eb04e tst_net.sh: Support both new and legacy APIs + rename

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reported-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Suggested-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/geneve01.sh  |  2 --
 testcases/network/virt/gre01.sh     |  3 ---
 testcases/network/virt/ipvlan01.sh  |  2 --
 testcases/network/virt/macvlan01.sh |  2 --
 testcases/network/virt/macvtap01.sh |  2 --
 testcases/network/virt/virt_lib.sh  | 38 +++++++++++++++++++++----------------
 testcases/network/virt/vlan01.sh    |  2 --
 testcases/network/virt/vlan02.sh    |  2 --
 testcases/network/virt/vlan03.sh    |  2 --
 testcases/network/virt/vxlan01.sh   |  2 --
 testcases/network/virt/vxlan02.sh   |  2 --
 testcases/network/virt/vxlan03.sh   |  2 --
 12 files changed, 22 insertions(+), 39 deletions(-)

diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 709201358..0cc117f3b 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -27,8 +27,6 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index 74ecb4898..09a77a4d5 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -24,9 +24,6 @@ TCID=gre01
 TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
 virt_type="gre"
 [ "$TST_IPV6" ] && virt_type="ip6gre"
 
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index b69444644..36b07f027 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -24,8 +24,6 @@ TST_TOTAL=2
 
 virt_type="ipvlan"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 options="mode l2,mode l3"
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index cf0462ec4..cafca75e2 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -24,8 +24,6 @@ TST_TOTAL=4
 
 virt_type="macvlan"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 options="mode private,mode vepa,mode bridge,mode passthru"
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index e647f9009..7b90213a1 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -24,8 +24,6 @@ TST_TOTAL=4
 
 virt_type="macvtap"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 options="mode private,mode vepa,mode bridge,mode passthru"
diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index c99004b85..0f75bb030 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -28,19 +29,8 @@
 #          them in cleanup function. See "start_vni" variable which can
 #          solve it.
 
-ip_local=$(tst_ipaddr)
-ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
-ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
-
-ip_remote=$(tst_ipaddr rhost)
-ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
-ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
-
-# Max performance loss (%) for virtual devices during network load
-VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
-vxlan_dstport=0
-
-while getopts :hi:d:6 opt; do
+virt_lib_parse_args()
+{
 	case "$opt" in
 	h)
 		echo "Usage:"
@@ -52,13 +42,29 @@ while getopts :hi:d:6 opt; do
 	;;
 	i) start_id=$OPTARG ;;
 	d) vxlan_dst_addr=$OPTARG ;;
-	6) # skip, test_net library already processed it
-	;;
 	*)
 		tst_brkm TBROK "unknown option: $opt"
 	;;
 	esac
-done
+}
+
+TST_OPTS="hi:d:"
+TST_PARSE_ARGS=virt_lib_parse_args
+
+TST_USE_LEGACY_API=1
+. tst_net.sh
+
+ip_local=$(tst_ipaddr)
+ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
+ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
+
+ip_remote=$(tst_ipaddr rhost)
+ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
+ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
+
+# Max performance loss (%) for virtual devices during network load
+VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-80}
+vxlan_dstport=0
 
 cleanup_vifaces()
 {
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 890848fee..5ac412b32 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -24,8 +24,6 @@ TST_TOTAL=9
 
 virt_type="vlan"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 p0="protocol 802.1Q"
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index 4cb4856ba..748f9c44c 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -25,8 +25,6 @@ TST_TOTAL=1
 
 virt_type="vlan"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 virt_add_delete_test "id 4094"
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 63a9d517d..7a8f74295 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -29,8 +29,6 @@ TST_NEEDS_TMPDIR=1
 
 virt_type="vlan"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 TST_CLEANUP="virt_cleanup"
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 8d96db257..1a301e5cc 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -25,8 +25,6 @@ TST_TOTAL=5
 virt_type="vxlan"
 start_id=16700000
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 options="l2miss l3miss,norsc nolearning noproxy,\
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index db152afdf..66d48ba56 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -26,8 +26,6 @@ TST_TOTAL=1
 virt_type="vxlan"
 start_id=16700000
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 [ "$TST_IPV6" ] && mult_addr="ff02::abc" || mult_addr="239.1.1.1"
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 6d3792ab7..94eee71a8 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -33,8 +33,6 @@ start_id=16700000
 # Destination address, can be unicast or multicast address
 vxlan_dst_addr="uni"
 
-TST_USE_LEGACY_API=1
-. tst_net.sh
 . virt_lib.sh
 
 # In average cases (with small packets less then 150 bytes) VxLAN slower
-- 
2.16.3

