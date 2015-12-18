From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:33 +0300
Subject: [LTP] [PATCH 5/7] pi_test: thread_sample: do not use the buffer
	explicitly
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-6-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This buffer is small to keep the output for a large number
of CPUs (100s). We might either allocate it dynamically or do not
use it at all.

Removing the buffer is easier, and I'm not sure we really
need the buffer at all. Therefore, I removed it.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |   26 ++++++++++++++-----
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index 41c8096..8c719e5 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -231,16 +231,22 @@ static void *thread_sample(void *arg)
 {
 	struct sample_param *sp = arg;
 	struct thread_param *tp = sp->tp;
-	char buffer[1024];
 	struct timespec ts;
 	double period = sp->period;
-	size_t size;
+	double reltime;
 	int i, j, rc;
 	int tplen = sp->tplen;
 	int priority = sp->priority;
+	unsigned int *progress;
 
 	test_set_priority(pthread_self(), SCHED_FIFO, priority);
 
+	progress = malloc(tplen * sizeof(*progress));
+	if (progress == NULL) {
+		EPRINTF("UNRESOLVED: malloc failed");
+		exit(UNRESOLVED);
+	}
+
 	DPRINTF(stderr, "Thread Sampler: started\n");
 	DPRINTF(stdout, "# COLUMNS %d Time ", 1 + tplen);
 	j = 0;
@@ -257,16 +263,22 @@ static void *thread_sample(void *arg)
 	ts.tv_nsec = period * 1000 * 1000;
 
 	while (!ts_stop) {
-		size = snprintf(buffer, 1023, "%f ", seconds_read() - base_time);
+		reltime = seconds_read() - base_time;
+		for (i = 0; i < tplen; i++)
+			progress[i] = tp[i].progress;
+
+		DPRINTF(stdout, "%f ", reltime);
 		for (i = 0; i < tplen; i++)
-			size +=
-			    snprintf(buffer + size, 1023 - size, "%u ",
-				     tp[i].progress);
-		DPRINTF(stdout, "%s\n", buffer);
+			DPRINTF(stdout, "%u ", progress[i]);
+		DPRINTF(stdout, "\n");
+
 		rc = nanosleep(&ts, NULL);
 		if (rc < 0)
 			EPRINTF("UNRESOLVED: Thread %s %d: nanosleep returned "
 				"%d %s", tp->name, tp->index, rc, strerror(rc));
 	}
+
+	free(progress);
+
 	return NULL;
 }
-- 
1.7.1

