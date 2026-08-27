Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BD6C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45E2A3DAC8B
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 123E33D865A
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC596200962
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4CD1F896
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX4q4jeiVhDbYv44BxQTGBNgOgugMb4kNeiGOGJz9xI=;
 b=tOQkF1emMbUUa2BZcXkhJR6BhrM7q81UNUCbjcIVyyPaXtt/G6N0OPZwYl2PeWjMHYjFbu
 EeZfazFUv/jbFbHr06tXn3kcISyrQxfOlv/J4oVaI8t7/rCUuMlWC7Ep8LsLm9L/W5RSVG
 5cdAN8ZZaK6DnVgHpiY4oFqWFOONAo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829758;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX4q4jeiVhDbYv44BxQTGBNgOgugMb4kNeiGOGJz9xI=;
 b=wwC/jdfnc+DDuWOfPEfd02x+tX8Y0gpXPFDhc53mPJmJWrRshae+NbBZ+2yt3f1GB/YO5X
 gTQG+dnS2KwbGEBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EcTToOdk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AZHK00oR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX4q4jeiVhDbYv44BxQTGBNgOgugMb4kNeiGOGJz9xI=;
 b=EcTToOdk7yRVLqjuuP6jDKiVGY0M0Iu+xUhEWI4IR947yL1EhAIQiuzlcUk9fNim6CeVaL
 TkQ8dttrV/HfTj4XIKAc8yHoDCliofun76ORZYYOm+dNXlDVzqvB7c3KJmUKGH3CzULhOJ
 r+YB/BgF8geOAXJLk7OyIQjmxl8eetU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nX4q4jeiVhDbYv44BxQTGBNgOgugMb4kNeiGOGJz9xI=;
 b=AZHK00oRIbh3VDfKT1XnlEW/s1FOztCg5qPoBbiDv1I60ZbbwLbs823+4Iak6NJMx7ANCw
 a0F/F2m+S5F4gCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1010D13694
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rLu8AvodkGqwawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:34 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:56 +0200
Message-ID: <20260827112157.1748734-31-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F4CD1F896
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:mid];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 30/31] testcases: sysfs: Add sys_mm_swap01
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

A test for /sys/kernel/mm/swap/vma_ra_enabled file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_path_defs.h                       |  3 ++
 runtest/sysfs                                 |  1 +
 .../kernel/sysfs/kernel/mm/swap/.gitignore    |  1 +
 .../kernel/sysfs/kernel/mm/swap/Makefile      |  7 ++++
 .../sysfs/kernel/mm/swap/sys_mm_swap01.c      | 35 +++++++++++++++++++
 5 files changed, 47 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 94836eb42..ecee8d426 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -92,6 +92,9 @@
 #define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
 #define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
 
+/* SWAP */
+#define PATH_MM_SWAP				"/sys/kernel/mm/swap"
+
 /* SYS_BLOCK */
 #define PATH_SYS_BLOCK				"/sys/block"
 
diff --git a/runtest/sysfs b/runtest/sysfs
index 08358ebc6..7d59ae701 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -25,3 +25,4 @@ sys_block_size01 sys_block_size01
 sys_hugepages01 sys_hugepages01
 sys_hugepages02 sys_hugepages02
 sys_ksm01 sys_ksm01
+sys_mm_swap01 sys_mm_swap01
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/.gitignore b/testcases/kernel/sysfs/kernel/mm/swap/.gitignore
new file mode 100644
index 000000000..38895046b
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/.gitignore
@@ -0,0 +1 @@
+/sys_mm_swap01
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/Makefile b/testcases/kernel/sysfs/kernel/mm/swap/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
new file mode 100644
index 000000000..08e3528da
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/swap/sys_mm_swap01.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity check for /sys/kernel/mm/swap/vma_ra_enabled.
+ *
+ * Unlike most other boolean sysfs tunables which use 0/1, this one is
+ * formatted as the strings ``true`` or ``false``, so it needs its own check
+ * rather than TST_SYSFS_ASSERT_BOOL().
+ *
+ * The test skips with TCONF when the attribute is not present.
+ */
+
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static const char *const bool_str_allowed[] = {
+	"true", "false", NULL
+};
+
+static void do_test(void)
+{
+	TST_SYSFS_ASSERT_ONEOF(bool_str_allowed, PATH_MM_SWAP "/vma_ra_enabled");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_SWAP=y",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
