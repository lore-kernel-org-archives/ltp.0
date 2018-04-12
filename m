From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Apr 2018 11:27:55 +0800
Subject: [LTP] [PATCH v3] read_all: give more time to wait children finish
	read action
Message-ID: <20180412032755.4131-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. We get the following worker stalled messges in test:
 # ./read_all -d /sys -q -r 10
   tst_test.c:987: INFO: Timeout per run is 0h 05m 00s
   read_all.c:280: BROK: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26075 is stalled
   read_all.c:280: WARN: Worker 26079 is stalled
   read_all.c:280: WARN: Worker 26087 is stalled

The reason is that some children are still working on the read I/O but
parent trys to stopping them after visit_dir() immediately. Although
the stop_attemps is 65535, it still sometimes fails.

Instead, we use an exponential backoff way to loop the stop operation
in limited seconds.

2. The sched_work() push action in a infinite loop, here also let it
trys in limited time.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/fs/read_all/read_all.c | 35 ++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index b7ed540..32ab4e8 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -57,6 +57,7 @@
 #define BUFFER_SIZE 1024
 #define MAX_PATH 4096
 #define MAX_DISPLAY 40
+#define SECOND 1000000
 
 struct queue {
 	sem_t sem;
@@ -265,21 +266,22 @@ static void spawn_workers(void)
 static void stop_workers(void)
 {
 	const char stop_code[1] = { '\0' };
-	int i, stop_attempts;
+	int i, delay = 1;
 
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
+		if (!workers[i].q)
+			continue;
+		while (!queue_push(workers[i].q, stop_code)) {
+			if (delay < SECOND) {
+				usleep(delay);
+				delay *= 2;
+			} else {
+				tst_brk(TBROK,
+					"Worker %d is stalled",
+					workers[i].pid);
 			}
 		}
 	}
@@ -295,7 +297,7 @@ static void stop_workers(void)
 static void sched_work(const char *path)
 {
 	static int cur;
-	int push_attempts = 0, pushed;
+	int push_attempts = 0, pushed, delay = 1;
 
 	while (1) {
 		pushed = queue_push(workers[cur].q, path);
@@ -306,9 +308,14 @@ static void sched_work(const char *path)
 		if (pushed)
 			break;
 
-		if (++push_attempts > worker_count) {
-			usleep(100);
-			push_attempts = 0;
+		if (delay < SECOND) {
+			push_attempts++;
+			usleep(delay);
+			delay *= 2;
+		} else {
+			tst_brk(TBROK,
+				"Attempted %d times but still failed to push %s",
+				push_attempts, path);
 		}
 	}
 }
-- 
2.9.3

