From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 15 Oct 2020 15:20:54 +0300
Subject: [LTP] [PATCH 3/5] network/virt: skip setting neighbour table if
 tunnel doesn't have hwaddr
In-Reply-To: <20201015122056.20715-1-alexey.kodanev@oracle.com>
References: <20201015122056.20715-1-alexey.kodanev@oracle.com>
Message-ID: <20201015122056.20715-3-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/virt/virt_lib.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
index 80b9bcc90..f62120347 100644
--- a/testcases/network/virt/virt_lib.sh
+++ b/testcases/network/virt/virt_lib.sh
@@ -229,10 +229,13 @@ virt_minimize_timeout()
 	local mac_loc="$(cat /sys/class/net/ltp_v0/address)"
 	local mac_rmt="$(tst_rhost_run -c 'cat /sys/class/net/ltp_v0/address')"
 
-	ROD_SILENT "ip ne replace $ip_virt_remote lladdr \
-		    $mac_rmt nud permanent dev ltp_v0"
-	tst_rhost_run -s -c "ip ne replace $ip_virt_local lladdr \
-			     $mac_loc nud permanent dev ltp_v0"
+	if [ "$mac_loc" ]; then
+		ROD_SILENT "ip ne replace $ip_virt_remote lladdr \
+			    $mac_rmt nud permanent dev ltp_v0"
+		tst_rhost_run -s -c "ip ne replace $ip_virt_local lladdr \
+				     $mac_loc nud permanent dev ltp_v0"
+	fi
+
 	virt_tcp_syn=$(sysctl -n net.ipv4.tcp_syn_retries)
 	ROD sysctl -q net.ipv4.tcp_syn_retries=1
 }
-- 
2.20.1

