Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A221C07E9D
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 16:15:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A27E3C868B
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 18:15:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4123E3C87C9
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A0EEC1000D43
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 18:14:20 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 1AA6E21E95;
 Tue, 27 Sep 2022 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1664295260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fd47GhO37EQRQPpWoTsMwGW1kEsvyFVi73M5E7RB3A8=;
 b=AruJhxjxeoHKUVBNvRuzjUhkAVy4wgq0KLxEN3rPhITiN5oAo5uEK0CvRV65m/Vz7/mnI/
 GJFsxkj4GD06PQD2Tt6j28VbFTWUTIsWXqRytWdczJAQf/ExH98/KwhIT0PhwTHWAfdLdI
 UA3NPJIEGJUdXqRncp7BrcyXaU4mL74=
Received: from g78.suse.de (unknown [10.163.24.90])
 by relay2.suse.de (Postfix) with ESMTP id B47772C16D;
 Tue, 27 Sep 2022 16:14:19 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 Sep 2022 17:14:04 +0100
Message-Id: <20220927161408.23743-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220927161408.23743-1-rpalethorpe@suse.com>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] api/evloop: Add helpers for creating an event loop
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

Puts some of the boiler plate for creating an "event loop", into an
API. Useful for asynchronous or evented I/O.

This uses epoll and signalfd which are very widely supported on
Linux. I also think epoll is a better interface than ppoll and
pselect.

The tst_epoll_event_data struct (added in the previous commit) can be
used to add callbacks on particular FD events.

There is also a special callback for the signlfd and on_cont which is
called at the end of each loop. Returning 0 from these will cause the
loop to exit.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_evloop.h |  32 ++++++++++++++
 lib/tst_evloop.c     | 102 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 include/tst_evloop.h
 create mode 100644 lib/tst_evloop.c

diff --git a/include/tst_evloop.h b/include/tst_evloop.h
new file mode 100644
index 000000000..bdab2d6f7
--- /dev/null
+++ b/include/tst_evloop.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+
+#include "inttypes.h"
+#include "sys/signalfd.h"
+
+#include "tst_epoll.h"
+
+#ifndef TST_EVLOOP_H
+#define TST_EVLOOP_H
+
+struct tst_evloop {
+	int epollfd;
+	int signalfd;
+	struct tst_epoll_event_data signalfd_evdata;
+	int timeout;
+
+	void *priv;
+	int (*on_cont)(struct tst_evloop *self);
+	int (*on_signal)(struct tst_evloop *self, struct signalfd_siginfo *si);
+};
+
+void tst_evloop_setup(struct tst_evloop *self);
+void tst_evloop_run(struct tst_evloop *self);
+void tst_evloop_add(struct tst_evloop *self,
+		    struct tst_epoll_event_data *evdata,
+		    int fd, uint32_t events);
+void tst_evloop_cleanup(struct tst_evloop *self);
+
+#endif
diff --git a/lib/tst_evloop.c b/lib/tst_evloop.c
new file mode 100644
index 000000000..66d74ce58
--- /dev/null
+++ b/lib/tst_evloop.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 SUSE LLC <rpalethorpe@suse.com>
+ */
+#define _GNU_SOURCE
+#define TST_NO_DEFAULT_MAIN
+
+#include "tst_test.h"
+#include "tst_evloop.h"
+
+static void handle_epoll_event(struct epoll_event *event)
+{
+	struct tst_epoll_event_data *data = event->data.ptr;
+
+	data->on_epoll(data->self, event->events);
+}
+
+static int evloop_on_signal(struct tst_evloop *self, uint32_t events)
+{
+	int i, n;
+	struct signalfd_siginfo si[16];
+
+	if (events ^ EPOLLIN) {
+		tst_brk(TBROK, "Unexpected event on signalfd");
+		return 1;
+	}
+
+	n = SAFE_READ(0, self->signalfd, si, sizeof(si));
+
+	if (!n)
+		tst_brk(TBROK, "Got EPOLLIN on signalfd, but no signal read from fd");
+
+	for (i = 0; i < n/(int)sizeof(si[0]); i++) {
+		if (!self->on_signal(self, si + i))
+			return 0;
+	}
+
+	return 1;
+}
+
+void tst_evloop_add(struct tst_evloop *self,
+		       struct tst_epoll_event_data *evdata,
+		       int fd, uint32_t events)
+{
+	struct epoll_event ev = {
+		.events = events,
+		.data.ptr = evdata,
+	};
+
+	SAFE_EPOLL_CTL(self->epollfd, EPOLL_CTL_ADD, fd, &ev);
+}
+
+void tst_evloop_setup(struct tst_evloop *self)
+{
+
+	sigset_t mask;
+
+	self->epollfd = SAFE_EPOLL_CREATE1(EPOLL_CLOEXEC);
+
+	sigfillset(&mask);
+	SAFE_SIGPROCMASK(SIG_BLOCK, &mask, NULL);
+	self->signalfd = signalfd(-1, &mask, SFD_CLOEXEC);
+
+	self->signalfd_evdata.self = self;
+	self->signalfd_evdata.on_epoll = (tst_on_epoll_fn)evloop_on_signal;
+
+	tst_evloop_add(self, &self->signalfd_evdata, self->signalfd, EPOLLIN);
+}
+
+void tst_evloop_run(struct tst_evloop *self)
+{
+	static int saturated_warn;
+	const int maxevents = 128;
+	struct epoll_event events[maxevents];
+
+	for (;;) {
+		const int ev_num = SAFE_EPOLL_WAIT(self->epollfd, events,
+						   maxevents, self->timeout);
+
+		for (int i = 0; i < ev_num; i++)
+			handle_epoll_event(events + i);
+
+		if (ev_num == maxevents) {
+			if (!saturated_warn)
+				tst_res(TINFO, "Event loop saturated");
+
+			saturated_warn = 1;
+			continue;
+		}
+
+		if (!self->on_cont(self))
+			break;
+	}
+}
+
+void tst_evloop_cleanup(struct tst_evloop *self)
+{
+	if (self->epollfd > 0)
+		SAFE_CLOSE(self->epollfd);
+	if (self->signalfd > 0)
+		SAFE_CLOSE(self->signalfd);
+}
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
