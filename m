From: Li Wang <liwang@redhat.com>
Date: Sat, 21 Apr 2018 10:16:00 +0800
Subject: [LTP] [PATCH v3 2/2] read_all: wait children I/O reading in limited
	time
Message-ID: <20180421021600.17549-2-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

read_all reports some stalled messges in test:
 # ./read_all -d /sys -q -r 10
   tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
   read_all.c:280: BROK: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26079 is stalled
   read_all.c:280: WARN: Worker 26087 is stalled

The reason is that some children are still working on the read
I/O but parent trys to stopping them after visit_dir immediately.
Although the stop_attemps is 65535, it still sometimes fails.

Instead, we take use of TST_RETRY_FUNC maroc to loop the stop
operation in limited seconds to wait children I/O.

And, the sched_work push action in an infinite loop, here merge it
into rep_sched_work with using TST_RETRY_FUNC macro.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    Hi Cyril and Richard,
    
    The purpose of this patch is to replace the old one[1] to solve
    the children I/O issue. Please could you consider to merge or
    comment on the change of using new marco.
    
    [1] http://lists.linux.it/pipermail/ltp/2018-April/007704.html

 testcases/kernel/fs/read_all/read_all.c | 45 +++++++--------------------------
 1 file changed, 9 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index b7ed540..b420e37 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -265,23 +265,14 @@ static void spawn_workers(void)
 static void stop_workers(void)
 {
 	const char stop_code[1] = { '\0' };
-	int i, stop_attempts;
+	int i;
 
 	if (!workers)
 		return;
 
 	for (i = 0; i < worker_count; i++) {
-		stop_attempts = 0xffff;
-		if (workers[i].q) {
-			while (!queue_push(workers[i].q, stop_code)) {
-				if (--stop_attempts < 0) {
-					tst_brk(TBROK,
-						"Worker %d is stalled",
-						workers[i].pid);
-					break;
-				}
-			}
-		}
+		if (workers[i].q)
+			TST_RETRY_FUNC(queue_push(workers[i].q, stop_code), 1);
 	}
 
 	for (i = 0; i < worker_count; i++) {
@@ -292,33 +283,15 @@ static void stop_workers(void)
 	}
 }
 
-static void sched_work(const char *path)
-{
-	static int cur;
-	int push_attempts = 0, pushed;
-
-	while (1) {
-		pushed = queue_push(workers[cur].q, path);
-
-		if (++cur >= worker_count)
-			cur = 0;
-
-		if (pushed)
-			break;
-
-		if (++push_attempts > worker_count) {
-			usleep(100);
-			push_attempts = 0;
-		}
-	}
-}
-
 static void rep_sched_work(const char *path, int rep)
 {
-	int i;
+	int i, j;
 
-	for (i = 0; i < rep; i++)
-		sched_work(path);
+	for (i = j = 0; i < rep; i++, j++) {
+		if (j >= worker_count)
+			j = 0;
+		TST_RETRY_FUNC(queue_push(workers[j].q, path), 1);
+	}
 }
 
 static void setup(void)
-- 
2.9.3

