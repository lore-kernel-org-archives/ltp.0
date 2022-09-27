Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C4C54EE9
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5E123C66A2
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:15:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD4D93C91E2
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AAC8C1000DCC
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 484D41F891;
 Tue, 27 Sep 2022 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EINcHCKYxAznP4Pq6Oxht9ArpSBLhNg+KlEo2vzSGRk=;
 b=PxqLlVX6W9nMwsCS1Ytu0TVBvTXHY9SciyDzzOqVHYR+tJRalInBqo0TtbdQbLK56fcfHg
 xvGY+5tNQxhWGe+CvNEmD1EyKVyvGa/xV8KnGuImHyqgWxcO/bqYY0jINzW++Zh8es1dck
 k1DbovRfmlmN7ShDbPpZk/CBt+ECkPw=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id 703C12C16B;
 Tue, 27 Sep 2022 16:14:22 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:08 +0100
Message-Id: <20220927161408.23743-7-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/6] read_all: Migrate to the worker lib
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

Use the worker API added in the previous commit.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/fs/read_all/read_all.c | 588 +++++++-----------------
 1 file changed, 171 insertions(+), 417 deletions(-)

diff --git a/testcases/kernel/fs/read_all/read_all.c b/testcases/kernel/fs/read_all/read_all.c
index 266678ea7..6d3ff4594 100644
--- a/testcases/kernel/fs/read_all/read_all.c
+++ b/testcases/kernel/fs/read_all/read_all.c
@@ -27,9 +27,9 @@
  * overridden with the 'w' parameters.
  */
 #include <signal.h>
+#include <stdint.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/wait.h>
 #include <fnmatch.h>
 #include <lapi/fnmatch.h>
 #include <stdlib.h>
@@ -40,7 +40,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <limits.h>
-#include <semaphore.h>
 #include <ctype.h>
 #include <pwd.h>
 #include <grp.h>
@@ -49,28 +48,12 @@
 #include "tst_safe_clocks.h"
 #include "tst_test.h"
 #include "tst_timer.h"
+#include "tst_worker.h"
 
-#define QUEUE_SIZE 16384
 #define BUFFER_SIZE 1024
 #define MAX_PATH 4096
 #define MAX_DISPLAY 40
 
-struct queue {
-	sem_t sem;
-	int front;
-	int back;
-	char data[QUEUE_SIZE];
-	char popped[BUFFER_SIZE];
-};
-
-struct worker {
-	int i;
-	pid_t pid;
-	struct queue *q;
-	int last_seen;
-	unsigned int kill_sent:1;
-};
-
 enum dent_action {
 	DA_UNKNOWN,
 	DA_IGNORE,
@@ -78,19 +61,21 @@ enum dent_action {
 	DA_VISIT,
 };
 
+struct path_worker {
+	char cur[MAX_PATH];
+	char next[MAX_PATH];
+};
+
 static char *verbose;
 static char *quiet;
 static char *root_dir;
 static char *str_reads;
 static int reads = 1;
 static char *str_worker_count;
-static long worker_count;
 static char *str_max_workers;
 static long max_workers = 15;
-static struct worker *workers;
 static char *drop_privs;
 static char *str_worker_timeout;
-static int worker_timeout;
 static int timeout_warnings_left = 15;
 
 static char *blacklist[] = {
@@ -101,83 +86,9 @@ static char *blacklist[] = {
 	"/sys/*/cpu??*(?)/*",	/* cpu* entries with 2 or more digits */
 };
 
-static long long epoch;
-
-static int atomic_timestamp(void)
-{
-	struct timespec now;
-
-	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &now);
-
-	return tst_timespec_to_us(now) - epoch;
-}
-
-static int queue_pop(struct queue *q)
-{
-	int i = q->front, j = 0;
-
-	sem_wait(&q->sem);
-
-	if (!q->data[i])
-		return 0;
-
-	while (q->data[i]) {
-		q->popped[j] = q->data[i];
-
-		if (++j >= BUFFER_SIZE - 1)
-			tst_brk(TBROK, "Buffer is too small for path");
-
-		 i = (i + 1) % QUEUE_SIZE;
-	}
-
-	q->popped[j] = '\0';
-	tst_atomic_store((i + 1) % QUEUE_SIZE, &q->front);
-
-	return 1;
-}
-
-static int queue_push(struct queue *q, const char *buf)
-{
-	int i = q->back, j = 0;
-	int front = tst_atomic_load(&q->front);
-
-	do {
-		q->data[i] = buf[j];
-
-		i = (i + 1) % QUEUE_SIZE;
-
-		if (i == front)
-			return 0;
-
-	} while (buf[j++]);
-
-	q->back = i;
-	sem_post(&q->sem);
-
-	return 1;
-}
-
-static struct queue *queue_init(void)
-{
-	struct queue *q = SAFE_MMAP(NULL, sizeof(*q),
-				    PROT_READ | PROT_WRITE,
-				    MAP_SHARED | MAP_ANONYMOUS,
-				    0, 0);
-
-	sem_init(&q->sem, 1, 0);
-	q->front = 0;
-	q->back = 0;
-
-	return q;
-}
-
-static void queue_destroy(struct queue *q, int is_worker)
-{
-	if (is_worker)
-		sem_destroy(&q->sem);
-
-	SAFE_MUNMAP(q, sizeof(*q));
-}
+static struct tst_workers workers;
+static struct path_worker *worker_privs;
+struct tst_evloop evloop;
 
 static void sanitize_str(char *buf, ssize_t count)
 {
@@ -208,63 +119,45 @@ static int is_blacklisted(const char *path)
 	return 0;
 }
 
-static void worker_heartbeat(const int worker)
-{
-	tst_atomic_store(atomic_timestamp(), &workers[worker].last_seen);
-}
-
-static int worker_elapsed(const int worker)
-{
-	struct worker *const w = workers + worker;
-
-	return atomic_timestamp() - tst_atomic_load(&w->last_seen);
-}
-
-static int worker_ttl(const int worker)
-{
-	return MAX(0, worker_timeout - worker_elapsed(worker));
-}
-
-static void read_test(const int worker, const char *const path)
+static void read_test(struct tst_worker *self, char *path)
 {
 	char buf[BUFFER_SIZE];
 	int fd;
 	ssize_t count;
-	const pid_t pid = workers[worker].pid;
-	int elapsed;
+	long long elapsed;
 
 	if (is_blacklisted(path))
 		return;
 
 	if (verbose)
-		tst_res(TINFO, "Worker %d: %s(%s)", pid, __func__, path);
+		tst_res(TINFO, "%s: %s(%s)", tst_worker_idstr(self), __func__, path);
 
 	fd = open(path, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
 		if (!quiet) {
-			tst_res(TINFO | TERRNO, "Worker %d (%d): open(%s)",
-				pid, worker, path);
+			tst_res(TINFO | TERRNO, "%s: open(%s)",
+			        tst_worker_idstr(self), path);
 		}
 		return;
 	}
 
-	worker_heartbeat(worker);
+	elapsed = tst_chan_elapsed(&self->chan);
 	count = read(fd, buf, sizeof(buf) - 1);
-	elapsed = worker_elapsed(worker);
+	elapsed = tst_chan_elapsed(&self->chan) - elapsed;
 
 	if (count > 0 && verbose) {
 		sanitize_str(buf, count);
 		tst_res(TINFO,
-			"Worker %d (%d): read(%s, buf) = %zi, buf = %s, elapsed = %dus",
-			pid, worker, path, count, buf, elapsed);
+			"%s: read(%s, buf) = %zi, buf = %s, elapsed = %llus",
+			tst_worker_idstr(self), path, count, buf, elapsed);
 	} else if (!count && verbose) {
 		tst_res(TINFO,
-			"Worker %d (%d): read(%s) = EOF, elapsed = %dus",
-			pid, worker, path, elapsed);
+			"%s: read(%s) = EOF, elapsed = %llus",
+			tst_worker_idstr(self), path, elapsed);
 	} else if (count < 0 && !quiet) {
 		tst_res(TINFO | TERRNO,
-			"Worker %d (%d): read(%s), elapsed = %dus",
-			pid, worker, path, elapsed);
+			"%s: read(%s), elapsed = %llus",
+			tst_worker_idstr(self), path, elapsed);
 	}
 
 	SAFE_CLOSE(fd);
@@ -294,254 +187,213 @@ static void maybe_drop_privs(void)
 		tst_brk(TBROK | TTERRNO, "Failed to use nobody uid");
 }
 
-static int worker_run(int worker)
+static void visit_dir(struct tst_worker *self, const char *path)
 {
+	DIR *dir;
+	struct dirent *dent;
+	struct stat dent_st;
+	char dent_path[MAX_PATH];
+	enum dent_action act;
+
+	dir = opendir(path);
+	if (!dir) {
+		tst_res(TINFO | TERRNO, "opendir(%s)", path);
+		return;
+	}
+
+	while (1) {
+		errno = 0;
+		dent = readdir(dir);
+		if (!dent && errno) {
+			tst_res(TINFO | TERRNO, "readdir(%s)", path);
+			break;
+		} else if (!dent) {
+			break;
+		}
+
+		if (!strcmp(dent->d_name, ".") ||
+		    !strcmp(dent->d_name, ".."))
+			continue;
+
+		if (dent->d_type == DT_DIR)
+			act = DA_VISIT;
+		else if (dent->d_type == DT_LNK)
+			act = DA_IGNORE;
+		else if (dent->d_type == DT_UNKNOWN)
+			act = DA_UNKNOWN;
+		else
+			act = DA_READ;
+
+		snprintf(dent_path, MAX_PATH,
+			 "%s/%s", path, dent->d_name);
+
+		if (act == DA_UNKNOWN) {
+			if (lstat(dent_path, &dent_st))
+				tst_res(TINFO | TERRNO, "lstat(%s)", path);
+			else if ((dent_st.st_mode & S_IFMT) == S_IFDIR)
+				act = DA_VISIT;
+			else if ((dent_st.st_mode & S_IFMT) == S_IFLNK)
+				act = DA_IGNORE;
+			else
+				act = DA_READ;
+		}
+
+		if (act == DA_VISIT)
+			visit_dir(self, dent_path);
+		else if (act == DA_READ)
+			tst_chan_send(&self->chan, dent_path, strlen(dent_path) + 1);
+	}
+
+	if (closedir(dir))
+		tst_res(TINFO | TERRNO, "closedir(%s)", path);
+}
+
+static int dir_worker_run(struct tst_worker *self)
+{
+	visit_dir(self, root_dir);
+
+	tst_res(TINFO, "Dir Worker %d (%d): fin.", self->pid, self->i);
+	tst_chan_send(&self->chan, "", 1);
+
+	return 0;
+}
+
+static int path_worker_run(struct tst_worker *self)
+{
+	char buf[BUFFER_SIZE];
 	struct sigaction term_sa = {
 		.sa_handler = SIG_IGN,
 		.sa_flags = 0,
 	};
-	struct worker *const self = workers + worker;
-	struct queue *q = self->q;
 
 	sigaction(SIGTTIN, &term_sa, NULL);
 	maybe_drop_privs();
-	self->pid = getpid();
-
-	if (!worker_ttl(self->i)) {
-		tst_brk(TBROK,
-			"Worker timeout is too short; restarts take >%dus",
-			worker_elapsed(self->i));
-	}
 
 	while (1) {
-		worker_heartbeat(worker);
+		tst_chan_recv(&self->chan, buf, PATH_MAX);
 
-		if (!queue_pop(q))
+		if (!buf[0])
 			break;
 
-		read_test(worker, q->popped);
+		read_test(self, buf);
 	}
 
-	queue_destroy(q, 1);
 	tst_flush();
 	return 0;
 }
 
-static void spawn_workers(void)
+static void path_worker_resend(struct tst_worker *const self)
 {
-	int i;
-	struct worker *wa = workers;
-
-	memset(workers, 0, worker_count * sizeof(*workers));
+	struct path_worker *pw = self->priv;
 
-	for (i = 0; i < worker_count; i++) {
-		wa[i].i = i;
-		wa[i].q = queue_init();
-		wa[i].last_seen = atomic_timestamp();
-		wa[i].pid = SAFE_FORK();
-		if (!wa[i].pid)
-			exit(worker_run(i));
-	}
+	tst_chan_send(&self->chan, pw->next, strlen(pw->next));
 }
 
-static void restart_worker(const int worker)
+static void do_next_path(struct tst_worker *path_worker)
 {
-	struct worker *const w = workers + worker;
-	int wstatus, ret, i, q_len;
+	size_t slen = 1;
+	struct tst_worker *const dir_worker = workers.vec;
+	struct path_worker *pw = path_worker->priv;
 
-	if (!w->kill_sent) {
-		SAFE_KILL(w->pid, SIGKILL);
-		w->kill_sent = 1;
-		worker_heartbeat(worker);
-	}
-
-	ret = waitpid(w->pid, &wstatus, WNOHANG);
+	pw->next[0] = '\0';
 
-	if (!ret) {
-		if (worker_ttl(worker) > 0)
-			return;
+	if (TST_STATE_GET(&dir_worker->mach, TST_STATE_ANY) != WS_RUNNING)
+		goto send;
 
-		if (!quiet || timeout_warnings_left) {
-			tst_res(TINFO,
-				"Worker %d (%d): Timeout waiting after kill",
-				w->pid, worker);
-		}
-	} else if (ret != w->pid) {
-		tst_brk(TBROK | TERRNO, "Worker %d (%d): waitpid = %d",
-			w->pid, worker, ret);
-	}
+	tst_chan_recv(&dir_worker->chan, pw->next, BUFFER_SIZE);
 
-	w->kill_sent = 0;
+	if (!pw->next[0])
+		TST_STATE_SET(&dir_worker->mach, WS_STOPPING);
 
-	if (!w->q->popped[0]) {
-		tst_brk(TBROK,
-			"Worker %d (%d): Timed out, but doesn't appear to be reading anything",
-			w->pid, worker);
-	}
+	slen = dir_worker->chan.in.len;
+send:
+	tst_chan_send(&path_worker->chan, pw->next, slen);
 
-	if (!quiet || timeout_warnings_left) {
-		tst_res(TINFO, "Worker %d (%d): Last popped '%s'",
-			w->pid, worker, w->q->popped);
-	}
+}
 
-	/* Make sure the queue length and semaphore match. Threre is a
-	 * race in qeue_pop where the semaphore can be decremented
-	 * then the worker killed before updating q->front
-	 */
-	q_len = 0;
-	i = w->q->front;
-	while (i != w->q->back) {
-		if (!w->q->data[i])
-			q_len++;
-
-		i = (i + 1) % QUEUE_SIZE;
-	}
+static void path_worker_sent(struct tst_worker *self, char *path, size_t len)
+{
+	struct path_worker *pw = self->priv;
 
-	ret = sem_destroy(&w->q->sem);
-	if (ret == -1)
-		tst_brk(TBROK | TERRNO, "sem_destroy");
-	ret = sem_init(&w->q->sem, 1, q_len);
-	if (ret == -1)
-		tst_brk(TBROK | TERRNO, "sem_init");
+	memcpy(pw->cur, path, len);
 
-	worker_heartbeat(worker);
-	w->pid = SAFE_FORK();
+	if (!path[0])
+		return;
 
-	if (!w->pid)
-		exit(worker_run(worker));
+	do_next_path(self);
 }
 
-static void check_timeout_warnings_limit(void)
+static int check_timeout_warnings_limit(void)
 {
 	if (!quiet)
-		return;
+		return 1;
 
 	timeout_warnings_left--;
 
 	if (timeout_warnings_left)
-		return;
+		return 1;
 
 	tst_res(TINFO,
 		"Silencing timeout warnings; consider increasing LTP_RUNTIME_MUL or removing -q");
-}
-
-static int try_push_work(const int worker, const char *buf)
-{
-	int ret = 0;
-	int elapsed;
-	struct worker *const w = workers + worker;
-
-	if (w->kill_sent) {
-		restart_worker(worker);
-		return 0;
-	}
-
-	ret = queue_push(w->q, buf);
-	if (ret)
-		return 1;
-
-	elapsed = worker_elapsed(worker);
-
-	if (elapsed > worker_timeout) {
-		if (!quiet || timeout_warnings_left) {
-			tst_res(TINFO,
-				"Worker %d (%d): Stuck for %dus, restarting it",
-				w->pid, worker, elapsed);
-			check_timeout_warnings_limit();
-		}
-		restart_worker(worker);
-	}
 
 	return 0;
 }
 
-static void push_work(const int worker, const char *buf)
+static void path_worker_died(struct tst_worker *self)
 {
-	int sleep_time = 1;
+	struct path_worker *pw = self->priv;
 
-	while (!try_push_work(worker, buf)) {
-		const int ttl = worker_ttl(worker);
-
-		sleep_time = MIN(2 * sleep_time, ttl);
-		usleep(sleep_time);
+	if (pw->cur[0] == '\0') {
+		tst_brk(TBROK,
+			"%s: Died, but doesn't appear to be reading anything",
+			tst_worker_idstr(self));
 	}
-}
-
-static void stop_workers(void)
-{
-	const char stop_code[1] = { '\0' };
-	int i;
 
-	if (!workers)
-		return;
+	if (check_timeout_warnings_limit())
+		tst_res(TINFO, "%s: Died; Last sent '%s'", tst_worker_idstr(self), pw->cur);
 
-	for (i = 0; i < worker_count; i++) {
-		if (workers[i].q)
-			push_work(i, stop_code);
-	}
+	tst_worker_start(self);
+	path_worker_resend(self);
 }
 
-static void destroy_workers(void)
+static void spawn_workers(void)
 {
 	int i;
+	long wcount = workers.count;
+	struct tst_worker *wa = workers.vec;
 
-	if (!workers)
-		return;
-
-	for (i = 0; i < worker_count; i++) {
-		if (workers[i].q) {
-			queue_destroy(workers[i].q, 0);
-			workers[i].q = 0;
-		}
-	}
-}
-
-static int sched_work(const int first_worker,
-		      const char *path, int repetitions)
-{
-	int i, j;
-	int min_ttl = worker_timeout, sleep_time = 1;
-	int pushed, workers_pushed = 0;
-
-	for (i = 0, j = first_worker; i < repetitions; j++) {
-		if (j >= worker_count)
-			j = 0;
-
-		if (j == first_worker && !workers_pushed) {
-			sleep_time = MIN(2 * sleep_time, min_ttl);
-			usleep(sleep_time);
-			min_ttl = worker_timeout;
-		}
+	wa[0].name = "Dir";
+	wa[0].run = dir_worker_run;
+	wa[0].mode = TST_WORKER_SYNC;
 
-		if (j == first_worker)
-			workers_pushed = 0;
+	tst_worker_start(wa);
 
-		pushed = try_push_work(j, path);
-		i += pushed;
-		workers_pushed += pushed;
+	for (i = 1; i < wcount; i++) {
+		wa[i].name = "Path";
+		wa[i].run = path_worker_run;
+		wa[i].on_sent = path_worker_sent;
+		wa[i].on_died = path_worker_died;
+		wa[i].mode = TST_WORKER_ASYNC;
+		wa[i].priv = worker_privs + i;
 
-		if (!pushed)
-			min_ttl = MIN(min_ttl, worker_ttl(j));
+		tst_worker_start(wa + i);
+		do_next_path(wa + i);
 	}
-
-	return j;
 }
 
 static void setup(void)
 {
-	struct timespec now;
-
 	if (tst_parse_int(str_reads, &reads, 1, INT_MAX))
 		tst_brk(TBROK,
 			"Invalid reads (-r) argument: '%s'", str_reads);
 
-	if (tst_parse_long(str_max_workers, &max_workers, 1, LONG_MAX)) {
+	if (tst_parse_long(str_max_workers, &max_workers, 2, LONG_MAX)) {
 		tst_brk(TBROK,
 			"Invalid max workers (-w) argument: '%s'",
 			str_max_workers);
 	}
 
-	if (tst_parse_long(str_worker_count, &worker_count, 1, LONG_MAX)) {
+	if (tst_parse_long(str_worker_count, &workers.count, 2, LONG_MAX)) {
 		tst_brk(TBROK,
 			"Invalid worker count (-W) argument: '%s'",
 			str_worker_count);
@@ -550,139 +402,41 @@ static void setup(void)
 	if (!root_dir)
 		tst_brk(TBROK, "The directory argument (-d) is required");
 
-	if (!worker_count)
-		worker_count = MIN(MAX(tst_ncpus() - 1, 1L), max_workers);
-	workers = SAFE_MALLOC(worker_count * sizeof(*workers));
+	if (!workers.count)
+		workers.count = MIN(MAX(tst_ncpus() - 1, 2L), max_workers);
 
-	if (tst_parse_int(str_worker_timeout, &worker_timeout, 1, INT_MAX)) {
+	workers.vec = SAFE_MALLOC(workers.count * sizeof(workers.vec[0]));
+	memset(workers.vec, 0, workers.count * sizeof(workers.vec[0]));
+	worker_privs = SAFE_MALLOC(workers.count * sizeof(struct path_worker));
+
+	if (tst_parse_int(str_worker_timeout, (int *)&workers.timeout, 1, INT_MAX)) {
 		tst_brk(TBROK,
 			"Invalid worker timeout (-t) argument: '%s'",
 			str_worker_count);
 	}
 
-	if (worker_timeout) {
-		tst_res(TINFO, "Worker timeout forcibly set to %dms",
-			worker_timeout);
+	if (workers.timeout) {
+		tst_res(TINFO, "Worker timeout forcibly set to %lldms",
+			workers.timeout);
 	} else {
-		worker_timeout = 10 * tst_remaining_runtime();
-		tst_res(TINFO, "Worker timeout set to 10%% of max_runtime: %dms",
-			worker_timeout);
+		workers.timeout = 10 * tst_remaining_runtime();
+		tst_res(TINFO, "Worker timeout set to 10%% of max_runtime: %lldms",
+			workers.timeout);
 	}
-	worker_timeout *= 1000;
+	workers.timeout *= 1000;
 
-	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &now);
-	epoch = tst_timespec_to_us(now);
-}
-
-static void reap_children(void)
-{
-	int status, bad_exit = 0;
-	pid_t pid;
-
-	for (;;) {
-		pid = wait(&status);
-
-		if (pid > 0) {
-			if (!WIFEXITED(status))
-				bad_exit = 1;
-
-			continue;
-		}
-
-		if (errno == ECHILD)
-			break;
-
-		if (errno == EINTR)
-			continue;
-
-		tst_brk(TBROK | TERRNO, "wait() failed");
-	}
-
-	if (!bad_exit)
-		return;
-
-	tst_res(TINFO,
-		"Zombie workers detected; consider increasing LTP_RUNTIME_MUL");
+	tst_workers_setup(&workers);
 }
 
 static void cleanup(void)
 {
-	stop_workers();
-	reap_children();
-	destroy_workers();
-	free(workers);
-}
-
-static void visit_dir(const char *path)
-{
-	DIR *dir;
-	struct dirent *dent;
-	struct stat dent_st;
-	char dent_path[MAX_PATH];
-	enum dent_action act;
-	int last_sched = 0;
-
-	dir = opendir(path);
-	if (!dir) {
-		tst_res(TINFO | TERRNO, "opendir(%s)", path);
-		return;
-	}
-
-	while (1) {
-		errno = 0;
-		dent = readdir(dir);
-		if (!dent && errno) {
-			tst_res(TINFO | TERRNO, "readdir(%s)", path);
-			break;
-		} else if (!dent) {
-			break;
-		}
-
-		if (!strcmp(dent->d_name, ".") ||
-		    !strcmp(dent->d_name, ".."))
-			continue;
-
-		if (dent->d_type == DT_DIR)
-			act = DA_VISIT;
-		else if (dent->d_type == DT_LNK)
-			act = DA_IGNORE;
-		else if (dent->d_type == DT_UNKNOWN)
-			act = DA_UNKNOWN;
-		else
-			act = DA_READ;
-
-		snprintf(dent_path, MAX_PATH,
-			 "%s/%s", path, dent->d_name);
-
-		if (act == DA_UNKNOWN) {
-			if (lstat(dent_path, &dent_st))
-				tst_res(TINFO | TERRNO, "lstat(%s)", path);
-			else if ((dent_st.st_mode & S_IFMT) == S_IFDIR)
-				act = DA_VISIT;
-			else if ((dent_st.st_mode & S_IFMT) == S_IFLNK)
-				act = DA_IGNORE;
-			else
-				act = DA_READ;
-		}
-
-		if (act == DA_VISIT)
-			visit_dir(dent_path);
-		else if (act == DA_READ)
-			last_sched = sched_work(last_sched, dent_path, reads);
-	}
-
-	if (closedir(dir))
-		tst_res(TINFO | TERRNO, "closedir(%s)", path);
+	tst_workers_cleanup(&workers);
 }
 
 static void run(void)
 {
 	spawn_workers();
-	visit_dir(root_dir);
-
-	stop_workers();
-	reap_children();
-	destroy_workers();
+	tst_evloop_run(&workers.evloop);
 
 	tst_res(TPASS, "Finished reading files");
 }
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
