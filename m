From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  9 Oct 2019 12:29:48 +0200
Subject: [LTP] [PATCH] read_all: retry to queue work for any worker
Message-ID: <26d555b1d9deddb5a6f0a93a7c7d3b00e8abc1ff.1570616598.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

read_all is currently retrying only for short time period and it's
retrying to queue for same worker. If that worker is busy, it easily
hits timeout.

For example 'kernel_page_tables' on aarch64 can take long time to open/read:
  # time dd if=/sys/kernel/debug/kernel_page_tables of=/dev/null count=1 bs=1024
  1+0 records in
  1+0 records out
  1024 bytes (1.0 kB, 1.0 KiB) copied, 13.0531 s, 0.1 kB/s

  real    0m13.066s
  user    0m0.000s
  sys     0m13.059s

Rather than retrying to queue for specific worker, pick any that can accept
the work and keep trying until we succeed or hit test timeout.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 3dac20e02638..4bce4521ace7 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -282,6 +282,33 @@ static void spawn_workers(void)
 	}
 }
 
+static void work_push_retry(int worker, const char *buf)
+{
+	int i, ret, worker_min, worker_max;
+
+	if (worker < 0) {
+		/* pick any, try -worker first */
+		worker_min = worker * (-1);
+		worker_max = worker_count;
+	} else {
+		/* keep trying worker */
+		worker_min = worker;
+		worker_max = worker + 1;
+	}
+	i = worker_min;
+
+	for (;;) {
+		ret = queue_push(workers[i].q, buf);
+		if (ret == 1)
+			break;
+
+		if (++i >= worker_max) {
+			i = worker_min;
+			usleep(100000);
+		}
+	}
+}
+
 static void stop_workers(void)
 {
 	const char stop_code[1] = { '\0' };
@@ -292,7 +319,7 @@ static void stop_workers(void)
 
 	for (i = 0; i < worker_count; i++) {
 		if (workers[i].q)
-			TST_RETRY_FUNC(queue_push(workers[i].q, stop_code), 1);
+			work_push_retry(i, stop_code);
 	}
 
 	for (i = 0; i < worker_count; i++) {
@@ -310,7 +337,7 @@ static void rep_sched_work(const char *path, int rep)
 	for (i = j = 0; i < rep; i++, j++) {
 		if (j >= worker_count)
 			j = 0;
-		TST_RETRY_FUNC(queue_push(workers[j].q, path), 1);
+		work_push_retry(-j, path);
 	}
 }
 
-- 
1.8.3.1

