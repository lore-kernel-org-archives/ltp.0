From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  5 Apr 2018 13:56:52 +0300
Subject: [LTP] [PATCH COMMITTED 3/3] network/geneve: don't set lower device
	for geneve tunnel
In-Reply-To: <1522925812-17200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1522925812-17200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1522925812-17200-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unlike vxlan, geneve doesn't have dev parameter. This patch
is fixing unintentional TCONF for geneve tests:
...
geneve01 1 TCONF: iproute2 or kernel doesn't support geneve

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 5c0c106..c99004b 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -98,6 +98,7 @@ virt_add()
 	vlan|vxlan)
 		[ -z "$opt" ] && opt="id 4094"
 		[ "$vxlan_dstport" -eq 1 ] && opt="dstport 0 $opt"
+		[ "$virt_type" = "vxlan" ] && opt="$opt dev $(tst_iface)"
 	;;
 	geneve)
 		[ -z "$opt" ] && opt="id 4094 remote $(tst_ipaddr rhost)"
@@ -110,7 +111,7 @@ virt_add()
 
 	case $virt_type in
 	vxlan|geneve)
-		ip li add $vname type $virt_type $opt dev $(tst_iface)
+		ip li add $vname type $virt_type $opt
 	;;
 	gre|ip6gre)
 		ip -f inet$TST_IPV6 tu add $vname mode $virt_type $opt
@@ -126,7 +127,7 @@ virt_add_rhost()
 	local opt=""
 	case $virt_type in
 	vxlan|geneve)
-		opt="dev $(tst_iface rhost)"
+		[ "$virt_type" = "vxlan" ] && opt="dev $(tst_iface rhost)"
 		[ "$vxlan_dstport" -eq 1 ] && opt="$opt dstport 0"
 		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
-- 
1.7.1

