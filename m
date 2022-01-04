Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A15C4332F
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 08:26:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A3E3C903F
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 09:19:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F9FB3C8FAD
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0FA096008A8
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:18:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72205210E3;
 Tue,  4 Jan 2022 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1641284322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BuduZWapJ2/gyF7qCNCTEQtDRGZTlXrM/xJqLEyjJyI=;
 b=Yv0DotJaXckCWonf/ajpt/9tJZqCZ33+nIiFT0rCh/TVH5xX7p0lVa+hWlMr6/HZOj/ImQ
 ccVXezUogkpRPAhbLeaMpEYnzabFErmkWyhBImR+l6vmFEnUy85yqbPJFphkyfn1eX8Ezo
 5gNO0b5kh8rfit0/xGKW8EgPbqsR5TI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20F4F13AB9;
 Tue,  4 Jan 2022 08:18:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yAGIA+IC1GGeZwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 04 Jan 2022 08:18:42 +0000
To: ltp@lists.linux.it
Date: Tue,  4 Jan 2022 09:18:28 +0100
Message-Id: <20220104081836.22827-3-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104081836.22827-1-andrea.cervesato@suse.com>
References: <20220104081836.22827-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 02/10] Add wqueue01 new test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test checks if KEYCTL_UPDATE event is recognized by watch queue

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/watchqueue/common.h   | 153 +++++++++++++++++++++++++
 testcases/kernel/watchqueue/wqueue01.c |  68 +++++++++++
 2 files changed, 221 insertions(+)
 create mode 100644 testcases/kernel/watchqueue/common.h
 create mode 100644 testcases/kernel/watchqueue/wqueue01.c

diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
new file mode 100644
index 000000000..6a7ae213e
--- /dev/null
+++ b/testcases/kernel/watchqueue/common.h
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef WQUEUE_COMMON_H__
+#define WQUEUE_COMMON_H__
+
+#define _FCNTL_H
+
+#include <linux/watch_queue.h>
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+
+static struct watch_notification_filter wqueue_key_filter = {
+	.nr_filters	= 1,
+	.__reserved	= 0,
+	.filters = {
+		[0]	= {
+			.type = WATCH_TYPE_KEY_NOTIFY,
+			.subtype_filter[0] = UINT_MAX,
+		},
+	},
+};
+
+static const char *key_subtypes[256] = {
+	[NOTIFY_KEY_INSTANTIATED]	= "instantiated",
+	[NOTIFY_KEY_UPDATED]		= "updated",
+	[NOTIFY_KEY_LINKED]		= "linked",
+	[NOTIFY_KEY_UNLINKED]		= "unlinked",
+	[NOTIFY_KEY_CLEARED]		= "cleared",
+	[NOTIFY_KEY_REVOKED]		= "revoked",
+	[NOTIFY_KEY_INVALIDATED]	= "invalidated",
+	[NOTIFY_KEY_SETATTR]		= "setattr",
+};
+
+static inline long safe_keyctl(int cmd, ...)
+{
+	long ret;
+	va_list va;
+	unsigned long arg2, arg3, arg4, arg5;
+
+	va_start(va, cmd);
+	arg2 = va_arg(va, unsigned long);
+	arg3 = va_arg(va, unsigned long);
+	arg4 = va_arg(va, unsigned long);
+	arg5 = va_arg(va, unsigned long);
+	va_end(va);
+
+	ret = tst_syscall(__NR_keyctl, cmd, arg2, arg3, arg4, arg5);
+	if (ret == -1)
+		tst_brk(TBROK, "keyctl error: %s", tst_strerrno(errno));
+
+	return ret;
+}
+
+static int wqueue_key_event(struct watch_notification *n, size_t len, unsigned int wtype, int type)
+{
+	struct key_notification *k;
+	const char* msg;
+
+	if (wtype != WATCH_TYPE_KEY_NOTIFY)
+		return 0;
+
+	if (len != sizeof(struct key_notification))
+		tst_brk(TBROK, "Incorrect key message length");
+
+	k = (struct key_notification *)n;
+	msg = key_subtypes[n->subtype];
+
+	tst_res(TINFO, "KEY %08x change=%u[%s] aux=%u",
+	    k->key_id, n->subtype, msg, k->aux);
+
+	if (n->subtype == type)
+        return 1;
+
+    return 0;
+}
+
+static key_serial_t wqueue_add_key(int fd)
+{
+	key_serial_t key;
+
+	key = add_key("user", "ltptestkey", "a", 1, KEY_SPEC_SESSION_KEYRING);
+	if (key == -1)
+		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
+
+	safe_keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
+	safe_keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
+
+	return key;
+}
+
+static int wqueue_watch(int buf_size, struct watch_notification_filter *filter)
+{
+	int pipefd[2];
+	int fd;
+
+	SAFE_PIPE2(pipefd, O_NOTIFICATION_PIPE);
+
+	fd = pipefd[0];
+
+	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_SIZE, buf_size);
+	SAFE_IOCTL(fd, IOC_WATCH_QUEUE_SET_FILTER, filter);
+
+	return fd;
+}
+
+typedef void (*wqueue_callback) (struct watch_notification *n, size_t len, unsigned int wtype);
+
+static void wqueue_consumer(int fd, volatile int *keep_polling, wqueue_callback cb)
+{
+	unsigned char buffer[433], *p, *end;
+	union {
+		struct watch_notification n;
+		unsigned char buf1[128];
+	} n;
+	ssize_t buf_len;
+
+	tst_res(TINFO, "Waiting for watch queue events");
+
+	while (*keep_polling) {
+		buf_len = SAFE_READ(0, fd, buffer, sizeof(buffer));
+
+		p = buffer;
+		end = buffer + buf_len;
+		while (p < end) {
+			size_t largest, len;
+
+			largest = end - p;
+			if (largest > 128)
+				largest = 128;
+
+			if (largest < sizeof(struct watch_notification))
+				tst_brk(TBROK, "Short message header: %zu", largest);
+
+			memcpy(&n, p, largest);
+
+			tst_res(TINFO, "NOTIFY[%03zx]: ty=%06x sy=%02x i=%08x",
+			       p - buffer, n.n.type, n.n.subtype, n.n.info);
+
+			len = n.n.info & WATCH_INFO_LENGTH;
+			if (len < sizeof(n.n) || len > largest)
+				tst_brk(TBROK, "Bad message length: %zu/%zu", len, largest);
+
+			cb(&n.n, len, n.n.type);
+
+			p += len;
+		}
+	}
+}
+
+#endif
diff --git a/testcases/kernel/watchqueue/wqueue01.c b/testcases/kernel/watchqueue/wqueue01.c
new file mode 100644
index 000000000..f22682eed
--- /dev/null
+++ b/testcases/kernel/watchqueue/wqueue01.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if keyctl update is correctly recognized by watch queue.
+ */
+
+#define _FCNTL_H
+
+#include "tst_test.h"
+#include "lapi/keyctl.h"
+#include "common.h"
+
+static int *keep_polling;
+
+static void saw_key_updated(struct watch_notification *n, size_t len, unsigned int wtype)
+{
+	if (wqueue_key_event(n, len, wtype, NOTIFY_KEY_UPDATED))
+		tst_res(TPASS, "keyctl update has been recognized");
+	else
+		tst_res(TFAIL, "keyctl update has not been recognized");
+}
+
+static void setup(void)
+{
+	keep_polling = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	*keep_polling = 0;
+	SAFE_MUNMAP(keep_polling, sizeof(int));
+}
+
+static void run(void)
+{
+	int fd;
+	int pid;
+	key_serial_t key;
+
+	fd = wqueue_watch(256, &wqueue_key_filter);
+	key = wqueue_add_key(fd);
+
+	*keep_polling = 1;
+
+	pid = SAFE_FORK();
+	if (pid > 0) {
+		wqueue_consumer(fd, keep_polling, saw_key_updated);
+		return;
+	}
+
+	safe_keyctl(KEYCTL_UPDATE, key, "b", 1);
+
+	*keep_polling = 0;
+
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.forks_child = 1
+};
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
