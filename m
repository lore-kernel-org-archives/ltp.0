Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613DD10A62F9
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:40:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEDE33CC20B
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 15:40:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BD823CB935
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:40:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F0381000367
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 15:40:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D4A35BD29;
 Thu, 26 Mar 2026 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774536001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5chGy+nHssmX4B5dRWHnyo2+Dk/RJ1zPI2fd7twcC6c=;
 b=U5WoB1akvkyVkHSQdT/1P640crJFNEvTmUYdqIPh9GU8BLKJjj234F88a4xEug5IgsLqOr
 8V13DtOAl0ad9xZnB1VGp+xpsIaTzM9fiVe7DZ5H4/3SibrvObJpjdIksdFzg7gmefNrwa
 JaIOiNd3+ITKvWolWt9nsukW1bKYLBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774536001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5chGy+nHssmX4B5dRWHnyo2+Dk/RJ1zPI2fd7twcC6c=;
 b=cRxc+Lnxj22kOrg4KNxGfxGwcjZpEGfx+fh9SEw6pTN5mi9tqLNaOkdiSh/nqbgDRgaiBM
 T5LnUc/D0QOlKpCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774536001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5chGy+nHssmX4B5dRWHnyo2+Dk/RJ1zPI2fd7twcC6c=;
 b=U5WoB1akvkyVkHSQdT/1P640crJFNEvTmUYdqIPh9GU8BLKJjj234F88a4xEug5IgsLqOr
 8V13DtOAl0ad9xZnB1VGp+xpsIaTzM9fiVe7DZ5H4/3SibrvObJpjdIksdFzg7gmefNrwa
 JaIOiNd3+ITKvWolWt9nsukW1bKYLBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774536001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5chGy+nHssmX4B5dRWHnyo2+Dk/RJ1zPI2fd7twcC6c=;
 b=cRxc+Lnxj22kOrg4KNxGfxGwcjZpEGfx+fh9SEw6pTN5mi9tqLNaOkdiSh/nqbgDRgaiBM
 T5LnUc/D0QOlKpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C10F4A0A3;
 Thu, 26 Mar 2026 14:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kA+qAUFFxWleMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Mar 2026 14:40:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Mar 2026 15:40:06 +0100
Message-ID: <20260326144006.3035-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/test_kconfig.c |  1 +
 lib/tst_kconfig.c               | 37 ++++++++++++++++++++++++++++++++-
 lib/tst_kconfig_checks.h        | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 1 deletion(-)
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
index adc56503e..5c2f4e044 100644
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
diff --git a/lib/tst_kconfig_checks.h b/lib/tst_kconfig_checks.h
new file mode 100644
index 000000000..e117ab640
--- /dev/null
+++ b/lib/tst_kconfig_checks.h
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_KCONFIG_CHECKS
+#define TST_KCONFIG_CHECKS
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
+#endif /* TST_KCONFIG_CHECKS */
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
