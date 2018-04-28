From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 28 Apr 2018 15:59:20 +0200
Subject: [LTP] [PATCH 1/2] Revert "network/vxlan03: Fix getopts parameters
	passed to virt_lib.sh"
In-Reply-To: <20180428135921.9622-1-pvorel@suse.cz>
References: <20180428135921.9622-1-pvorel@suse.cz>
Message-ID: <20180428135921.9622-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This reverts commit 06ee2b0273bd79a423b88b4488c71aebef0bb2ea.

With this patch vxlan03 ignores the '-6' option.

And tst_net.sh sourced two times there, in virt_lib.sh and in vxlan03.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/virt_lib.sh | 29 ++++++++++++-----------------
 testcases/network/virt/vxlan03.sh  |  3 +--
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 2355ddfe9..c99004b85 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -28,6 +28,18 @@
 #          them in cleanup function. See "start_vni" variable which can
 #          solve it.
 
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
+
 while getopts :hi:d:6 opt; do
 	case "$opt" in
 	h)
@@ -48,23 +60,6 @@ while getopts :hi:d:6 opt; do
 	esac
 done
 
-shift $(($OPTIND - 1))
-
-TST_USE_LEGACY_API=1
-. tst_net.sh
-
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
 cleanup_vifaces()
 {
 	tst_resm TINFO "cleanup virtual interfaces..."
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 9587badb6..6d3792ab7 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -33,10 +33,9 @@ start_id=16700000
 # Destination address, can be unicast or multicast address
 vxlan_dst_addr="uni"
 
-. virt_lib.sh
-
 TST_USE_LEGACY_API=1
 . tst_net.sh
+. virt_lib.sh
 
 # In average cases (with small packets less then 150 bytes) VxLAN slower
 # by 10-30%. If hosts are too close to each other, e.g. connected to the same
-- 
2.16.3

