From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 25 Sep 2017 11:51:36 +0200
Subject: [LTP] [PATCH v4 6/7] Convert cve-2014-0196 to use long running
	threads
In-Reply-To: <20170925095137.31491-1-rpalethorpe@suse.com>
References: <20170925095137.31491-1-rpalethorpe@suse.com>
Message-ID: <20170925095137.31491-6-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/cve/cve-2014-0196.c | 50 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 4e2b3f582..68302295e 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -51,11 +51,13 @@
 #define ATTEMPTS      0x7000
 #define BUFLEN        512
 
-static int master_fd, slave_fd;
+static volatile int master_fd, slave_fd;
 static int filler_ptys[ONEOFF_ALLOCS * 2];
 static int target_ptys[RUN_ALLOCS * 2];
 static char buf[BUFLEN];
 
+static pthread_t overwrite_thread;
+static void *overwrite_thread_fn(void *);
 static struct tst_fzsync_pair fzsync_pair = TST_FZSYNC_PAIR_INIT;
 
 static void create_pty(int *amaster, int *aslave)
@@ -68,35 +70,40 @@ static void setup(void)
 {
 	int i;
 
-	fzsync_pair.delay_inc = 100;
 	for (i = 0; i < ONEOFF_ALLOCS; i++) {
 		create_pty(&filler_ptys[i],
 			   &filler_ptys[i + ONEOFF_ALLOCS]);
 	}
+
+	fzsync_pair.info_gap = 0xFFF;
+	SAFE_PTHREAD_CREATE(&overwrite_thread, NULL,
+			    overwrite_thread_fn, NULL);
 }
 
-static void *overwrite_thread_fn(void *p)
+static void *overwrite_thread_fn(void *p LTP_ATTRIBUTE_UNUSED)
 {
-	tst_fzsync_delay_b(&fzsync_pair);
-	tst_fzsync_time_b(&fzsync_pair);
-
-	SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
-	SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
-	SAFE_WRITE(0, slave_fd, buf, BUFLEN);
-
-	return p;
+	while(tst_fzsync_wait_update_b(&fzsync_pair)) {
+		tst_fzsync_delay_b(&fzsync_pair);
+		tst_fzsync_time_b(&fzsync_pair);
+
+		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
+		SAFE_WRITE(0, slave_fd, buf, BUFLEN - 1);
+		SAFE_WRITE(0, slave_fd, buf, BUFLEN);
+		if (!tst_fzsync_wait_b(&fzsync_pair))
+			break;
+	}
+	return 0;
 }
 
 static void run(void)
 {
 	struct termios t;
-	pthread_t overwrite_thread;
 	int i, j;
 
 	tst_res(TINFO, "Attempting to overflow into a tty_struct...");
 
 	for (i = 0; i < ATTEMPTS; i++) {
-		create_pty(&master_fd, &slave_fd);
+		create_pty((int *)&master_fd, (int *)&slave_fd);
 
 		for (j = 0; j < RUN_ALLOCS; j++)
 			create_pty(&target_ptys[j],
@@ -111,20 +118,12 @@ static void run(void)
 		t.c_lflag |= ECHO;
 		tcsetattr(master_fd, TCSANOW, &t);
 
-		SAFE_PTHREAD_CREATE(&overwrite_thread, NULL,
-				    overwrite_thread_fn, NULL);
+		tst_fzsync_wait_update_a(&fzsync_pair);
 
 		tst_fzsync_delay_a(&fzsync_pair);
 		tst_fzsync_time_a(&fzsync_pair);
 		SAFE_WRITE(0, master_fd, "A", 1);
 
-		SAFE_PTHREAD_JOIN(overwrite_thread, NULL);
-
-		tst_fzsync_pair_update(i, &fzsync_pair);
-
-		if (!(i & 0x1FFF))
-			tst_fzsync_pair_info(&fzsync_pair);
-
 		for (j = 0; j < RUN_ALLOCS; j++) {
 			if (j == RUN_ALLOCS / 2)
 				continue;
@@ -139,6 +138,8 @@ static void run(void)
 		ioctl(slave_fd, 0xdeadbeef);
 		SAFE_CLOSE(master_fd);
 		SAFE_CLOSE(slave_fd);
+
+		tst_fzsync_wait_a(&fzsync_pair);
 	}
 
 	tst_res(TPASS, "Nothing bad happened, probably.");
@@ -148,6 +149,11 @@ static void cleanup(void)
 {
 	int i;
 
+	if (overwrite_thread) {
+		tst_fzsync_pair_exit(&fzsync_pair);
+		SAFE_PTHREAD_JOIN(overwrite_thread, NULL);
+	}
+
 	for (i = 0; i < ONEOFF_ALLOCS * 2; i++)
 		close(filler_ptys[i]);
 	close(master_fd);
-- 
2.14.1

