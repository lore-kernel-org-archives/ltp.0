Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WHp7n-0001ej-Au
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 06:34:47 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WHp7k-0008IM-Co
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 06:34:47 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1O6YVcm021990
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Feb 2014 14:34:31 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 24 Feb 2014 14:33:00 +0800
Message-Id: <1393223580-28029-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: [LTP] [PATCH] direct_io/dma_thread_diotest7.c: cleanup
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

Cleanup of dma_thread_diotest7.c and remove test_dma_thread_diotest7.sh.

If user wants to run these tests, a big block device should be specified
by running runltp with -z option, or export an environment variable named
LTP_BIG_DEV, which contains the big block device.

Split tests in runtest/test_dma_thread_diotest7 into separate testcases,
keep one entry per test in runtest/test_dma_thread_diotest7

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/test_dma_thread_diotest7                   |   9 +-
 scenario_groups/default                            |   1 +
 .../kernel/io/direct_io/dma_thread_diotest7.c      | 354 +++++++++++----------
 .../io/direct_io/test_dma_thread_diotest7.sh       |  42 ---
 4 files changed, 194 insertions(+), 212 deletions(-)
 delete mode 100755 testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh

diff --git a/runtest/test_dma_thread_diotest7 b/runtest/test_dma_thread_diotest7
index cb5ea8f..5c3556e 100644
--- a/runtest/test_dma_thread_diotest7
+++ b/runtest/test_dma_thread_diotest7
@@ -1,2 +1,7 @@
-test_dma_thread_diotest7  mkdir -p /tmp/$$-work; cp -r $LTPROOT/testcases/bin/test_dma_thread_diotest7.sh $LTPROOT/testcases/bin/dma_thread_diotest7 /tmp/$$-work; (cd /tmp/$$-work; ./test_dma_thread_diotest7.sh); rm -rf /tmp/$$-work
-
+dma_thread_diotest7_1 dma_thread_diotest7 -a 512
+dma_thread_diotest7_2 dma_thread_diotest7 -a 1024
+dma_thread_diotest7_3 dma_thread_diotest7 -a 1536
+dma_thread_diotest7_4 dma_thread_diotest7 -a 2048
+dma_thread_diotest7_5 dma_thread_diotest7 -a 2560
+dma_thread_diotest7_6 dma_thread_diotest7 -a 3072
+dma_thread_diotest7_7 dma_thread_diotest7 -a 3584
diff --git a/scenario_groups/default b/scenario_groups/default
index ff23c7c..cdf9aca 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -26,3 +26,4 @@ commands
 hyperthreading
 kernel_misc
 modules
+test_dma_thread_diotest7
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest7.c b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
index 0b29b89..f9e730d 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest7.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
@@ -99,38 +99,51 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-
-#define FILESIZE (12*1024*1024)
-#define READSIZE  (1024*1024)
-
-#define FILENAME    "_dma_thread_test_%.04d.tmp"
-#define FILECOUNT   100
-#define MIN_WORKERS 2
-#define MAX_WORKERS 256
-#define PAGE_SIZE getpagesize()
-
-#define true	1
-#define false	0
-
-typedef int bool;
-
-bool done = false;
-int workers = 2;
-
-#define PATTERN (0xfa)
-
-static void usage(void)
-{
-	fprintf(stderr,
-		"\nUsage: dma_thread [-h | -a <alignment> [ -w <workers>]\n"
-		"\nWith no arguments, generate test files and exit.\n"
-		"-h Display this help and exit.\n"
-		"-a align read buffer to offset <alignment>.\n"
-		"-w number of worker threads, 2 (default) to 256,\n"
-		"   defaults to number of cores.\n\n"
-		"Run first with no arguments to generate files.\n"
-		"Then run with -a <alignment> = 512  or 0. \n");
-}
+#include <sys/mount.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+#define FILESIZE	(12*1024*1024)
+#define READSIZE	(1024*1024)
+
+#define MNT_POINT	"mntpoint"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define FILENAME	"mntpoint/_dma_thread_test_%.04d.tmp"
+#define FILECOUNT	50
+#define MIN_WORKERS	2
+#define MAX_WORKERS	256
+#define PATTERN		(0xfa)
+#define PAGE_SIZE	getpagesize()
+
+char *TCID = "dma_thread_diotest7";
+int TST_TOTAL = 1;
+
+static void setup(void);
+static void dma_thread_diotest_verify(void);
+static void cleanup(void);
+static void help(void);
+
+static unsigned char *buffer;
+
+static char *align_str;
+static int align;
+static int aflag;
+static char *workers_str;
+static int workers;
+static int wflag;
+static char *device;
+static int mount_flag;
+static option_t options[] = {
+	{"a:", &aflag, &align_str},
+	{"w:", &wflag, &workers_str},
+	{NULL, NULL, NULL}
+};
+
+static volatile int done;
+static volatile int tst_result;
 
 typedef struct {
 	pthread_t tid;
@@ -141,12 +154,13 @@ typedef struct {
 	int pattern;
 	unsigned char *buffer;
 } worker_t;
+static worker_t *worker;
 
-void *worker_thread(void *arg)
+static void *worker_thread(void *arg)
 {
-	int bytes_read;
 	int i, k;
-	worker_t *worker = (worker_t *) arg;
+	int nread;
+	worker_t *worker = (worker_t *)arg;
 	int offset = worker->offset;
 	int fd = worker->fd;
 	unsigned char *buffer = worker->buffer;
@@ -156,14 +170,13 @@ void *worker_thread(void *arg)
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		fprintf(stderr, "Failed to lseek to %d on fd %d: %s.\n",
 			offset, fd, strerror(errno));
-		exit(1);
+		return NULL;
 	}
 
-	bytes_read = read(fd, buffer, length);
-	if (bytes_read != length) {
-		fprintf(stderr, "read failed on fd %d: bytes_read %d, %s\n",
-			fd, bytes_read, strerror(errno));
-		exit(1);
+	nread = read(fd, buffer, length);
+	if (nread == -1 || nread != length) {
+		fprintf(stderr, "read failed in worker thread%d: %s",
+			worker->worker_number, strerror(errno));
 	}
 
 	/* Corruption check */
@@ -182,24 +195,25 @@ void *worker_thread(void *arg)
 			}
 
 			printf("\n");
-			abort();
+			tst_result = 1;
 		}
 	}
 
 	return 0;
 }
 
-void *fork_thread(void *arg)
+static void *fork_thread(void *arg)
 {
 	pid_t pid;
 
 	while (!done) {
-		pid = fork();
+		pid = tst_fork();
 		if (pid == 0) {
 			exit(0);
 		} else if (pid < 0) {
-			fprintf(stderr, "Failed to fork child.\n");
-			exit(1);
+			fprintf(stderr, "Failed to fork child: %s.\n",
+				strerror(errno));
+			return NULL;
 		}
 		waitpid(pid, NULL, 0);
 		usleep(100);
@@ -211,122 +225,42 @@ void *fork_thread(void *arg)
 
 int main(int argc, char *argv[])
 {
-	unsigned char *buffer = NULL;
-	char filename[1024];
-	int fd;
-	bool dowrite = true;
-	pthread_t fork_tid;
-	int c, n, j;
-	worker_t *worker;
-	int align = 0;
-	int offset, rc;
+	int i, lc;
+	char *msg;
 
 	workers = sysconf(_SC_NPROCESSORS_ONLN);
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	while ((c = getopt(argc, argv, "a:hw:")) != -1) {
-		switch (c) {
-		case 'a':
-			align = atoi(optarg);
-			if (align < 0 || align > PAGE_SIZE) {
-				printf("Bad alignment %d.\n", align);
-				exit(1);
-			}
-			dowrite = false;
-			break;
-
-		case 'h':
-			usage();
-			exit(0);
-			break;
-
-		case 'w':
-			workers = atoi(optarg);
-			if (workers < MIN_WORKERS || workers > MAX_WORKERS) {
-				fprintf(stderr, "Worker count %d not between "
-					"%d and %d, inclusive.\n",
-					workers, MIN_WORKERS, MAX_WORKERS);
-				usage();
-				exit(1);
-			}
-			dowrite = false;
-			break;
-
-		default:
-			usage();
-			exit(1);
-		}
-	}
-
-	if (argc > 1 && (optind < argc)) {
-		fprintf(stderr, "Bad command line.\n");
-		usage();
-		exit(1);
-	}
-
-	if (dowrite) {
-
-		buffer = malloc(FILESIZE);
-		if (buffer == NULL) {
-			fprintf(stderr, "Failed to malloc write buffer.\n");
-			exit(1);
-		}
+	setup();
 
-		for (n = 1; n <= FILECOUNT; n++) {
-			sprintf(filename, FILENAME, n);
-			fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
-			if (fd < 0) {
-				printf("create failed(%s): %s.\n", filename,
-				       strerror(errno));
-				exit(1);
-			}
-			memset(buffer, n, FILESIZE);
-			printf("Writing file %s.\n", filename);
-			if (write(fd, buffer, FILESIZE) != FILESIZE) {
-				printf("write failed (%s)\n", filename);
-			}
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
 
-			close(fd);
-			fd = -1;
-		}
-
-		free(buffer);
-		buffer = NULL;
-
-		printf("done\n");
-		exit(0);
+		for (i = 0; i < TST_TOTAL; i++)
+			dma_thread_diotest_verify();
 	}
 
-	printf("Using %d workers.\n", workers);
-
-	worker = malloc(workers * sizeof(worker_t));
-	if (worker == NULL) {
-		fprintf(stderr, "Failed to malloc worker array.\n");
-		exit(1);
-	}
-
-	for (j = 0; j < workers; j++) {
-		worker[j].worker_number = j;
-	}
+	cleanup();
+	tst_exit();
+}
 
-	printf("Using alignment %d.\n", align);
+static void dma_thread_diotest_verify(void)
+{
+	int n, j, offset, rc;
+	char filename[PATH_MAX];
+	pthread_t fork_tid;
 
-	posix_memalign((void *)&buffer, PAGE_SIZE, READSIZE + align);
-	printf("Read buffer: %p.\n", buffer);
 	for (n = 1; n <= FILECOUNT; n++) {
-
 		sprintf(filename, FILENAME, n);
 		for (j = 0; j < workers; j++) {
-			if ((worker[j].fd =
-			     open(filename, O_RDONLY | O_DIRECT)) < 0) {
-				fprintf(stderr, "Failed to open %s: %s.\n",
-					filename, strerror(errno));
-				exit(1);
-			}
-
+			worker[j].fd = SAFE_OPEN(cleanup, filename,
+						 O_RDONLY | O_DIRECT);
 			worker[j].pattern = n;
 		}
 
-		printf("Reading file %d.\n", n);
+		tst_resm(TINFO, "Reading file %d.", n);
 
 		for (offset = 0; offset < FILESIZE; offset += READSIZE) {
 			memset(buffer, PATTERN, READSIZE + align);
@@ -344,31 +278,26 @@ int main(int argc, char *argv[])
 
 			rc = pthread_create(&fork_tid, NULL, fork_thread, NULL);
 			if (rc != 0) {
-				fprintf(stderr,
-					"Can't create fork thread: %s.\n",
-					strerror(rc));
-				exit(1);
+				tst_brkm(TBROK, cleanup, "pthread_create "
+					 "failed: %s", strerror(rc));
 			}
 
 			for (j = 0; j < workers; j++) {
-				rc = pthread_create(&worker[j].tid,
-						    NULL,
+				rc = pthread_create(&worker[j].tid, NULL,
 						    worker_thread, worker + j);
 				if (rc != 0) {
-					fprintf(stderr,
-						"Can't create worker thread %d: %s.\n",
-						j, strerror(rc));
-					exit(1);
+					tst_brkm(TBROK, cleanup, "Can't create"
+						 "worker thread %d: %s",
+						 j, strerror(rc));
 				}
 			}
 
 			for (j = 0; j < workers; j++) {
 				rc = pthread_join(worker[j].tid, NULL);
 				if (rc != 0) {
-					fprintf(stderr,
-						"Failed to join worker thread %d: %s.\n",
-						j, strerror(rc));
-					exit(1);
+					tst_brkm(TBROK, cleanup, "Failed to "
+						 "join worker thread %d: %s.",
+						 j, strerror(rc));
 				}
 			}
 
@@ -377,18 +306,107 @@ int main(int argc, char *argv[])
 
 			rc = pthread_join(fork_tid, NULL);
 			if (rc != 0) {
-				fprintf(stderr,
-					"Failed to join fork thread: %s.\n",
-					strerror(rc));
-				exit(1);
+				tst_brkm(TBROK, cleanup,
+					 "Failed to join fork thread: %s.",
+					 strerror(rc));
 			}
 		}
 
 		/* Close the fd's for the next file. */
-		for (j = 0; j < workers; j++) {
-			close(worker[j].fd);
+		for (j = 0; j < workers; j++)
+			SAFE_CLOSE(cleanup, worker[j].fd);
+		if (tst_result)
+			break;
+	}
+
+	if (tst_result)
+		tst_resm(TINFO, "data corruption is detected");
+	else
+		tst_resm(TINFO, "data corruption is not detected");
+
+	tst_resm(TPASS, "dma_thread_diotest test completed");
+}
+
+static void setup(void)
+{
+	char *tmpbuffer;
+	char filename[PATH_MAX];
+	int n, fd, j;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_require_root(NULL);
+
+	device = getenv("LTP_BIG_DEV");
+	if (device == NULL) {
+		tst_brkm(TCONF, NULL,
+			 "you must specify a big blockdevice(>1.2G)");
+	} else {
+		tst_mkfs(NULL, device, "ext3", NULL);
+	}
+
+	TEST_PAUSE;
+
+	if (aflag) {
+		align = atoi(align_str);
+		if (align < 0 || align > PAGE_SIZE)
+			tst_brkm(TCONF, NULL, "Bad alignment %d.", align);
+	}
+	tst_resm(TINFO, "using alignment %d", align);
+
+	if (wflag) {
+		workers = atoi(workers_str);
+		if (workers < MIN_WORKERS || workers > MAX_WORKERS) {
+			tst_brkm(TCONF, NULL, "Worker count %d not between "
+				 "%d and %d, inclusive",
+				 workers, MIN_WORKERS, MAX_WORKERS);
 		}
 	}
+	tst_resm(TINFO, "using %d workers.", workers);
 
-	return 0;
+	tst_tmpdir();
+
+	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+
+	worker = SAFE_MALLOC(cleanup, workers * sizeof(worker_t));
+
+	for (j = 0; j < workers; j++)
+		worker[j].worker_number = j;
+
+	if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
+		tst_brkm(TBROK | TERRNO, cleanup,
+			 "mount device:%s failed", device);
+	}
+	mount_flag = 1;
+
+	tmpbuffer = SAFE_MALLOC(cleanup, FILESIZE);
+
+	for (n = 1; n <= FILECOUNT; n++) {
+		sprintf(filename, FILENAME, n);
+		fd = SAFE_OPEN(cleanup, filename,
+			       O_RDWR | O_CREAT | O_TRUNC, 0666);
+		memset(tmpbuffer, n, FILESIZE);
+		SAFE_WRITE(cleanup, 1, fd, tmpbuffer, FILESIZE);
+		SAFE_CLOSE(cleanup, fd);
+	}
+	free(tmpbuffer);
+
+	if (posix_memalign((void *)&buffer, PAGE_SIZE, READSIZE + align) != 0)
+		tst_brkm(TBROK, cleanup, "call posix_memalign failed");
+}
+
+static void cleanup(void)
+{
+	free(buffer);
+
+	if (mount_flag && umount(MNT_POINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
+	free(worker);
+}
+
+static void help(void)
+{
+	printf("-a align read buffer to offset <alignment>.\n");
+	printf("-w number of worker threads, 2 (default) to 256,"
+	       " defaults to number of cores.\n");
 }
diff --git a/testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh b/testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh
deleted file mode 100755
index 9f4e0e5..0000000
--- a/testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh
+++ /dev/null
@@ -1,42 +0,0 @@
-#! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
-## Copyright (c) Li Zefan <lizf@cn.fujitsu.com>, 2009                         ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##                                                                            ##
-################################################################################
-
-export TCID=dma_thread_diotest7
-export TST_TOTAL=3
-export TST_COUNT=3
-
-tst_resm TINFO "Generating Test Files"
-./dma_thread_diotest7
-
-# test different alignments: 512, 1024, ..., (4096-512)
-for i in $(seq 512 512 4095)
-do
-        tst_resm TINFO "i=$i"
-        ./dma_thread_diotest7 -a="$i"
-        if [ $? -ne 0 ]; then
-             tst_res TFAIL "Test Failed"
-             exit 1
-        else
-             tst_resm TPASS "Test Passed"
-        fi
-done
-exit 0;
-- 
1.8.2.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
