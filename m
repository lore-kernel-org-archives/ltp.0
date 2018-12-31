From: Sun Lianwen <sun_lianwen@163.com>
Date: Mon, 31 Dec 2018 18:31:26 +0800
Subject: [LTP] [PATCH] network/busy_poll: Change the "ethtool
	--show-features to "ethtool -k"
Message-ID: <20181231103126.3679-1-sun_lianwen@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To keep the same struct of "ethtool -i $(tst_iface)",
change the "ethtool --show-features" to "ethtool -k".

Signed-off-by: Sun Lianwen <sun_lianwen@163.com>
---
 testcases/network/busy_poll/busy_poll_lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index 5270a1bbd..2a24ff262 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -22,8 +22,7 @@ busy_poll_check_config()
 	fi
 
 	if tst_kvcmp -lt "4.5"; then
-		ethtool --show-features $(tst_iface) | \
-			grep -q 'busy-poll.*on' || \
+		ethtool -k  $(tst_iface) | grep -q 'busy-poll.*on' || \
 			tst_brk TCONF "busy poll not supported by driver"
 	else
 		drvs="bnx2x|bnxt|cxgb4|enic|benet|ixgbe|ixgbevf|mlx4|mlx5|myri10ge|sfc|virtio"
-- 
2.19.0


