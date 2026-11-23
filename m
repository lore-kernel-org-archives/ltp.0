Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F70606A31A
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=QzEQRhiE;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Xe7Xkj37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795400354; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=MK8mSgj4arSmFT24bjW094K0bRAVXAG21LFV6N+NuaU=;
 b=QzEQRhiEQuMG9eCW3THnl4dmYIeFPE+3GXwUfRBl9vfgZk13R1TLF2BOA1HEYUdm8SKZQ
 4V7qvPGFG6+B9WXmAcVzvqMbr7C+t58lRnC07P6RB0rpeIxmW45ELwmyDbIl2W1wm58BD/w
 GrWSPeTKT1Jq8hh8H+abtMJURNUs3Xc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B97053CFD84
	for <ltp@archiver.kernel.org>; Mon, 23 Nov 2026 03:19:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A6A53C0159
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 03:18:52 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E330710001FD
 for <ltp@lists.linux.it>; Mon, 23 Nov 2026 03:18:51 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so17002305e9.0
 for <ltp@lists.linux.it>; Sun, 22 Nov 2026 18:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795400331; x=1796005131; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nxsApAnuX41uBsUn2rO2/R7QuV9yFAjix65ZVlm4hbI=;
 b=Xe7Xkj37o7c9+5Q+U6seycrtcQq+c8tLs3/D0rLichGVM0vO3KfS8jz1Iu/vStkZOH
 2jM/+NUaiHkercfrUdgyTuojx983EBeAK7Ymc4f/xfvxmw0f/1EBeLFrLXAE1JUoG9/R
 NXdvfRhwf1vvehYY1Fmp4qYRUON/y6A1xsUKoApfHp/tPYI/UPIVtFcWXtiSizm5kL+2
 bnpka2CTPj5okE7YxuDWVQyLGsiXV1g/MYLJrTWHEMcHUoJHCIvLbP4a3/7GR/pb66N4
 qeG6HjXuPrqPULDpbRM2NHoID/aLUMEjyfVsIiZbIfOUoHpAh7WcMFz+8sE84PYag/dt
 kFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795400331; x=1796005131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nxsApAnuX41uBsUn2rO2/R7QuV9yFAjix65ZVlm4hbI=;
 b=aCxdVBNE7XF9i0zZBVJ8VAz1Juqy3noDDEZn+qGFTsRvraBbCGuzuJzGcEbN1UZueV
 aZwaMJVbEBMXZmdJnlT2VOpnQC0/3mtWbkPlA0OsLXPTUzwNz/7aDbiiduQp1lyio4Bm
 oiNMHbKYhZ2GiIsb2Nb6hoi/U1Cja5UqDhEVCB8GyaybNQxz3pqX1xcyGWyQAOd6N2JV
 TV9iQRa3J8g3sfkhZjNBAW1XKDdVLYdaQl73eXzDLjMbwgL28Fbu6+e7j+JQ218sl/AL
 LSDE0dgk3+1doxwx6PXkpCSukS1qvKzi3uRJ+GAqm6PVe9B6ItgKy1D5Tr6dOgpJsZlU
 YL2Q==
X-Gm-Message-State: APuU4Z9Cv0GrYPWOjps+UZhxpTAWYU3mcnUqVjjojGD71DmjjT61qbSq
 uORxvWhhBZP1Oqc6vXduOItzfOo1EU7CnkGOfZqpXl8PQuy1UvLr4dPQ+PCo8gm3dOqd3X0KJcn
 cmJDvkA==
X-Gm-Gg: AZFdTZfLVDMCTjZOpF1q48lgi4+DGmV1RszkFuIUP+gfqgpNXUz260AsIU20E8CTtZh
 McwNxn/TYxFB2oCLhQ41FVswBrz8uioxmDV/J8196zbFo1PQd1WdwNa/5njhEbH0G0gBAYcZGlp
 yehlVCKtqh4JdGtp6e2EpcFUBrzkNvO0W0Jp0mOhcKnZfak0aFtl0dT9UTmUQHRkqgqCNRffGZK
 6/3Z0SIliXkiSCK1PDrQAwAMhf+k9PWTwkLbfhUFq6CAUZqyZf3cj1bHMpCON96eZ5OVJxboiOX
 M1oLjwdLMPFsIdia0+6bceiMdm1+MESi8yi5NamfS2xXuN0YjjhVu5ALiAkok3Y2LM3q9yE9RAV
 SAHNvBIEOVT4V71ek2jOnE8N+PNuuybbgrzHvNv1d/3FFVhR69HqDpP7al2RBKT6AmMFj0idj1Z
 HPiEJWuzfQWI1ka23ae//cJWMBYHkISH+CJw33t7zGqHYR1vS2ebHyKI/iuOIlSX7tkOjujxWNF
 12UI/ZfQ90UKkGwrIqGzKfxKctDaWL0dPPCijxsW0u6ErNd+vlymfc56rE18+xSlFIqTtvC4h7p
 6P3mVFGyQeNURrNhQoXCy/OnIDlT0JG9bpxfS7TTzAWQThCYSCQRFeM26PzV0PACZKPIGs+Y2/i
 vnfUhKIw/Y8+OXcgKzXWTlb9neZGfgocTUQ==
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr218960585e9.14.1795400331056; 
 Sun, 22 Nov 2026 18:18:51 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb895f7bc1sm113245715e9.3.2026.11.22.18.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 18:18:50 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 23 Nov 2026 02:18:47 +0000
Message-ID: <20261123021848.24966-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] mem/mtest07: Convert shm_test to new LTP API and
 fix race conditions
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The legacy shm_test implementation suffered from severe race conditions
between paired reader and writer threads due to a complete lack of
synchronization. One thread could complete its work, mark the shared
memory segment for deletion with IPC_RMID, and detach. This caused
shm_nattch to drop to 0, prompting the kernel to immediately reclaim the
segment. Consequently, the peer thread's subsequent shmat() call failed
with EINVAL ("Invalid argument"):

    pid[4717]: shmat_rd_wr(): shmget():success got segment id 11
    pid[4717]: do_shmat_shmadt(): got shmat address = 0x7fff8aba0000
    pid[4717]: shmat_rd_wr(): shmget():success got segment id 11
    rm_shared_mem(): shmctl(): Invalid argument
    pid[4717]: do_shmat_shmadt(): shmat_addr = 0xffffffffffffffff
    pid[4717]: shmat_rd_wr(): shmget():success got segment id 12
    pid[4717]: do_shmat_shmadt(): got shmat address = 0x7fff8aba0000
    do_shmat_shmadt(): shmat(): Invalid argument
    pid[4717]: shmat_rd_wr(): shmget():success got segment id 13
    pid[4717]: do_shmat_shmadt(): got shmat address = 0x7fff8aba0000
    pid[4717]: shmat_rd_wr(): shmget():success got segment id 14

Refactor the test to use the modern LTP API (tst_test.h):
- Coordinate reader and writer thread pairs using POSIX barriers to
  ensure safe segment attachment, memory access, single-thread IPC_RMID
  deletion.
- Add an explicit data verification oracle where the reader thread
  checks that data written by the writer matches expectations ('Y').
- Drop hand-rolled iteration loops (-l) and delegate iteration driving
  to the LTP framework's native -i option, updating runtest/mm to run
  20 concurrent threads across 10 iterations.
- Query getpagesize() dynamically instead of assuming 4 KB pages.
- Use IPC_PRIVATE for segment creation instead of hardcoded keys.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/mm                              |   2 +-
 testcases/kernel/mem/mtest07/shm_test.c | 483 ++++++++----------------
 2 files changed, 151 insertions(+), 334 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index c9d460c41..cd67016eb 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -33,7 +33,7 @@ shmt08 shmt08
 shmt09 shmt09
 shmt10 shmt10
 
-shm_test01	shm_test -l 10 -t 2
+shm_test01	shm_test -i 10 -t 20
 mallocstress01	mallocstress
 
 mmapstress01 mmapstress01
diff --git a/testcases/kernel/mem/mtest07/shm_test.c b/testcases/kernel/mem/mtest07/shm_test.c
index 6d4d016a8..9106fb328 100644
--- a/testcases/kernel/mem/mtest07/shm_test.c
+++ b/testcases/kernel/mem/mtest07/shm_test.c
@@ -1,361 +1,178 @@
-/******************************************************************************/
-/*									      */
-/* Copyright (c) International Business Machines  Corp., 2001		      */
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
-
-/******************************************************************************/
-/*                                                                            */
-/* History:     Nov - 21 - 2001 Created - Manoj Iyer, IBM Austin TX.          */
-/*                               email:manjo@austin.ibm.com                   */
-/*                                                                            */
-/*		Nov - 26 - 2001 Modified - Manoj Iyer, IBM Austin Tx.         */
-/*				- Added function rm_shared_mem.               */
-/*                                                                            */
-/*		Dec - 03 - 2001 Modified - Manoj Iyer, IBM Austin Tx.         */
-/*				- Added code to spawn threads.		      */
-/*				- Removed dead code.		              */
-/*				- Checked in the initial version to CVS       */
-/*								              */
-/*		Feb - 27 - 2001 Modified - Manoj Iyer, IBM Austin TX.         */
-/*				- removed compiler warnings.                  */
-/*				- removed compiler errors.                    */
-/*                                                                            */
-/* File:	shm_test.c				                      */
-/*									      */
-/* Description:	This program is designed to stress the Memory management sub -*/
-/*		system of Linux. This program will spawn multiple pairs of    */
-/*		reader and writer threads. One thread will create the shared  */
-/*		segment of random size and write to this memory, the other    */
-/*		pair will read from this memory.		              */
-/*									      */
-/******************************************************************************/
-#include <pthread.h>		/* required by pthread functions                      */
-#include <stdio.h>		/* required by fprintf()                              */
-#include <stdlib.h>		/* required by exit(), atoi()                         */
-#include <string.h>		/* required by strncpy()                              */
-#include <unistd.h>		/* required by getopt(), mmap()                       */
-#include <sys/types.h>		/* required by open(), shmat(), shmdt()               */
-#include <sys/stat.h>		/* required by open()                                 */
-#include <sys/ipc.h>		/* required by shmat() shmdt(), shmctl()              */
-#include <sys/shm.h>		/* required by shmat() shmdt(), shmctl()              */
-#include <sys/mman.h>		/* required by mmap()                                 */
-#include <fcntl.h>		/* required by open()                                 */
-#include <stdint.h>		/* required by uintptr_t                              */
-
-void noprintf(char *string, ...)
-{
-}
-
-#ifdef DEBUG
-#define dprt	printf
-#else
-#define dprt	noprintf
-#endif
-
-#define PTHREAD_EXIT(val)    do {\
-			exit_val = val; \
-                        dprt("pid[%d]: exiting with %d\n", getpid(),exit_val); \
-			pthread_exit((void *)(uintptr_t)exit_val); \
-				} while (0)
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2001
+ * Author: Manoj Iyer <manjo@austin.ibm.com>
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Stress test for the shared memory (SysV IPC) subsystem.
+ *
+ * Creates shared memory segments of random page-aligned size and spawns
+ * pairs of reader and writer threads. For each segment, the threads attach,
+ * touch, and detach the memory, with the writer removing the segment.
+ *
+ * [Algorithm]
+ *
+ * - Writer fills memory with 'Y'; reader waits (Barrier 1).
+ * - Reader verifies data integrity; writer waits (Barrier 2).
+ * - Writer removes segment with IPC_RMID and both detach.
+ */
+
+#include <pthread.h>
+#include <sched.h>
+#include <stdlib.h>
+#include <sys/ipc.h>
+#include <sys/shm.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "tst_safe_sysv_ipc.h"
+
+#define MAXT 1000
+
+struct pair_sync {
+	pthread_barrier_t barrier;
+	int shm_id;
+};
 
-#define OPT_MISSING(prog, opt)   do{\
-			       fprintf(stderr, "%s: option -%c ", prog, opt); \
-                               fprintf(stderr, "requires an argument\n"); \
-                               usage(prog); \
-                                   } while (0)
+struct child_args {
+	pthread_t threadid;
+	size_t map_size;
+	int is_writer;
+	struct pair_sync *sync;
+};
 
-#define MAXT	30		/* default number of threads to create.               */
-#define MAXR	1000		/* default number of repatetions to execute           */
+static char *str_thrds;
+static int num_thrd = 30;
+static volatile int fail_flag;
+static size_t page_size;
 
-struct child_args
-{
-	pthread_t threadid;
-	int num_reps;
-	int shmkey;
-	int map_size;
-	int is_reader;
+static struct pair_sync sync_pairs[MAXT / 2] = {
+	[0 ... (MAXT / 2 - 1)] = {.shm_id = -1}
 };
 
+static struct child_args chld_args[MAXT];
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	usage							      */
-/*									      */
-/* Description:	Print the usage message.				      */
-/*									      */
-/* Return:	exits with -1						      */
-/*									      */
-/******************************************************************************/
-static void usage(char *progname)
-{				/* name of this program                       */
-	fprintf(stderr,
-		"Usage: %s -d NUMDIR -f NUMFILES -h -t NUMTHRD\n"
-		"\t -h Help!\n"
-		"\t -l Number of repatetions to execute:       Default: 1000\n"
-		"\t -t Number of threads to generate:          Default: 30\n",
-		progname);
-	exit(-1);
-}
+static void *shmat_rd_wr(void *vargs)
+{
+	struct child_args *args = vargs;
+	char *shmat_addr;
+	size_t j;
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	rm_shared_mem						      */
-/*									      */
-/* Description:	This function removes the shared segments that were created   */
-/*		This function is called when shmat fails or logical end of    */
-/*		the while loop is reached in shmat_rd_wr function.         */
-/*									      */
-/* Input:	shm_id   - id of the shared memory segment to be removed      */
-/*		shm_addr - address of the shared memory segment to be removed */
-/*		cmd      - remove id only or remove id and detach??           */
-/*			   0 - remove id dont detach segment.                 */
-/*			   1 - remove id and detach segment.                  */
-/*									      */
-/* Output:	NONE.                                                         */
-/*									      */
-/* Return:	exits with -1 on error, 0 on success                          */
-/*									      */
-/******************************************************************************/
-static int rm_shared_mem(key_t shm_id,	/* id of shared memory segment to be removed  */
-			 char *shm_addr,	/* address of shared mem seg to be removed    */
-			 int cmd)
-{				/* remove id only or remove id and detach seg */
-	struct shmid *shmbuf = NULL;	/* info about the segment pointed by shmkey   */
-
-	dprt("pid[%d]: rm_shared_mem(): shm_id = %d shm_addr = %#x cmd = %d\n",
-	     getpid(), shm_id, shm_addr, cmd);
-	if (shmctl(shm_id, IPC_RMID, (struct shmid_ds *)shmbuf) == -1) {
-		dprt("pid[%d]: rm_shared_mem(): shmctl unable to remove shm_id[%d]\n", getpid(), shm_id);
-		perror("rm_shared_mem(): shmctl()");
-		return -1;
-	}
+	shmat_addr = SAFE_SHMAT(args->sync->shm_id, NULL, 0);
 
-	if (cmd) {
-		if (shmdt((void *)shm_addr) == -1) {
-			dprt("pid[%d]:rm_shared_mem(): shmdt unable to detach addr = %#x\n", getpid(), shm_addr);
-			perror("rm_shared_mem(): shmdt()");
-			return -1;
+	if (args->is_writer) {
+		for (j = 0; j < args->map_size; j += page_size) {
+			shmat_addr[j] = 'Y';
+			sched_yield();
 		}
 	}
-	return 0;
-}
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	shmat_rd_wr						      */
-/*									      */
-/* Description:	This function repeatedly attaches and detaches the memory     */
-/*		The size of the file is a multiple of page size.              */
-/*		The function acts as either reader or writer thread depending */
-/*		on arg[3]. The reader and writer thread use the same key so   */
-/*		they get access to the same shared memory segment.            */
-/*									      */
-/* Input:	The argument pointer contains the following.                  */
-/*		arg[0] - number of repatetions of the above operation         */
-/*		arg[1] - shared memory key.				      */
-/*		arg[2] - size of the memory that is to be attached.           */
-/*		arg[3] - reader or writer.                                    */
-/*									      */
-/* Return:	exits with -1 on error, 0 on success                          */
-/*									      */
-/******************************************************************************/
-static void *shmat_rd_wr(void *vargs)
-{				/* arguments to the thread function             */
-	int shmndx = 0;		/* index to the number of attach and detach   */
-	int index = 0;		/* index to the number of blocks touched      */
-	key_t shm_id = 0;	/* shared memory id                           */
-	struct child_args *args = vargs;
-	volatile int exit_val = 0;	/* exit value of the pthread                  */
-	char *read_from_mem;	/* ptr to touch each (4096) block in memory   */
-	char *write_to_mem;	/* ptr to touch each (4096) block in memory   */
-	char *shmat_addr;	/* address of the attached memory             */
-	char buff;		/* temporary buffer                           */
-
-	while (shmndx++ < args->num_reps) {
-		dprt("pid[%d]: shmat_rd_wr(): locargs[1] = %#x\n",
-		     getpid(), args->shmkey);
-
-		/* get shared memory id */
-		if ((shm_id =
-		     shmget(args->shmkey, args->map_size, IPC_CREAT | 0666))
-		    == -1) {
-			dprt("pid[%d]: shmat_rd_wr(): shmget failed\n",
-			     getpid());
-			perror("do_shmat_shmadt(): shmget()");
-			PTHREAD_EXIT(-1);
-		}
+	SAFE_PTHREAD_BARRIER_WAIT(&args->sync->barrier);
 
-		fprintf(stdout, "pid[%d]: shmat_rd_wr(): shmget():"
-			"success got segment id %d\n", getpid(), shm_id);
-
-		/* get shared memory segment */
-		if ((shmat_addr = shmat(shm_id, NULL, 0)) == (void *)-1) {
-			rm_shared_mem(shm_id, shmat_addr, 0);
-			fprintf(stderr,
-				"pid[%d]: do_shmat_shmadt(): shmat_addr = %#lx\n",
-				getpid(), (long)shmat_addr);
-			perror("do_shmat_shmadt(): shmat()");
-			PTHREAD_EXIT(-1);
-		}
-		dprt("pid[%d]: do_shmat_shmadt(): content of memory shmat_addr = %s\n", getpid(), shmat_addr);
-
-		fprintf(stdout,
-			"pid[%d]: do_shmat_shmadt(): got shmat address = %#lx\n",
-			getpid(), (long)shmat_addr);
-
-		if (args->is_reader) {
-			/* write character 'Y' to that memory area */
-			index = 0;
-			write_to_mem = shmat_addr;
-			while (index < args->map_size) {
-				dprt("pid[%d]: do_shmat_shmatd(): write_to_mem = %#x\n", getpid(), write_to_mem);
-				*write_to_mem = 'Y';
-				index++;
-				write_to_mem++;
-				sched_yield();
-			}
-		} else {
-			/* read from the memory area */
-			index = 0;
-			read_from_mem = shmat_addr;
-			while (index < args->map_size) {
-				buff = *read_from_mem;
-				index++;
-				read_from_mem++;
-				sched_yield();
+	if (!args->is_writer) {
+		for (j = 0; j < args->map_size; j += page_size) {
+			if (shmat_addr[j] != 'Y') {
+				tst_res(TFAIL,
+					"Data mismatch at offset %zu: expected 'Y', got '%c'",
+					j, shmat_addr[j]);
+				fail_flag = 1;
+				break;
 			}
 		}
+	}
 
-		sched_yield();
+	SAFE_PTHREAD_BARRIER_WAIT(&args->sync->barrier);
 
-		/* remove the shared memory */
-		if (rm_shared_mem(shm_id, shmat_addr, 1) == -1) {
-			fprintf(stderr,
-				"pid[%d]: do_shmat_shmatd(): rm_shared_mem(): faild to rm id\n",
-				getpid());
-			PTHREAD_EXIT(-1);
-		}
+	if (args->is_writer)
+		SAFE_SHMCTL(args->sync->shm_id, IPC_RMID, NULL);
+
+	SAFE_SHMDT(shmat_addr);
+
+	return NULL;
+}
+
+static void setup(void)
+{
+	page_size = getpagesize();
+
+	if (str_thrds) {
+		if (tst_parse_int(str_thrds, &num_thrd, 2, MAXT))
+			tst_brk(TBROK, "Invalid thread count '%s' (2..%d)", str_thrds, MAXT);
+		if (num_thrd % 2 != 0)
+			tst_brk(TBROK, "Thread count '%s' must be even", str_thrds);
 	}
 
-	PTHREAD_EXIT(0);
+	srand(time(NULL));
 }
 
-/******************************************************************************/
-/*								 	      */
-/* Function:	main							      */
-/*									      */
-/* Description:	This is the entry point to the program. This function will    */
-/*		parse the input arguments and set the values accordingly. If  */
-/*		no arguments (or desired) are provided default values are used*/
-/*		refer the usage function for the arguments that this program  */
-/*		takes. It also creates the threads which do most of the dirty */
-/*		work. If the threads exits with a value '0' the program exits */
-/*		with success '0' else it exits with failure '-1'.             */
-/*									      */
-/* Return:	-1 on failure						      */
-/*		 0 on success						      */
-/*									      */
-/******************************************************************************/
-int main(int argc,		/* number of input parameters                 */
-	 char **argv)
-{				/* pointer to the command line arguments.     */
-	int c;			/* command line options                       */
-	int num_thrd = MAXT;	/* number of threads to create                */
-	int num_reps = MAXR;	/* number of repatitions the test is run      */
+static void cleanup(void)
+{
 	int i;
-	void *th_status;	/* exit status of LWP's                       */
-	int map_size;		/* size of the file mapped.                   */
-	int shmkey = 1969;	/* key used to generate shmid by shmget()     */
-	struct child_args chld_args[30];	/* arguments to the thread function */
-	char *map_address = NULL;
-	/* address in memory of the mapped file       */
-	extern int optopt;	/* options to the program                     */
-
-	while ((c = getopt(argc, argv, "hl:t:")) != -1) {
-		switch (c) {
-		case 'h':
-			usage(argv[0]);
-			break;
-		case 'l':	/* how many repetitions of the test to exec   */
-			if ((num_reps = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_reps < 0) {
-				fprintf(stdout,
-					"WARNING: bad argument. Using default\n");
-				num_reps = MAXR;
-			}
-			break;
-		case 't':
-			if ((num_thrd = atoi(optarg)) == 0)
-				OPT_MISSING(argv[0], optopt);
-			else if (num_thrd < 0 || num_thrd > MAXT) {
-				fprintf(stdout,
-					"WARNING: bad argument. Using default\n");
-				num_thrd = MAXT;
-			}
-			break;
-		default:
-			usage(argv[0]);
-			break;
+
+	for (i = 0; i < MAXT / 2; i++) {
+		if (sync_pairs[i].shm_id != -1) {
+			shmctl(sync_pairs[i].shm_id, IPC_RMID, NULL);
+			sync_pairs[i].shm_id = -1;
 		}
 	}
+}
 
-	for (i = 0; i < num_thrd; i += 2) {
-		srand(time(NULL) % 100);
-		map_size = (1 + (int)(1000.0 * rand() / (RAND_MAX + 1.0))) * 4096;
-
-		dprt("main(): thrd_ndx = %d map_address = %#x map_size = %d\n",
-		     i, map_address, map_size);
-
-		chld_args[i].num_reps = num_reps;
-		chld_args[i].map_size = map_size;
-		chld_args[i].shmkey = shmkey++;
-		chld_args[i].is_reader = 0;
-		if (pthread_create
-		    (&chld_args[i].threadid, NULL, shmat_rd_wr, &chld_args[i])) {
-			perror("shmat_rd_wr(): pthread_create()");
-			exit(-1);
-		}
+static void run(void)
+{
+	int pairs = num_thrd / 2;
+	pthread_attr_t attr;
+	int i;
 
-		chld_args[i + 1] = chld_args[i];
-		chld_args[i + 1].is_reader = 1;
-		if (pthread_create
-		    (&chld_args[i + 1].threadid, NULL, shmat_rd_wr, &chld_args[i + 1])) {
-			perror("shmat_rd_wr(): pthread_create()");
-			exit(-1);
-		}
-	}
+	fail_flag = 0;
 
-	sync();
-
-	for (i = 0; i < num_thrd; i++) {
-		if (pthread_join(chld_args[i].threadid, &th_status) != 0) {
-			perror("shmat_rd_wr(): pthread_join()");
-			exit(-1);
-		} else {
-			dprt("WE ARE HERE %d\n", __LINE__);
-			if (th_status == (void *)-1) {
-				fprintf(stderr,
-					"thread [%ld] - process exited with errors\n",
-					(long)chld_args[i].threadid);
-				exit(-1);
-			}
-		}
+	pthread_attr_init(&attr);
+	pthread_attr_setstacksize(&attr, 256 * 1024);
+
+	for (i = 0; i < pairs; i++) {
+		size_t map_size = (size_t)(1 + rand() % 1000) * page_size;
+		int idx = i * 2;
+
+		sync_pairs[i].shm_id = SAFE_SHMGET(IPC_PRIVATE, map_size, IPC_CREAT | 0666);
+		SAFE_PTHREAD_BARRIER_INIT(&sync_pairs[i].barrier, NULL, 2);
+
+		chld_args[idx].map_size = map_size;
+		chld_args[idx].is_writer = 0;
+		chld_args[idx].sync = &sync_pairs[i];
+
+		chld_args[idx + 1].map_size = map_size;
+		chld_args[idx + 1].is_writer = 1;
+		chld_args[idx + 1].sync = &sync_pairs[i];
+
+		SAFE_PTHREAD_CREATE(&chld_args[idx].threadid, &attr,
+				    shmat_rd_wr, &chld_args[idx]);
+		SAFE_PTHREAD_CREATE(&chld_args[idx + 1].threadid, &attr,
+				    shmat_rd_wr, &chld_args[idx + 1]);
 	}
-	exit(0);
+
+	pthread_attr_destroy(&attr);
+
+	for (i = 0; i < pairs * 2; i++)
+		SAFE_PTHREAD_JOIN(chld_args[i].threadid, NULL);
+
+	for (i = 0; i < pairs; i++)
+		SAFE_PTHREAD_BARRIER_DESTROY(&sync_pairs[i].barrier);
+
+	if (!fail_flag)
+		tst_res(TPASS, "shm_test passed with %d threads", pairs * 2);
 }
+
+static struct tst_option options[] = {
+	{"t:", &str_thrds, "Number of threads to generate (default: 30)"},
+	{}
+};
+
+static struct tst_test test = {
+	.options = options,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
