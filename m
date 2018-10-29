From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 29 Oct 2018 16:03:17 +0300
Subject: [LTP] [PATCH 1/6] network/virt: add support for sit tunnel
In-Reply-To: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1540818202-11247-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index de3aba6..c9fe80c 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -116,10 +116,13 @@ virt_add()
 		[ -z "$opt" ] && \
 			opt="remote $(tst_ipaddr rhost) dev $(tst_iface)"
 	;;
+	sit)
+		[ -z "$opt" ] && opt="remote $(tst_ipaddr rhost) local $(tst_ipaddr)"
+	;;
 	esac
 
 	case $virt_type in
-	vxlan|geneve)
+	vxlan|geneve|sit)
 		ip li add $vname type $virt_type $opt
 	;;
 	gre|ip6gre)
@@ -140,6 +143,9 @@ virt_add_rhost()
 		[ "$vxlan_dstport" -eq 1 ] && opt="$opt dstport 0"
 		tst_rhost_run -s -c "ip li add ltp_v0 type $virt_type $@ $opt"
 	;;
+	sit)
+		tst_rhost_run -s -c "ip link add ltp_v0 type $virt_type $@"
+	;;
 	gre|ip6gre)
 		tst_rhost_run -s -c "ip -f inet$TST_IPV6 tu add ltp_v0 \
 				     mode $virt_type $@"
-- 
1.7.1

