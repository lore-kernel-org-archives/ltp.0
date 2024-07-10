Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA5FC3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FA803D3888
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:57:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AFF33D383E
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:01 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3FD1F14060A5
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B184B21BF0;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiquYT62z6r7Qx4rPBHnCs6Nk9SPOFdvGBmU2MBv/Wc=;
 b=aS/9xGYdarkCRZ1gARaowyQ0zmV71k8/hJFTHduCw5EJlQU6MfYuzPsGzn1u0SmUiGYU85
 JQx9KQKfHlD5c061Y5AzKof99n2K5Pof70Ogi5PghaGf26BjwQXGsSHvNX9dzKyxEtCZN5
 c6K9KH2mdoUyBwWI5ZGKJjcw70ighY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiquYT62z6r7Qx4rPBHnCs6Nk9SPOFdvGBmU2MBv/Wc=;
 b=a1afC/ZZy3LRZcYC3HEqT+QDfLjrtgmdRcYTf13OY8cRB7+89rW0IEpoF9AeJ4AMK3a0SI
 FaGY8KXLykteoDCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiquYT62z6r7Qx4rPBHnCs6Nk9SPOFdvGBmU2MBv/Wc=;
 b=aS/9xGYdarkCRZ1gARaowyQ0zmV71k8/hJFTHduCw5EJlQU6MfYuzPsGzn1u0SmUiGYU85
 JQx9KQKfHlD5c061Y5AzKof99n2K5Pof70Ogi5PghaGf26BjwQXGsSHvNX9dzKyxEtCZN5
 c6K9KH2mdoUyBwWI5ZGKJjcw70ighY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NiquYT62z6r7Qx4rPBHnCs6Nk9SPOFdvGBmU2MBv/Wc=;
 b=a1afC/ZZy3LRZcYC3HEqT+QDfLjrtgmdRcYTf13OY8cRB7+89rW0IEpoF9AeJ4AMK3a0SI
 FaGY8KXLykteoDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95247137D2;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EDMmI2vLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:43 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-5-478d8c2f6bab@suse.com>
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15387;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=8cGf2mIKMXNVbpT2Wr9eJmQiH/C6xjYF2sjLtmRB2uE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsteM6//dzsTZfDzXdexUFqR43hkTXXW18HwN
 FK5tGczREaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LXgAKCRDLzBqyILPm
 RmDDDACT/zFH/OFqbRjaXjwUKoiuGN8tHsfKk+NOTE5cwKUBj/GKQEfBAuZ8NkM1pVh5I8EN0oR
 yJxvojJeZUF1U/8IpzP0jk/Zn3IjBzSF2YFppTCjZd9IaIXvftvBG0/Unps61a8vR4XQYpCpWHe
 HgMkz+IJz37dV/iaDS9KQi8eHPSmATGWU8xJ4A67AI3OJPh1MwT44bEElmCRcIx8ufqrzCQfXH7
 SvkeVLKnUfCN72m4UA9px1EY/A4isjLEkvaBhkamjLiLHWL1F6zdOZ94dcxRIKK0D9qlxPOxUTO
 0agZqbprQ/IMMWx+je1LBBn6AHvzR0SUgFFigXhsvzoU45vUaA7yHCyWeHL6qjeb73T4dUdynkf
 ZOYwaTS0MJe0l4NKAVNhad5l8yH1oZvgIx3ep0wHkNzEe+W1FsqK+d4Pob+eTI6J0SkrC42W+BQ
 M6VHFgwh/8jUhXUqlTE5pgiiyxHbZrX2a0mhW5QhfPBo7bm2WtO4nSgy/g3paEAeC+25g=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/7] Add landlock04 test
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

This test verifies that all landlock rules are working properly.
The way we do it is to verify that all disabled syscalls are not
working but the one we enabled via specifc landlock rules.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   2 +
 testcases/kernel/syscalls/landlock/landlock04.c    | 176 +++++++++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 350 +++++++++++++++++++++
 5 files changed, 538 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 269cf24b1..10b54ae84 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -687,6 +687,7 @@ kill13 kill13
 landlock01 landlock01
 landlock02 landlock02
 landlock03 landlock03
+landlock04 landlock04
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index f79cd090b..4fe8d7cba 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -1,3 +1,5 @@
+landlock_exec
 landlock01
 landlock02
 landlock03
+landlock04
diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
new file mode 100644
index 000000000..1567328bb
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that all landlock rules are working properly. The way we
+ * do it is to verify that all disabled syscalls are not working but the one we
+ * enabled via specifc landlock rules.
+ */
+
+#include "landlock_common.h"
+#include "landlock_tester.h"
+
+#define ACCESS_NAME(x) #x
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+
+struct rule_access {
+	char *path;
+	int access;
+};
+
+static struct tvariant {
+	int access;
+	char *desc;
+} tvariants[] = {
+	{
+		LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_EXECUTE,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_EXECUTE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_WRITE_FILE,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_WRITE_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_READ_FILE,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_READ_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_READ_DIR,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_READ_DIR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_REMOVE_DIR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_REMOVE_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_CHAR,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_CHAR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_BLOCK,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_BLOCK)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_REG,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_REG)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_SOCK,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_SOCK)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_FIFO,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_FIFO)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_SYM,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_MAKE_SYM)
+	},
+	{
+		LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
+		ACCESS_NAME(LANDLOCK_ACCESS_FS_TRUNCATE)
+	},
+};
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		struct tvariant  variant = tvariants[tst_variant];
+
+		tester_run_all_rules(variant.access);
+		_exit(0);
+	}
+}
+
+static void setup(void)
+{
+	struct tvariant variant = tvariants[tst_variant];
+	int ruleset_fd;
+
+	verify_landlock_is_enabled();
+	tester_create_tree();
+
+	tst_res(TINFO, "Testing %s", variant.desc);
+
+	ruleset_attr->handled_access_fs = tester_get_all_rules();
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	/* since our binary is dynamically linked, we need to enable libraries
+	 * to be read and executed
+	 */
+	struct rule_access rules[] = {
+		{"/lib", LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_EXECUTE},
+		{"/lib64", LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_EXECUTE},
+		{SANDBOX_FOLDER, variant.access}
+	};
+	int num_of_rules = ARRAY_SIZE(rules);
+
+	for (int i = 0; i < num_of_rules; i++) {
+		if (access(rules[i].path, F_OK) == -1)
+			continue;
+
+		path_beneath_attr->allowed_access = rules[i].access;
+		path_beneath_attr->parent_fd = SAFE_OPEN(rules[i].path, O_PATH | O_CLOEXEC);
+
+		SAFE_LANDLOCK_ADD_RULE(
+			ruleset_fd,
+			LANDLOCK_RULE_PATH_BENEATH,
+			path_beneath_attr,
+			0);
+
+		SAFE_CLOSE(path_beneath_attr->parent_fd);
+	}
+
+	enforce_ruleset(ruleset_fd);
+	SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "5.13",
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.test_variants = ARRAY_SIZE(tvariants),
+	.resource_files = (const char *[]) {
+		TESTAPP,
+		NULL,
+	},
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_SECURITY_LANDLOCK=y",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
+		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
+		{},
+	},
+	.caps = (struct tst_cap []) {
+		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
+		TST_CAP(TST_CAP_REQ, CAP_MKNOD),
+		{}
+	},
+	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = SANDBOX_FOLDER,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"vfat",
+		"exfat",
+		NULL
+	},
+	.max_runtime = 3600,
+};
diff --git a/testcases/kernel/syscalls/landlock/landlock_exec.c b/testcases/kernel/syscalls/landlock/landlock_exec.c
new file mode 100644
index 000000000..aae5c76b2
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock_exec.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+int main(void)
+{
+	return 0;
+}
diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
new file mode 100644
index 000000000..89ca085d7
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -0,0 +1,350 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LANDLOCK_TESTER_H
+
+#include "tst_test.h"
+#include "lapi/landlock.h"
+#include <sys/sysmacros.h>
+
+#define PERM_MODE 0700
+
+#define SANDBOX_FOLDER	"sandbox"
+#define TESTAPP			"landlock_exec"
+
+#define FILE_EXEC		SANDBOX_FOLDER"/"TESTAPP
+#define FILE_READ		SANDBOX_FOLDER"/file_read"
+#define FILE_WRITE		SANDBOX_FOLDER"/file_write"
+#define FILE_REMOVE		SANDBOX_FOLDER"/file_remove"
+#define FILE_UNLINK		SANDBOX_FOLDER"/file_unlink"
+#define FILE_UNLINKAT	SANDBOX_FOLDER"/file_unlinkat"
+#define FILE_TRUNCATE	SANDBOX_FOLDER"/file_truncate"
+#define FILE_REGULAR	SANDBOX_FOLDER"/regular0"
+#define FILE_SOCKET		SANDBOX_FOLDER"/socket0"
+#define FILE_FIFO		SANDBOX_FOLDER"/fifo0"
+#define FILE_SYM0		SANDBOX_FOLDER"/symbolic0"
+#define FILE_SYM1		SANDBOX_FOLDER"/symbolic1"
+#define DIR_READDIR		SANDBOX_FOLDER"/dir_readdir"
+#define DIR_RMDIR		SANDBOX_FOLDER"/dir_rmdir"
+#define DEV_CHAR0		SANDBOX_FOLDER"/chardev0"
+#define DEV_BLK0		SANDBOX_FOLDER"/blkdev0"
+
+#define ALL_RULES (\
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_READ_FILE | \
+	LANDLOCK_ACCESS_FS_READ_DIR | \
+	LANDLOCK_ACCESS_FS_REMOVE_DIR | \
+	LANDLOCK_ACCESS_FS_REMOVE_FILE | \
+	LANDLOCK_ACCESS_FS_MAKE_CHAR | \
+	LANDLOCK_ACCESS_FS_MAKE_DIR | \
+	LANDLOCK_ACCESS_FS_MAKE_REG | \
+	LANDLOCK_ACCESS_FS_MAKE_SOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
+	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
+	LANDLOCK_ACCESS_FS_MAKE_SYM | \
+	LANDLOCK_ACCESS_FS_REFER | \
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_NET_BIND_TCP | \
+	LANDLOCK_ACCESS_NET_CONNECT_TCP | \
+	LANDLOCK_ACCESS_FS_IOCTL_DEV)
+
+static char *readdir_files[] = {
+	DIR_READDIR"/file0",
+	DIR_READDIR"/file1",
+	DIR_READDIR"/file2",
+};
+
+static int dev_chr;
+static int dev_blk;
+
+static int tester_get_all_rules(void)
+{
+	int abi;
+	int all_rules = ALL_RULES;
+
+	abi = SAFE_LANDLOCK_CREATE_RULESET(
+		NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+
+	if (abi < 2)
+		all_rules &= ~LANDLOCK_ACCESS_FS_REFER;
+
+	if (abi < 3)
+		all_rules &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
+
+	if (abi < 4) {
+		all_rules &= ~(LANDLOCK_ACCESS_NET_BIND_TCP |
+			LANDLOCK_ACCESS_NET_CONNECT_TCP);
+	}
+
+	if (abi < 5)
+		all_rules &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
+	return all_rules;
+}
+
+static void tester_create_tree(void)
+{
+	if (access(SANDBOX_FOLDER, F_OK) == -1)
+		SAFE_MKDIR(SANDBOX_FOLDER, PERM_MODE);
+
+	/* folders */
+	SAFE_MKDIR(DIR_RMDIR, PERM_MODE);
+	SAFE_MKDIR(DIR_READDIR, PERM_MODE);
+	for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++)
+		SAFE_TOUCH(readdir_files[i], PERM_MODE, NULL);
+
+	/* files */
+	tst_fill_file(FILE_READ, 'a', getpagesize(), 1);
+	SAFE_TOUCH(FILE_WRITE, PERM_MODE, NULL);
+	SAFE_TOUCH(FILE_REMOVE, PERM_MODE, NULL);
+	SAFE_TOUCH(FILE_UNLINK, PERM_MODE, NULL);
+	SAFE_TOUCH(FILE_UNLINKAT, PERM_MODE, NULL);
+	SAFE_TOUCH(FILE_TRUNCATE, PERM_MODE, NULL);
+	SAFE_TOUCH(FILE_SYM0, PERM_MODE, NULL);
+	SAFE_CP(TESTAPP, FILE_EXEC);
+
+	/* devices */
+	dev_chr = makedev(1, 3);
+	dev_blk = makedev(7, 0);
+}
+
+static void _test_exec(const int result)
+{
+	int status;
+	pid_t pid;
+	char *const args[] = {(char *)FILE_EXEC, NULL};
+
+	tst_res(TINFO, "Test binary execution");
+
+	pid = SAFE_FORK();
+	if (!pid) {
+		int rval;
+
+		if (result == TPASS) {
+			rval = execve(FILE_EXEC, args, NULL);
+			if (rval == -1)
+				tst_res(TFAIL | TERRNO, "Failed to execute test binary");
+		} else {
+			TST_EXP_FAIL(execve(FILE_EXEC, args, NULL), EACCES);
+		}
+
+		_exit(1);
+	}
+
+	SAFE_WAITPID(pid, &status, 0);
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		return;
+
+	tst_res(result, "Test binary has been executed");
+}
+
+static void _test_write(const int result)
+{
+	tst_res(TINFO, "Test writing file");
+
+	if (result == TPASS)
+		TST_EXP_FD(open(FILE_WRITE, O_WRONLY, PERM_MODE));
+	else
+		TST_EXP_FAIL(open(FILE_WRITE, O_WRONLY, PERM_MODE), EACCES);
+
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void _test_read(const int result)
+{
+	tst_res(TINFO, "Test reading file");
+
+	if (result == TPASS)
+		TST_EXP_FD(open(FILE_READ, O_RDONLY, PERM_MODE));
+	else
+		TST_EXP_FAIL(open(FILE_READ, O_RDONLY, PERM_MODE), EACCES);
+
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void _test_readdir(const int result)
+{
+	tst_res(TINFO, "Test reading directory");
+
+	DIR *dir;
+	struct dirent *de;
+	int files_counted = 0;
+
+	dir = opendir(DIR_READDIR);
+	if (!dir) {
+		tst_res(result == TPASS ? TFAIL : TPASS,
+			"Can't read '%s' directory", DIR_READDIR);
+
+		return;
+	}
+
+	tst_res(result, "Can read '%s' directory", DIR_READDIR);
+	if (result == TFAIL)
+		return;
+
+	while ((de = readdir(dir)) != NULL) {
+		if (de->d_type != DT_REG)
+			continue;
+
+		for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++) {
+			if (readdir_files[i] == NULL)
+				continue;
+
+			if (strstr(readdir_files[i], de->d_name) != NULL)
+				files_counted++;
+		}
+	}
+
+	SAFE_CLOSEDIR(dir);
+
+	TST_EXP_EQ_LI(files_counted, ARRAY_SIZE(readdir_files));
+}
+
+static void _test_rmdir(const int result)
+{
+	tst_res(TINFO, "Test removing directory");
+
+	if (result == TPASS)
+		TST_EXP_PASS(rmdir(DIR_RMDIR));
+	else
+		TST_EXP_FAIL(rmdir(DIR_RMDIR), EACCES);
+}
+
+static void _test_rmfile(const int result)
+{
+	tst_res(TINFO, "Test removing file");
+
+	if (result == TPASS) {
+		TST_EXP_PASS(unlink(FILE_UNLINK));
+		TST_EXP_PASS(remove(FILE_REMOVE));
+	} else {
+		TST_EXP_FAIL(unlink(FILE_UNLINK), EACCES);
+		TST_EXP_FAIL(remove(FILE_REMOVE), EACCES);
+	}
+}
+
+static void _test_make(
+	const char *path,
+	const int type,
+	const int dev,
+	const int result)
+{
+	tst_res(TINFO, "Test normal or special files creation");
+
+	if (result == TPASS)
+		TST_EXP_PASS(mknod(path, type | 0400, dev));
+	else
+		TST_EXP_FAIL(mknod(path, type | 0400, dev), EACCES);
+}
+
+static void _test_symbolic(const int result)
+{
+	tst_res(TINFO, "Test symbolic links");
+
+	if (result == TPASS)
+		TST_EXP_PASS(symlink(FILE_SYM0, FILE_SYM1));
+	else
+		TST_EXP_FAIL(symlink(FILE_SYM0, FILE_SYM1), EACCES);
+}
+
+static void _test_truncate(const int result)
+{
+	int fd;
+
+	tst_res(TINFO, "Test truncating file");
+
+	if (result == TPASS) {
+		TST_EXP_PASS(truncate(FILE_TRUNCATE, 10));
+
+		fd = TST_EXP_FD(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE));
+		if (fd != -1) {
+			TST_EXP_PASS(ftruncate(fd, 10));
+			SAFE_CLOSE(fd);
+		}
+
+		fd = TST_EXP_FD(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE));
+		if (fd != -1)
+			SAFE_CLOSE(fd);
+	} else {
+		TST_EXP_FAIL(truncate(FILE_TRUNCATE, 10), EACCES);
+
+		fd = open(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
+		if (fd != -1) {
+			TST_EXP_FAIL(ftruncate(fd, 10), EACCES);
+			SAFE_CLOSE(fd);
+		}
+
+		TST_EXP_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE),
+			EACCES);
+
+		if (TST_RET != -1)
+			SAFE_CLOSE(TST_RET);
+	}
+}
+
+static void tester_run_rules(const int rules, const int result)
+{
+	if (rules & LANDLOCK_ACCESS_FS_EXECUTE)
+		_test_exec(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_WRITE_FILE)
+		_test_write(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_READ_FILE)
+		_test_read(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_READ_DIR)
+		_test_readdir(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_REMOVE_DIR)
+		_test_rmdir(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_REMOVE_FILE)
+		_test_rmfile(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_CHAR)
+		_test_make(DEV_CHAR0, S_IFCHR, dev_chr, result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_BLOCK)
+		_test_make(DEV_BLK0, S_IFBLK, dev_blk, result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_REG)
+		_test_make(FILE_REGULAR, S_IFREG, 0, result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_SOCK)
+		_test_make(FILE_SOCKET, S_IFSOCK, 0, result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_FIFO)
+		_test_make(FILE_FIFO, S_IFIFO, 0, result);
+
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_SYM)
+		_test_symbolic(result);
+
+	if (rules & LANDLOCK_ACCESS_FS_TRUNCATE) {
+		if ((tst_kvercmp(6, 2, 0)) < 0) {
+			tst_res(TINFO, "Skip truncate test. Minimum kernel version is 6.2");
+			return;
+		}
+
+		_test_truncate(result);
+	}
+}
+
+static inline void tester_run_all_rules(const int pass_rules)
+{
+	int fail_rules;
+	int all_rules;
+
+	all_rules = tester_get_all_rules();
+	fail_rules = all_rules & ~pass_rules;
+
+	tester_run_rules(pass_rules, TPASS);
+	tester_run_rules(fail_rules, TFAIL);
+}
+
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
