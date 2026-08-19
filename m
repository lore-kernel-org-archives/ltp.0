Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B413C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77FEF3C728C
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:17:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FD2E3C57A0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AB00620092C
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4246B3ED4
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thEBGvufCsI6fM2wSRS7GMl0B74CvK2erHhNrAthEZU=;
 b=guULxBNHJIQb2vqJ9WsPRHFasPYYWisTEcU75BUvDWbt1tfdfXfyw0Vb6NMtLeADL+pPCU
 zVKInfvxdavR8xFHXIezFIULSFgIX+kmPUcBEQfdqRCXjWF0ldQvsQ/XCn58t1Jt91bfWB
 k/vDLsBfnlKsGGSczGAdkET6gSOpQnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thEBGvufCsI6fM2wSRS7GMl0B74CvK2erHhNrAthEZU=;
 b=ZOi1iXCKAobv6cZWVOVdv3QM2GxP1p5+/VojtbUVZuqCEFEBSBJhqybzNvk27J1xGcA4NC
 fQOLwPOGd1ArtWAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mYd1855z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=I1VThcci
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thEBGvufCsI6fM2wSRS7GMl0B74CvK2erHhNrAthEZU=;
 b=mYd1855zZFEtzjSYKii21RPdIna+YNWtYmFjAPccHeTmzXVWq6Ol85JCwFXZ9o1n6zKkCC
 3NGNKj6vmRFnAiBsQgFk85wfLzZJyOY704uKgiDd2jZxfq3exb9NKGEGWVl0xZvH2PWiv1
 FsiAz6hBkQmQwZ3V68rrquPy6Eu/fJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156199;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thEBGvufCsI6fM2wSRS7GMl0B74CvK2erHhNrAthEZU=;
 b=I1VThccir3H0T7UPK7pQh2WmOV6lntf74cYQteQc//dw5okff4j3iylvMShvgnhlAB5Imf
 sD09LqG+OR36zCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 305E4367A
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NI/2CufWhWrscgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:06 +0200
Message-ID: <20260819161634.1341577-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4246B3ED4
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:email,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 03/31] testcases: sysfs: Add sys_kernel01
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
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
