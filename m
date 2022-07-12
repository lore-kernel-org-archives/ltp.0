Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C40C433EF
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 12:46:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63A2B3CA539
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 14:46:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AC783CA249
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 14:46:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB89E200A0C
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 14:46:29 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DC39B2009F;
 Tue, 12 Jul 2022 12:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1657629988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mYHZ12SX23O41lozVTR15k8tDhELtGvEJAKOC3jTuuk=;
 b=TUKzO2tTQWbOPHDAlrNHDio2Mv3amYOFqkZI5wZfy7Awww2t2WZ4PIUhKPd4V8+E8O7Upe
 BX2taV4a6ksTcZ7pndzlvB1exeAMfHIWeYENwOb9+UlwITivpmHLqXpnosWDbMyBP4hS8J
 emgsD+VCYroSwePfAB/heDY9XmpEL1s=
Received: from g78.suse.de (unknown [10.163.24.226])
 by relay2.suse.de (Postfix) with ESMTP id 8996C2C141;
 Tue, 12 Jul 2022 12:46:28 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 13:46:16 +0100
Message-Id: <20220712124617.23139-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] read_all: Add worker timeout
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Kill and restart workers that take too long to read a file. The
default being one second. A custom time can be set with the new -t
option.

This is to prevent a worker from blocking forever in a read. Currently
when this happens the whole test times out and any remaining files in
the worker's queue are not tested.

As a side effect we can now also set the timeout very low to cause
partial reads.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Joerg Vehlow <lkml@jv-coder.de>
Cc: Li Wang <liwang@redhat.com>
---
 testcases/kernel/fs/read_all/read_all.c | 83 ++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index a5b93b966..d8c68bd33 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -26,8 +26,10 @@
  * an IPC stress test on systems with large numbers of weak cores. This can be
  * overridden with the 'w' parameters.
  */
+#include <signal.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <lapi/fnmatch.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -43,7 +45,9 @@
 #include <pwd.h>
 #include <grp.h>
 
+#include "tst_clocks.h"
 #include "tst_test.h"
+#include "tst_timer.h"
 
 #define QUEUE_SIZE 16384
 #define BUFFER_SIZE 1024
@@ -60,6 +64,7 @@ struct queue {
 struct worker {
 	pid_t pid;
 	struct queue *q;
+	int last_seen;
 };
 
 enum dent_action {
@@ -80,6 +85,8 @@ static char *str_max_workers;
 static long max_workers = 15;
 static struct worker *workers;
 static char *drop_privs;
+static char *str_worker_timeout;
+static int worker_timeout = 1000;
 
 static char *blacklist[] = {
 	NULL, /* reserved for -e parameter */
@@ -227,10 +234,14 @@ static int worker_run(struct worker *self)
 		.sa_flags = 0,
 	};
 	struct queue *q = self->q;
+	struct timespec now;
 
 	sigaction(SIGTTIN, &term_sa, NULL);
 
 	while (1) {
+		tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
+		tst_atomic_store(tst_timespec_to_ms(now), &self->last_seen);
+
 		if (!queue_pop(q, buf))
 			break;
 
@@ -270,11 +281,15 @@ static void spawn_workers(void)
 {
 	int i;
 	struct worker *wa = workers;
+	struct timespec now;
+
+	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
 
 	memset(workers, 0, worker_count * sizeof(*workers));
 
 	for (i = 0; i < worker_count; i++) {
 		wa[i].q = queue_init();
+		wa[i].last_seen = tst_timespec_to_ms(now);
 		wa[i].pid = SAFE_FORK();
 		if (!wa[i].pid) {
 			maybe_drop_privs();
@@ -283,9 +298,52 @@ static void spawn_workers(void)
 	}
 }
 
+static void restart_worker(struct worker *const worker)
+{
+	int wstatus, ret, i, q_len;
+	struct timespec now;
+
+	kill(worker->pid, SIGKILL);
+	ret = waitpid(worker->pid, &wstatus, 0);
+
+	if (ret != worker->pid) {
+		tst_brk(TBROK | TERRNO, "waitpid(%d, ...) = %d",
+			worker->pid, ret);
+	}
+
+	/* Make sure the queue length and semaphore match. Threre is a
+	 * race in qeuue_pop where the semaphore can be decremented
+	 * then the worker killed before updating q->front
+	 */
+	q_len = 0;
+	i = worker->q->front;
+	while (i != worker->q->back) {
+		if (!worker->q->data[i])
+			q_len++;
+
+		i = (i + 1) % QUEUE_SIZE;
+	}
+
+	ret = sem_destroy(&worker->q->sem);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "sem_destroy");
+	ret = sem_init(&worker->q->sem, 1, q_len);
+	if (ret == -1)
+		tst_brk(TBROK | TERRNO, "sem_init");
+
+	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
+	worker->last_seen = tst_timespec_to_ms(now);
+	worker->pid = SAFE_FORK();
+
+	if (!worker->pid)
+		exit(worker_run(worker));
+}
+
 static void work_push_retry(int worker, const char *buf)
 {
 	int i, ret, worker_min, worker_max, usleep_time = 100;
+	struct timespec now;
+	int elapsed;
 
 	if (worker < 0) {
 		/* pick any, try -worker first */
@@ -299,10 +357,25 @@ static void work_push_retry(int worker, const char *buf)
 	i = worker_min;
 
 	for (;;) {
-		ret = queue_push(workers[i].q, buf);
+		struct worker *const w = workers + i;
+
+		ret = queue_push(w->q, buf);
 		if (ret == 1)
 			break;
 
+		tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
+		elapsed =
+			tst_timespec_to_ms(now) - tst_atomic_load(&w->last_seen);
+
+		if (elapsed > worker_timeout) {
+			if (!quiet) {
+				tst_res(TINFO,
+					"Worker %d (%d) stuck for %dms, restarting it",
+					i, w->pid, elapsed);
+			}
+			restart_worker(w);
+		}
+
 		if (++i >= worker_max) {
 			i = worker_min;
 			if (usleep_time < 100000)
@@ -368,6 +441,12 @@ static void setup(void)
 	if (!worker_count)
 		worker_count = MIN(MAX(tst_ncpus() - 1, 1), max_workers);
 	workers = SAFE_MALLOC(worker_count * sizeof(*workers));
+
+	if (tst_parse_int(str_worker_timeout, &worker_timeout, 1, INT_MAX)) {
+		tst_brk(TBROK,
+			"Invalid worker timeout (-t) argument: '%s'",
+			str_worker_count);
+	}
 }
 
 static void cleanup(void)
@@ -465,6 +544,8 @@ static struct tst_test test = {
 		 "Count Override the worker count. Ignores (-w) and the processor count."},
 		{"p", &drop_privs,
 		 "Drop privileges; switch to the nobody user."},
+		{"t:", &str_worker_timeout,
+		 "Milliseconds a worker has to read a file before it is restarted"},
 		{}
 	},
 	.setup = setup,
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
