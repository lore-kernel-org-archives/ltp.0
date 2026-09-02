Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B5A8C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:11:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4AB13E93AE
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:11:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87CA13E93AC
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D796F600D47
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F72021E36;
 Wed,  2 Sep 2026 11:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5P1PMDkUGcSwrbJFFTWnd0OidQvtzboqJQZyN/DR7i8=;
 b=ABrVBTFfQlPZWX9o+AoICdryr3f3e4RhMtye4ggdTUNZ14wX/+mIUOvkKOvW28OyrIxy4h
 9J5NkULaXpoE7uT412kJ/jAULYSMMQooCS5oli/lZxahwqX91MflmUxi4whsDOPAao/byC
 Ptj93Xe3UjfaMA+EEllGJU3KkaH48v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5P1PMDkUGcSwrbJFFTWnd0OidQvtzboqJQZyN/DR7i8=;
 b=0mqaeOa5JRQBJdSFUZbqXIerJu9Vyl0Eddm1JngLDdz32pZj/XfNbJndqv8ZVOikrzz9kJ
 UViqrJa4vlXybjCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5P1PMDkUGcSwrbJFFTWnd0OidQvtzboqJQZyN/DR7i8=;
 b=Dhv3npJuIrnQDjW5+ZRAlqFD332S12bZWr6MlnPc3OJEqZS4Q8HcadzKivNVoXWndI5LAG
 rRCHtjA7b+I+Y18w9UdK1JIpLWMkvfT53pyN3uwRxwCvOii4MlgRH/F9RPYZGIGndej/9C
 HmiNjxmVwZvFNHAgu5cCE03TJjyR+3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5P1PMDkUGcSwrbJFFTWnd0OidQvtzboqJQZyN/DR7i8=;
 b=tAwRIWBP+SGBW+iskT/V7kclhRbI/e5AWpAG/IXOutlHpubq8SYUk3LfIW1oNBRolDxVow
 7kk1qlX3GislNfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25997139AF;
 Wed,  2 Sep 2026 11:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +MN4B7sCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:47 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-32-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=3944;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=yKPm6DiRjc+hvXyQA6ki3Ae76DwaiyeZLDzUd052ykA=;
 b=BaFZgFP2/8N4FUJv4QPact4lAZ9Bb0ANaJPILnV8lB7iuKWDbMvRA9Sxxpmjm5p7IXblzJHoM
 d2cs+k+2PirCWXL7FkcoFjTKkSq7EkpVQvHY/twTtfJOJGYCAEgd2xg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 32/33] keyctl38: Test KEYCTL_WATCH_KEY add and remove
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl38.c | 91 +++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 66215afd7..e9d47b5c4 100644
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
index 7ee6b9098..c0a18dd77 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -35,3 +35,4 @@
 /keyctl35
 /keyctl36
 /keyctl37
+/keyctl38
diff --git a/testcases/kernel/syscalls/keyctl/keyctl38.c b/testcases/kernel/syscalls/keyctl/keyctl38.c
new file mode 100644
index 000000000..26475c7de
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
+	key = new_user_key("ltpkeyctl38", "payload", 7,
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
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
