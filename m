Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDA3C54EE9
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:15:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CEFA3C919E
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:15:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26C6B3C25D7
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE9501000D39
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:21 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7889F1F8CF;
 Tue, 27 Sep 2022 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nkiTtJztpENjunXutOZXdmC3Vks/gw5448zMmrMjH0M=;
 b=gRdX3FnuWY9CMcAXvGYfBfX2xY+vUAramSwD640lEKpIeywLI10CcplsmVcKyhzMmQr5Zx
 50C+Nql9g8eS51JMMiZ8RuFspNa3nBB06GkcEymVnQYlB63HZ1Zyx51w67/jO7GqsiUWut
 gPBZlx05GK+8D+37FeCKTIRnp+rUB4U=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id EB9F22C16B;
 Tue, 27 Sep 2022 16:14:20 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:06 +0100
Message-Id: <20220927161408.23743-5-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] api/channel: Add channel abstraction for message
 passing
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

Adds an API for the channel pattern and an implementation based on
pipes.

A channel supports synchronous and asynchronous modes. When a message
is sent synchronously it's guaranteed to have been sent and ack'ed by
the time send returns. Similar for receiving.

In asynchronous mode, send returns immediately and a callback must be
registered to handle the response. This requires that the channel is
registered with an event loop. Again it's similar for receiving.

Messages are binary safe strings with a specified size.

The use of pipes instead of shared memory is motivated by the idea
that the same interface can be used for remote or isolated
processes.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_channel.h |  97 ++++++++++
 lib/tst_channel.c     | 410 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 507 insertions(+)
 create mode 100644 include/tst_channel.h
 create mode 100644 lib/tst_channel.c

diff --git a/include/tst_channel.h b/include/tst_channel.h
new file mode 100644
index 000000000..c572d213b
--- /dev/null
+++ b/include/tst_channel.h
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#include "tst_evloop.h"
+#include "tst_state_machine.h"
+
+#ifndef TST_CHANNEL_H
+#define TST_CHANNEL_H
+
+enum tst_chan_mode {
+	CHM_SYNC,
+	CHM_ASYNC,
+};
+
+enum tst_chan_state {
+	CHS_CLOSED,
+	CHS_READY,
+	CHS_RECV,
+	CHS_SEND
+};
+
+struct tst_chan_buf {
+	char *ptr;
+	size_t len;
+	size_t off;
+};
+
+struct tst_chan;
+struct tst_chan_ops {
+	void (*const close)(struct tst_chan *self);
+
+	void (*const send)(struct tst_chan *self);
+	void (*const recv)(struct tst_chan *self);
+
+	int (*const on_epoll)(struct tst_chan *self, uint32_t events);
+};
+
+struct tst_chan {
+	const struct tst_chan_ops *ops;
+	void *priv;
+
+	enum tst_chan_mode mode;
+	struct tst_state_mach mach;
+	long long last_seen;
+
+	struct tst_epoll_event_data evdata;
+
+	struct tst_chan_buf in;
+	struct tst_chan_buf out;
+
+	void *user_priv;
+	void (*on_send)(struct tst_chan *self, char *sent, size_t len);
+	void (*on_recv)(struct tst_chan *self, char *recv, size_t len);
+};
+
+enum tst_pchan_msg_kind {
+	PCMK_ACK = 1,
+	PCMK_DATA
+};
+
+struct tst_pchan_envelope {
+	unsigned int kind;
+	unsigned int len;
+} __attribute__((packed));
+
+enum tst_pchan_state {
+	PCS_IDLE,
+	PCS_RECV_DATA,
+	PCS_SEND_ACK,
+	PCS_SEND_DATA,
+	PCS_RECV_ACK,
+};
+
+struct tst_pchan {
+	int infd;
+	int outfd;
+
+	struct tst_pchan_envelope envelope;
+	struct tst_chan_buf envelope_buf;
+
+	unsigned int out_full:1;
+
+	struct tst_state_mach mach;
+};
+
+void tst_chan_send(struct tst_chan *self, char *msg, size_t len);
+void tst_chan_recv(struct tst_chan *self, char *msg, size_t len);
+void tst_chan_seen(struct tst_chan *self);
+long long tst_chan_elapsed(struct tst_chan *self);
+
+void tst_pchan_open(struct tst_chan *self, int infd, int outfd,
+		    struct tst_evloop *const evloop);
+void tst_pchan_close(struct tst_chan *self);
+
+#endif
diff --git a/lib/tst_channel.c b/lib/tst_channel.c
new file mode 100644
index 000000000..6d96cccab
--- /dev/null
+++ b/lib/tst_channel.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_timer.h"
+#include "tst_safe_clocks.h"
+#include "tst_channel.h"
+
+static struct tst_state_matrix chan_state_mat = {
+	.names = {
+		[CHS_CLOSED] = "closed",
+		[CHS_READY] = "ready",
+		[CHS_RECV] = "receiving",
+		[CHS_SEND] = "sending"
+	},
+	.states = {
+		[CHS_CLOSED] = 1 << CHS_READY,
+		[CHS_READY] = 1 << CHS_CLOSED | 1 << CHS_RECV | 1 << CHS_SEND,
+		[CHS_RECV] = 1 << CHS_CLOSED | 1 << CHS_READY,
+		[CHS_SEND] = 1 << CHS_CLOSED | 1 << CHS_READY,
+	}
+};
+
+static struct tst_state_matrix pchan_state_mat = {
+	.names = {
+		[PCS_IDLE] = "idle",
+		[PCS_RECV_DATA] = "receiving data",
+		[PCS_SEND_ACK] = "sending ack",
+		[PCS_SEND_DATA]= "sending data",
+		[PCS_RECV_ACK] = "receving ack",
+	},
+	.states = {
+		[PCS_IDLE] = 1 << PCS_IDLE | 1 << PCS_RECV_DATA | 1 << PCS_SEND_DATA,
+		[PCS_RECV_DATA] = 1 << PCS_SEND_ACK | 1 << PCS_IDLE,
+		[PCS_SEND_ACK] = 1 << PCS_IDLE,
+		[PCS_SEND_DATA]= 1 << PCS_RECV_ACK | 1 << PCS_IDLE,
+		[PCS_RECV_ACK] = 1 << PCS_IDLE,
+	},
+};
+
+static size_t chan_buf_more(struct tst_chan_buf *self)
+{
+	return self->off < self->len;
+}
+
+void tst_chan_send(struct tst_chan *self, char *msg, size_t len)
+{
+	if (self->mode == CHM_SYNC)
+		goto send;
+
+	if (!self->on_send) {
+		tst_brk(TBROK, "In async mode, but on_sent cb not set");
+		return;
+	}
+
+	if (!self->evdata.on_epoll) {
+		tst_brk(TBROK, "In async mode, but not added to epoll");
+		return;
+	}
+
+send:
+	self->out.ptr = msg;
+	self->out.len = len;
+	self->out.off = 0;
+
+	TST_STATE_SET(&self->mach, CHS_SEND);
+	self->ops->send(self);
+}
+
+void tst_chan_recv(struct tst_chan *self, char *msg, size_t len)
+{
+	if (self->mode == CHM_SYNC)
+		goto recv;
+
+	if (!self->on_recv) {
+		tst_brk(TBROK, "In async mode, but on_recv cb not set");
+		return;
+	}
+
+	if (!self->evdata.on_epoll) {
+		tst_brk(TBROK, "In async mode, but not added to epoll");
+		return;
+	}
+
+recv:
+	self->in.ptr = msg;
+	self->in.len = len;
+	self->in.off = 0;
+
+	TST_STATE_SET(&self->mach, CHS_RECV);
+	self->ops->recv(self);
+}
+
+void tst_chan_seen(struct tst_chan *self)
+{
+	struct timespec now;
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &now);
+	self->last_seen = tst_timespec_to_us(now);
+}
+
+long long tst_chan_elapsed(struct tst_chan *self)
+{
+	struct timespec now;
+
+	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &now);
+
+	return tst_timespec_to_us(now) - self->last_seen;
+}
+
+static void pipe_chan_write(struct tst_chan *self, struct tst_chan_buf *buf)
+{
+	ssize_t ret;
+	size_t written = buf->off;
+	struct tst_pchan *priv = self->priv;
+
+	while (written < buf->len) {
+		ret = write(priv->outfd,
+			    buf->ptr + written, buf->len - written);
+
+		if (ret == -1) {
+			if (self->mode == CHM_ASYNC && errno == EAGAIN) {
+				priv->out_full = 1;
+				break;
+			}
+
+			if (errno == EINTR)
+				continue;
+
+			tst_brk(TBROK | TERRNO, "write");
+		}
+
+		written += ret;
+	}
+
+	buf->off = written;
+}
+
+static void pipe_chan_read(struct tst_chan *self, struct tst_chan_buf *buf)
+{
+	ssize_t ret;
+	size_t recved = buf->off;
+	struct tst_pchan *priv = self->priv;
+
+	while (recved < buf->len) {
+		ret = read(priv->infd,
+			   buf->ptr + recved, buf->len - recved);
+
+		if (!ret)
+			tst_brk(TBROK, "PID %d: read(%d) = EOF", getpid(), priv->infd);
+
+		if (ret == -1) {
+			if (self->mode == CHM_ASYNC && errno == EAGAIN)
+				break;
+
+			if (errno == EINTR)
+				continue;
+
+			tst_brk(TBROK | TERRNO, "read");
+		}
+
+		recved += ret;
+	}
+
+	buf->off = recved;
+}
+
+static void pipe_chan_send(struct tst_chan *self)
+{
+	struct tst_pchan *priv = self->priv;
+	const enum tst_pchan_state state =
+		TST_STATE_GET(&priv->mach, 1 << PCS_IDLE | 1 << PCS_SEND_DATA | 1 << PCS_RECV_ACK);
+
+ 	TST_STATE_EXP(&self->mach, 1 << CHS_READY | 1 << CHS_SEND);
+
+	switch (state) {
+	case PCS_IDLE:
+		priv->envelope.kind = PCMK_DATA;
+		priv->envelope.len = self->out.len;
+		priv->envelope_buf.ptr = (char *)&priv->envelope;
+		priv->envelope_buf.len = sizeof(priv->envelope);
+		priv->envelope_buf.off = 0;
+
+		TST_STATE_SET(&priv->mach, PCS_SEND_DATA);
+		break;
+	case PCS_SEND_DATA:
+		break;
+	case PCS_RECV_ACK:
+		goto ack;
+	default:
+		break;
+	}
+
+	if (priv->out_full)
+		return;
+
+	pipe_chan_write(self, &priv->envelope_buf);
+	if (chan_buf_more(&priv->envelope_buf))
+		return;
+
+	pipe_chan_write(self, &self->out);
+	if (chan_buf_more(&self->out))
+		return;
+
+	TST_STATE_SET(&priv->mach, PCS_RECV_ACK);
+	priv->envelope_buf.off = 0;
+
+	if (self->mode == CHM_ASYNC)
+		return;
+ack:
+	pipe_chan_read(self, &priv->envelope_buf);
+
+	if (chan_buf_more(&priv->envelope_buf))
+		return;
+
+	if (priv->envelope.kind != PCMK_ACK || priv->envelope.len) {
+		tst_brk(TBROK, "Malformed ack");
+		return;
+	}
+
+	tst_chan_seen(self);
+	TST_STATE_SET(&priv->mach, PCS_IDLE);
+	TST_STATE_SET(&self->mach, CHS_READY);
+
+	if (self->on_send)
+		self->on_send(self, self->out.ptr, self->out.len);
+}
+
+static void pipe_chan_recv(struct tst_chan *self)
+{
+	struct tst_pchan *priv = self->priv;
+	const enum tst_pchan_state state =
+		TST_STATE_GET(&priv->mach, 1 << PCS_IDLE | 1 << PCS_RECV_DATA | 1 << PCS_SEND_ACK);
+
+	TST_STATE_EXP(&self->mach, 1 << CHS_READY | 1 << CHS_RECV);
+
+	switch (state) {
+	case PCS_IDLE:
+		priv->envelope_buf.off = 0;
+
+		TST_STATE_SET(&priv->mach, PCS_RECV_DATA);
+		break;
+	case PCS_RECV_DATA:
+		break;
+	case PCS_SEND_ACK:
+		goto ack;
+	default:
+		break;
+	}
+
+	pipe_chan_read(self, &priv->envelope_buf);
+	if (chan_buf_more(&priv->envelope_buf))
+		return;
+
+	if (priv->envelope.kind != PCMK_DATA) {
+		tst_brk(TBROK, "Expected data message, but got: %d", priv->envelope.kind);
+		return;
+	}
+
+	if (priv->envelope.len > self->in.len) {
+		tst_brk(TBROK, "Incoming message too large: %ul", priv->envelope.len);
+		return;
+	}
+
+	self->in.len = priv->envelope.len;
+	pipe_chan_read(self, &self->in);
+	if (chan_buf_more(&self->in))
+		return;
+
+	TST_STATE_SET(&priv->mach, PCS_SEND_ACK);
+	priv->envelope.kind = PCMK_ACK;
+	priv->envelope.len = 0;
+	priv->envelope_buf.off = 0;
+
+ack:
+	pipe_chan_write(self, &priv->envelope_buf);
+	if (chan_buf_more(&priv->envelope_buf))
+		return;
+
+	TST_STATE_SET(&priv->mach, PCS_IDLE);
+	TST_STATE_SET(&self->mach, CHS_READY);
+
+	if (self->on_recv)
+		self->on_recv(self, self->in.ptr, self->in.len);
+}
+
+static int pipe_chan_on_epoll(struct tst_chan *self, uint32_t events)
+{
+	struct tst_pchan *priv = self->priv;
+	enum tst_chan_state chs = TST_STATE_GET(&self->mach, TST_STATE_ANY);
+	enum tst_pchan_state phs = TST_STATE_GET(&priv->mach, TST_STATE_ANY);
+
+	if (events | EPOLLOUT) {
+		priv->out_full = 0;
+
+		switch (chs) {
+		case CHS_RECV:
+			if (phs == PCS_RECV_DATA)
+				break;
+
+			self->ops->recv(self);
+			break;
+		case CHS_SEND:
+			if (phs == PCS_RECV_ACK)
+				break;
+
+			self->ops->send(self);
+			break;
+		case CHS_READY:
+		case CHS_CLOSED:
+			TST_STATE_EXP(&priv->mach, 1 << PCS_IDLE);
+			break;
+		}
+	}
+
+	if (events | EPOLLIN) {
+		switch (chs) {
+		case CHS_RECV:
+			if (phs == PCS_SEND_ACK)
+				break;
+
+			self->ops->recv(self);
+			break;
+		case CHS_SEND:
+			if (phs == PCS_SEND_DATA)
+				break;
+
+			self->ops->send(self);
+			break;
+		case CHS_READY:
+		case CHS_CLOSED:
+			TST_STATE_EXP(&priv->mach, 1 << PCS_IDLE);
+			break;
+		}
+	}
+
+	if (events & EPOLLERR) {
+		switch (phs) {
+		case PCS_RECV_DATA:
+		case PCS_SEND_ACK:
+		case PCS_SEND_DATA:
+			tst_brk(TBROK, "Channel closed during operation");
+		default:
+			break;
+		}
+
+		if (chs != CHS_CLOSED)
+			self->ops->close(self);
+	}
+
+	return 1;
+}
+
+static struct tst_chan_ops pipe_chan_ops = {
+	.close = tst_pchan_close,
+	.send = pipe_chan_send,
+	.recv = pipe_chan_recv,
+	.on_epoll = pipe_chan_on_epoll,
+};
+
+void tst_pchan_open(struct tst_chan *self,
+		    int infd, int outfd,
+		    struct tst_evloop *const evloop)
+{
+	struct tst_pchan *priv = self->priv;
+
+	self->mach.mat = &chan_state_mat;
+	TST_STATE_EXP(&self->mach, 1 << CHS_CLOSED);
+
+	self->ops = &pipe_chan_ops;
+
+	if (!priv)
+		tst_brk(TBROK, "Channel should have pipe_chan priv preallocated");
+
+	priv->mach.mat = &pchan_state_mat;
+	TST_STATE_EXP(&priv->mach, 1 << PCS_IDLE);
+
+	priv->out_full = 0;
+	priv->infd = infd;
+	priv->outfd = outfd;
+	priv->envelope_buf.ptr = (char *)&priv->envelope;
+	priv->envelope_buf.len = sizeof(priv->envelope);
+
+	if (!evloop)
+		goto out;
+
+	self->mode = CHM_ASYNC;
+	self->evdata.on_epoll = (tst_on_epoll_fn)self->ops->on_epoll;
+	self->evdata.self = self;
+	tst_evloop_add(evloop, &self->evdata, infd, EPOLLIN);
+	tst_evloop_add(evloop, &self->evdata, outfd, EPOLLOUT | EPOLLET);
+
+out:
+	TST_STATE_SET(&self->mach, CHS_READY);
+	tst_chan_seen(self);
+}
+
+void tst_pchan_close(struct tst_chan *self)
+{
+	struct tst_pchan *priv = self->priv;
+
+	close(priv->infd);
+	close(priv->outfd);
+
+	TST_STATE_SET(&priv->mach, PCS_IDLE);
+	TST_STATE_SET(&self->mach, CHS_CLOSED);
+}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
