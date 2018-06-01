From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 11:21:46 +0200
Subject: [LTP] [COMMITTED] [PATCH 1/1] net/ipneigh: Fix rhost IP
Message-ID: <20180601092146.22392-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: 64ce601d4 ("net/ipneigh: Use new API + split into more test
cases")

Reported-by: Anton Smorodskyi <asmorodskyi@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I'm sorry, Anton, this was my fault (last minute change when replacing
rhost variable.


Kind regards,
Petr
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 8f895b726..6843c6eae 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -88,7 +88,7 @@ do_test()
 
 		$DEL_CMD || tst_brk TFAIL "fail to delete entry"
 
-		$SHOW_CMD | grep -q "${rhost}.*$(tst_hwaddr rhost)" && \
+		$SHOW_CMD | grep -q "$(tst_ipaddr rhost).*$(tst_hwaddr rhost)" && \
 			tst_brk TFAIL "'$DEL_CMD' failed, entry has " \
 				"$(tst_hwaddr rhost)' $i/$NUMLOOPS"
 	done
-- 
2.16.3

