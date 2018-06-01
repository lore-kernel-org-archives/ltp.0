From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:56 +0200
Subject: [LTP] [PATCH 7/7] net/virt: Replace $ipver by $TST_IPVER from
	tst_net.sh
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/virt/virt_lib.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 00978a062..77f129894 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -289,8 +289,8 @@ virt_compare_netperf()
 
 	case "$virt_type" in
 	vxlan|geneve)
-		tst_resm TINFO "IP4 $virt_type over IP$ipver slower by $per %"
-		tst_resm TINFO "IP6 $virt_type over IP$ipver slower by $per6 %"
+		tst_resm TINFO "IP4 $virt_type over IP$TST_IPVER slower by $per %"
+		tst_resm TINFO "IP6 $virt_type over IP$TST_IPVER slower by $per6 %"
 	;;
 	*)
 		tst_resm TINFO "IP4 $virt_type slower by $per %"
@@ -420,8 +420,6 @@ vxlan|geneve)
 ;;
 esac
 
-ipver=${TST_IPV6:-'4'}
-
 tst_check_cmds "ip"
 
 virt_add ltp_v0 || \
-- 
2.16.3

