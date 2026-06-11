Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7522CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 13:45:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 464473C56FF
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 15:45:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 233B53E618C
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 336072003B6
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 15:44:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 245DE6AF7D;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAgrxxPkppPYVOwAZiIgJPamxurpvOIyfO1hiWXxpk4=;
 b=SL1iKv/j2Lk4RoFjjzORtcfK/9zR/7SeggY8mJxtBhozHfV5mxQKTunAbrptgd/RFYu3Tp
 7+226prq6AuSvpXNvR+0/QkseruzSskFFK0eEj74JboTPdzAF7SkJP89jMYo7+c+OX7oxG
 Wx8ZEH77AhTVn9IrQZpp/nubbhMlQoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAgrxxPkppPYVOwAZiIgJPamxurpvOIyfO1hiWXxpk4=;
 b=H96eIAHE+TqRC80xOVP7zJ2y0th18xIpo/rdngEFleUsOQYfftBnyv/VGeitWDIaCPN4Y6
 xBaCUSBZbFMC23Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="SL1iKv/j";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=H96eIAHE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781185464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAgrxxPkppPYVOwAZiIgJPamxurpvOIyfO1hiWXxpk4=;
 b=SL1iKv/j2Lk4RoFjjzORtcfK/9zR/7SeggY8mJxtBhozHfV5mxQKTunAbrptgd/RFYu3Tp
 7+226prq6AuSvpXNvR+0/QkseruzSskFFK0eEj74JboTPdzAF7SkJP89jMYo7+c+OX7oxG
 Wx8ZEH77AhTVn9IrQZpp/nubbhMlQoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781185464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAgrxxPkppPYVOwAZiIgJPamxurpvOIyfO1hiWXxpk4=;
 b=H96eIAHE+TqRC80xOVP7zJ2y0th18xIpo/rdngEFleUsOQYfftBnyv/VGeitWDIaCPN4Y6
 xBaCUSBZbFMC23Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07AAF779A7;
 Thu, 11 Jun 2026 13:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABRQALi7KmqcJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 11 Jun 2026 13:44:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 11 Jun 2026 15:44:20 +0200
MIME-Version: 1.0
Message-Id: <20260611-fw_load-v6-2-c2aec79a7ed7@suse.com>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
In-Reply-To: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781185463; l=13768;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QvfoR+rmbAE3vEiluH5BMAOOFgXymJVF+khCG6BpITc=;
 b=WV2i+yv1fgGeHZUnv1TRUUPgdMlRxBqBLI5kcEKM6FC5PlI93iPf9NCIzpJiB/w1ncAztdCQF
 IT+fjnxmVViD5KgSAjqMM/PKrV+7S1GAd+hx7QZud/Jcj5obVfrwARK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 245DE6AF7D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 2/4] fw_load: rewrite test using new LTP API
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

Remove the obsolete user-helper and create a fw_load.h where to
store the firmware support information.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/firmware/fw_load_user/Makefile  |  18 +-
 testcases/kernel/firmware/fw_load_user/README    |  11 -
 testcases/kernel/firmware/fw_load_user/fw_load.c | 286 ++++++++++-------------
 testcases/kernel/firmware/fw_load_user/fw_load.h |  18 ++
 4 files changed, 140 insertions(+), 193 deletions(-)

diff --git a/testcases/kernel/firmware/fw_load_user/Makefile b/testcases/kernel/firmware/fw_load_user/Makefile
index effd5dae5c05e9115c391093af523ab36ebfc8d6..5b031e2eb81597689ff5eab70246fb20ad02e77d 100644
--- a/testcases/kernel/firmware/fw_load_user/Makefile
+++ b/testcases/kernel/firmware/fw_load_user/Makefile
@@ -1,20 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of
-# the License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# Copyright (c) Linux Test Project, 2026
 
-top_srcdir		?= ../../../..
+top_srcdir	?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/firmware/fw_load_user/README b/testcases/kernel/firmware/fw_load_user/README
deleted file mode 100644
index 702fac90a2ccb41612ea8dc1010b468588cd3446..0000000000000000000000000000000000000000
--- a/testcases/kernel/firmware/fw_load_user/README
+++ /dev/null
@@ -1,11 +0,0 @@
-The aim of the test is to check device firmware loading. Since kernel 3.7
-firmware loading changed to direct loading (by-pass udev). The test consists
-of the two parts:
- - userspace part
- - kernelspace part
-
-This is the userspace part, its tasks are:
- - create firmware files in the standard firmware paths
- - load the module and initiate firmware request procedure
- - read device's result file and print final results
- - unload the module.
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index 1f68f2ad67cb34af5bfe19f77482cd032bdbad3f..0659c84215f37c06bdb589bed6a4012b3b4fbf90 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -1,213 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *	Alexey Kodanev <alexey.kodanev@oracle.com>
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verifies that the kernel firmware loader (``CONFIG_FW_LOADER``)
+ * can find and load firmware files from the standard search paths.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 of
- * the License, or (at your option) any later version.
+ * A helper kernel module (``ltp_fw_load.ko``) registers a virtual
+ * device that calls :kernel_doc:`request_firmware` for a set of
+ * numbered firmware blobs. Each blob is verified in-kernel against
+ * its expected size and byte pattern.
  *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * [Algorithm]
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * - Load the helper module with ``fw_size`` matching the blob size
+ * - Create firmware files in the standard firmware search
+ *   directories:
  *
- * Author:
- * Alexey Kodanev <alexey.kodanev@oracle.com>
+ *   - ``/lib/firmware/``
+ *   - ``/lib/firmware/<kernel-release>/``
+ *   - ``/lib/firmware/updates/``
+ *   - ``/lib/firmware/updates/<kernel-release>/``
  *
- * Test checks device firmware loading.
+ * - Add one fake firmware entry that has no file on disk
+ * - Write the firmware count to ``/sys/devices/ltp_fw_load/fwnum``
+ *   to trigger :kernel_doc:`request_firmware` calls in-kernel
+ * - Read the result bitmask from ``/sys/devices/ltp_fw_load/result``
+ * - Verify that every real firmware file was loaded successfully
+ *   and that the fake entry was correctly rejected
  */
 
-#define _GNU_SOURCE
 #include <sys/utsname.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <string.h>
-
-#include "test.h"
-#include "tst_security.h"
-#include "tso_safe_macros.h"
-#include "tso_module.h"
-
-/* number of test firmware files */
-#define FW_FILES	5
-
-char *TCID = "fw_load";
-int TST_TOTAL = FW_FILES;
+#include "tst_test.h"
+#include "tst_module.h"
+#include "fw_load.h"
 
-static int fw_size = 0x1000;
+static int module_loaded;
+static int fw_count;
 
-static const char fw_name[]	= "load_tst.fw";
-static const char module_name[]	= "ltp_fw_load.ko";
-
-/* paths to module's sysfs files */
-static const char dev_fwnum[]	= "/sys/devices/ltp_fw_load/fwnum";
-static const char dev_result[]	= "/sys/devices/ltp_fw_load/result";
-
-struct fw_file_info {
-	char *file;
-	char *dir;
+static struct fw_data {
+	char dir[PATH_MAX];
+	char file[PATH_MAX];
 	int fake;
-	int remove_dir;
-	int remove_file;
-};
+	int created_dir;
+} firmware[FW_NUM];
 
-static struct fw_file_info fw[FW_FILES];
-static int fw_num;
-
-/* test options */
-static char *narg;
-static int nflag;
-static int skip_cleanup;
-static int verbose;
-static const option_t options[] = {
-	{"n:", &nflag, &narg},
-	{"s", &skip_cleanup, NULL},
-	{"v", &verbose, NULL},
-	{NULL, NULL, NULL}
-};
+static void create_firmware(const char *dir)
+{
+	struct fw_data *fw = &firmware[fw_count];
+	char buf[FW_SIZE];
+	int fd = -1;
+
+	snprintf(fw->dir, sizeof(fw->dir), "%s", dir);
+	if (access(dir, X_OK) == -1) {
+		SAFE_MKDIR(dir, 0755);
+		fw->created_dir = 1;
+	}
 
-static void help(void);
-static void setup(int argc, char *argv[]);
-static void test_run(void);
-static void cleanup(void);
+	snprintf(fw->file, sizeof(fw->file), "%s/n%d_%s", dir, fw_count, FW_NAME);
+	memset(buf, fw_count, FW_SIZE);
 
-/*
- * create firmware files in the fw_paths
- * @fw_paths: it must be termintated by a NULL pointer
- */
-static void create_firmware(char *const fw_paths[]);
+	fd = SAFE_OPEN(fw->file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, FW_SIZE);
+	SAFE_CLOSE(fd);
 
-int main(int argc, char *argv[])
+	fw_count++;
+}
+
+static void run(void)
 {
-	setup(argc, argv);
+	struct fw_data *fw;
+	int result = 0;
+	int fail, offset;
 
-	test_run();
+	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
+	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
 
-	cleanup();
+	for (int i = 0; i < fw_count; i++) {
+		fw = &firmware[i];
 
-	tst_exit();
-}
+		fail = (result & (1 << i)) == 0 && !fw->fake;
+		offset = fw->dir[0] ? strlen(fw->dir) : 0;
 
-static void help(void)
-{
-	printf("  -n x    Write x bytes to firmware file, default is %d\n",
-		fw_size);
-	printf("  -s      Skip cleanup\n");
-	printf("  -v      Verbose\n");
+		if (fw->fake) {
+			tst_res(result & (1 << i) ? TFAIL : TPASS,
+				"Firmware '%s' correctly not loaded",
+				fw->file + offset);
+		} else {
+			tst_res(fail ? TFAIL : TPASS,
+				"Firmware '%s' loaded",
+				fw->file + offset);
+		}
+	}
 }
 
-void setup(int argc, char *argv[])
+static void setup(void)
 {
-	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
-		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");
-
-	tst_parse_opts(argc, argv, options, help);
+	char fw_dir[PATH_MAX];
+	char fw_size_param[32];
+	struct utsname name;
 
-	if (nflag) {
-		if (sscanf(narg, "%i", &fw_size) != 1)
-			tst_brkm(TBROK, NULL, "-n option arg is not a number");
-		if (fw_size < 0)
-			tst_brkm(TBROK, NULL, "-n option arg is less than 0");
-	}
+	if (access(LIB_PATH, W_OK) == -1)
+		tst_brk(TCONF, "Skipping test due to read-only %s", LIB_PATH);
 
-	tst_require_root();
 	tst_requires_module_signature_disabled();
 
-	char fw_size_param[19];
-	snprintf(fw_size_param, 19, "fw_size=%d", fw_size);
-	char *const mod_params[2] = { fw_size_param, NULL };
-	tst_module_load(NULL, module_name, mod_params);
+	snprintf(fw_size_param, sizeof(fw_size_param), "fw_size=%d", FW_SIZE);
+	char *const mod_params[] = {fw_size_param, NULL};
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	tst_module_load(MNAME_KO, mod_params);
+	module_loaded = 1;
 
-	/* get current Linux version and make firmware paths */
-	struct utsname uts_name;
-	uname(&uts_name);
+	create_firmware(LIB_PATH);
 
-	/* 4 firmware paths + NULL */
-	char *fw_paths[5] = { "/lib/firmware", "/lib/firmware/updates" };
-	SAFE_ASPRINTF(cleanup, &fw_paths[2], "%s/%s", fw_paths[0], uts_name.release);
-	SAFE_ASPRINTF(cleanup, &fw_paths[3], "%s/%s", fw_paths[1], uts_name.release);
+	uname(&name);
 
-	/* create firmware in the hard coded firmware search paths */
-	create_firmware(fw_paths);
+	snprintf(fw_dir, sizeof(fw_dir), "%s/%s", LIB_PATH, name.release);
+	create_firmware(fw_dir);
 
-	free(fw_paths[2]);
-	free(fw_paths[3]);
+	snprintf(fw_dir, sizeof(fw_dir), "%s/updates", LIB_PATH);
+	create_firmware(fw_dir);
 
-	/* make non-existent firmware file */
-	SAFE_ASPRINTF(cleanup, &fw[fw_num].file, "/n%d_%s", fw_num, fw_name);
-	fw[fw_num].fake = 1;
-	++fw_num;
-}
+	snprintf(fw_dir, sizeof(fw_dir), "%s/updates/%s", LIB_PATH, name.release);
+	create_firmware(fw_dir);
 
-static void test_run(void)
-{
-	/* initiate firmware requests */
-	SAFE_FILE_PRINTF(cleanup, dev_fwnum, "%d", fw_num);
+	/* add a fake file */
+	snprintf(firmware[fw_count].file, sizeof(firmware[fw_count].file),
+		 "/n%d_%s", fw_count, FW_NAME);
 
-	/* get module results by reading result bit mask */
-	int result = 0;
-	SAFE_FILE_SCANF(cleanup, dev_result, "%d", &result);
-
-	int i, fail, offset;
-	for (i = 0; i < fw_num; ++i) {
-		fail = (result & (1 << i)) == 0 && !fw[i].fake;
-		offset = (fw[i].dir) ? strlen(fw[i].dir) : 0;
-		tst_resm((fail) ? TFAIL : TPASS,
-			"Expect: %s load firmware '...%s'",
-			(fw[i].fake) ? "can't" : "can",
-			fw[i].file + offset);
-	}
+	firmware[fw_count].fake = 1;
+	fw_count++;
 }
 
 static void cleanup(void)
 {
-	if (skip_cleanup)
-		return;
-
-	int i;
-	/* remove subdirs first and then upper level dirs */
-	for (i = fw_num - 1; i >= 0; --i) {
-		if (fw[i].remove_file && remove(fw[i].file) == -1)
-			tst_resm(TWARN, "Can't remove: %s", fw[i].file);
-		free(fw[i].file);
-
-		if (fw[i].remove_dir && remove(fw[i].dir) == -1)
-			tst_resm(TWARN, "Can't remove %s", fw[i].dir);
-		free(fw[i].dir);
-	}
+	struct fw_data *fw;
 
-	tst_module_unload(NULL, module_name);
-}
+	for (int i = fw_count - 1; i >= 0; i--) {
+		fw = &firmware[i];
 
-static void create_firmware(char *const fw_paths[])
-{
-	int i = 0;
-	while (fw_paths[i] != NULL) {
-		struct fw_file_info *fi = &fw[fw_num];
-		fi->dir = strdup(fw_paths[i]);
-		if (access(fi->dir, X_OK) == -1) {
-			/* create dir */
-			SAFE_MKDIR(cleanup, fi->dir, 0755);
-			fi->remove_dir = 1;
-		}
+		if (access(fw->file, F_OK) != -1)
+			SAFE_UNLINK(fw->file);
 
-		/* create test firmware file */
-		SAFE_ASPRINTF(cleanup, &fi->file, "%s/n%d_%s", fi->dir, fw_num, fw_name);
-
-		FILE *f = SAFE_FOPEN(cleanup, fi->file, "w");
-		fi->remove_file = 1;
-		int k, byte = fw_num;
-		++fw_num;
-		for (k = 0; k < fw_size; ++k)
-			fputc(byte, f);
-		SAFE_FCLOSE(cleanup, f);
-		++i;
+		if (fw->created_dir)
+			remove(fw->dir);
 	}
+
+	if (module_loaded)
+		tst_module_unload(MNAME_KO);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_FW_LOADER=y|CONFIG_FW_LOADER=m",
+		NULL,
+	},
+};
diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.h b/testcases/kernel/firmware/fw_load_user/fw_load.h
new file mode 100644
index 0000000000000000000000000000000000000000..39f207cc30810e2ed9ea76176cedd98aa902d887
--- /dev/null
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.h
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef FW_LOAD_H
+#define FW_LOAD_H
+
+#define MNAME_KO "ltp_fw_load.ko"
+#define FW_NAME	"load_tst.fw"
+#define FW_SIZE	0x1000
+#define FW_NUM 5
+#define FW_PATH "/sys/module/firmware_class/parameters/path"
+#define DEV_FWNUM "/sys/devices/ltp_fw_load/fwnum"
+#define DEV_RESULT "/sys/devices/ltp_fw_load/result"
+#define LIB_PATH "/lib/firmware"
+
+#endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
