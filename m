Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC59CF3184
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 09:30:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2395A3CF8FB
	for <ltp@archiver.kernel.org>; Wed, 19 Nov 2025 10:30:49 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01C8D3CF4FB
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 10:30:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F02D1A00916
 for <ltp@lists.linux.it>; Wed, 19 Nov 2025 10:30:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED82C211A1;
 Wed, 19 Nov 2025 09:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763544629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tkk/8roEIKwxQINpemIUmkgb6epLlHmiQe/geYIWL78=;
 b=SQj+Z5y4AqFwuTm3oLKGjee2Xdm9C/Oh+awOKy/Y0jOiHl7WAutVOItGForURu2XqSI3Mj
 Ff80O18XdDL5u6pO9m1EnrS1gMxbv1QhHPJvAkPg2BaIlT5AvitTe1WXFB1g2w8G0OOTAf
 CLKvtJRiLdxukkq9GybN61TUwe6mWJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763544629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tkk/8roEIKwxQINpemIUmkgb6epLlHmiQe/geYIWL78=;
 b=wO2INaP2kgg7tRzRYDUj2HQ7xNJRzDuFCCvDj0ZO4XH4M4R/mOEybwx+e9oa+s/AIWvnOi
 P7LWLulu3HRkBfBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763544628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tkk/8roEIKwxQINpemIUmkgb6epLlHmiQe/geYIWL78=;
 b=oEEffwTSjyucT+Yr5qFv+iPaNg5QqbHFrxww2lBqYmXrVnYd1ReblTimAf+b4EYBYhFFWl
 F7Ov5Wbs/srmRjBGmQYsVX2MqSC9u6eLEPHeOXtTxYsn+BeiS2NhMjodDAdfID+Bchw1Gi
 UA3uVpB0GtUkc1gh7ZZRb1N4eS8VDAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763544628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Tkk/8roEIKwxQINpemIUmkgb6epLlHmiQe/geYIWL78=;
 b=tY18f2f4seG9tHzQ31VbwRBuHjAFyBseyNPfpLrE/uTonNeF5tngob5YwVZQ/8VG0ISgHv
 4pmkJ5XvElWVpzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8C993EA61;
 Wed, 19 Nov 2025 09:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9fCFMzSOHWkdUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 19 Nov 2025 09:30:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Nov 2025 10:31:20 +0100
Message-ID: <20251119093120.18775-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, intel.com:email,
 suse.cz:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shell: Add support for runtime
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
Cc: Piotr Kubaj <piotr.kubaj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Adds support for "runtime" and "min_runtime" to the tst_run_shell as
well as new binary helper tst_remaining_runtime that calls the C
function of that name and prints the number into the stdout.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Piotr Kubaj <piotr.kubaj@intel.com>
---
 testcases/lib/.gitignore                      |  1 +
 testcases/lib/Makefile                        |  2 +-
 .../lib/tests/shell_loader_filesystems.sh     |  9 +++++++
 testcases/lib/tst_remaining_runtime.c         | 26 +++++++++++++++++++
 testcases/lib/tst_run_shell.c                 | 16 ++++++++++++
 5 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 testcases/lib/tst_remaining_runtime.c

diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
index 385f3c3ca..19d7c67bb 100644
--- a/testcases/lib/.gitignore
+++ b/testcases/lib/.gitignore
@@ -25,3 +25,4 @@
 /tst_timeout_kill
 /tst_res_
 /tst_run_shell
+/tst_remaining_runtime
diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
index b3a9181c1..2309a42a3 100644
--- a/testcases/lib/Makefile
+++ b/testcases/lib/Makefile
@@ -17,6 +17,6 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
 			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
 			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
 			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
-			   tst_run_shell
+			   tst_run_shell tst_remaining_runtime
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index d584503ad..823ce1975 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -6,6 +6,7 @@
 # env
 # {
 #  "mount_device": true,
+#  "runtime": 10,
 #  "mntpoint": "ltp_mntpoint",
 #  "filesystems": [
 #   {
@@ -38,6 +39,14 @@ tst_test()
 	else
 		tst_res TFAIL "Device not mounted!"
 	fi
+
+	RUNTIME=$(tst_remaining_runtime)
+
+	if [ "$RUNTIME" -ge 9 ]; then
+		tst_res TPASS "Remaining runtime $RUNTIME"
+	else
+		tst_res TFAIL "Remaning runtime $RUNTIME"
+	fi
 }
 
 . tst_run.sh
diff --git a/testcases/lib/tst_remaining_runtime.c b/testcases/lib/tst_remaining_runtime.c
new file mode 100644
index 000000000..df383d346
--- /dev/null
+++ b/testcases/lib/tst_remaining_runtime.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+
+static void print_help(char *name)
+{
+	fprintf(stderr, "Usage: %s\n", name);
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc > 1) {
+		print_help(argv[0]);
+		return 1;
+	}
+
+	tst_reinit();
+
+	printf("%u\n", tst_remaining_runtime());
+
+	return 0;
+}
diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 7a446e004..91f34127d 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -60,6 +60,7 @@ enum test_attr_ids {
 	MIN_CPUS,
 	MIN_MEM_AVAIL,
 	MIN_KVER,
+	MIN_RUNTIME,
 	MIN_SWAP_AVAIL,
 	MNTPOINT,
 	MOUNT_DEVICE,
@@ -74,6 +75,7 @@ enum test_attr_ids {
 	NEEDS_ROOT,
 	NEEDS_TMPDIR,
 	RESTORE_WALLCLOCK,
+	RUNTIME,
 	SAVE_RESTORE,
 	SKIP_FILESYSTEMS,
 	SKIP_IN_COMPAT,
@@ -93,6 +95,7 @@ static ujson_obj_attr test_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(MIN_CPUS, "min_cpus", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MIN_MEM_AVAIL, "min_mem_avail", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MIN_KVER, "min_kver", UJSON_STR),
+	UJSON_OBJ_ATTR_IDX(MIN_RUNTIME, "min_runtime", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MIN_SWAP_AVAIL, "min_swap_avail", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(MNTPOINT, "mntpoint", UJSON_STR),
 	UJSON_OBJ_ATTR_IDX(MOUNT_DEVICE, "mount_device", UJSON_BOOL),
@@ -107,6 +110,7 @@ static ujson_obj_attr test_attrs[] = {
 	UJSON_OBJ_ATTR_IDX(NEEDS_ROOT, "needs_root", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(NEEDS_TMPDIR, "needs_tmpdir", UJSON_BOOL),
 	UJSON_OBJ_ATTR_IDX(RESTORE_WALLCLOCK, "restore_wallclock", UJSON_BOOL),
+	UJSON_OBJ_ATTR_IDX(RUNTIME, "runtime", UJSON_INT),
 	UJSON_OBJ_ATTR_IDX(SAVE_RESTORE, "save_restore", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(SKIP_FILESYSTEMS, "skip_filesystems", UJSON_ARR),
 	UJSON_OBJ_ATTR_IDX(SKIP_IN_COMPAT, "skip_in_compat", UJSON_BOOL),
@@ -421,6 +425,12 @@ static void parse_metadata(void)
 		case MIN_KVER:
 			test.min_kver = strdup(val.val_str);
 		break;
+		case MIN_RUNTIME:
+			if (val.val_int <= 0)
+				ujson_err(&reader, "Minimal runtime must be > 0");
+			else
+				test.min_runtime = val.val_int;
+		break;
 		case MIN_SWAP_AVAIL:
 			if (val.val_int <= 0)
 				ujson_err(&reader, "Minimal available swap size must be > 0");
@@ -469,6 +479,12 @@ static void parse_metadata(void)
 		case RESTORE_WALLCLOCK:
 			test.restore_wallclock = val.val_bool;
 		break;
+		case RUNTIME:
+			if (val.val_int <= 0)
+				ujson_err(&reader, "Runtime must be > 0");
+			else
+				test.runtime = val.val_int;
+		break;
 		case SAVE_RESTORE:
 			test.save_restore = parse_save_restore(&reader, &val);
 		break;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
