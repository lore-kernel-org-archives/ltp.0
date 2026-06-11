Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEF9CD98CC
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:45:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA6AB3C9F1E
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:45:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A3933E5E8F
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EB3D61000986
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 658566AF8B;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLf2dLRfgdItwwFlnuGO4LOScZ/R6dN3MYajRE8ZSoI=;
 b=jRrWQP9WH1SIgp3WP5wN5pLJTthYMTukWVstwX8A+ZoL8EjXDYIkc56xyWTbAsPvMrTAO0
 bPYjqNbyVWPgUpS8mByz6IeXH5CevWZXsnuj4F3ZMFBpl18lXmkgVIO/rOI86ClxBbo+mm
 5xuq2tsvMFOMpBc17BuudScd9qSkDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLf2dLRfgdItwwFlnuGO4LOScZ/R6dN3MYajRE8ZSoI=;
 b=bFfhHrayDy9owDRVIIPI+CcYJO6+KfqyxUhzAbD/VsQIxlaUbcfHwMz+UXMpOgeZ3AaPfZ
 RESpJyIjjeQ9ifCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLf2dLRfgdItwwFlnuGO4LOScZ/R6dN3MYajRE8ZSoI=;
 b=jRrWQP9WH1SIgp3WP5wN5pLJTthYMTukWVstwX8A+ZoL8EjXDYIkc56xyWTbAsPvMrTAO0
 bPYjqNbyVWPgUpS8mByz6IeXH5CevWZXsnuj4F3ZMFBpl18lXmkgVIO/rOI86ClxBbo+mm
 5xuq2tsvMFOMpBc17BuudScd9qSkDzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLf2dLRfgdItwwFlnuGO4LOScZ/R6dN3MYajRE8ZSoI=;
 b=bFfhHrayDy9owDRVIIPI+CcYJO6+KfqyxUhzAbD/VsQIxlaUbcfHwMz+UXMpOgeZ3AaPfZ
 RESpJyIjjeQ9ifCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47A09779A9;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CCT7D7i7KmqcJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 13:44:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 15:44:22 +0200
MIME-Version: 1.0
Message-Id: <20260611-fw_load-v6-4-c2aec79a7ed7@suse.com>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
In-Reply-To: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781185463; l=6476;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=qL637HIDeyKneao0k770JbFo1G8nGgsUr3CJpFtP32Y=;
 b=pQJVfarmF5mwshD/KYUnpk1QliyJl2yTIOYIVCLPKPBHIKJSmwOguyw3MAaPIebCX05/6NnIr
 Pb4nUF9vwCHA4nshOUoNPCSxxmGX4qHsLXAFue4nLjHhLdJybLxXkac
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/4] fw_load: add fw_load02 for custom firmware path
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

Add fw_load02 which points the kernel firmware loader at the writable
LTP temporary directory via /sys/module/firmware_class/parameters/path.
Unlike fw_load01, it does not rely on a writable /lib/firmware and so
works on read-only and immutable root filesystems while still exercising
request_firmware() for both successful loads and the not-found case.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                           |   1 +
 testcases/kernel/firmware/fw_load/.gitignore  |   1 +
 testcases/kernel/firmware/fw_load/Makefile    |   2 +-
 testcases/kernel/firmware/fw_load/fw_load02.c | 138 ++++++++++++++++++++++++++
 4 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 19caee1d81da9cf0503088138ecfda13436b96cf..cc3562cb78cfa9b657692fcbd8fb732f2879092e 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -1,6 +1,7 @@
 cn_pec_sh cn_pec.sh
 kmsg01 kmsg01
 fw_load01 fw_load01
+fw_load02 fw_load02
 rtc01 rtc01
 rtc02 rtc02
 block_dev block_dev
diff --git a/testcases/kernel/firmware/fw_load/.gitignore b/testcases/kernel/firmware/fw_load/.gitignore
index 57eca444c161e6ba642561664cc7de3a8f134841..0bacefd371fc3ac6cf043102398b5a0c74b0b66d 100644
--- a/testcases/kernel/firmware/fw_load/.gitignore
+++ b/testcases/kernel/firmware/fw_load/.gitignore
@@ -6,3 +6,4 @@
 /.tmp_versions/
 modules.livepatch
 fw_load01
+fw_load02
diff --git a/testcases/kernel/firmware/fw_load/Makefile b/testcases/kernel/firmware/fw_load/Makefile
index 91e8d8d153b43c459a899aff2124db612ec9e960..bf6f9abd7517654066a5a92ac481e8eb1f959a41 100644
--- a/testcases/kernel/firmware/fw_load/Makefile
+++ b/testcases/kernel/firmware/fw_load/Makefile
@@ -17,7 +17,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 REQ_VERSION_MAJOR   := 3
 REQ_VERSION_PATCH   := 7
 
-MAKE_TARGETS	:= fw_load01 ltp_fw_load.ko
+MAKE_TARGETS	:= fw_load01 fw_load02 ltp_fw_load.ko
 
 include $(top_srcdir)/include/mk/module.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/firmware/fw_load/fw_load02.c b/testcases/kernel/firmware/fw_load/fw_load02.c
new file mode 100644
index 0000000000000000000000000000000000000000..20de8383078bf637dd48499fecc89754fdbaec67
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load/fw_load02.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *	Alexey Kodanev <alexey.kodanev@oracle.com>
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verifies that the kernel firmware loader (``CONFIG_FW_LOADER``)
+ * can find and load firmware files from a custom firmware search
+ * path.
+ *
+ * A helper kernel module (``ltp_fw_load.ko``) registers a virtual
+ * device that calls :kernel_doc:`request_firmware` for a set of
+ * numbered firmware blobs. Each blob is verified in-kernel against
+ * its expected size and byte pattern.
+ *
+ * The kernel firmware loader is pointed at the writable LTP temporary
+ * directory through ``/sys/module/firmware_class/parameters/path``.
+ * This avoids writing into ``/lib/firmware`` and therefore works on
+ * read-only or immutable root filesystems. The original value is
+ * saved and restored automatically.
+ *
+ * [Algorithm]
+ *
+ * - Set the firmware search path to the LTP temporary directory
+ * - Load the helper module with ``fw_size`` matching the blob size
+ * - Create ``FW_NUM - 1`` firmware files there, each named
+ *   ``n<i>_load_tst.fw`` and filled with a known byte pattern
+ * - Add one fake firmware entry that has no file on disk
+ * - Write the firmware count to ``/sys/devices/ltp_fw_load/fwnum``
+ *   to trigger :kernel_doc:`request_firmware` calls in-kernel
+ * - Read the result bitmask from ``/sys/devices/ltp_fw_load/result``
+ * - Verify that every real firmware file was loaded successfully
+ *   and that the fake entry was correctly rejected
+ */
+
+#include "tst_test.h"
+#include "tst_module.h"
+#include "fw_load.h"
+
+#define MAX_NAME 64
+
+static int module_loaded;
+static int fw_count;
+
+static struct fw_data {
+	char file[PATH_MAX];
+	char name[MAX_NAME];
+	int fake;
+} firmware[FW_NUM];
+
+static void create_firmware(const char *dir)
+{
+	struct fw_data *fw = &firmware[fw_count];
+	char buf[FW_SIZE];
+	int fd;
+
+	snprintf(fw->name, sizeof(fw->name), "n%d_%s", fw_count, FW_NAME);
+	snprintf(fw->file, sizeof(fw->file), "%s/n%d_%s", dir, fw_count, FW_NAME);
+	memset(buf, fw_count, FW_SIZE);
+
+	fd = SAFE_OPEN(fw->file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, FW_SIZE);
+	SAFE_CLOSE(fd);
+
+	fw_count++;
+}
+
+static void run(void)
+{
+	struct fw_data *fw;
+	int result = 0;
+	int fail;
+
+	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
+	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
+
+	for (int i = 0; i < fw_count; i++) {
+		fw = &firmware[i];
+
+		if (fw->fake) {
+			tst_res(result & (1 << i) ? TFAIL : TPASS,
+				"Firmware '%s' correctly not loaded", fw->name);
+		} else {
+			fail = (result & (1 << i)) == 0;
+			tst_res(fail ? TFAIL : TPASS,
+				"Firmware '%s' loaded", fw->name);
+		}
+	}
+}
+
+static void setup(void)
+{
+	char fw_size_param[32];
+	char *tmpdir = tst_tmpdir_path();
+
+	tst_requires_module_signature_disabled();
+
+	SAFE_FILE_PRINTF(FW_PATH, "%s", tmpdir);
+
+	snprintf(fw_size_param, sizeof(fw_size_param), "fw_size=%d", FW_SIZE);
+	char *const mod_params[] = {fw_size_param, NULL};
+
+	tst_module_load(MNAME_KO, mod_params);
+	module_loaded = 1;
+
+	for (int i = 0; i < FW_NUM - 1; i++)
+		create_firmware(tmpdir);
+
+	/* add a fake file that is never created on disk */
+	snprintf(firmware[fw_count].name, sizeof(firmware[fw_count].name),
+		 "n%d_%s", fw_count, FW_NAME);
+	firmware[fw_count].fake = 1;
+	fw_count++;
+}
+
+static void cleanup(void)
+{
+	if (module_loaded)
+		tst_module_unload(MNAME_KO);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_FW_LOADER=y|CONFIG_FW_LOADER=m",
+		NULL,
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{FW_PATH, NULL, TST_SR_TCONF},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
