Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A612C61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:17:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBAD63C5F31
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:17:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70B473E976E
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 246111001140
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6FFB7229EA;
 Fri,  4 Sep 2026 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=RqlkbeQrnzYyOn5p3No7jSh0rQfIkGLO3OqAM9HK3gHd9JrnD2dukwDPj5aFqKqvZ3440B
 ZvKvG88duUeoTgdznPETb6l7dxA7ay4HURiaXsPerjoNth0y0zqffCWaJ+Tr91oEEcOAAk
 UiDPWfHfZSW4Tdk9o1dLz3G1OTWr1+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=e+UyfzcBGhMuQpG8KedAha72+mn7XB4vVUH/tb2e7oEK9WFxSPgpIakso0igvTGgx1k/wm
 Dpgk/OU/XBSkB/Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dTZU081P;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WDhHq4O6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=dTZU081PWSXXxal2z3ytWqwcT3sFGBrTcimHP0jpOyBG+91zmUE/idke2Xg2Ui/dqIg85K
 wD0CHIC7og1LspHhz4JahG1i8dR4iysLnXDww1Fq8gEEEnIlhxHrYVVDIQCwFxyLDkxhW2
 KQ5VqmkqMKjBJzLTpWo53IASA1+HnpI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=WDhHq4O6RFpH0LFaceYGMnm3AMGKNCRXN8DqiiwQtzx+CCd0jSprwfclw2IqDZ0+9nx9Dy
 Dhr6vwasTeX/swDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7731413A04;
 Fri,  4 Sep 2026 12:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IGBbGtu0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:22 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-33-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=5203;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=449z9+992oftrv+9hmSze9XHDiw+7sU0Ci56rgR4DcM=;
 b=28jkJmgqyZvs0PlrVMFJhy5ZbWTojyD3luaOO3B6w2xAGny1EYK0HyrLzgPUcUcjyWtJ1nv+y
 hkFp+enKpovB6kOwB0v1jkPVrcd5j0Zc5KyMypPNUp+53i3fLlirwKq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 6FFB7229EA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 33/33] keyctl39: Negative tests for KEYCTL_WATCH_KEY
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add negative test cases for KEYCTL_WATCH_KEY verifying invalid
watch_id values, bogus key ids, missing View permission, invalid
file descriptors, non-watch-queue pipes, and removal of watches
on unwatched keys.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl39.c | 149 ++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index e9d47b5c4..538449a81 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -756,6 +756,7 @@ keyctl35 keyctl35
 keyctl36 keyctl36
 keyctl37 keyctl37
 keyctl38 keyctl38
+keyctl39 keyctl39
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index c0a18dd77..8de3d46c2 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -36,3 +36,4 @@
 /keyctl36
 /keyctl37
 /keyctl38
+/keyctl39
diff --git a/testcases/kernel/syscalls/keyctl/keyctl39.c b/testcases/kernel/syscalls/keyctl/keyctl39.c
new file mode 100644
index 000000000..4a0cf5efb
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl39.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_WATCH_KEY`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify ``KEYCTL_WATCH_KEY`` with ``watch_id < -1`` fails with ``EINVAL``
+ * - verify ``KEYCTL_WATCH_KEY`` with ``watch_id > 255`` fails with ``EINVAL``
+ * - verify ``KEYCTL_WATCH_KEY`` with bogus key id fails with ``ENOKEY``
+ * - verify ``KEYCTL_WATCH_KEY`` without View permission fails with ``EACCES``
+ * - verify ``KEYCTL_WATCH_KEY`` with invalid fd fails with ``EINVAL``
+ * - verify ``KEYCTL_WATCH_KEY`` with non-watch-queue fd fails with ``EINVAL``
+ * - verify ``KEYCTL_WATCH_KEY`` remove on unwatched key fails with ``EBADSLT``
+ */
+
+#define _GNU_SOURCE
+
+#include <unistd.h>
+#include "keyctl_common.h"
+#include "lapi/watch_queue.h"
+
+static key_serial_t key_valid;
+static key_serial_t key_no_view;
+static key_serial_t bogus_key = INT32_MAX;
+static int wqueue_pipefd[2] = {-1, -1};
+static int plain_pipefd[2] = {-1, -1};
+static int bad_fd = -1;
+
+static struct tcase {
+	key_serial_t *key;
+	int *fd;
+	int watch_id;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{
+		.key = &key_valid,
+		.fd = &wqueue_pipefd[0],
+		.watch_id = -2,
+		.exp_errno = EINVAL,
+		.desc = "watch_id < -1",
+	},
+	{
+		.key = &key_valid,
+		.fd = &wqueue_pipefd[0],
+		.watch_id = 256,
+		.exp_errno = EINVAL,
+		.desc = "watch_id > 255",
+	},
+	{
+		.key = &bogus_key,
+		.fd = &wqueue_pipefd[0],
+		.watch_id = 1,
+		.exp_errno = ENOKEY,
+		.desc = "bogus key id",
+	},
+	{
+		.key = &key_no_view,
+		.fd = &wqueue_pipefd[0],
+		.watch_id = 1,
+		.exp_errno = EACCES,
+		.desc = "key without View permission",
+	},
+	{
+		.key = &key_valid,
+		.fd = &bad_fd,
+		.watch_id = 1,
+		.exp_errno = EINVAL,
+		.desc = "invalid fd",
+	},
+	{
+		.key = &key_valid,
+		.fd = &plain_pipefd[0],
+		.watch_id = 1,
+		.exp_errno = EINVAL,
+		.desc = "non-watch-queue fd",
+	},
+	{
+		.key = &key_valid,
+		.fd = &wqueue_pipefd[0],
+		.watch_id = -1,
+		.exp_errno = EBADSLT,
+		.desc = "remove watch on unwatched key",
+	},
+};
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key_valid = new_user_key("ltpkeyctl39_valid", "data", 4,
+				 KEY_SPEC_PROCESS_KEYRING);
+
+	key_no_view = new_user_key("ltpkeyctl39_noview", "data", 4,
+				   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key_no_view, KEY_PERM_NO_VIEW, 0, 0);
+
+	TEST(pipe2(wqueue_pipefd, O_NOTIFICATION_PIPE));
+	if (TST_RET < 0) {
+		if (TST_ERR == ENOPKG)
+			tst_brk(TCONF | TTERRNO, "CONFIG_WATCH_QUEUE is not set");
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF | TTERRNO, "O_NOTIFICATION_PIPE is not supported");
+		tst_brk(TBROK | TTERRNO, "pipe2(O_NOTIFICATION_PIPE) failed");
+	}
+
+	SAFE_IOCTL(wqueue_pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, 256);
+
+	SAFE_PIPE(plain_pipefd);
+}
+
+static void cleanup(void)
+{
+	if (wqueue_pipefd[0] != -1)
+		SAFE_CLOSE(wqueue_pipefd[0]);
+	if (wqueue_pipefd[1] != -1)
+		SAFE_CLOSE(wqueue_pipefd[1]);
+	if (plain_pipefd[0] != -1)
+		SAFE_CLOSE(plain_pipefd[0]);
+	if (plain_pipefd[1] != -1)
+		SAFE_CLOSE(plain_pipefd[1]);
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(keyctl(KEYCTL_WATCH_KEY, *tc->key, *tc->fd, tc->watch_id),
+		     tc->exp_errno,
+		     "%s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "5.8",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_KEY_NOTIFICATIONS=y",
+		"CONFIG_WATCH_QUEUE=y",
+		NULL
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
