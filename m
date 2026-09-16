Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E28BC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4433E8C4E
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:13:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF0C43E8C47
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5614600713
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3681FF3A;
 Wed, 16 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPj9Gk+6LSIC/5vo++CkH3bRoMc3U3J1dbQ7tEhCgvs=;
 b=3BUnLjdn2l82LyXxrmjiIpf19bfqCEFtZbPdA/NjvgHljA75CFeYyaBgX3XbZsKqmFDXLI
 Z07Ut93HYgUAPdf1vX2YYYo6qa3vC2MUtzhtT85TK33FrG6UDLGBpwVIDhrx3RodNWF0VO
 EajwTbV/F1muLyekDKKzPLKCELqJhbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPj9Gk+6LSIC/5vo++CkH3bRoMc3U3J1dbQ7tEhCgvs=;
 b=vforY0ApE+LHNefbHoBQenqv887ZrV7rf5d9gC3587FzMZMHawJ4AsvUhRU5AEG7luT5X9
 n9zHNPQeKSscR5BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cOUFOmTQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=33BxQRYo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPj9Gk+6LSIC/5vo++CkH3bRoMc3U3J1dbQ7tEhCgvs=;
 b=cOUFOmTQzYuhUEa1wGPJKQVCUeJg13DQd1q9l8Clsce5liXba2qG4vWhh0ypW1EylAxVsN
 +MqnR9rHSggbVFs0C1QQcqngAkfGJSyWuOZq73jieyjP9KFaV4w5mXRFpDDBCmM+CgzLT3
 hu0wBnbS+EgNFsoqk8Zpx+mOYh4NM8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PPj9Gk+6LSIC/5vo++CkH3bRoMc3U3J1dbQ7tEhCgvs=;
 b=33BxQRYoq/i9JCAFF82loDiLiSTmKR6+FqGT9XNyv0OE0J+0vDwMAXJr5pkQpVKjgAs+0H
 cZQkpioH2jWakpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7499139D3;
 Wed, 16 Sep 2026 14:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T37
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:04:02 +0200
Message-ID: <20260916140402.1797325-37-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8E3681FF3A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL47ebk195wksjxkdm8ez9hex8)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 36/36] keyctl39: Negative tests for KEYCTL_WATCH_KEY
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/keyctl/.gitignore |   1 +
 testcases/kernel/syscalls/keyctl/keyctl39.c | 149 ++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl39.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b5abadad87..f721962f85 100644
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
index c0a18dd77b..8de3d46c25 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -36,3 +36,4 @@
 /keyctl36
 /keyctl37
 /keyctl38
+/keyctl39
diff --git a/testcases/kernel/syscalls/keyctl/keyctl39.c b/testcases/kernel/syscalls/keyctl/keyctl39.c
new file mode 100644
index 0000000000..3df17911ff
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
+ * Verify ``KEYCTL_WATCH_KEY``
+ *
+ * - with ``watch_id < -1`` fails with ``EINVAL``
+ * - with ``watch_id > 255`` fails with ``EINVAL``
+ * - with bogus key id fails with ``ENOKEY``
+ * - without View permission fails with ``EACCES``
+ * - with invalid fd fails with ``EINVAL``
+ * - with non-watch-queue fd fails with ``EINVAL``
+ * - remove on unwatched key fails with ``EBADSLT``
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
+	key_valid = SAFE_NEW_USER_KEY("ltpkeyctl39_valid", "data", 4,
+				 KEY_SPEC_PROCESS_KEYRING);
+
+	key_no_view = SAFE_NEW_USER_KEY("ltpkeyctl39_noview", "data", 4,
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
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
