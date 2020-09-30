From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Sep 2020 10:58:51 +0200
Subject: [LTP] [PATCH 1/1] virt_lib.sh: Remove checks for tst_ipaddr() output
Message-ID: <20200930085851.21455-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ now unused $ip_local and $ip_remote variables.

These checks were originally (before f275363d7) in tests which use
virt_compare_netperf also with variables.

It should be safe to expect tst_ipaddr() output to be safe even for SSH
based setup ("two host" configuration) due various checks in tst_net.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
This can wait after the release.

 testcases/network/virt/virt_lib.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 827829633..cb2b2ba97 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -61,11 +61,9 @@ virt_lib_setup()
 TST_NEEDS_ROOT=1
 . tst_net.sh
 
-ip_local=$(tst_ipaddr)
 ip_virt_local="$(TST_IPV6= tst_ipaddr_un)"
 ip6_virt_local="$(TST_IPV6=6 tst_ipaddr_un)"
 
-ip_remote=$(tst_ipaddr rhost)
 ip_virt_remote="$(TST_IPV6= tst_ipaddr_un rhost)"
 ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
 
@@ -376,10 +374,6 @@ virt_gre_setup()
 	[ "$TST_IPV6" ] && virt_type="ip6gre"
 	virt_lib_setup
 
-	if [ -z $ip_local -o -z $ip_remote ]; then
-		tst_brk TBROK "you must specify IP address"
-	fi
-
 	tst_res TINFO "test $virt_type"
 	virt_setup "local $(tst_ipaddr) remote $(tst_ipaddr rhost) dev $(tst_iface)" \
 	"local $(tst_ipaddr rhost) remote $(tst_ipaddr) dev $(tst_iface rhost)"
-- 
2.28.0

