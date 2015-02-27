Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YRIMe-0004y0-ND
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 10:41:48 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YRIMc-0004rI-Qp
	for ltp-list@lists.sourceforge.net; Fri, 27 Feb 2015 10:41:48 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1RAfdp2029282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Feb 2015 05:41:40 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Feb 2015 11:41:33 +0100
Message-Id: <8508ffa01798c137e7c2c50a7fd97e74702cc569.1425033440.git.jstancek@redhat.com>
In-Reply-To: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
References: <2370af01ebeb2c4014c6d0c4252818a6138d8e19.1425033440.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] sched_setparam/10-1: remove testcase
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
Cc: jkastner@redhat.com

As in 9-1, this hangs on -rt kernel, because alarm(2)
never fires.

In case it runs on single cpu system, it's pretty
much same as 9-1: child process of higher priority
preempts parent.

In case it runs on 2+ CPUs, it doesn't matter that
one child is able to preempt parent, shared value
is going to be increased regardless in all other
children.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../conformance/interfaces/sched_setparam/10-1.c   | 180 ---------------------
 1 file changed, 180 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.c
deleted file mode 100644
index 15dfe41..0000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/10-1.c
+++ /dev/null
@@ -1,180 +0,0 @@
-/*
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *
- * Test that the process that is the head of the highest priority list preempt
- * the process calling sched_setparam() when the calling process sets its own
- * priority lower than that of one or more other non-empty process lists.
- *
- * There is no portable way to get the number of CPUs but the test should work
- * for most of UNIX system (including but not limited to: Linux, Solaris, AIX,
- * HPUX, *BSD).
- * This test used shared memory.
- * Steps:
- *   1. Create a share memory segment.
- *   2. Change the policy to SCHED_FIFO.
- *   3. Create nb_cpu children processes which shall have the same priority
- *      and policy than the father (cf specs of fork).
- *   4. Call sched_setparam with a priority smaller than those of children.
- *   5. Check if the shared value has been changed by a child process. If not,
- *      the test fail.
- */
-
-#include <sched.h>
-#include <stdio.h>
-#include <signal.h>
-#include <sys/ipc.h>
-#include <sys/shm.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <errno.h>
-#include "posixtest.h"
-
-#ifdef BSD
-#include <sys/types.h>
-#include <sys/param.h>
-#include <sys/sysctl.h>
-#endif
-
-#ifdef HPUX
-#include <sys/param.h>
-#include <sys/pstat.h>
-#endif
-
-static int nb_cpu;
-static int *shmptr;
-
-static int get_ncpu(void)
-{
-	int ncpu = -1;
-
-	/* This syscall is not POSIX but it should work on many system */
-#ifdef _SC_NPROCESSORS_ONLN
-	ncpu = sysconf(_SC_NPROCESSORS_ONLN);
-#else
-#ifdef BSD
-	int mib[2];
-	size_t len = sizeof(ncpu);
-	mib[0] = CTL_HW;
-	mib[1] = HW_NCPU;
-	sysctl(mib, 2, &ncpu, &len, NULL, 0);
-#else
-#ifdef HPUX
-	struct pst_dynamic psd;
-	pstat_getdynamic(&psd, sizeof(psd), 1, 0);
-	ncpu = (int)psd.psd_proc_cnt;
-#endif /* HPUX */
-#endif /* BSD */
-#endif /* _SC_NPROCESSORS_ONLN */
-
-	return ncpu;
-}
-
-static void child_process(void)
-{
-	alarm(2);
-
-	while (1) {
-		(*shmptr)++;
-		sched_yield();
-	}
-}
-
-static void kill_children(int *child_pid)
-{
-	int i;
-
-	for (i = 0; i < nb_cpu; i++) {
-		kill(child_pid[i], SIGTERM);
-	}
-}
-
-int main(void)
-{
-	int *child_pid, oldcount, newcount, shm_id, i, j;
-	struct sched_param param;
-	key_t key;
-
-	nb_cpu = get_ncpu();
-
-	if (nb_cpu == -1) {
-		printf("Can not get the number of CPUs of your machines.\n");
-		return PTS_UNRESOLVED;
-	}
-
-	child_pid = malloc(nb_cpu * sizeof(int));
-
-	key = ftok("conformance/interfaces/sched_setparam/10-1.c", 1234);
-	shm_id = shmget(key, sizeof(int), IPC_CREAT | 0600);
-	if (shm_id < 0) {
-		perror("An error occurs when calling shmget()");
-		return PTS_UNRESOLVED;
-	}
-
-	shmptr = shmat(shm_id, 0, 0);
-	if (shmptr == (void *)-1) {
-		perror("An error occurs when calling shmat()");
-		return PTS_UNRESOLVED;
-	}
-	*shmptr = 0;
-
-	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
-
-	if (sched_setscheduler(getpid(), SCHED_FIFO, &param) != 0) {
-		if (errno == EPERM) {
-			printf
-			    ("This process does not have the permission to set its own scheduling "
-			     "parameter.\nTry to launch this test as root\n");
-		} else {
-			perror
-			    ("An error occurs when calling sched_setscheduler()");
-		}
-		return PTS_UNRESOLVED;
-	}
-
-	for (i = 0; i < nb_cpu; i++) {
-		child_pid[i] = fork();
-		if (child_pid[i] == -1) {
-			perror("An error occurs when calling fork()");
-			for (j = 0; j < i; j++) {
-				kill(child_pid[j], SIGTERM);
-			}
-			return PTS_UNRESOLVED;
-		} else if (child_pid[i] == 0) {
-
-			child_process();
-
-			printf("This code should not be executed.\n");
-			return PTS_UNRESOLVED;
-		}
-	}
-
-	sleep(1);
-
-	param.sched_priority--;
-
-	oldcount = *shmptr;
-	if (sched_setparam(getpid(), &param) != 0) {
-		perror("An error occurs when calling sched_setparam()");
-		kill_children(child_pid);
-		return PTS_UNRESOLVED;
-	}
-	newcount = *shmptr;
-
-	if (newcount == oldcount) {
-		printf
-		    ("The calling process does not relinquish the processor\n");
-		kill_children(child_pid);
-		return PTS_FAIL;
-	}
-
-	printf("Test PASSED\n");
-	kill_children(child_pid);
-	return PTS_PASS;
-}
-- 
1.8.3.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
