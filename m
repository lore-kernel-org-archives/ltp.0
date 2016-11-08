From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  8 Nov 2016 17:13:51 +0100
Subject: [LTP] [PATCH 1/1] network: portability: using tst_sleep instead of
	usleep
Message-ID: <20161108161351.16366-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh              | 4 ++--
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 140619d..85f9b88 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -26,12 +26,12 @@ stop_dhcp()
 	while [ $count -le 10 ]; do
 		pkill -x $dhcp_name
 		[ "$(pgrep -x $dhcp_name)" ] || return 0
-		usleep 100000
+		tst_sleep 100ms
 		count=$((count + 1))
 	done
 
 	pkill -9 -x $dhcp_name
-	usleep 100000
+	tst_sleep 100ms
 	[ "$(pgrep -x $dhcp_name)" ] && return 1 || return 0
 }
 
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 736d149..31d6cc6 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -52,7 +52,7 @@ do_test()
 				ret=0
 				break;
 			fi
-			usleep 100
+			tst_sleep 100us
 		done
 
 		[ "$ret" -ne 0 ] && \
-- 
2.10.2

