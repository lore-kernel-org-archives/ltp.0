From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  7 Jan 2021 13:02:47 +0100
Subject: [LTP] [PATCH 1/1] if-mtu-change.sh: Lower CHANGE_INTERVAL to 1
Message-ID: <20210107120247.31465-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to make testing faster.

Tested only on netns based testing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Alexey,

any reason why CHANGE_INTERVAL was set 5s?

It'd be nice to speedup the tests, which were slow even before
2d422edbf ("if-mtu-change.sh: Add max packet size detection for IPv4")
which added 25% slowdown.

Could you please test this on two host based setup?

Kind regards,
Petr

 testcases/network/stress/interface/if-mtu-change.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/interface/if-mtu-change.sh b/testcases/network/stress/interface/if-mtu-change.sh
index d2816606b..3efe00461 100755
--- a/testcases/network/stress/interface/if-mtu-change.sh
+++ b/testcases/network/stress/interface/if-mtu-change.sh
@@ -11,7 +11,7 @@ TST_CLEANUP="do_cleanup"
 . if-lib.sh
 
 # The interval of the mtu change [second]
-CHANGE_INTERVAL=${CHANGE_INTERVAL:-5}
+CHANGE_INTERVAL=${CHANGE_INTERVAL:-1}
 
 TST_TIMEOUT=$(((CHANGE_INTERVAL + 30) * MTU_CHANGE_TIMES))
 
-- 
2.29.2

