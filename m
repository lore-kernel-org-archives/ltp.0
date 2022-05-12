Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0529C433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 19:47:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04D623CA9DF
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 21:47:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1320C3C8CC3
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9FF6514010EC
 for <ltp@lists.linux.it>; Thu, 12 May 2022 21:46:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D1F321B09;
 Thu, 12 May 2022 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652384766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNlM7+5qn2zdr7mCcIc1G5pcTM0yTybu6kxhQq6Do4k=;
 b=1bMzQWQC9nhkQb9KeWM4gnjcFPkqz2Ey595WL3ivtb3nn7npsS+9z6nJLSuokWyoy1llaU
 GfIzvuTd5fTecPTCeSwEEK1zNrSp1Gc02GSQhzmYLQ2L5i6Ts2cOqs7YzZFMVfEgUa66oD
 yUWzoZr7mTKeW3xzX2B57iB7MBr9hTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652384766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNlM7+5qn2zdr7mCcIc1G5pcTM0yTybu6kxhQq6Do4k=;
 b=2EZDxECBmYuRbgRribUc9JT4x07PZ41Pd3Y2a5RIxFnbIPSc1krK2eEyYXOXMPaTfUmAD/
 vt+pfRmf7hHMv4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E7CF513ABE;
 Thu, 12 May 2022 19:46:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OP6YNf1jfWIkVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 May 2022 19:46:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 21:45:54 +0200
Message-Id: <20220512194557.30911-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220512194557.30911-1-pvorel@suse.cz>
References: <20220512194557.30911-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/8] shell: Add tst_clear_device
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Binary required for shell $TST_ALL_FILESYSTEMS implementation
(C .all_filesystems uses it).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/.gitignore         |  1 +
 testcases/lib/Makefile           |  2 +-
 testcases/lib/tst_clear_device.c | 47 ++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_clear_device.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index c0d4dc851..579f84250 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -1,6 +1,7 @@
 /tst_check_drivers
 /tst_check_kconfigs
 /tst_checkpoint
+/tst_clear_device
 /tst_device
 /tst_getconf
 /tst_get_free_pids
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index f2de0c832..d5a8b08ac 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -12,6 +12,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
 			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
-			   tst_check_kconfigs
+			   tst_check_kconfigs tst_clear_device
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/lib/tst_clear_device.c b/testcases/lib/tst_clear_device.c
new file mode 100644
index 000000000..4111c7248
--- /dev/null
+++ b/testcases/lib/tst_clear_device.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#include <stdio.h>
+#include <sys/stat.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "old/old_device.h"
+
+extern struct tst_test *tst_test;
+
+static struct tst_test test = {
+};
+
+static void print_help(void)
+{
+	fprintf(stderr, "\nUsage: tst_clear_device block_device\n");
+}
+
+int main(int argc, char *argv[])
+{
+	/*
+	 * Force messages to be printed from the new library i.e. tst_test.c
+	 *
+	 * The new library prints messages into stderr while the old one prints
+	 * them into stdout. When messages are printed into stderr we can
+	 * safely do:
+	 *
+	 * DEV=$(tst_device acquire)
+	 */
+	tst_test = &test;
+	struct stat st;
+
+	if (argc < 2)
+		goto help;
+
+	if (stat(argv[1], &st) < 0 || !S_ISBLK(st.st_mode))
+		goto help;
+
+	return tst_clear_device(argv[1]);
+help:
+	print_help();
+	return 1;
+}
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
