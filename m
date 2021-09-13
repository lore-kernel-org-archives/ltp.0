From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon, 13 Sep 2021 19:37:43 +0300
Subject: [LTP] [PATCH v1 1/3] realtime:hrtimer-prio: fix misleading help
 message
Message-ID: <20210913163745.28108-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The argument "-m" had been removed years ago, but the help
message mistakenly offered to set "maximum timer
latency in microseconds".

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/hrtimer-prio/hrtimer-prio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
index 4ae49a713..cbc2343f6 100644
--- a/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
+++ b/testcases/realtime/func/hrtimer-prio/hrtimer-prio.c
@@ -76,9 +76,6 @@ void usage(void)
 	printf
 	    ("  -f#	   #:rt fifo priority of busy threads (1,98), defaults to %d\n",
 	     DEF_MED_PRIO);
-	printf
-	    ("  -m#	   #:maximum timer latency in microseconds, defaults to %d\n",
-	     DEF_CRITERIA);
 }
 
 int parse_args(int c, char *v)
-- 
2.32.0

