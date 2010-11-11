Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PGOX0-0003Ml-VV
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 04:13:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PGOWv-0001NO-Uf
	for ltp-list@lists.sourceforge.net; Thu, 11 Nov 2010 04:13:02 +0000
Message-ID: <4CDB6D54.1000605@cn.fujitsu.com>
Date: Thu, 11 Nov 2010 12:13:08 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
References: <4CDB6AEC.9090604@cn.fujitsu.com>
In-Reply-To: <4CDB6AEC.9090604@cn.fujitsu.com>
Subject: [LTP]  [POSIX][PATCH 3/4]Get rid of aio_suspend/8-1
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

If following patch be applied, aio_suspend/8-1 is same as 1-1, i suggest to remove it.

http://sourceforge.net/mailarchive/forum.php?thread_name=4CDB5E53.6070604%40cn.fujitsu.com&forum_name=ltp-list

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../conformance/interfaces/aio_suspend/8-1.c       |  240 --------------------
 1 files changed, 0 insertions(+), 240 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
deleted file mode 100644
index 0023520..0000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/aio_suspend/8-1.c
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * Copyright (c) 2004, Bull SA. All rights reserved.
- * Created by:  Laurent.Vivier@bull.net
- * This file is licensed under the GPL license.  For the full content
- * of this license, see the COPYING file at the top level of this 
- * source tree.
- */
-
-/*
- * assertion:
- *
- *	The aio_suspend() function shall suspend the calling thread until at
- *	least one of the asynchronous I/O operations referenced by the list
- *	argument has completed, until a signal interrupts the function, or,
- *	if timeout is not NULL, until the time interval specified by timeout
- *	has passed.
- *
- * method: Testing for a NULL timeout
- *
- *	- write to a file
- *	- submit a list of read requests
- *	- check that the selected request has not completed
- *	- suspend on selected request
- *	- check that the selected request has completed using aio_error and
- *	  aio_return
- *
- */
-
-#define _XOPEN_SOURCE 600
-#include <sys/stat.h>
-#include <aio.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <unistd.h>
-
-#include "posixtest.h"
-
-#define TNAME "aio_suspend/8-1.c"
-
-#define NUM_AIOCBS	10
-#define BUF_SIZE	1024*1024
-#define WAIT_FOR_AIOCB	6
-
-int received_selected	= 0;
-int received_all	= 0;
-
-void
-sigrt1_handler(int signum, siginfo_t *info, void *context)
-{
-	if (info->si_value.sival_int == WAIT_FOR_AIOCB)
-		received_selected = 1;
-}
-
-void
-sigrt2_handler(int signum, siginfo_t *info, void *context)
-{
-	received_all = 1;
-}
-
-int
-main ()
-{
-	char tmpfname[256];
-	int fd;
-
-	struct aiocb **aiocbs;
-	struct aiocb *plist[2];
-	char *bufs;
-	struct sigaction action;
-	struct sigevent event;
-	int errors = 0;
-	int ret;
-	int err;
-	int i;
-
-	if (sysconf(_SC_ASYNCHRONOUS_IO) != 200112L)
-		return PTS_UNSUPPORTED;
-
-	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_suspend_8_1_%d", 
-		  getpid());
-	unlink(tmpfname);
-
-	fd = open(tmpfname, O_CREAT | O_RDWR | O_EXCL, S_IRUSR | S_IWUSR);
-
-	if (fd == -1) {
-		printf(TNAME " Error at open(): %s\n",
-		       strerror(errno));
-		exit(PTS_UNRESOLVED);
-	}
-
-	unlink(tmpfname);
-
-	bufs = (char *) malloc (NUM_AIOCBS*BUF_SIZE);
-
-	if (bufs == NULL) {
-		printf (TNAME " Error at malloc(): %s\n", strerror (errno));
-		close (fd);
-		exit(PTS_UNRESOLVED);
-	}
-
-	if (write (fd, bufs, NUM_AIOCBS*BUF_SIZE) != (NUM_AIOCBS*BUF_SIZE)) {
-		printf(TNAME " Error at write(): %s\n", strerror(errno));
-		free (bufs);
-		close (fd);
-		exit(PTS_UNRESOLVED);
-	}
-
-
-
-	aiocbs = (struct aiocb**)malloc(sizeof(struct aiocb *) * NUM_AIOCBS);
-
-	/* Queue up a bunch of aio reads */
-	for (i = 0; i < NUM_AIOCBS; i++) {
-
-		aiocbs[i] = (struct aiocb*)malloc(sizeof(struct aiocb));
-		memset(aiocbs[i], 0, sizeof(struct aiocb));
-
-		aiocbs[i]->aio_fildes = fd;
-		aiocbs[i]->aio_offset = i * BUF_SIZE;
-		aiocbs[i]->aio_buf = &bufs[i*BUF_SIZE];
-		aiocbs[i]->aio_nbytes = BUF_SIZE;
-		aiocbs[i]->aio_lio_opcode = LIO_READ;
-
-		/* Use SIRTMIN+1 for individual completions */
-		aiocbs[i]->aio_sigevent.sigev_notify = SIGEV_SIGNAL;
-		aiocbs[i]->aio_sigevent.sigev_signo = SIGRTMIN+1;
-		aiocbs[i]->aio_sigevent.sigev_value.sival_int = i;
-	}
-
-	/* Use SIGRTMIN+2 for list completion */
-	event.sigev_notify = SIGEV_SIGNAL;
-	event.sigev_signo = SIGRTMIN+2;
-	event.sigev_value.sival_ptr = NULL;
-
-	/* Setup handler for individual operation completion */
-	action.sa_sigaction = sigrt1_handler;
-	sigemptyset(&action.sa_mask);
-	action.sa_flags = SA_SIGINFO|SA_RESTART;
-	sigaction(SIGRTMIN+1, &action, NULL);
-
-	/* Setup handler for list completion */
-	action.sa_sigaction = sigrt2_handler;
-	sigemptyset(&action.sa_mask);
-	action.sa_flags = SA_SIGINFO|SA_RESTART;
-	sigaction(SIGRTMIN+2, &action, NULL);
-
-	/* Setup suspend list */
-	plist[0] = NULL;
-	plist[1] = aiocbs[WAIT_FOR_AIOCB];
-
-	/* Submit request list */
-	ret = lio_listio(LIO_NOWAIT, aiocbs, NUM_AIOCBS, &event);
-
-	if (ret) {
-		printf(TNAME " Error at lio_listio() %d: %s\n", errno, strerror(errno));
-		for (i=0; i<NUM_AIOCBS; i++)
-			free (aiocbs[i]);
-		free (bufs);
-		free (aiocbs);
-		close (fd);
-		exit (PTS_UNRESOLVED);
-	}
-
-	/* Check selected request has not completed yet */
-	if (received_selected) {
-		printf (TNAME " Error : AIOCB %d already completed before suspend\n",
-			WAIT_FOR_AIOCB);
-		for (i=0; i<NUM_AIOCBS; i++)
-			free (aiocbs[i]);
-		free (bufs);
-		free (aiocbs);
-		close (fd);
-		exit (PTS_FAIL);
-	}
-
-	/* Suspend on selected request */
-	ret = aio_suspend((const struct aiocb **)plist, 2, NULL);
-
-	if (ret) {
-		printf (TNAME " Error at aio_suspend() %d: %s\n", errno, strerror (errno));
-		for (i=0; i<NUM_AIOCBS; i++)
-			free (aiocbs[i]);
-		free (bufs);
-		free (aiocbs);
-		close (fd);
-		exit (PTS_FAIL);
-	}
-
-	/* Check selected request has completed */
-	err = aio_error (aiocbs[WAIT_FOR_AIOCB]);
-	ret = aio_return (aiocbs[WAIT_FOR_AIOCB]);
-	
-	if ((err != 0) && (ret !=  BUF_SIZE)) {
-		printf (TNAME " Error : AIOCB %d should have completed after suspend\n",
-			WAIT_FOR_AIOCB);
-		for (i=0; i<NUM_AIOCBS; i++)
-			free (aiocbs[i]);
-		free (bufs);
-		free (aiocbs);
-		close (fd);
-		exit (PTS_FAIL);
-	}
-
-
-	/* Wait for list processing completion */
-	while (!received_all)
-		sleep (1);
-
-	/* Check return code and free things */
-	for (i = 0; i < NUM_AIOCBS; i++) {
-		if (i == WAIT_FOR_AIOCB)
-			continue;
-
-	  	err = aio_error(aiocbs[i]);
-		ret = aio_return(aiocbs[i]);
-
-		if ((err != 0) && (ret != BUF_SIZE)) {
-			printf(TNAME " req %d: error = %d - return = %d\n", i, err, ret);
-			errors++;
-		}
-
-		free (aiocbs[i]);
-	}
-
-	free (bufs);
-	free (aiocbs);
-
-	close(fd);
-
-	if (errors != 0)
-		exit (PTS_FAIL);
-
-	printf (TNAME " PASSED\n");
-
-	return PTS_PASS;
-}
-- 
1.7.0.4




------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
