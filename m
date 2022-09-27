Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E37DC07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:15:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC41E3C25D7
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:15:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F38AB3C8CAE
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CAD3C200060
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3E5B921CFF;
 Tue, 27 Sep 2022 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dFAN3b9YQxyEE7R1avcDV8JnpbxGTW8AoNOWK681vI=;
 b=n/i0HyhXALJMT6KF5Es8F3r3wowwAXtz0+rfMCQN84KfKhQqt8BkNJI3H+zCzCcGvtKjz1
 fw1X8tbQT8Au834825/JKx0fK/uusQL7SXwkhHUgvLfArJfCfu/fxpaTOU6Yn0Yc20tXjr
 Z+qGESn7cEj5l2zkpNXN7uT3mbfkrQc=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id ADE8E2C16B;
 Tue, 27 Sep 2022 16:14:21 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:07 +0100
Message-Id: <20220927161408.23743-6-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] api/worker: Add library for distributing work
 over multiple procs
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

Builds on the channel, state machine and event loop APIs. Allows one
to create multiple processes (workers) and distribute work to them
using messages.

The main test process can create, send and receive messages from the
workers. The main process can communicate async or synchronously with
each worker over the worker's channel.

Initially workers are internally synchronous and do not communicate
directly with each other. However there is nothing preventing them
from creating an event loop or using channels between one another.

Presently workers are expected to be local processes. However various
types of isolation could be used. The main process just needs to share
a channel with them (pipe) and send and receive signals with them.

This is motivated by suggested additions to the read_all test and LTX.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_worker.h |  62 ++++++++++
 lib/tst_worker.c     | 285 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 347 insertions(+)
 create mode 100644 include/tst_worker.h
 create mode 100644 lib/tst_worker.c

diff --git a/include/tst_worker.h b/include/tst_worker.h
new file mode 100644
index 000000000..b5c51a66c
--- /dev/null
+++ b/include/tst_worker.h
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#include "tst_channel.h"
+
+#ifndef TST_WORKER_H
+#define TST_WORKER_H
+
+enum tst_worker_mode {
+	TST_WORKER_SYNC,
+	TST_WORKER_ASYNC
+};
+
+enum tst_worker_state {
+	WS_STOPPED,
+	WS_RUNNING,
+	WS_STOPPING,
+	WS_KILL_SENT,
+	WS_DIED
+};
+
+struct tst_workers;
+struct tst_worker {
+	int i;
+	pid_t pid;
+	struct tst_chan chan;
+	struct tst_pchan pipe_chan;
+	struct tst_workers *group;
+	enum tst_worker_mode mode;
+	struct tst_state_mach mach;
+
+	char display_buf[128];
+	char *name;
+
+	void *priv;
+	int (*run)(struct tst_worker *self);
+	void (*on_stopped)(struct tst_worker *self);
+	void (*on_died)(struct tst_worker *self);
+	void (*on_timeout)(struct tst_worker *self);
+	void (*on_sent)(struct tst_worker *self, char *sent, size_t len);
+	void (*on_recved)(struct tst_worker *self, char *recv, size_t len);
+};
+
+struct tst_workers {
+	long long timeout;
+	struct tst_evloop evloop;
+
+	long count;
+	struct tst_worker *vec;
+};
+
+void tst_workers_setup(struct tst_workers *self);
+void tst_workers_cleanup(struct tst_workers *self);
+
+void tst_worker_start(struct tst_worker *self);
+int tst_worker_ttl(struct tst_worker *self);
+void tst_worker_kill(struct tst_worker *self);
+char *tst_worker_idstr(struct tst_worker *self);
+
+#endif
diff --git a/lib/tst_worker.c b/lib/tst_worker.c
new file mode 100644
index 000000000..4bb2398e1
--- /dev/null
+++ b/lib/tst_worker.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "tst_test.h"
+#include "tst_worker.h"
+
+static struct tst_state_matrix worker_state_mat = {
+	.names = {
+		[WS_STOPPED] = "Stopped",
+		[WS_RUNNING] = "Running",
+		[WS_STOPPING] = "Stopping",
+		[WS_KILL_SENT] = "Kill sent",
+		[WS_DIED] = "Dead"
+	},
+	.states = {
+		[WS_STOPPED] = 1 << WS_RUNNING,
+		[WS_RUNNING] = 1 << WS_STOPPING | 1 << WS_STOPPED | 1 << WS_KILL_SENT | 1 << WS_DIED,
+		[WS_STOPPING] = 1 << WS_STOPPED | 1 << WS_KILL_SENT | 1 << WS_DIED,
+		[WS_KILL_SENT] = 1 << WS_STOPPED | 1 << WS_DIED,
+		[WS_DIED] = 1 << WS_RUNNING,
+	},
+};
+
+static char *idstr(struct tst_worker *self)
+{
+	if (self->display_buf[0] != '\0')
+		return self->display_buf;
+
+	snprintf(self->display_buf,
+		 sizeof(self->display_buf) - 1,
+		 "%s Worker %d (%d)", self->name, self->pid, self->i);
+
+	self->display_buf[sizeof(self->display_buf) - 1] = '\0';
+
+	return self->display_buf;
+}
+
+static void worker_chan_on_send(struct tst_chan *chan, char *sent, size_t len)
+{
+	struct tst_worker *self = chan->user_priv;
+
+	if (self->on_sent)
+		self->on_sent(self, sent, len);
+}
+
+static void worker_chan_on_recv(struct tst_chan *chan, char *recved, size_t len)
+{
+	struct tst_worker *self = chan->user_priv;
+
+	if (self->on_recved)
+		self->on_recved(self, recved, len);
+}
+
+char *tst_worker_idstr(struct tst_worker *self)
+{
+	return idstr(self);
+}
+
+void tst_worker_start(struct tst_worker *self)
+{
+	struct tst_evloop *evloop = NULL;
+	int infd[2];
+	int outfd[2];
+
+	SAFE_PIPE2(infd, O_CLOEXEC);
+	SAFE_PIPE2(outfd, O_CLOEXEC);
+
+	self->chan.user_priv = self;
+	self->chan.priv = &self->pipe_chan;
+	tst_chan_seen(&self->chan);
+	self->pid = SAFE_FORK();
+
+	if (!self->pid) {
+		self->pid = getpid();
+
+		close(infd[0]);
+		close(outfd[1]);
+		tst_pchan_open(&self->chan, outfd[0], infd[1], NULL);
+
+		if (!tst_worker_ttl(self))
+			tst_res(TWARN, "Worker timeout is too short; restarts take >%lldus", tst_chan_elapsed(&self->chan));
+
+		exit(self->run(self));
+	}
+
+	close(infd[1]);
+	close(outfd[0]);
+
+	self->chan.on_send = worker_chan_on_send;
+	self->chan.on_recv = worker_chan_on_recv;
+
+	if (self->mode == TST_WORKER_ASYNC)
+		evloop = &self->group->evloop;
+
+	tst_pchan_open(&self->chan, infd[0], outfd[1], evloop);
+
+	tst_res(TINFO, "%s: Started", idstr(self));
+	TST_STATE_SET(&self->mach, WS_RUNNING);
+}
+
+int tst_worker_ttl(struct tst_worker *self)
+{
+	long long t = self->group->timeout;
+
+	return MAX(0LL, t - tst_chan_elapsed(&self->chan));
+}
+
+void tst_worker_kill(struct tst_worker *w)
+{
+	const enum tst_worker_state ws =
+		TST_STATE_GET(&w->mach, 1 << WS_RUNNING | 1 << WS_STOPPING | 1 << WS_KILL_SENT);
+
+	if (ws != WS_KILL_SENT) {
+		if (TST_STATE_GET(&w->chan.mach, TST_STATE_ANY) != CHS_CLOSED)
+			w->chan.ops->close(&w->chan);
+
+		tst_chan_seen(&w->chan);
+
+		SAFE_KILL(w->pid, SIGKILL);
+		TST_STATE_SET(&w->mach, WS_KILL_SENT);
+		return;
+	}
+
+	tst_res(TWARN, "%s: Timed out again after KILL signal sent", idstr(w));
+
+	if (w->on_died)
+		w->on_died(w);
+}
+
+static int workers_waitpid(struct tst_workers *self)
+{
+	struct tst_worker *w = self->vec;
+	int i,  ws;
+	const pid_t pid = waitpid(-1, &ws, WNOHANG);
+
+	if (!pid || (pid == -1 && errno == ECHILD))
+		return 0;
+
+	if (pid == -1)
+		tst_brk(TBROK | TERRNO, "waitpid(-1, &ws, WNOHANG)");
+
+	for (i = 0; i < self->count; i++) {
+		if (w[i].pid == pid)
+			break;
+	}
+
+	if (i == self->count) {
+		tst_res(TWARN, "Received SIGCHLD for untracked PID: %d", pid);
+
+		if (WIFEXITED(ws))
+			tst_res(TINFO, "PID: %d: Exited: %d", pid, WEXITSTATUS(ws));
+		if (WIFSIGNALED(ws))
+			tst_res(TINFO, "PID: %d: Killed: %s", pid, tst_strsig(WTERMSIG(ws)));
+		if (WCOREDUMP(ws))
+			tst_res(TINFO, "PID: %d: Core dumped", pid);
+	}
+
+	w += i;
+
+	if (WIFSTOPPED(ws) || WIFCONTINUED(ws))
+		return 1;
+
+	if (TST_STATE_GET(&w->chan.mach, TST_STATE_ANY) != CHS_CLOSED)
+		w->chan.ops->close(&w->chan);
+
+	if (WIFEXITED(ws) && !WEXITSTATUS(ws)) {
+		TST_STATE_SET(&w->mach, WS_STOPPED);
+
+		if (w->on_stopped)
+			w->on_stopped(w);
+		else
+			tst_res(TINFO, "%s: Stopped", idstr(w));
+	} else {
+		TST_STATE_SET(&w->mach, WS_DIED);
+
+		if (w->on_died)
+			w->on_died(w);
+		else
+			tst_brk(TBROK, "%s: Died", idstr(w));
+	}
+
+	return 1;
+}
+
+static int workers_on_signal(struct tst_evloop *self,
+			     struct signalfd_siginfo *si)
+{
+	struct tst_workers *const workers = self->priv;
+
+	if (si->ssi_signo != SIGCHLD) {
+		tst_brk(TBROK,
+			"Don't know how to handle signal %s",
+			tst_strsig(si->ssi_signo));
+		return 0;
+	}
+
+	while (workers_waitpid(workers))
+		;
+
+	return 1;
+}
+
+static int workers_on_cont(struct tst_evloop *self)
+{
+	struct tst_workers *const workers = self->priv;
+	int i, stopped = 0;
+
+	for (i = 0; i < workers->count; i++) {
+		struct tst_worker *w = workers->vec + i;
+		const enum tst_worker_state ws = TST_STATE_GET(&w->mach, TST_STATE_ANY);
+
+		if (ws == WS_STOPPED || ws == WS_DIED) {
+			stopped++;
+			continue;
+		}
+
+		if (tst_worker_ttl(w))
+			continue;
+
+		if (w->on_timeout) {
+			w->on_timeout(w);
+		} else {
+			tst_res(TINFO, "%s: Timedout", idstr(w));
+			tst_worker_kill(w);
+		}
+	}
+
+	if (stopped == workers->count)
+		return 0;
+
+	return 1;
+}
+
+void tst_workers_setup(struct tst_workers *self)
+{
+	int i;
+
+	self->evloop.priv = self;
+	self->evloop.on_cont = workers_on_cont;
+	self->evloop.on_signal = workers_on_signal;
+
+	tst_evloop_setup(&self->evloop);
+
+	for (i = 0; i < self->count; i++) {
+		struct tst_worker *w = self->vec + i;
+
+		w->mach.mat = &worker_state_mat;
+		TST_STATE_EXP(&w->mach, 1 << WS_STOPPED);
+
+		w->i = i;
+		w->group = self;
+	}
+}
+
+void tst_workers_cleanup(struct tst_workers *self)
+{
+	int i;
+
+	for (i = 0; i < self->count; i++) {
+		struct tst_worker *w = self->vec + i;
+		const enum tst_worker_state ws = TST_STATE_GET(&w->mach, TST_STATE_ANY);
+
+		if (TST_STATE_GET(&w->chan.mach, 1 << CHS_CLOSED) != CHS_CLOSED)
+			w->chan.ops->close(&w->chan);
+
+		if (ws != WS_STOPPED) {
+			if (ws != WS_KILL_SENT)
+				SAFE_KILL(w->pid, SIGKILL);
+
+			tst_res(TWARN, "%s: Still running", idstr(w));
+		}
+	}
+
+	tst_evloop_cleanup(&self->evloop);
+}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
