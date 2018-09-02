From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Date: Sun, 2 Sep 2018 10:34:25 +0800
Subject: [LTP] [PATCH] change the default cmdfile to exec when exec runltp -N
Message-ID: <20180902023425.16264-1-lufq.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

when exec "runltp -N " and no command files were provided ,
the cmmand file of "$LTPROOT/scenario_groups/network" should execute,
not the "$LTPROOT/scenario_groups/default"

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 runltp | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runltp b/runltp
index 24ea94fe5..1810c9384 100755
--- a/runltp
+++ b/runltp
@@ -609,7 +609,7 @@ main()
 
 	SCENARIO_LISTS="$LTPROOT/scenario_groups/default"
         if [ "$RUN_NETEST" -eq 1 ]; then
-            SCENARIO_LISTS="$SCENARIO_LISTS $LTPROOT/scenario_groups/network"
+            SCENARIO_LISTS="$LTPROOT/scenario_groups/network"
         fi
 
     # DO NOT INDENT/DEDENT!
-- 
2.18.0



