From: Li Wang <liwang@redhat.com>
Date: Thu, 23 Nov 2017 18:32:50 +0800
Subject: [LTP] [PATCH] fs_fill: create all the directories in setup()
	function
Message-ID: <20171123103250.18716-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is a follow up change for:
  commit 55a3c56bc6 (fs_fill: switch the SAFE MACROs back to ordinary syscall

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/fs/fs_fill/fs_fill.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index f592cd5..bb07ede 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -34,6 +34,7 @@
 static volatile int run;
 static unsigned int nthreads;
 static int enospc_cnt;
+static struct worker *workers;
 
 struct worker {
 	char dir[PATH_MAX];
@@ -41,21 +42,11 @@ struct worker {
 
 static void *worker(void *p)
 {
-	int ret;
 	struct worker *w = p;
 	DIR *d;
 	struct dirent *ent;
 	char file[PATH_MAX];
 
-	ret = mkdir(w->dir, 0700);
-	if (ret == -1) {
-		if (errno != ENOSPC)
-			tst_brk(TBROK | TERRNO, "mkdir()");
-
-		tst_res(TINFO | TERRNO, "mkdir()");
-		return NULL;
-	}
-
 	while (run) {
 		tst_fill_fs(w->dir, 0);
 
@@ -84,16 +75,12 @@ static void *worker(void *p)
 
 static void testrun(void)
 {
-	struct worker workers[nthreads];
 	pthread_t threads[nthreads];
 	unsigned int i, ms;
 
 	run = 1;
-	for (i = 0; i < nthreads; i++) {
-		snprintf(workers[i].dir, sizeof(workers[i].dir),
-			 MNTPOINT "/thread%i", i + 1);
+	for (i = 0; i < nthreads; i++)
 		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, &workers[i]);
-	}
 
 	for (ms = 0; ; ms++) {
 		usleep(1000);
@@ -114,11 +101,25 @@ static void testrun(void)
 
 static void setup(void)
 {
+	unsigned int i;
+
 	nthreads = tst_ncpus_conf() + 2;
+	workers = SAFE_MALLOC(sizeof(struct worker) * nthreads);
+
+	for (i = 0; i < nthreads; i++) {
+		snprintf(workers[i].dir, sizeof(workers[i].dir),
+			 MNTPOINT "/thread%i", i + 1);
+		SAFE_MKDIR(workers[i].dir, 0700);
+	}
 
 	tst_res(TINFO, "Running %i writer threads", nthreads);
 }
 
+static void cleanup(void)
+{
+	free(workers);
+}
+
 static struct tst_test test = {
 	.needs_root = 1,
 	.needs_tmpdir = 1,
@@ -126,5 +127,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = testrun,
 };
-- 
2.9.3

