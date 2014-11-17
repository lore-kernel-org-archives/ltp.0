Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xuw@redhat.com>) id 1XqOor-0002hJ-AT
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:06:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XqOoq-0005C9-29
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 16:06:25 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sAHG6HmT026406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 11:06:18 -0500
From: xuw@redhat.com
Date: Tue, 18 Nov 2014 00:06:13 +0800
Message-Id: <1416240373-7693-1-git-send-email-xuw@redhat.com>
Subject: [LTP] [PATCH V2] fs/openfile: refactor code based on ltp rules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

From: George Wang <xuw@redhat.com>

Signed-off-by: George Wang <xuw@redhat.com>
---
 testcases/kernel/fs/openfile/openfile.c | 149 +++++++++++---------------------
 1 file changed, 49 insertions(+), 100 deletions(-)

diff --git a/testcases/kernel/fs/openfile/openfile.c b/testcases/kernel/fs/openfile/openfile.c
index 8657064..82ff1f7 100644
--- a/testcases/kernel/fs/openfile/openfile.c
+++ b/testcases/kernel/fs/openfile/openfile.c
@@ -38,7 +38,7 @@
 #include "test.h"
 #include "usctest.h"
 
-char *TCID = "openfile01";	/* Test program identifier.    */
+char *TCID = "openfile01";
 int TST_TOTAL = 1;
 
 #define MAXFILES        32768
@@ -52,33 +52,38 @@ struct cb {
 	int thr_sleeping;
 } c;
 
-/* Global Variables */
 int numthreads = 10, numfiles = 10;
 int debug = 0;
 char *filename = "FILETOOPEN";
+FILE *fd = NULL;
 
-void setup(void)
+void cleanup(void)
 {
-	tst_tmpdir();
+	if (fd)
+		fclose(fd);
+	tst_rmdir();
+
 }
 
-void cleanup(void)
+void setup(void)
 {
-	tst_rmdir();
+	tst_tmpdir();
+
+	if ((fd = fopen(filename, "w")) == NULL)
+		tst_brkm(TBROK, NULL, "Could not create file");
 
+	pthread_mutex_init(&c.m, NULL);
+	pthread_cond_init(&c.init_cv, NULL);
+	pthread_cond_init(&c.thr_cv, NULL);
+	c.thr_sleeping = 0;
 }
 
-/* Procedures */
-void *threads(void *thread_id);
 
-/* **************************************************************************
- *                              MAIN PROCEDURE                            *
- ************************************************************************** */
+void *threads(void *thread_id);
 
 int main(int argc, char *argv[])
 {
 	int i, opt, badopts = 0;
-	FILE *fd;
 	pthread_t th_id;
 	char msg[80] = "";
 	extern char *optarg;
@@ -101,100 +106,57 @@ int main(int argc, char *argv[])
 		case 'h':
 		default:
 			printf("Usage: openfile [-d] -f FILES -t THREADS\n");
-			_exit(1);
+			tst_brkm(TBROK, NULL, "PARSE OPTION");
 		}
 	}
-	if (badopts) {
-		printf("Usage: openfile [-d] -f FILES -t THREADS\n");
-		_exit(1);
-	}
-
-	setup();
+	if (badopts)
+		tst_brkm(TBROK, NULL, "Usage: openfile [-d] -f FILES -t THREADS");
 
-	/* Check if numthreads is less than MAXFILES */
 	if (numfiles > MAXFILES) {
 		sprintf(msg, "%s\nCannot use %d files", msg, numfiles);
 		sprintf(msg, "%s, used %d files instead\n", msg, MAXFILES);
 		numfiles = MAXFILES;
 	}
 
-	/* Check if numthreads is less than MAXTHREADS */
 	if (numthreads > MAXTHREADS) {
 		sprintf(msg, "%s\nCannot use %d threads", msg, numthreads);
 		sprintf(msg, "%s, used %d threads instead\n", msg, MAXTHREADS);
 		numthreads = MAXTHREADS;
 	}
 
-	/* Create files */
-	if ((fd = fopen(filename, "w")) == NULL) {
-		tst_resm(TFAIL, "Could not create file");
-		cleanup();
-	}
-
-	/* Initialize thread control variables, lock & condition */
-	pthread_mutex_init(&c.m, NULL);
-	pthread_cond_init(&c.init_cv, NULL);
-	pthread_cond_init(&c.thr_cv, NULL);
-	c.thr_sleeping = 0;
+	setup();
 
-	/* Grab mutex lock */
-	if (pthread_mutex_lock(&c.m)) {
-		tst_resm(TFAIL, "failed to grab mutex lock");
-		fclose(fd);
-		unlink(filename);
-		cleanup();
-	}
+	if (pthread_mutex_lock(&c.m))
+		tst_brkm(TBROK, cleanup, "failed to grab mutex lock");
 
 	printf("Creating Reading Threads\n");
 
 	/* Create threads */
-	for (i = 0; i < numthreads; i++)
-		if (pthread_create(&th_id, NULL, threads,
-				   (void *)(uintptr_t) i)) {
-			tst_resm(TFAIL,
-				 "failed creating a pthread; increase limits");
-			fclose(fd);
-			unlink(filename);
-			cleanup();
-		}
+	for (i = 0; i < numthreads; i++) {
+		if (pthread_create(&th_id, NULL, threads, (void *)(uintptr_t) i))
+			tst_brkm(TFAIL, cleanup, "failed creating a pthread; increase limits");
+	}
 
 	/* Sleep until all threads are created */
-	while (c.thr_sleeping != numthreads)
-		if (pthread_cond_wait(&c.init_cv, &c.m)) {
-			tst_resm(TFAIL,
-				 "error while waiting for reading threads");
-			fclose(fd);
-			unlink(filename);
-			cleanup();
-		}
+	while (c.thr_sleeping != numthreads) {
+		if (pthread_cond_wait(&c.init_cv, &c.m))
+			tst_brkm(TFAIL, cleanup, "error while waiting for reading threads");
+	}
 
 	/* Wake up all threads */
-	if (pthread_cond_broadcast(&c.thr_cv)) {
-		tst_resm(TFAIL, "failed trying to wake up reading threads");
-		fclose(fd);
-		unlink(filename);
-		cleanup();
-	}
+	if (pthread_cond_broadcast(&c.thr_cv))
+		tst_brkm(TFAIL, cleanup, "failed trying to wake up reading threads");
+
 	/* Release mutex lock */
-	if (pthread_mutex_unlock(&c.m)) {
-		tst_resm(TFAIL, "failed to release mutex lock");
-		fclose(fd);
-		unlink(filename);
-		cleanup();
-	}
+	if (pthread_mutex_unlock(&c.m))
+		tst_brkm(TFAIL, cleanup, "failed to release mutex lock");
 
 	tst_resm(TPASS, "Threads are done reading");
 
-	fclose(fd);
-	unlink(filename);
 	cleanup();
-	_exit(0);
+	tst_exit();
 }
 
-/* **************************************************************************
- *				OTHER PROCEDURES			    *
- ************************************************************************** */
-
 void close_files(FILE * fd_list[], int len)
 {
 	int i;
@@ -210,8 +172,8 @@ void *threads(void *thread_id_)
 	char errmsg[80];
 	FILE *fd_list[MAXFILES];
 	int i;
+	int rs = 1;
 
-	/* Open files */
 	for (i = 0; i < numfiles; i++) {
 		if (debug)
 			printf("Thread  %d : Opening file number %d \n",
@@ -219,49 +181,36 @@ void *threads(void *thread_id_)
 		if ((fd_list[i] = fopen(filename, "rw")) == NULL) {
 			sprintf(errmsg, "FAIL - Couldn't open file #%d", i);
 			perror(errmsg);
-			if (i > 0) {
-				close_files(fd_list, i - 1);
-			}
-			unlink(filename);
-			pthread_exit((void *)1);
+			goto ret;
 		}
 	}
 
-	/* Grab mutex lock */
 	if (pthread_mutex_lock(&c.m)) {
 		perror("FAIL - failed to grab mutex lock");
-		close_files(fd_list, numfiles);
-		unlink(filename);
-		pthread_exit((void *)1);
+		goto ret;
 	}
 
 	/* Check if you should wake up main thread */
 	if (++c.thr_sleeping == numthreads)
 		if (pthread_cond_signal(&c.init_cv)) {
 			perror("FAIL - failed to signal main thread");
-			close_files(fd_list, numfiles);
-			unlink(filename);
-			pthread_exit((void *)1);
+			goto ret;
 		}
 
-	/* Sleep until woken up */
 	if (pthread_cond_wait(&c.thr_cv, &c.m)) {
 		perror("FAIL - failed to wake up correctly");
-		close_files(fd_list, numfiles);
-		unlink(filename);
-		pthread_exit((void *)1);
+		goto ret;
 	}
 
-	/* Release mutex lock */
 	if (pthread_mutex_unlock(&c.m)) {
 		perror("FAIL - failed to release mutex lock");
-		close_files(fd_list, numfiles);
-		unlink(filename);
-		pthread_exit((void *)1);
+		goto ret;
 	}
+	
+	rs = 0;
+
+ret:
 
-	/* Close file handles and exit */
-	close_files(fd_list, numfiles);
-	unlink(filename);
-	pthread_exit(NULL);
+	close_files(fd_list, i);
+	pthread_exit((void *)rs);
 }
-- 
1.8.4.2


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
