Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEA2C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:11:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ED823E93BA
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:11:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E59F13E5857
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7C7D3200BCF
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC0E71F7F9;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=QdjwQWLojik/10IQ313g+7EaO39jTlVRiR5Dbqor9B7r3oqidWvBf3UWQTCWmM8jOAwVKC
 xwHH70QCUE88L9l0Jv5K2Ph7bEhDKnp4nFW2mDEvdQscy9Q2lx1eLqWPI/1RgBMunsVfuN
 A0CScelUp8k5SpKDB+aDYoP068CcuMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=ESOKzabtRVrjFnS4mbtK8CF6IB7h//w7v439CKGlhSg2SagHX6K7hOdUJmiqyCrbvo8q0R
 Q+Mal3MqvDdC/UDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OrDhjCbo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q7yBYe3l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=OrDhjCboGiOwxVolgjQ8aPhjYfhmVFm7AWG0gZkxMnS6RWIGyEZ2+NjyKDbMAyfSUhOafp
 i5G9y/9fraGdRJSNkwNM/yUehrD3TKcLEseZBFn+pYXK9/Dy6YM4mpsL4wYgKK9ufN3M44
 nZiK/BYrzHEIYRXiPFzA3S792Y/1/VU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gO2TO6SJcJWv+SSbkBEmFx9X9tGDGfVaGdZJ+MIJySI=;
 b=q7yBYe3lOIHZipGUo1ywNjAfZkY/w+FSnFz8R81Q/km+5DyT18tRmjO7gOoVrigXG47jS6
 o3lzuQV8VjvjX7Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4AFCB139B1;
 Wed,  2 Sep 2026 11:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eHyCELsCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:48 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-33-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=5203;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=449z9+992oftrv+9hmSze9XHDiw+7sU0Ci56rgR4DcM=;
 b=mjkqUCyOf3MIzVjysb5gZjtBxjq9HGEnzhM+IoyfDj/bjwqm100vjhJqWTN2TQ6U08++HU6PK
 4kdG/wh1Xh7Ah8vB2EMcFt+e6WIoOZS4/BVpCzGHuP8GvAUM4i+UqCN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: BC0E71F7F9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 33/33] keyctl39: Negative tests for KEYCTL_WATCH_KEY
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
