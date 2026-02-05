Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71083EC1EBA
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 13:57:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03113CE2E9
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 14:57:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00C4C3CD31E
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 14:57:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 777B82005F3
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 14:57:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 111663E7A3
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770299845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xaNhEZ2EJEn4MEyZ/MANKj+OUq1PI7sGaNEQ3bHxoCQ=;
 b=m5WtNY5rHrhALiH80X2N7mkE7eOFAlmb1zr1yvBccy+RvCIn6A1hJR4LOL/nXMWJ0wEIu7
 hkR4KZ+DsBHxs+mmIPGCv6Nni4a2xw/+vWY+Nd5UyaKlE0i9BrJ/jTG5LXMfS4b80K4d6c
 EUL8R2U1ZW0UB9K+GbgGvmOWuLluoJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770299845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xaNhEZ2EJEn4MEyZ/MANKj+OUq1PI7sGaNEQ3bHxoCQ=;
 b=IcOIvaZnk8c+7Qo7HhY3NFpC+kLX6eTMX+gU3AaGi9BRFPVbc8IYqfF8OOMDBCU/6TE9rv
 RAfeAKnPTfMYc7Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m5WtNY5r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IcOIvaZn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770299845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xaNhEZ2EJEn4MEyZ/MANKj+OUq1PI7sGaNEQ3bHxoCQ=;
 b=m5WtNY5rHrhALiH80X2N7mkE7eOFAlmb1zr1yvBccy+RvCIn6A1hJR4LOL/nXMWJ0wEIu7
 hkR4KZ+DsBHxs+mmIPGCv6Nni4a2xw/+vWY+Nd5UyaKlE0i9BrJ/jTG5LXMfS4b80K4d6c
 EUL8R2U1ZW0UB9K+GbgGvmOWuLluoJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770299845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xaNhEZ2EJEn4MEyZ/MANKj+OUq1PI7sGaNEQ3bHxoCQ=;
 b=IcOIvaZnk8c+7Qo7HhY3NFpC+kLX6eTMX+gU3AaGi9BRFPVbc8IYqfF8OOMDBCU/6TE9rv
 RAfeAKnPTfMYc7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB3423EA63
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 13:57:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iQt0OMShhGkDLgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 05 Feb 2026 13:57:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Feb 2026 14:57:24 +0100
Message-ID: <20260205135724.23772-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 111663E7A3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_kconfig: Add runtime checks
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

So far for CONFIG_*_NS.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/test_kconfig.c |  1 +
 lib/tst_kconfig.c               | 35 +++++++++++++++++++++++++++++++++
 lib/tst_ns_checks.h             | 32 ++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100644 lib/tst_ns_checks.h

diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
index cea36b5ee..ed2c4610a 100644
--- a/lib/newlib_tests/test_kconfig.c
+++ b/lib/newlib_tests/test_kconfig.c
@@ -18,6 +18,7 @@ static const char *kconfigs[] = {
 	"CONFIG_MMU & CONFIG_EXT4_FS=m",
 	"CONFIG_EXT4_FS=m | CONFIG_MMU",
 	"CONFIG_DEFAULT_HOSTNAME=\"(none)\"",
+	"CONFIG_USER_NS",
 	NULL
 };
 
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 9bcd57721..8d0f8ae3a 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -16,6 +16,8 @@
 #include "tst_bool_expr.h"
 #include "tst_safe_stdio.h"
 
+#include "tst_ns_checks.h"
+
 static int kconfig_skip_check(void)
 {
 	char *skipped = getenv("KCONFIG_SKIP_CHECK");
@@ -110,6 +112,37 @@ static void close_kconfig(FILE *fp)
 		fclose(fp);
 }
 
+static struct runtime_check {
+	const char *config;
+	bool (*runtime_check)(void);
+} runtime_checks[] = {
+	{"CONFIG_USER_NS", tst_user_ns_enabled},
+	{"CONFIG_NET_NS", tst_net_ns_enabled},
+	{"CONFIG_PID_NS", tst_pid_ns_enabled},
+	{"CONFIG_MNT_NS", tst_mnt_ns_enabled},
+	{"CONFIG_IPC_NS", tst_ipc_ns_enabled},
+	{}
+};
+
+static void runtime_check(struct tst_kconfig_var *var)
+{
+	size_t i;
+
+	for (i = 0; runtime_checks[i].config; i++) {
+		if (strcmp(runtime_checks[i].config, var->id))
+			continue;
+
+		tst_res(TDEBUG, "Running runtime check for '%s'", var->id);
+
+		if (!runtime_checks[i].runtime_check()) {
+			tst_res(TINFO,
+				"%s=%c present but disabled at runtime",
+				var->id, var->choice);
+			var->choice = 'n';
+		}
+	}
+}
+
 static inline int kconfig_parse_line(const char *line,
                                      struct tst_kconfig_var *vars,
                                      unsigned int vars_len)
@@ -183,9 +216,11 @@ out:
 			switch (val[0]) {
 			case 'y':
 				vars[i].choice = 'y';
+				runtime_check(&vars[i]);
 				return 1;
 			case 'm':
 				vars[i].choice = 'm';
+				runtime_check(&vars[i]);
 				return 1;
 			}
 		}
diff --git a/lib/tst_ns_checks.h b/lib/tst_ns_checks.h
new file mode 100644
index 000000000..743d3d09d
--- /dev/null
+++ b/lib/tst_ns_checks.h
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <unistd.h>
+#include <stdbool.h>
+
+static inline bool tst_user_ns_enabled(void)
+{
+	return access("/proc/self/ns/user", F_OK) == 0;
+}
+
+static inline bool tst_net_ns_enabled(void)
+{
+	return access("/proc/self/ns/net", F_OK) == 0;
+}
+
+static inline bool tst_pid_ns_enabled(void)
+{
+	return access("/proc/self/ns/pid", F_OK) == 0;
+}
+
+static inline bool tst_mnt_ns_enabled(void)
+{
+	return access("/proc/self/ns/mnt", F_OK) == 0;
+}
+
+static inline bool tst_ipc_ns_enabled(void)
+{
+	return access("/proc/self/ns/ipc", F_OK) == 0;
+}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
