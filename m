Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC341CD98DE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:14:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3423E6CCF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:14:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D52973E6CDB
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:13:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 31D461400BE0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:13:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D3779759AC;
 Mon, 15 Jun 2026 12:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781525572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjPno/rGAH2OYm+6QMuPLaQ5bTx0paRCEHX/XSZkfSM=;
 b=AYcpg9Z+h1GM59yaSJln9TS4oTCDJrTDy688TiMui0ehQZAyNYgM/WEsUTH209Cs0uW7U8
 R02IDU0FXyL5gmRl/rUvypu4cAcnGlX3VE0B4SYs+16C3vmWm/8cyXzXRFDgY2sU7vfRwG
 2nUg9Wnb1/Uk2qd5udC8gzawQVGC8UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781525572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjPno/rGAH2OYm+6QMuPLaQ5bTx0paRCEHX/XSZkfSM=;
 b=rqCiUmuN+D2MoUSurKFMtGhdUQQnWOSpPax4ZlSzW9fKxOx5GHAwBwRJISWCG0v8iIfJMq
 q498FbRt7s/hdnAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781525572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjPno/rGAH2OYm+6QMuPLaQ5bTx0paRCEHX/XSZkfSM=;
 b=AYcpg9Z+h1GM59yaSJln9TS4oTCDJrTDy688TiMui0ehQZAyNYgM/WEsUTH209Cs0uW7U8
 R02IDU0FXyL5gmRl/rUvypu4cAcnGlX3VE0B4SYs+16C3vmWm/8cyXzXRFDgY2sU7vfRwG
 2nUg9Wnb1/Uk2qd5udC8gzawQVGC8UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781525572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yjPno/rGAH2OYm+6QMuPLaQ5bTx0paRCEHX/XSZkfSM=;
 b=rqCiUmuN+D2MoUSurKFMtGhdUQQnWOSpPax4ZlSzW9fKxOx5GHAwBwRJISWCG0v8iIfJMq
 q498FbRt7s/hdnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB70C779A9;
 Mon, 15 Jun 2026 12:12:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id COlBLETsL2pRZAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jun 2026 12:12:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jun 2026 14:12:48 +0200
MIME-Version: 1.0
Message-Id: <20260615-fw_load-v7-4-d51e607f16bd@suse.com>
References: <20260615-fw_load-v7-0-d51e607f16bd@suse.com>
In-Reply-To: <20260615-fw_load-v7-0-d51e607f16bd@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781525572; l=10766;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=/QSRUayZwE4A57OWhy1Uizt3q779/C2EuiLEMqLxF2s=;
 b=X3nobGFVnv6HQVPAf0cIGTJSQrvr8h5JQBSLgWI/qn6csf9DUNmPzCg1G56EsfIF0KwV/d4fv
 tvuRF53jwUDD8LQo4yQ88ysFtcYTjFJebLXK1qgZQmP8DJTzOAcZU5l
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/4] fw_load: add fw_load02 for custom firmware path
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

Move test inside the header so both fw_load01 and fw_load02 will share
the same test function.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/kernel_misc                           |  1 +
 testcases/kernel/firmware/fw_load/.gitignore  |  1 +
 testcases/kernel/firmware/fw_load/Makefile    |  2 +-
 testcases/kernel/firmware/fw_load/fw_load.h   | 69 ++++++++++++++++++++
 testcases/kernel/firmware/fw_load/fw_load01.c | 72 +++------------------
 testcases/kernel/firmware/fw_load/fw_load02.c | 93 +++++++++++++++++++++++++++
 6 files changed, 174 insertions(+), 64 deletions(-)

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
diff --git a/testcases/kernel/firmware/fw_load/fw_load.h b/testcases/kernel/firmware/fw_load/fw_load.h
index 39f207cc30810e2ed9ea76176cedd98aa902d887..9692c0c90e046d1c13d3082d187076b2b43f84f5 100644
--- a/testcases/kernel/firmware/fw_load/fw_load.h
+++ b/testcases/kernel/firmware/fw_load/fw_load.h
@@ -6,6 +6,8 @@
 #ifndef FW_LOAD_H
 #define FW_LOAD_H
 
+#include "tst_test.h"
+
 #define MNAME_KO "ltp_fw_load.ko"
 #define FW_NAME	"load_tst.fw"
 #define FW_SIZE	0x1000
@@ -15,4 +17,71 @@
 #define DEV_RESULT "/sys/devices/ltp_fw_load/result"
 #define LIB_PATH "/lib/firmware"
 
+struct fw_data {
+	char dir[PATH_MAX];
+	char file[PATH_MAX];
+	int fake;
+	int created_dir;
+};
+
+static inline void create_firmware(struct fw_data *firmware,
+				   int *fw_count, const char *dir)
+{
+	struct fw_data *fw = &firmware[*fw_count];
+	char buf[FW_SIZE];
+	int fd;
+
+	snprintf(fw->dir, sizeof(fw->dir), "%s", dir);
+
+	if (access(dir, X_OK) == -1) {
+		SAFE_MKDIR(dir, 0755);
+		fw->created_dir = 1;
+	}
+
+	snprintf(fw->file, sizeof(fw->file), "%s/n%d_%s", dir, *fw_count, FW_NAME);
+	memset(buf, *fw_count, FW_SIZE);
+
+	fd = SAFE_OPEN(fw->file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, FW_SIZE);
+	SAFE_CLOSE(fd);
+
+	(*fw_count)++;
+}
+
+static inline void create_fake_firmware(struct fw_data *firmware, int *fw_count)
+{
+	snprintf(firmware[*fw_count].file, sizeof(firmware[*fw_count].file),
+		 "/n%d_%s", *fw_count, FW_NAME);
+
+	firmware[*fw_count].fake = 1;
+	(*fw_count)++;
+}
+
+static inline void do_test(struct fw_data *firmware, int fw_count)
+{
+	struct fw_data *fw;
+	int result = 0;
+	int pass, offset;
+
+	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
+	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
+
+	for (int i = 0; i < fw_count; i++) {
+		fw = &firmware[i];
+
+		pass = result & (1 << i);
+		offset = fw->dir[0] ? strlen(fw->dir) : 0;
+
+		if (fw->fake) {
+			tst_res(pass ? TFAIL : TPASS,
+				"Firmware '%s' correctly not loaded",
+				fw->file + offset);
+		} else {
+			tst_res(pass ? TPASS : TFAIL,
+				"Firmware '%s' loaded",
+				fw->file + offset);
+		}
+	}
+}
+
 #endif
diff --git a/testcases/kernel/firmware/fw_load/fw_load01.c b/testcases/kernel/firmware/fw_load/fw_load01.c
index 402e2c71f508fdbb9c3f73fcd42bf87da280137b..4b30a3b40fb1e3db8f300b2c56d5f29e8e37a7ff 100644
--- a/testcases/kernel/firmware/fw_load/fw_load01.c
+++ b/testcases/kernel/firmware/fw_load/fw_load01.c
@@ -40,61 +40,11 @@
 
 static int module_loaded;
 static int fw_count;
-
-static struct fw_data {
-	char dir[PATH_MAX];
-	char file[PATH_MAX];
-	int fake;
-	int created_dir;
-} firmware[FW_NUM];
-
-static void create_firmware(const char *dir)
-{
-	struct fw_data *fw = &firmware[fw_count];
-	char buf[FW_SIZE];
-	int fd = -1;
-
-	snprintf(fw->dir, sizeof(fw->dir), "%s", dir);
-	if (access(dir, X_OK) == -1) {
-		SAFE_MKDIR(dir, 0755);
-		fw->created_dir = 1;
-	}
-
-	snprintf(fw->file, sizeof(fw->file), "%s/n%d_%s", dir, fw_count, FW_NAME);
-	memset(buf, fw_count, FW_SIZE);
-
-	fd = SAFE_OPEN(fw->file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
-	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, FW_SIZE);
-	SAFE_CLOSE(fd);
-
-	fw_count++;
-}
+static struct fw_data firmware[FW_NUM];
 
 static void run(void)
 {
-	struct fw_data *fw;
-	int result = 0;
-	int pass, offset;
-
-	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
-	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
-
-	for (int i = 0; i < fw_count; i++) {
-		fw = &firmware[i];
-
-		pass = result & (1 << i);
-		offset = fw->dir[0] ? strlen(fw->dir) : 0;
-
-		if (fw->fake) {
-			tst_res(pass ? TFAIL : TPASS,
-				"Firmware '%s' correctly not loaded",
-				fw->file + offset);
-		} else {
-			tst_res(pass ? TPASS : TFAIL,
-				"Firmware '%s' loaded",
-				fw->file + offset);
-		}
-	}
+	do_test(firmware, fw_count);
 }
 
 static void setup(void)
@@ -104,7 +54,8 @@ static void setup(void)
 	struct utsname name;
 
 	if (access(LIB_PATH, W_OK) == -1)
-		tst_brk(TCONF, "Skipping test due to read-only %s", LIB_PATH);
+		tst_brk(TCONF, "Skipping test due to read-only %s",
+			LIB_PATH);
 
 	tst_requires_module_signature_disabled();
 
@@ -114,25 +65,20 @@ static void setup(void)
 	tst_module_load(MNAME_KO, mod_params);
 	module_loaded = 1;
 
-	create_firmware(LIB_PATH);
+	create_firmware(firmware, &fw_count, LIB_PATH);
 
 	uname(&name);
 
 	snprintf(fw_dir, sizeof(fw_dir), "%s/%s", LIB_PATH, name.release);
-	create_firmware(fw_dir);
+	create_firmware(firmware, &fw_count, fw_dir);
 
 	snprintf(fw_dir, sizeof(fw_dir), "%s/updates", LIB_PATH);
-	create_firmware(fw_dir);
+	create_firmware(firmware, &fw_count, fw_dir);
 
 	snprintf(fw_dir, sizeof(fw_dir), "%s/updates/%s", LIB_PATH, name.release);
-	create_firmware(fw_dir);
-
-	/* add a fake file */
-	snprintf(firmware[fw_count].file, sizeof(firmware[fw_count].file),
-		 "/n%d_%s", fw_count, FW_NAME);
+	create_firmware(firmware, &fw_count, fw_dir);
 
-	firmware[fw_count].fake = 1;
-	fw_count++;
+	create_fake_firmware(firmware, &fw_count);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/firmware/fw_load/fw_load02.c b/testcases/kernel/firmware/fw_load/fw_load02.c
new file mode 100644
index 0000000000000000000000000000000000000000..8d2063772c0f0aadeb5e46fcba6bf2a6bba4d327
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load/fw_load02.c
@@ -0,0 +1,93 @@
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
+ * The kernel firmware loader is pointed at the writable LTP
+ * temporary directory through
+ * ``/sys/module/firmware_class/parameters/path``.
+ * This avoids writing into ``/lib/firmware`` and therefore works
+ * on read-only or immutable root filesystems. The original value
+ * is saved and restored automatically.
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
+static int module_loaded;
+static int fw_count;
+static struct fw_data firmware[FW_NUM];
+
+static void run(void)
+{
+	do_test(firmware, fw_count);
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
+		create_firmware(firmware, &fw_count, tmpdir);
+
+	create_fake_firmware(firmware, &fw_count);
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
