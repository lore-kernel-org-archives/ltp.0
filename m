Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B80C88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:10:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D4353E8B97
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:10:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A84E3C72EC
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 005EB1A00A38
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62F4E1FEFD;
 Wed, 16 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kSU+Ga43GuMZ9vSXd5MbZJzxkvYix0zmkVg39MHLzk=;
 b=D5//aGhlpmNMDxhD+hrBAayrnHXSJB9DyLCx4g4amJo+HVombaUZJYVObrzwPdp75oD9Bn
 58vwxaWQy9qcuhRtb5X2wlhUZCGcWyb5LU/5yPXF1kAWqtQQj5P8C0qRj8keeCsJW5ooCM
 baqN0YgtaHhahXI162Ai+FXg7dkig9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kSU+Ga43GuMZ9vSXd5MbZJzxkvYix0zmkVg39MHLzk=;
 b=sLAP0GA+JvXiQCHzXhhYtqDxfPpeSH873l0MxKJ2AvP1S3nfj6knwbJU5X//1bZqp8dW2Q
 KW2ha9SF2Q/RpuBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Mm7iJak5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d9bjzY+v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kSU+Ga43GuMZ9vSXd5MbZJzxkvYix0zmkVg39MHLzk=;
 b=Mm7iJak5Hb3FLN14NsoRYl182KCqAr83j3SRkRMJpgQ0ueMatMeY3f4JDc9fbxHya0T6P2
 lE4+OZD1s6nbsc3kTY4B5sQ6A1dZdU89GGe5Bjjb5qPXqH+euWbY/T3DG1elb4ifC8EPZ5
 LoF5mlLacCOhnvtrJwxEF3Yh+GDtQkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kSU+Ga43GuMZ9vSXd5MbZJzxkvYix0zmkVg39MHLzk=;
 b=d9bjzY+vtfq65MYkL7n3Tgrn5AtL0aM+t4Vho4h7EtfBMYG0qWuQM2GmmDbbK3oU9vrJQj
 ZzDqbGchTHL2YTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64847139D2;
 Wed, 16 Sep 2026 14:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T36
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:04:01 +0200
Message-ID: <20260916140402.1797325-36-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 62F4E1FEFD
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 R_RATELIMIT(0.00)[to_ip_from(RL47ebk195wksjxkdm8ez9hex8)];
 RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 35/36] keyctl38: Test KEYCTL_WATCH_KEY add and
 remove
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

Test KEYCTL_WATCH_KEY by opening a watch queue notification pipe
and adding then removing watches on both a user key and the
session keyring.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_NEW_USER_KEY() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl38.c | 91 +++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl38.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e9a31a1947..b5abadad87 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -755,6 +755,7 @@ keyctl34 keyctl34
 keyctl35 keyctl35
 keyctl36 keyctl36
 keyctl37 keyctl37
+keyctl38 keyctl38
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 7ee6b90989..c0a18dd77b 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -35,3 +35,4 @@
 /keyctl35
 /keyctl36
 /keyctl37
+/keyctl38
diff --git a/testcases/kernel/syscalls/keyctl/keyctl38.c b/testcases/kernel/syscalls/keyctl/keyctl38.c
new file mode 100644
index 0000000000..4cf9a5b9f5
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl38.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_WATCH_KEY`` of :manpage:`keyctl(2)`, added in Linux 5.8.
+ *
+ * ``KEYCTL_WATCH_KEY`` adds or removes a watch on a key or keyring to/from
+ * a watch queue notification pipe.
+ *
+ * [Algorithm]
+ *
+ * - open a notification pipe via :manpage:`pipe2()` with
+ *   ``O_NOTIFICATION_PIPE``
+ * - add a watch on a key with ``watch_id = 1`` and verify success
+ * - remove the watch on the key with ``watch_id = -1`` and verify success
+ * - add a watch on a keyring with ``watch_id = 2`` and verify success
+ * - remove the watch on the keyring with ``watch_id = -1`` and verify success
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/resource.h>
+#include <unistd.h>
+#include "keyctl_common.h"
+#include "lapi/watch_queue.h"
+
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = SAFE_NEW_USER_KEY("ltpkeyctl38", "payload", 7,
+			   KEY_SPEC_PROCESS_KEYRING);
+}
+
+static void run(void)
+{
+	int pipefd[2];
+
+	TEST(pipe2(pipefd, O_NOTIFICATION_PIPE));
+	if (TST_RET < 0) {
+		if (TST_ERR == ENOPKG)
+			tst_brk(TCONF | TTERRNO, "CONFIG_WATCH_QUEUE is not set");
+		if (TST_ERR == EINVAL)
+			tst_brk(TCONF | TTERRNO, "O_NOTIFICATION_PIPE is not supported");
+		tst_brk(TBROK | TTERRNO, "pipe2(O_NOTIFICATION_PIPE) failed");
+	}
+
+	SAFE_IOCTL(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, 256);
+
+	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, key, pipefd[0], 1),
+		     "KEYCTL_WATCH_KEY add watch on key");
+
+	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, key, pipefd[0], -1),
+		     "KEYCTL_WATCH_KEY remove watch on key");
+
+	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING,
+			    pipefd[0], 2),
+		     "KEYCTL_WATCH_KEY add watch on session keyring");
+
+	TST_EXP_PASS(keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING,
+			    pipefd[0], -1),
+		     "KEYCTL_WATCH_KEY remove watch on session keyring");
+
+	SAFE_CLOSE(pipefd[0]);
+	SAFE_CLOSE(pipefd[1]);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.8",
+	/*
+	 * add_one_watch() charges per-user watches against RLIMIT_NOFILE,
+	 * so raise the limit high enough to accommodate pre-existing
+	 * watches on the calling user.
+	 */
+	.ulimit = (const struct tst_ulimit_val []) {
+		{RLIMIT_NOFILE, 524288},
+		{}
+	},
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
