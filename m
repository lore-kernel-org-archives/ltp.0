From: Li Wang <liwang@redhat.com>
Date: Fri,  8 Mar 2019 18:10:49 +0800
Subject: [LTP] [PATCH v3] mm: rewrite mtest01 with new API
Message-ID: <20190308101049.21201-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

 Test issue:
   mtest01 start many children to alloc chunck of memory and do write
   page(with -w option), but occasionally some children were killed by
   oom-killer and exit with SIGCHLD signal sending. After the parent
   reciving this SIGCHLD signal it will report FAIL as a test result.

   It seems not a real kernel bug if something just like that, it's
   trying to use 80% of memory and swap. Once it uses most of memory,
   system starts swapping, but the test is likely consuming memory at
   greater rate than kswapd can provide, which eventually triggers OOM.

   ---- FAIL LOG ----
   mtest01     0  TINFO  :  Total memory already used on system = 1027392 kbytes
   mtest01     0  TINFO  :  Total memory used needed to reach maximum = 12715520 kbytes
   mtest01     0  TINFO  :  Filling up 80% of ram which is 11688128 kbytes
   mtest01     1  TFAIL  :  mtest01.c:314: child process exited unexpectedly
   -------------------

 Rewrite changes:
   To make mtest01 more easier to understand, I just rewrite it into
   LTP new API and make a little changes in children behavior.

   * decrease the pressure to 80% of free memory for testing
   * drop the signal SIGCHLD action becasue new API help to check_child_status
   * make child pause itself after finishing their memory allocating/writing
   * parent sends SIGCONT to make children continue and exit
   * use TST_PROCESS_STATE_WAIT to wait child changes to 'T' state
   * involve ALLOC_THRESHOLD to rework same code in defines
   * to make mtest01 support running with -i N > 1

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v2 --> v3
       * modify test description for new version
       * move some global variables to local
       * remove SIGCONT sending from cleanup
       * involve ALLOC_THRESHOLD to avoid same code in defines

 testcases/kernel/mem/mtest01/mtest01.c | 465 +++++++++++--------------
 1 file changed, 195 insertions(+), 270 deletions(-)

diff --git a/testcases/kernel/mem/mtest01/mtest01.c b/testcases/kernel/mem/mtest01/mtest01.c
index ca9073a8e..6ce75118b 100644
--- a/testcases/kernel/mem/mtest01/mtest01.c
+++ b/testcases/kernel/mem/mtest01/mtest01.c
@@ -1,36 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ *  Copyright (c) International Business Machines Corp., 2001
+ *  Copyright (c) Linux Test Project., 2019
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ *  DESCRIPTION:
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ *  mtest01 mallocs memory <chunksize> at a time until malloc fails.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- *  FILE		: mtest01.c
- *  DESCRIPTION : mallocs memory <chunksize> at a time until malloc fails.
- *  HISTORY:
- *	04/10/2001 Paul Larson (plars@us.ibm.com)
- *	  written
- *	11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
- *	  Modified.
- *	  - Removed compile warnings.
- *	  - Added header file #include <unistd.h> definition for getopt()
- *	05/13/2003 Robbie Williamson (robbiew@us.ibm.com)
- *	  Modified.
- *	  - Rewrote the test to be able to execute on large memory machines.
+ *  Parent process starts several child processes (each child process is
+ *  tasked with allocating some amount of memory), it waits until all child
+ *  processes send SIGRTMIN signal and resumes all children by sending the
+ *  SIGCONT signal.
  *
+ *  Child process allocates certain amount of memory and fills it with some
+ *  data (the '-w' option) so the pages are actually allocated when the desired
+ *  amount of memory is allocated then it sends SIGRTMIN signal to the parent
+ *  process, it pauses itself by raise SIGSTOP until get parent SIGCONT signal
+ *  to continue and exit.
  */
 
 #include <sys/types.h>
@@ -42,285 +28,224 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#include "test.h"
+#include "tst_test.h"
 
-#define FIVE_HUNDRED_MB (unsigned long long)(500*1024*1024)
-#define ONE_GB	(unsigned long long)(1024*1024*1024)
-#define THREE_GB (unsigned long long)(3*ONE_GB)
+#define FIVE_HUNDRED_MB         (unsigned long long)(500*1024*1024)
 
-char *TCID = "mtest01";
-int TST_TOTAL = 1;
-static sig_atomic_t pid_count;
-static sig_atomic_t sigchld_count;
-static pid_t *pid_list;
+#if defined (_s390_)
+#define ALLOC_THRESHOLD		FIVE_HUNDRED_MB
+#elif __WORDSIZE == 32
+#define ALLOC_THRESHOL		(unsigned long long)(2*FIVE_HUNDRED_MB)
+#elif __WORDSIZE == 64
+#define ALLOC_THRESHOLD		(unsigned long long)(6*FIVE_HUNDRED_MB)
+#endif
 
-static void handler(int signo)
+#define STOP_THRESHOLD 15	/* seconds remaining before reaching timeout */
+
+static pid_t *pid_list;
+static sig_atomic_t pid_count;
+static int max_pids;
+static unsigned long long alloc_maxbytes;
+static unsigned long long original_maxbytes;
+
+static int chunksize = 1024*1024;
+static int maxpercent = 20;
+static long maxbytes = 0;
+static char *dowrite;
+static char *verbose;
+
+static char *opt_chunksize, *opt_maxbytes, *opt_maxpercent;
+static struct tst_option mtest_options[] = {
+	{"c:", &opt_chunksize,	"-c  size of chunk in bytes to malloc on each pass"},
+	{"b:", &opt_maxbytes,	"-b  maximum number of bytes to allocate before stopping"},
+	{"p:", &opt_maxpercent, "-u  percent of total memory used at which the program stops"},
+	{"w",  &dowrite,   	"-w  write to the memory after allocating"},
+	{"v",  &verbose,     	"-v  verbose"},
+	{NULL, NULL, 		NULL}
+};
+
+static void parse_mtest_options(char *str_chunksize, int *chunksize,
+		char *str_maxbytes, long *maxbytes,
+		char *str_maxpercent, int *maxpercent)
 {
-	if (signo == SIGCHLD)
-		sigchld_count++;
-	pid_count++;
+	if (str_chunksize)
+		if (tst_parse_int(str_chunksize, chunksize, 1, INT_MAX))
+			tst_brk(TBROK, "Invalid chunksize '%s'", str_chunksize);
+
+	if (str_maxbytes) {
+		if (tst_parse_long(str_maxbytes, maxbytes, 1, LONG_MAX)) {
+			tst_brk(TBROK, "Invalid maxbytes '%s'", str_maxbytes);
+		} else if (str_maxpercent) {
+			tst_brk(TBROK, "ERROR: -b option cannot be used with -p "
+					"option at the same time");
+		}
+		alloc_maxbytes = (unsigned long long)maxbytes;
+	}
+
+	if (str_maxpercent) {
+		if (tst_parse_int(str_maxpercent, maxpercent, 1, 99)) {
+			tst_brk(TBROK, "Invalid maxpercent '%s'", str_maxpercent);
+		} else if (str_maxbytes) {
+			tst_brk(TBROK, "ERROR: -p option cannot be used with -b "
+					"option at the same time");
+		}
+	}
 }
 
-static void cleanup(void)
+static void handler(int sig LTP_ATTRIBUTE_UNUSED)
 {
-	int i = 0;
+        pid_count++;
+}
 
-	while (pid_list[i] > 0) {
-		kill(pid_list[i], SIGKILL);
-		i++;
-	}
+static void do_write_page(char *mem, int chunksize)
+{
+	int i;
 
-	free(pid_list);
+	for (i = 0; i < chunksize; i++)
+		*(mem + i) = 'a';
 }
 
-int main(int argc, char *argv[])
+static void setup(void)
 {
-	int c;
-	char *mem;
-	float percent;
-	unsigned int maxpercent = 0, dowrite = 0, verbose = 0, j;
-	unsigned long bytecount, alloc_bytes, max_pids;
-	unsigned long long original_maxbytes, maxbytes = 0;
-	unsigned long long pre_mem = 0, post_mem = 0;
-	unsigned long long total_ram, total_free, D, C;
-	int chunksize = 1024 * 1024;	/* one meg at a time by default */
 	struct sysinfo sstats;
-	int i, pid_cntr;
-	pid_t pid;
-	struct sigaction act;
+	unsigned long long total_free;
 
+	struct sigaction act;
 	act.sa_handler = handler;
 	act.sa_flags = 0;
 	sigemptyset(&act.sa_mask);
 	sigaction(SIGRTMIN, &act, 0);
-	sigaction(SIGCHLD, &act, 0);
-
-	while ((c = getopt(argc, argv, "c:b:p:wvh")) != -1) {
-		switch (c) {
-		case 'c':
-			chunksize = atoi(optarg);
-			break;
-		case 'b':
-			if (maxpercent != 0)
-				tst_brkm(TBROK, NULL,
-					 "ERROR: -b option cannot be used with -p "
-					 "option at the same time");
-			maxbytes = atoll(optarg);
-			break;
-		case 'p':
-			if (maxbytes != 0)
-				tst_brkm(TBROK, NULL,
-					 "ERROR: -p option cannot be used with -b "
-					 "option@the same time");
-			maxpercent = atoi(optarg);
-			if (maxpercent <= 0)
-				tst_brkm(TBROK, NULL,
-					 "ERROR: -p option requires number greater "
-					 "than 0");
-			if (maxpercent > 99)
-				tst_brkm(TBROK, NULL,
-					 "ERROR: -p option cannot be greater than "
-					 "99");
-			break;
-		case 'w':
-			dowrite = 1;
-			break;
-		case 'v':
-			verbose = 1;
-			break;
-		case 'h':
-		default:
-			printf
-			    ("usage: %s [-c <bytes>] [-b <bytes>|-p <percent>] [-v]\n",
-			     argv[0]);
-			printf
-			    ("\t-c <num>\tsize of chunk in bytes to malloc on each pass\n");
-			printf
-			    ("\t-b <bytes>\tmaximum number of bytes to allocate before stopping\n");
-			printf
-			    ("\t-p <bytes>\tpercent of total memory used at which the program stops\n");
-			printf
-			    ("\t-w\t\twrite to the memory after allocating\n");
-			printf("\t-v\t\tverbose\n");
-			printf("\t-h\t\tdisplay usage\n");
-			exit(1);
-		}
-	}
 
+	parse_mtest_options(opt_chunksize, &chunksize,
+			opt_maxbytes, &maxbytes,
+			opt_maxpercent, &maxpercent);
 	sysinfo(&sstats);
-	total_ram = sstats.totalram + sstats.totalswap;
-	total_free = sstats.freeram + sstats.freeswap;
-	/* Total Free Pre-Test RAM */
-	pre_mem = sstats.mem_unit * total_free;
-	max_pids = total_ram * sstats.mem_unit
-		/ (unsigned long)FIVE_HUNDRED_MB + 10;
-
-	if ((pid_list = malloc(max_pids * sizeof(pid_t))) == NULL)
-		tst_brkm(TBROK | TERRNO, NULL, "malloc failed.");
-	memset(pid_list, 0, max_pids * sizeof(pid_t));
+	total_free = sstats.freeram;
 
-	/* Currently used memory */
-	C = sstats.mem_unit * (total_ram - total_free);
-	tst_resm(TINFO, "Total memory already used on system = %llu kbytes",
-		 C / 1024);
+	max_pids = total_free * sstats.mem_unit
+		/ (unsigned long)ALLOC_THRESHOLD + 10;
+	pid_list = SAFE_MALLOC(max_pids * sizeof(pid_t));
+	memset(pid_list, 0, max_pids * sizeof(pid_t));
 
 	if (maxpercent) {
-		percent = (float)maxpercent / 100.00;
-
-		/* Desired memory needed to reach maxpercent */
-		D = percent * (sstats.mem_unit * total_ram);
-		tst_resm(TINFO,
-			 "Total memory used needed to reach maximum = %llu kbytes",
-			 D / 1024);
-
-		/* Are we already using more than maxpercent? */
-		if (C > D) {
-			tst_resm(TFAIL,
-				 "More memory than the maximum amount you specified "
-				 " is already being used");
-			free(pid_list);
-			tst_exit();
-		}
+		/* set alloc_maxbytes to the extra amount we want to allocate */
+		alloc_maxbytes = ((float)maxpercent / 100.00)
+			* (sstats.mem_unit * total_free);
+		tst_res(TINFO, "Filling up %d%% of free ram which is %llu kbytes",
+			 maxpercent, alloc_maxbytes / 1024);
+	}
+
+	original_maxbytes = alloc_maxbytes;
+}
+
+static void cleanup(void)
+{
+	if(pid_list)
+		free(pid_list);
+}
 
-		/* set maxbytes to the extra amount we want to allocate */
-		maxbytes = D - C;
-		tst_resm(TINFO, "Filling up %d%% of ram which is %llu kbytes",
-			 maxpercent, maxbytes / 1024);
+static void child_loop_alloc(unsigned long long alloc_bytes)
+{
+	unsigned long bytecount = (unsigned long)chunksize;
+	char *mem;
+
+	while (1) {
+		mem = SAFE_MALLOC(chunksize);
+		if (dowrite)
+			do_write_page(mem, chunksize);
+
+		if (verbose)
+			tst_res(TINFO,
+				"child %d allocated %lu bytes chunksize is %d",
+				getpid(), bytecount, chunksize);
+		bytecount += chunksize;
+		if (bytecount >= alloc_bytes)
+			break;
 	}
-	original_maxbytes = maxbytes;
-	i = 0;
-	pid_cntr = 0;
-	pid = fork();
-	if (pid < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-	if (pid != 0) {
+	if (dowrite)
+		tst_res(TINFO, "... %lu bytes allocated and used in child %d",
+				bytecount, getpid());
+	else
+		tst_res(TINFO, "... %lu bytes allocated only in child %d",
+				bytecount, getpid());
+
+	kill(getppid(), SIGRTMIN);
+	raise(SIGSTOP);
+	exit(0);
+}
+
+static void mem_test(void)
+{
+	pid_t pid;
+	int i = 0, pid_cntr = 0;
+	unsigned long long alloc_bytes;
+
+	/* to make mtest01 support -i N */
+	if (original_maxbytes)
+		alloc_maxbytes = original_maxbytes;
+	pid_count = 0;
+
+	do {
+		pid = SAFE_FORK();
+		if (pid == 0)
+			break;
+
 		pid_cntr++;
 		pid_list[i] = pid;
-	}
 
-#if defined (_s390_)		/* s390's 31bit addressing requires smaller chunks */
-	while (pid != 0 && maxbytes > FIVE_HUNDRED_MB) {
-		i++;
-		if (i >= max_pids)
-			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
-		maxbytes -= FIVE_HUNDRED_MB;
-		pid = fork();
-		if (pid < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-		if (pid != 0) {
-			pid_cntr++;
-			pid_list[i] = pid;
-		}
-	}
-	if (maxbytes > FIVE_HUNDRED_MB)
-		alloc_bytes = FIVE_HUNDRED_MB;
-	else
-		alloc_bytes = (unsigned long)maxbytes;
+		if (alloc_maxbytes <= ALLOC_THRESHOLD)
+			break;
 
-#elif __WORDSIZE == 32
-	while (pid != 0 && maxbytes > ONE_GB) {
-		i++;
-		if (i >= max_pids)
-			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
-		maxbytes -= ONE_GB;
-		pid = fork();
-		if (pid < 0)
-		    tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-		if (pid != 0) {
-			pid_cntr++;
-			pid_list[i] = pid;
-		}
-	}
-	if (maxbytes > ONE_GB)
-		alloc_bytes = ONE_GB;
-	else
-		alloc_bytes = (unsigned long)maxbytes;
+		alloc_maxbytes -= ALLOC_THRESHOLD;
+	} while ((pid != 0) && (++i < max_pids));
 
-#elif __WORDSIZE == 64
-	while (pid != 0 && maxbytes > THREE_GB) {
-		i++;
-		if (i >= max_pids)
-			tst_brkm(TBROK, cleanup, "max_pids needs to be increased");
-		maxbytes -= THREE_GB;
-		pid = fork();
-		if (pid < 0)
-			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
-		if (pid != 0) {
-			pid_cntr++;
-			pid_list[i] = pid;
+	alloc_bytes = MIN(ALLOC_THRESHOLD, alloc_maxbytes);
+	if (pid == 0)
+		child_loop_alloc(alloc_bytes);
+
+	/* waits in the loop for all children finish allocating */
+	while(pid_count < pid_cntr) {
+		if (tst_timeout_remaining() < STOP_THRESHOLD) {
+			tst_res(TWARN,
+				"the remaininig time is not enough for testing");
+
+			break;
 		}
+
+		sleep(1);
 	}
-	alloc_bytes = MIN(THREE_GB, maxbytes);
-#endif
 
-	if (pid == 0) {
-		bytecount = chunksize;
-		while (1) {
-			if ((mem = malloc(chunksize)) == NULL) {
-				tst_resm(TBROK | TERRNO,
-					 "stopped@%lu bytes", bytecount);
-				free(pid_list);
-				tst_exit();
-			}
-			if (dowrite)
-				for (j = 0; j < chunksize; j++)
-					*(mem + j) = 'a';
-			if (verbose)
-				tst_resm(TINFO,
-					 "allocated %lu bytes chunksize is %d",
-					 bytecount, chunksize);
-			bytecount += chunksize;
-			if (alloc_bytes && bytecount >= alloc_bytes)
-				break;
+	if (dowrite) {
+		if(pid_count < pid_cntr) {
+			tst_res(TFAIL, "kbytes allocated and used less than expected %llu",
+					original_maxbytes / 1024);
+
+		} else {
+			tst_res(TPASS, "%llu kbytes allocated and used",
+					original_maxbytes / 1024);
 		}
-		if (dowrite)
-			tst_resm(TINFO, "... %lu bytes allocated and used.",
-				 bytecount);
-		else
-			tst_resm(TINFO, "... %lu bytes allocated only.",
-				 bytecount);
-		kill(getppid(), SIGRTMIN);
-		while (1)
-			sleep(1);
 	} else {
-		sysinfo(&sstats);
-
-		if (dowrite) {
-			/* Total Free Post-Test RAM */
-			post_mem =
-			    (unsigned long long)sstats.mem_unit *
-			    sstats.freeram;
-			post_mem =
-			    post_mem +
-			    (unsigned long long)sstats.mem_unit *
-			    sstats.freeswap;
-
-			while ((((unsigned long long)pre_mem - post_mem) <
-				(unsigned long long)original_maxbytes) &&
-			       pid_count < pid_cntr && !sigchld_count) {
-				sleep(1);
-				sysinfo(&sstats);
-				post_mem =
-				    (unsigned long long)sstats.mem_unit *
-				    sstats.freeram;
-				post_mem =
-				    post_mem +
-				    (unsigned long long)sstats.mem_unit *
-				    sstats.freeswap;
-			}
-		}
-
-		if (sigchld_count) {
-			tst_resm(TFAIL, "child process exited unexpectedly");
-		} else if (dowrite) {
-			tst_resm(TPASS, "%llu kbytes allocated and used.",
-				 original_maxbytes / 1024);
+		if(pid_count < pid_cntr) {
+			tst_res(TFAIL, "kbytes allocated less than expected %llu",
+					original_maxbytes / 1024);
 		} else {
-			tst_resm(TPASS, "%llu kbytes allocated only.",
-				 original_maxbytes / 1024);
+			tst_res(TPASS, "%llu kbytes allocated only",
+					original_maxbytes / 1024);
 		}
+	}
 
+	i = 0;
+	while (pid_list[i] > 0) {
+		TST_PROCESS_STATE_WAIT(pid_list[i], 'T');
+		kill(pid_list[i], SIGCONT);
+		i++;
 	}
-	cleanup();
-	tst_exit();
 }
+
+static struct tst_test test = {
+	.forks_child = 1,
+	.options = mtest_options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = mem_test,
+};
-- 
2.20.1

