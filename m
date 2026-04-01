Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DF9D35177
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 11:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60CB13E5C1D
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 13:52:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F24923CAE45
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 13:51:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6D63B100074D
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 13:51:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D120D4D2E0;
 Wed,  1 Apr 2026 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775044304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l0NBkrk3KK5uPwvxUQ8y0WatCK+0w5qY8w1wn0BCMSQ=;
 b=2RqcsvuLEbOruVKbej4QAIWkzjhQx7tHGTqrl2C3pZeTqc2KYHPpCqVxFuzyRAu+ON1TdF
 ehzi9GRAPwkyFUINg3IZEcHiPVkNxIz85LoL+zwL6K0BDOfy5dP+zhQPaN1EdWHhQkbvd8
 r/+EAnYBkFW7dFxbu6NZnwwBxbDlDEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775044304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l0NBkrk3KK5uPwvxUQ8y0WatCK+0w5qY8w1wn0BCMSQ=;
 b=9exbVB+HVGvskE+JnAo8C53Oq5nK6gkozxifnLVNqb90xqIzN5fs0piDE1rWej7BD1DZaQ
 Q45YKQPkEJg4zIDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FCfaCNuZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CL3qwA07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775044303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l0NBkrk3KK5uPwvxUQ8y0WatCK+0w5qY8w1wn0BCMSQ=;
 b=FCfaCNuZojVrQQ/qbSywd0GwwivIePL1KhE/WdFQRHaAhHcwZDDJ0wlSidq8+hQ/uDHJ3R
 pEOXEHmGTlotkfV0+rtK54xoaBaNQrSSuMU6ty4BaxOTL91M5cJ2S72mPvwhtZuDOjQFw6
 CnnMxSUEWYYw+6ypvNjFFTDijPjPHEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775044303;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=l0NBkrk3KK5uPwvxUQ8y0WatCK+0w5qY8w1wn0BCMSQ=;
 b=CL3qwA07JWOxGHNU1ozXTGKzu7O24YxD3kquHfFzN/5HcIygihfq8Arks7J+rsLMa1h1zJ
 275TRwHATqsApFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C32FB4A0B0;
 Wed,  1 Apr 2026 11:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6r7sLs8GzWkZXgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 01 Apr 2026 11:51:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Apr 2026 13:51:47 +0200
Message-ID: <20260401115147.11604-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: D120D4D2E0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: tst_kconfig: Add runtime checks for
 CONFIG_*_NS
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

Previously LTP Kconfig parsing logic only checked if a feature was
enabled during kernel compilation (e.g., CONFIG_USER_NS=y). However,
some kernel features can be compiled in but disabled at runtime via
kernel command-line or sysctls. Tests relying only on Kconfig variables
may have failed when features were runtime disabled.

This patch introduces a runtime check mechanism for Kconfig variables.
When a  CONFIG_* variable is parsed as 'y' or 'm' and when runtime check
has been associated with the variable we run the check and potentionaly
print a message and override the variable value.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/test_kconfig.c |  1 +
 lib/tst_kconfig.c               | 38 ++++++++++++++++++++++++++++++++-
 lib/tst_kconfig_checks.h        | 37 ++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)
 create mode 100644 lib/tst_kconfig_checks.h

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
index adc56503e..52dd6d726 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2018-2026 Cyril Hrubis <chrubis@suse.cz>
  */
 
 #include <stdlib.h>
@@ -16,6 +16,8 @@
 #include "tst_bool_expr.h"
 #include "tst_safe_stdio.h"
 
+#include "tst_kconfig_checks.h"
+
 static int kconfig_skip_check(void)
 {
 	char *skipped = getenv("KCONFIG_SKIP_CHECK");
@@ -110,6 +112,38 @@ static void close_kconfig(FILE *fp)
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
+			return;
+		}
+	}
+}
+
 static inline int kconfig_parse_line(const char *line,
                                      struct tst_kconfig_var *vars,
                                      unsigned int vars_len)
@@ -183,9 +217,11 @@ out:
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
diff --git a/lib/tst_kconfig_checks.h b/lib/tst_kconfig_checks.h
new file mode 100644
index 000000000..94aad6411
--- /dev/null
+++ b/lib/tst_kconfig_checks.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_KCONFIG_CHECKS_H
+#define TST_KCONFIG_CHECKS_H
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
+
+#endif /* TST_KCONFIG_CHECKS_H */
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
