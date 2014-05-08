Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WiNUR-00014r-TD
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 12:31:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WiNUO-0008U3-UA
	for ltp-list@lists.sourceforge.net; Thu, 08 May 2014 12:31:55 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s48CUhEY025819
	for <ltp-list@lists.sourceforge.net>; Thu, 8 May 2014 20:30:44 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 8 May 2014 20:28:31 +0800
Message-ID: <1399552111-7367-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3] direct_io/dma_thread_diotest7.c: cleanup and add
	it to run default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This test will create 100 files(every is 12MB), so the total needed free space is
1200MB at least. If the current test temporary directory do not satisfy this
requirement, wo need to specify a big block device by running runltp with -z option.
If satisfied, we also need to check whether filesystem, which current test temporary
directory is in, supports the O_DIRECT flag. If not supported, we will also need to
have tests in a big block device specified by users.

Rename runtest/test_dma_thread_diotest7 to runtest/dma_thread_diotest and
split tests in runtest/dma_thread_diotest into separate testcases, keep one entry
per test in runtest/dma_thread_diotest. And remove test_dma_thread_diotest7.sh,
which is useless now.

Some cleanup.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/dma_thread_diotest                         |   7 +
 runtest/test_dma_thread_diotest7                   |   2 -
 .../kernel/io/direct_io/dma_thread_diotest7.c      | 400 ++++++++++++---------
 .../io/direct_io/test_dma_thread_diotest7.sh       |  42 ---
 4 files changed, 235 insertions(+), 216 deletions(-)
 create mode 100644 runtest/dma_thread_diotest
 delete mode 100644 runtest/test_dma_thread_diotest7
 delete mode 100755 testcases/kernel/io/direct_io/test_dma_thread_diotest7.sh

diff --git a/runtest/dma_thread_diotest b/runtest/dma_thread_diotest
new file mode 100644
index 0000000..5c3556e
--- /dev/null
+++ b/runtest/dma_thread_diotest
@@ -0,0 +1,7 @@
+dma_thread_diotest7_1 dma_thread_diotest7 -a 512
+dma_thread_diotest7_2 dma_thread_diotest7 -a 1024
+dma_thread_diotest7_3 dma_thread_diotest7 -a 1536
+dma_thread_diotest7_4 dma_thread_diotest7 -a 2048
+dma_thread_diotest7_5 dma_thread_diotest7 -a 2560
+dma_thread_diotest7_6 dma_thread_diotest7 -a 3072
+dma_thread_diotest7_7 dma_thread_diotest7 -a 3584
diff --git a/runtest/test_dma_thread_diotest7 b/runtest/test_dma_thread_diotest7
deleted file mode 100644
index cb5ea8f..0000000
--- a/runtest/test_dma_thread_diotest7
+++ /dev/null
@@ -1,2 +0,0 @@
-test_dma_thread_diotest7  mkdir -p /tmp/$$-work; cp -r $LTPROOT/testcases/bin/test_dma_thread_diotest7.sh $LTPROOT/testcases/bin/dma_thread_diotest7 /tmp/$$-work; (cd /tmp/$$-work; ./test_dma_thread_diotest7.sh); rm -rf /tmp/$$-work
-
diff --git a/testcases/kernel/io/direct_io/dma_thread_diotest7.c b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
index 0b29b89..77e67a2 100644
--- a/testcases/kernel/io/direct_io/dma_thread_diotest7.c
+++ b/testcases/kernel/io/direct_io/dma_thread_diotest7.c
@@ -90,6 +90,7 @@
 #define _GNU_SOURCE 1
 
 #include <stdio.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -99,38 +100,50 @@
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
+#include "tst_fs_type.h"
+
+#define FILESIZE	(12*1024*1024)
+#define READSIZE	(1024*1024)
+
+#define MNT_POINT	"mntpoint"
+#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
+			 S_IXGRP|S_IROTH|S_IXOTH)
+#define FILECOUNT	100
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
+static char basefilename[128];
+
+static char *align_str;
+static int align;
+static char *workers_str;
+static int workers;
+static char *device;
+static int mount_flag;
+static option_t options[] = {
+	{"a:", NULL, &align_str},
+	{"w:", NULL, &workers_str},
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
@@ -156,14 +170,14 @@ void *worker_thread(void *arg)
 	if (lseek(fd, offset, SEEK_SET) < 0) {
 		fprintf(stderr, "Failed to lseek to %d on fd %d: %s.\n",
 			offset, fd, strerror(errno));
-		exit(1);
+		return (void *) 1;
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
+		return (void *) 1;
 	}
 
 	/* Corruption check */
@@ -182,151 +196,74 @@ void *worker_thread(void *arg)
 			}
 
 			printf("\n");
-			abort();
+			tst_result = 1;
 		}
 	}
 
-	return 0;
+	return NULL;
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
+			return (void *) 1;
 		}
 		waitpid(pid, NULL, 0);
 		usleep(100);
 	}
 
 	return NULL;
-
 }
 
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
+	setup();
 
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
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
 
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
+		for (i = 0; i < TST_TOTAL; i++)
+			dma_thread_diotest_verify();
 	}
 
-	if (dowrite) {
-
-		buffer = malloc(FILESIZE);
-		if (buffer == NULL) {
-			fprintf(stderr, "Failed to malloc write buffer.\n");
-			exit(1);
-		}
-
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
-
-			close(fd);
-			fd = -1;
-		}
-
-		free(buffer);
-		buffer = NULL;
-
-		printf("done\n");
-		exit(0);
-	}
-
-	printf("Using %d workers.\n", workers);
-
-	worker = malloc(workers * sizeof(worker_t));
-	if (worker == NULL) {
-		fprintf(stderr, "Failed to malloc worker array.\n");
-		exit(1);
-	}
+	cleanup();
+	tst_exit();
+}
 
-	for (j = 0; j < workers; j++) {
-		worker[j].worker_number = j;
-	}
+static void dma_thread_diotest_verify(void)
+{
+	int n, j, offset, rc;
+	void *retval;
+	char filename[PATH_MAX];
+	pthread_t fork_tid;
 
-	printf("Using alignment %d.\n", align);
+	tst_result = 0;
 
-	posix_memalign((void *)&buffer, PAGE_SIZE, READSIZE + align);
-	printf("Read buffer: %p.\n", buffer);
 	for (n = 1; n <= FILECOUNT; n++) {
-
-		sprintf(filename, FILENAME, n);
+		sprintf(filename, basefilename, n);
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
@@ -344,51 +281,170 @@ int main(int argc, char *argv[])
 
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
-				rc = pthread_join(worker[j].tid, NULL);
+				rc = pthread_join(worker[j].tid, &retval);
 				if (rc != 0) {
-					fprintf(stderr,
-						"Failed to join worker thread %d: %s.\n",
-						j, strerror(rc));
-					exit(1);
+					tst_brkm(TBROK, cleanup, "Failed to "
+						 "join worker thread %d: %s.",
+						 j, strerror(rc));
+				}
+				if ((intptr_t)retval != 0) {
+					tst_brkm(TBROK, cleanup, "there is"
+						 "some errors in worker[%d],"
+						 "return value: %ld",
+						 j, (intptr_t)retval);
 				}
 			}
 
 			/* Let the fork thread know it's ok to exit */
 			done = 1;
 
-			rc = pthread_join(fork_tid, NULL);
+			rc = pthread_join(fork_tid, &retval);
 			if (rc != 0) {
-				fprintf(stderr,
-					"Failed to join fork thread: %s.\n",
-					strerror(rc));
-				exit(1);
+				tst_brkm(TBROK, cleanup,
+					 "Failed to join fork thread: %s.",
+					 strerror(rc));
+			}
+			if ((intptr_t)retval != 0) {
+				tst_brkm(TBROK, cleanup,
+					 "fork() failed in fork thread:"
+					 "return value: %ld", (intptr_t)retval);
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
+		tst_resm(TFAIL, "data corruption is detected");
+	else
+		tst_resm(TPASS, "data corruption is not detected");
+}
+
+static void setup(void)
+{
+	char filename[PATH_MAX];
+	int n, j, fd, directflag = 1;
+	long type;
+
+	if (align_str) {
+		align = atoi(align_str);
+		if (align < 0 || align > PAGE_SIZE)
+			tst_brkm(TCONF, NULL, "Bad alignment %d.", align);
+	}
+	tst_resm(TINFO, "using alignment %d", align);
+
+	if (workers_str) {
+		workers = atoi(workers_str);
+		if (workers < MIN_WORKERS || workers > MAX_WORKERS) {
+			tst_brkm(TCONF, NULL, "Worker count %d not between "
+				 "%d and %d, inclusive",
+				 workers, MIN_WORKERS, MAX_WORKERS);
 		}
 	}
+	tst_resm(TINFO, "using %d workers.", workers);
+
+	tst_sig(FORK, DEF_HANDLER, NULL);
+	tst_require_root(NULL);
+
+	TEST_PAUSE;
+
+	tst_tmpdir();
+
+	/*
+	 * Some file systems may not implement the O_DIRECT flag and open() will
+	 * fail with EINVAL if it is used. So add this check for current
+	 * filesystem current directory is in, if not supported, we choose to
+	 * have this test in LTP_BIG_DEV and mkfs it as ext3.
+	 */
+	fd = open("testfile", O_CREAT | O_DIRECT, 0644);
+	if (fd < 0 && errno == EINVAL) {
+		type = tst_fs_type(NULL, ".");
+		tst_resm(TINFO, "O_DIRECT flag is not supported on %s "
+			 "filesystem", tst_fs_type_name(type));
+		directflag = 0;
+	} else if (fd > 0) {
+		SAFE_CLOSE(NULL, fd);
+	}
+
+	/*
+	 * verify whether the current directory has enough free space,
+	 * if it is not satisfied, we will use the LTP_BIG_DEV, which
+	 * will be exported by runltp with "-z" option.
+	 */
+	if (!directflag || !tst_fs_has_free(NULL, ".", 1300, TST_MB)) {
+		device = getenv("LTP_BIG_DEV");
+		if (device == NULL) {
+			tst_brkm(TCONF, NULL,
+				 "you must specify a big blockdevice(>1.3G)");
+		} else {
+			tst_mkfs(NULL, device, "ext3", NULL);
+		}
 
-	return 0;
+		SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
+		if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				 "mount device:%s failed", device);
+		}
+		mount_flag = 1;
+		strcpy(basefilename, "mntpoint/_dma_thread_test_%.04d.tmp");
+	} else {
+		strcpy(basefilename, "_dma_thread_test_%.04d.tmp");
+	}
+
+	worker = SAFE_MALLOC(cleanup, workers * sizeof(worker_t));
+
+	for (j = 0; j < workers; j++)
+		worker[j].worker_number = j;
+
+	for (n = 1; n <= FILECOUNT; n++) {
+		sprintf(filename, basefilename, n);
+
+		if (tst_fill_file(filename, n, FILESIZE, 1)) {
+			tst_brkm(TBROK, cleanup, "failed to create file: %s",
+				 filename);
+		}
+	}
+
+	if (posix_memalign((void **)&buffer, PAGE_SIZE, READSIZE + align) != 0)
+		tst_brkm(TBROK, cleanup, "call posix_memalign failed");
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+
+	free(buffer);
+
+	if (mount_flag && umount(MNT_POINT) < 0)
+		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
+
+	free(worker);
+
+	tst_rmdir();
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
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
