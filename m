From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 20 Nov 2018 10:56:09 +0100
Subject: [LTP] [PATCH RFC] mtest06/mmap1: rewrite to newlib
Message-ID: <bb56352d02aac0b65a5fa53ae29014e15c929b24.1542707357.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #165

This patch is aiming to rewrite mtest06/mmap1 from scratch,
to address sporadic failures in #165.

Main difference is that it uses only one signal handler and no
synchronization between threads, no sched_yield calls.

Instead each mmap/munmap increases a map/unmap counter. Upon hitting
SIGSEGV or when comparing read value, these counter values are used
to determine state of mapped area as observed by first thread.
This isn't 100% accurrate as first thread might be faster than the
check, but it allows second thread to race against map/unmap for
its entire duration.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/mtest06/mmap1.c | 666 +++++++++++++----------------------
 1 file changed, 239 insertions(+), 427 deletions(-)
 rewrite testcases/kernel/mem/mtest06/mmap1.c (92%)

diff --git a/testcases/kernel/mem/mtest06/mmap1.c b/testcases/kernel/mem/mtest06/mmap1.c
dissimilarity index 92%
index 80889676d96a..6565e777ba1b 100644
--- a/testcases/kernel/mem/mtest06/mmap1.c
+++ b/testcases/kernel/mem/mtest06/mmap1.c
@@ -1,427 +1,239 @@
-/******************************************************************************/
-/*									      */
-/* Copyright (c) International Business Machines  Corp., 2001		      */
-/* Copyright (c) 2001 Manoj Iyer <manjo@austin.ibm.com>                       */
-/* Copyright (c) 2003 Robbie Williamson <robbiew@us.ibm.com>                  */
-/* Copyright (c) 2004 Paul Larson <plars@linuxtestproject.org>                */
-/* Copyright (c) 2007 <rsalveti@linux.vnet.ibm.com>                           */
-/* Copyright (c) 2007 Suzuki K P <suzuki@in.ibm.com>                          */
-/* Copyright (c) 2011 Cyril Hrubis <chrubis@suse.cz>                          */
-/*									      */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.					      */
-/*									      */
-/* This program is distributed in the hope that it will be useful,	      */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of	      */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See	              */
-/* the GNU General Public License for more details.			      */
-/*									      */
-/* You should have received a copy of the GNU General Public License	      */
-/* along with this program;  if not, write to the Free Software		      */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
-/*									      */
-/******************************************************************************/
-/******************************************************************************/
-/* Description:	Test the LINUX memory manager. The program is aimed at        */
-/*		stressing the memory manager by simultanious map/unmap/read   */
-/*		by light weight processes, the test is scheduled to run for   */
-/*		a mininum of 24 hours.					      */
-/*									      */
-/*		Create two light weight processes X and Y.                    */
-/*		X - maps, writes  and unmap a file in a loop.	              */
-/*		Y - read from this mapped region in a loop.		      */
-/*	        read must be a success between map and unmap of the region.   */
-/*									      */
-/******************************************************************************/
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <sched.h>
-#include <unistd.h>
-#include <errno.h>
-#include <sys/mman.h>
-#include <sched.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <sys/time.h>
-#include <sys/wait.h>
-#include <setjmp.h>
-#include <pthread.h>
-#include <signal.h>
-#include <string.h>
-#include "test.h"
-#include "safe_macros.h"
-
-#define DISTANT_MMAP_SIZE (64*1024*1024)
-#define OPT_MISSING(prog, opt) do { \
-	fprintf(stderr, "%s: option -%c ", prog, opt); \
-        fprintf(stderr, "requires an argument\n"); \
-	usage(prog); \
-} while (0)
-
-#define TEST_FILENAME "ashfile"
-
-static int verbose_print = 0;
-static char *volatile map_address;
-static jmp_buf jmpbuf;
-static volatile char read_lock = 0;
-static void *distant_area;
-
-char *TCID = "mmap1";
-int TST_TOTAL = 1;
-
-static void sig_handler(int signal, siginfo_t * info, void *ut)
-{
-	switch (signal) {
-	case SIGALRM:
-		tst_resm(TPASS, "Test ended, success");
-		_exit(TPASS);
-	case SIGSEGV:
-		longjmp(jmpbuf, 1);
-		break;
-	default:
-		fprintf(stderr, "Unexpected signal - %d --- exiting\n", signal);
-		_exit(TBROK);
-	}
-}
-
-/*
- * Signal handler that is active, when file is mapped, eg. we do not expect
- * SIGSEGV to be delivered.
- */
-static void sig_handler_mapped(int signal, siginfo_t * info, void *ut)
-{
-	switch (signal) {
-	case SIGALRM:
-		tst_resm(TPASS, "Test ended, success");
-		_exit(TPASS);
-	case SIGSEGV:
-		tst_resm(TINFO, "[%lu] Unexpected page fault at %p",
-			 pthread_self(), info->si_addr);
-		_exit(TFAIL);
-		break;
-	default:
-		fprintf(stderr, "Unexpected signal - %d --- exiting\n", signal);
-		_exit(TBROK);
-	}
-}
-
-int mkfile(int size)
-{
-	int fd, i;
-
-	fd = open(TEST_FILENAME,  O_RDWR | O_CREAT, 0600);
-	if (fd < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "open for %s failed",
-			 TEST_FILENAME);
-
-	unlink(TEST_FILENAME);
-
-	for (i = 0; i < size; i++)
-		if (write(fd, "a", 1) == -1)
-			tst_brkm(TBROK | TERRNO, NULL, "write() failed");
-
-	if (write(fd, "\0", 1) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "write() failed");
-
-	if (fsync(fd) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "fsync() failed");
-
-	return fd;
-}
-
-void *map_write_unmap(void *ptr)
-{
-	struct sigaction sa;
-	long *args = ptr;
-	long i;
-	int j;
-
-	tst_resm(TINFO, "[%lu] - map, change contents, unmap files %ld times",
-		 pthread_self(), args[2]);
-
-	if (verbose_print)
-		tst_resm(TINFO, "map_write_unmap() arguments are: "
-			 "fd - arg[0]: %ld; "
-			 "size of file - arg[1]: %ld; "
-			 "num of map/write/unmap - arg[2]: %ld",
-			 args[0], args[1], args[2]);
-
-	for (i = 0; i < args[2]; i++) {
-		map_address = mmap(distant_area, (size_t) args[1],
-			PROT_WRITE | PROT_READ, MAP_SHARED, (int)args[0], 0);
-
-		if (map_address == (void *)-1) {
-			perror("map_write_unmap(): mmap()");
-			pthread_exit((void *)1);
-		}
-
-		while (read_lock)
-			sched_yield();
-
-		sigfillset(&sa.sa_mask);
-		sigdelset(&sa.sa_mask, SIGSEGV);
-		sa.sa_flags = SA_SIGINFO | SA_NODEFER;
-		sa.sa_sigaction = sig_handler_mapped;
-
-		if (sigaction(SIGSEGV, &sa, NULL)) {
-			perror("map_write_unmap(): sigaction()");
-			pthread_exit((void *)1);
-		}
-
-		if (verbose_print)
-			tst_resm(TINFO, "map address = %p", map_address);
-
-		for (j = 0; j < args[1]; j++) {
-			map_address[j] = 'a';
-			if (random() % 2)
-				sched_yield();
-		}
-
-		if (verbose_print)
-			tst_resm(TINFO,
-				 "[%ld] times done: of total [%ld] iterations, "
-				 "map_write_unmap():memset() content of memory = %s",
-				 i, args[2], (char *)map_address);
-
-		sigfillset(&sa.sa_mask);
-		sigdelset(&sa.sa_mask, SIGSEGV);
-		sa.sa_flags = SA_SIGINFO | SA_NODEFER;
-		sa.sa_sigaction = sig_handler;
-
-		if (sigaction(SIGSEGV, &sa, NULL)) {
-			perror("map_write_unmap(): sigaction()");
-			pthread_exit((void *)1);
-		}
-
-		if (munmap(map_address, (size_t) args[1]) == -1) {
-			perror("map_write_unmap(): mmap()");
-			pthread_exit((void *)1);
-		}
-	}
-
-	pthread_exit(NULL);
-}
-
-void *read_mem(void *ptr)
-{
-	long i;
-	long *args = ptr;
-	int j;
-
-	tst_resm(TINFO, "[%lu] - read contents of memory %p %ld times",
-		 pthread_self(), map_address, args[2]);
-
-	if (verbose_print)
-		tst_resm(TINFO, "read_mem() arguments are: "
-			 "number of reads to be performed - arg[2]: %ld; "
-			 "read from address %p", args[2], map_address);
-
-	for (i = 0; i < args[2]; i++) {
-
-		if (verbose_print)
-			tst_resm(TINFO, "read_mem() in while loop %ld times "
-				 "to go %ld times", i, args[2]);
-
-		if (setjmp(jmpbuf) == 1) {
-			read_lock = 0;
-			if (verbose_print)
-				tst_resm(TINFO, "page fault occurred due to "
-					 "a read after an unmap");
-		} else {
-			if (verbose_print) {
-				read_lock = 1;
-				tst_resm(TINFO,
-					 "read_mem(): content of memory: %s",
-					 (char *)map_address);
-				read_lock = 0;
-			}
-			for (j = 0; j < args[1]; j++) {
-				read_lock = 1;
-				if (map_address[j] != 'a')
-					pthread_exit((void *)-1);
-				read_lock = 0;
-				if (random() % 2)
-					sched_yield();
-			}
-		}
-	}
-
-	pthread_exit(NULL);
-}
-
-static void usage(char *progname)
-{
-	fprintf(stderr, "Usage: %s -d -l -s -v -x\n"
-		"\t -h help, usage message.\n"
-		"\t -l number of mmap/write/unmap     default: 1000\n"
-		"\t -s size of the file to be mmapped default: 1024 bytes\n"
-		"\t -v print more info.               default: quiet\n"
-		"\t -x test execution time            default: 24 Hrs\n",
-		progname);
-
-	exit(-1);
-}
-
-struct signal_info {
-	int signum;
-	char *signame;
-};
-
-static struct signal_info sig_info[] = {
-	{SIGHUP, "SIGHUP"},
-	{SIGINT, "SIGINT"},
-	{SIGQUIT, "SIGQUIT"},
-	{SIGABRT, "SIGABRT"},
-	{SIGBUS, "SIGBUS"},
-	{SIGSEGV, "SIGSEGV"},
-	{SIGALRM, "SIGALRM"},
-	{SIGUSR1, "SIGUSR1"},
-	{SIGUSR2, "SIGUSR2"},
-	{-1, "ENDSIG"}
-};
-
-int main(int argc, char **argv)
-{
-	int c, i;
-	int file_size;
-	int num_iter;
-	double exec_time;
-	int fd;
-	void *status;
-	pthread_t thid[2];
-	long chld_args[3];
-	extern char *optarg;
-	struct sigaction sigptr;
-	int ret;
-
-	/* set up the default values */
-	file_size = 1024;
-	num_iter = 1000;
-	exec_time = 24;
-
-	while ((c = getopt(argc, argv, "hvl:s:x:")) != -1) {
-		switch (c) {
-		case 'h':
-			usage(argv[0]);
-			break;
-		case 'l':
-			if ((num_iter = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_iter < 0)
-				printf
-				    ("WARNING: bad argument. Using default %d\n",
-				     (num_iter = 1000));
-			break;
-		case 's':
-			if ((file_size = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (file_size < 0)
-				printf
-				    ("WARNING: bad argument. Using default %d\n",
-				     (file_size = 1024));
-			break;
-		case 'v':
-			verbose_print = 1;
-			break;
-		case 'x':
-			exec_time = atof(optarg);
-			if (exec_time == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (exec_time < 0)
-				printf
-				    ("WARNING: bad argument. Using default %.0f\n",
-				     (exec_time = 24));
-			break;
-		default:
-			usage(argv[0]);
-			break;
-		}
-	}
-
-	/* We don't want other mmap calls to map into same area as is
-	 * used for test (mmap_address). The test expects read to return
-	 * test pattern or read must fail with SIGSEGV. Find an area
-	 * that we can use, which is unlikely to be chosen for other
-	 * mmap calls. */
-	distant_area = mmap(0, DISTANT_MMAP_SIZE, PROT_WRITE | PROT_READ,
-		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (distant_area == (void *)-1)
-		tst_brkm(TBROK | TERRNO, NULL, "distant_area: mmap()");
-	SAFE_MUNMAP(NULL, distant_area, (size_t)DISTANT_MMAP_SIZE);
-	distant_area += DISTANT_MMAP_SIZE / 2;
-
-	if (verbose_print)
-		tst_resm(TINFO, "Input parameters are: File size:  %d; "
-			 "Scheduled to run:  %lf hours; "
-			 "Number of mmap/write/read:  %d",
-			 file_size, exec_time, num_iter);
-
-	alarm(exec_time * 3600);
-
-	/* Do not mask SIGSEGV, as we are interested in handling it. */
-	sigptr.sa_sigaction = sig_handler;
-	sigfillset(&sigptr.sa_mask);
-	sigdelset(&sigptr.sa_mask, SIGSEGV);
-	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
-
-	for (i = 0; sig_info[i].signum != -1; i++) {
-		if (sigaction(sig_info[i].signum, &sigptr, NULL) == -1) {
-			perror("man(): sigaction()");
-			fprintf(stderr,
-				"could not set handler for %s, errno = %d\n",
-				sig_info[i].signame, errno);
-			exit(-1);
-		}
-	}
-
-	tst_tmpdir();
-
-	for (;;) {
-		if ((fd = mkfile(file_size)) == -1)
-			tst_brkm(TBROK, NULL,
-				 "main(): mkfile(): Failed to create temp file");
-
-		if (verbose_print)
-			tst_resm(TINFO, "Tmp file created");
-
-		chld_args[0] = fd;
-		chld_args[1] = file_size;
-		chld_args[2] = num_iter;
-
-		if ((ret =
-		     pthread_create(&thid[0], NULL, map_write_unmap,
-				    chld_args)))
-			tst_brkm(TBROK, NULL, "main(): pthread_create(): %s",
-				 strerror(ret));
-
-		tst_resm(TINFO, "created writing thread[%lu]", thid[0]);
-
-		if ((ret = pthread_create(&thid[1], NULL, read_mem, chld_args)))
-			tst_brkm(TBROK, NULL, "main(): pthread_create(): %s",
-				 strerror(ret));
-
-		tst_resm(TINFO, "created reading thread[%lu]", thid[1]);
-
-		for (i = 0; i < 2; i++) {
-			if ((ret = pthread_join(thid[i], &status)))
-				tst_brkm(TBROK, NULL,
-					 "main(): pthread_join(): %s",
-					 strerror(ret));
-
-			if (status)
-				tst_brkm(TFAIL, NULL,
-					 "thread [%lu] - process exited "
-					 "with %ld", thid[i], (long)status);
-		}
-
-		close(fd);
-	}
-
-	tst_rmdir();
-
-	exit(0);
-}
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2018 Jan Stancek. All rights reserved.
+ */
+/*
+ * Test: Spawn 2 threads. First thread maps, writes and unmaps
+ * an area. Second thread tries to read from it. Second thread
+ * races against first thread. There is no synchronization
+ * between threads, but each mmap/munmap increases a counter
+ * that is checked to determine when has read occurred. If a read
+ * hit SIGSEGV in between mmap/munmap it is a failure. If a read
+ * between mmap/munmap worked, then its value must match expected
+ * value.
+ */
+#include <errno.h>
+#include <float.h>
+#include <pthread.h>
+#include <sched.h>
+#include <setjmp.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+
+#define DISTANT_MMAP_SIZE (64*1024*1024)
+#define TEST_FILENAME "ashfile"
+
+/* seconds remaining before reaching timeout */
+#define STOP_THRESHOLD 10
+
+#define PROGRESS_SEC 3
+
+static int file_size = 1024;
+static int num_iter = 5000;
+static float exec_time = 0.05; /* default is 3 min */
+
+static void *distant_area;
+static char *str_exec_time;
+static jmp_buf jmpbuf;
+static volatile unsigned char *map_address;
+static unsigned long page_sz;
+
+static unsigned long mapped_sigsegv_count;
+static unsigned long map_count;
+static unsigned long threads_spawned;
+static unsigned long data_matched;
+
+/* sequence id for each map/unmap performed */
+static int mapcnt, unmapcnt;
+/* stored sequence id before making read attempt */
+static int br_map, br_unmap;
+
+static struct tst_option options[] = {
+	{"x:", &str_exec_time, "Exec time (hours)"},
+	{NULL, NULL, NULL}
+};
+
+/* compare "before read" counters  with "after read" counters */
+static inline int was_area_mapped(int br_m, int br_u, int ar_m, int ar_u)
+{
+	return (br_m == ar_m && br_u == ar_u && br_m > br_u);
+}
+
+static void sig_handler(int signal, siginfo_t *info,
+	LTP_ATTRIBUTE_UNUSED void *ut)
+{
+	int ar_m, ar_u;
+
+	switch (signal) {
+	case SIGSEGV:
+		/* if we hit SIGSEGV between map/unmap, something is wrong */
+		ar_u = tst_atomic_load(&unmapcnt);
+		ar_m = tst_atomic_load(&mapcnt);
+		if (was_area_mapped(br_map, br_unmap, ar_m, ar_u)) {
+			tst_res(TFAIL, "got sigsegv while mapped");
+			_exit(TFAIL);
+		}
+
+		mapped_sigsegv_count++;
+		longjmp(jmpbuf, 1);
+		break;
+	default:
+		tst_res(TFAIL, "Unexpected signal - %d, addr: %p, exiting\n",
+			signal, info->si_addr);
+		_exit(TBROK);
+	}
+}
+
+void *map_write_unmap(void *ptr)
+{
+	long *args = ptr;
+	void *tmp;
+	int i, j;
+
+	for (i = 0; i < num_iter; i++) {
+		map_address = SAFE_MMAP(distant_area,
+			(size_t) file_size, PROT_WRITE | PROT_READ,
+			MAP_SHARED, (int)args[0], 0);
+		tst_atomic_inc(&mapcnt);
+
+		for (j = 0; j < file_size; j++)
+			map_address[j] = 'a';
+
+		tmp = (void *)map_address;
+		tst_atomic_inc(&unmapcnt);
+		SAFE_MUNMAP(tmp, file_size);
+
+		map_count++;
+	}
+
+	return NULL;
+}
+
+void *read_mem(LTP_ATTRIBUTE_UNUSED void *ptr)
+{
+	int i, j, ar_map, ar_unmap;
+	unsigned char c;
+
+	for (i = 0; i < num_iter; i++) {
+		if (setjmp(jmpbuf) == 1)
+			continue;
+
+		for (j = 0; j < file_size; j++) {
+			br_map = tst_atomic_load(&mapcnt);
+			br_unmap = tst_atomic_load(&unmapcnt);
+
+			c = map_address[j];
+
+			ar_unmap = tst_atomic_load(&unmapcnt);
+			ar_map = tst_atomic_load(&mapcnt);
+
+			/*
+			 * Read above is racing against munmap and mmap
+			 * in other thread. While the address might be valid
+			 * the mapping could be in various stages of being
+			 * 'ready'. We only check the value, if we can be sure
+			 * read hapenned in between single mmap and munmap as
+			 * observed by first thread.
+			 */
+			if (was_area_mapped(br_map, br_unmap, ar_map, ar_unmap)) {
+				if (c != 'a') {
+					tst_res(TFAIL, "value@offset %d is %02x",
+						j, c);
+					break;
+				}
+				data_matched++;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+int mkfile(int size)
+{
+	int fd, i;
+
+	fd = SAFE_OPEN(TEST_FILENAME, O_RDWR | O_CREAT, 0600);
+	SAFE_UNLINK(TEST_FILENAME);
+
+	for (i = 0; i < size; i++)
+		SAFE_WRITE(1, fd, "a", 1);
+	SAFE_WRITE(1, fd, "\0", 1);
+
+	if (fsync(fd) == -1)
+		tst_brk(TBROK | TERRNO, "fsync()");
+
+	return fd;
+}
+
+static void setup(void)
+{
+	struct sigaction sigptr;
+
+	page_sz = getpagesize();
+
+	/*
+	 * Used as hint for mmap thread, so it doesn't interfere
+	 * with other potential (temporary) mappings from libc
+	 */
+	distant_area = SAFE_MMAP(0, DISTANT_MMAP_SIZE, PROT_WRITE | PROT_READ,
+			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	SAFE_MUNMAP(distant_area, (size_t)DISTANT_MMAP_SIZE);
+	distant_area += DISTANT_MMAP_SIZE / 2;
+
+	if (tst_parse_float(str_exec_time, &exec_time, 0, FLT_MAX)) {
+		tst_brk(TBROK, "Invalid number for exec_time '%s'",
+			str_exec_time);
+	}
+
+	sigptr.sa_sigaction = sig_handler;
+	sigemptyset(&sigptr.sa_mask);
+	sigptr.sa_flags = SA_SIGINFO | SA_NODEFER;
+	SAFE_SIGACTION(SIGSEGV, &sigptr, NULL);
+
+	tst_set_timeout((int)(exec_time * 3600));
+}
+
+static void run(void)
+{
+	pthread_t thid[2];
+	long chld_args[1];
+	int remaining = tst_timeout_remaining();
+	int elapsed = 0;
+
+	while (tst_timeout_remaining() > STOP_THRESHOLD) {
+		int fd = mkfile(file_size);
+
+		tst_atomic_store(0, &mapcnt);
+		tst_atomic_store(0, &unmapcnt);
+
+		chld_args[0] = fd;
+		SAFE_PTHREAD_CREATE(&thid[0], NULL, map_write_unmap, chld_args);
+		SAFE_PTHREAD_CREATE(&thid[1], NULL, read_mem, chld_args);
+		threads_spawned += 2;
+
+		SAFE_PTHREAD_JOIN(thid[0], NULL);
+		SAFE_PTHREAD_JOIN(thid[1], NULL);
+
+		close(fd);
+
+		if (remaining - tst_timeout_remaining() > PROGRESS_SEC) {
+			remaining = tst_timeout_remaining();
+			elapsed += PROGRESS_SEC;
+			tst_res(TINFO, "[%d] mapped: %lu, sigsegv hit: %lu, "
+				"threads spawned: %lu, data matched: %lu",
+				elapsed, map_count, mapped_sigsegv_count,
+				threads_spawned, data_matched);
+		}
+	}
+	tst_res(TPASS, "System survived.");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.options = options,
+	.needs_tmpdir = 1,
+};
-- 
1.8.3.1

