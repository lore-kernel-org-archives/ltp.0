Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3EDC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:23:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E44C43D69E8
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:23:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F21CB3D75B8
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 867EA20096A
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37E2A1F823
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZitCV3AvEGhgGN5XraVgm+QJN+mmTaJ/4QFzOFWw5o=;
 b=Zv9HTRrXwkmO0V88RE3WSby3T9wFe4XsGGqGmxzDYfJEyOjwlvKRi4/TuYjgLncLmV+0W0
 iHKbtw4HAb1qVH/CaHTjOtsV1k0DDbpUS1BNo3ZjaALin7yi186f8S+l+61Nn1lRtCR0RE
 XL85eo7cbQg6Ck4Ir0QHT1LZAY3uzIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829725;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZitCV3AvEGhgGN5XraVgm+QJN+mmTaJ/4QFzOFWw5o=;
 b=1UYOqGemsYR2aEeHmKRhizD1ne2f+iWDtYAQCPh5yxbymUD41J1hffXSlxVaI/XPP/G6Ag
 l/3HYS6N7QJj2NAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZitCV3AvEGhgGN5XraVgm+QJN+mmTaJ/4QFzOFWw5o=;
 b=2ctoFjr1xYjShUtrr5wCZ83yJeSNh/UaNmX93dm7Zq61S4/waiSuLo6xBPYLAccbH57ypi
 C23S7lyjdHiyBBaf0heGGOf1n0v2l9WjU8MaAef/+fkPpxvuqK4GtC3ttM6Qy1LAISqeEz
 DgTp+5sCmtvlmmBI4DH9dUpJ4o2n6o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YZitCV3AvEGhgGN5XraVgm+QJN+mmTaJ/4QFzOFWw5o=;
 b=/+huF5WCr/fdTvCa9E1bMPtIafImqWQKvMYqROgd/GXQP8ELvv8VM4Hbjh3gN2PrsolBpC
 w2Vho3srEUlcB4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2950E13354
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /H0PCdkdkGpIawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:29 +0200
Message-ID: <20260827112157.1748734-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 03/31] testcases: sysfs: Add sys_kernel01
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

A test for /sys/kernel/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_path_defs.h                      |  1 +
 runtest/sysfs                                |  1 +
 testcases/kernel/sysfs/kernel/.gitignore     |  1 +
 testcases/kernel/sysfs/kernel/Makefile       |  7 +++
 testcases/kernel/sysfs/kernel/sys_kernel01.c | 45 ++++++++++++++++++++
 5 files changed, 55 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/sys_kernel01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index b13559af8..8d0e1170a 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -93,6 +93,7 @@
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
 /* SYSFS */
+#define PATH_SYS_KERNEL				"/sys/kernel"
 #define PATH_SYS_POWER				"/sys/power"
 
 #endif /* TST_PATH_DEFS__ */
diff --git a/runtest/sysfs b/runtest/sysfs
index e679cacb1..142b4a290 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -1 +1,2 @@
 sys_power01 sys_power01
+sys_kernel01 sys_kernel01
diff --git a/testcases/kernel/sysfs/kernel/.gitignore b/testcases/kernel/sysfs/kernel/.gitignore
new file mode 100644
index 000000000..d11d43ce2
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/.gitignore
@@ -0,0 +1 @@
+/sys_kernel01
diff --git a/testcases/kernel/sysfs/kernel/Makefile b/testcases/kernel/sysfs/kernel/Makefile
new file mode 100644
index 000000000..d48598a66
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/kernel/sys_kernel01.c b/testcases/kernel/sysfs/kernel/sys_kernel01.c
new file mode 100644
index 000000000..37da11f97
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/sys_kernel01.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for assorted scalar attributes exported directly under
+ * /sys/kernel/.
+ *
+ * The test verifies that:
+ *
+ * - address_bits is either 32 or 64
+ * - cpu_byteorder is ``little`` or ``big`` and matches the host byte order
+ * - rcu_expedited and rcu_normal are booleans (0 or 1)
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, since these files were added over several kernel releases.
+ */
+
+#include <endian.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static const char *const address_bits_allowed[] = {
+	"32", "64", NULL
+};
+
+static void run(void)
+{
+	TST_SYSFS_ASSERT_ONEOF(address_bits_allowed, PATH_SYS_KERNEL "/address_bits");
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	TST_SYSFS_EXP_EQ_STR("little", PATH_SYS_KERNEL "/cpu_byteorder");
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	TST_SYSFS_EXP_EQ_STR("big", PATH_SYS_KERNEL "/cpu_byteorder");
+#endif
+
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_KERNEL "/rcu_expedited");
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_KERNEL "/rcu_normal");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
