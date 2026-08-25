Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05727C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:37:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CE873C55EA
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:37:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6E083C5E2C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 60AE960070F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EC991F7BC
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xINQ96uH4VBOZTykask6QBq3LmmuIHxz1xQjQmUPOdI=;
 b=yhNA1CfgFBmLrbdjd3dNNGPqWKkeK1XUrI6wah3/P5/5kJV6hGyb/iW5WtmzkZAl6mk72o
 T/e3BLAxJM9qdXRxj+N9qDTkDFX2AnvmEEeQ+l5upC3enjZIFwsZCIBZ7KQNc89v+YEKIu
 tjAEl1dhBBR4zJwPAeK7smvj9FFWf0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xINQ96uH4VBOZTykask6QBq3LmmuIHxz1xQjQmUPOdI=;
 b=9WxGoUIQFWcnMPfHe/uhpXK5CT5us3g7TG4A5O5vNO47PJ0Fec0DNyCeqBgPZdluBD9ovb
 8FLOgplRjaAi+4Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xINQ96uH4VBOZTykask6QBq3LmmuIHxz1xQjQmUPOdI=;
 b=jssiDVq8l/sF6anhV4qdjBXddO1VFKjpvxqM6JMFUWL/6KJGoPwxBxOhyDHrNJygiusDgc
 HpJHuFmmyoRYnEkMZ18J5KbC7F0Z0QzMYt67iqsVqtT6LTokGwsqA/Fq2KwuO9Z47W/N9I
 G78T1882Nr3EJeABHgi+P9HQWVbf/hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xINQ96uH4VBOZTykask6QBq3LmmuIHxz1xQjQmUPOdI=;
 b=RC+0fmuT7gJ+HP+H9acIVPRBIUuguF3GtlnQABJ5NyiX5/eJnAo1+zL99fZ4jb+ZJ7Laxv
 1OocEiOzMHPKjUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C70D1339C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +f1jITh+jWocSAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:24 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:35:57 +0200
Message-ID: <20260825113625.1624134-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 03/31] testcases: sysfs: Add sys_kernel01
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
 runtest/sysfs                                |  1 +
 testcases/kernel/sysfs/kernel/.gitignore     |  1 +
 testcases/kernel/sysfs/kernel/Makefile       |  7 +++
 testcases/kernel/sysfs/kernel/sys_kernel01.c | 46 ++++++++++++++++++++
 4 files changed, 55 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/sys_kernel01.c

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
index 000000000..b5efbe2e1
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/sys_kernel01.c
@@ -0,0 +1,46 @@
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
+ * - cpu_byteorder is "little" or "big" and matches the host byte order
+ * - rcu_expedited and rcu_normal are booleans (0 or 1)
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present, since these files were added over several kernel releases.
+ */
+
+#include <endian.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define SYS_KERNEL "/sys/kernel"
+
+static const char *const address_bits_allowed[] = {
+	"32", "64", NULL
+};
+
+static void run(void)
+{
+	TST_SYSFS_ASSERT_ONEOF(address_bits_allowed, SYS_KERNEL "/address_bits");
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	TST_SYSFS_EXP_EQ_STR("little", SYS_KERNEL "/cpu_byteorder");
+#elif __BYTE_ORDER == __BIG_ENDIAN
+	TST_SYSFS_EXP_EQ_STR("big", SYS_KERNEL "/cpu_byteorder");
+#endif
+
+	TST_SYSFS_ASSERT_BOOL(SYS_KERNEL "/rcu_expedited");
+	TST_SYSFS_ASSERT_BOOL(SYS_KERNEL "/rcu_normal");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
