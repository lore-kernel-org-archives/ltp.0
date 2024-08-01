Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AFEC3DA4A
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:09:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A5503D1DCB
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:09:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A2053D1DCB
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:53 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18941608A7D
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E30581FB54;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6q289gKRooaShWW/5FyrV1WXvaAZWC4NyE+czjsiOE=;
 b=lcGWD/SPndH58UDbzkuO0XzQDTM6/VHQuDZ+toF3x8qC8KLpBXmfyj5Gu+gu3EpwiX7OHr
 JqMVlNi+cLk3XHERNhQDYsmCQtmHz+AYvlx9QXUE0hxMHP04kItmli6CxyQL/4toWO+Ube
 /Tbsnq4oQ7MtgsoTEbMqMPRCKBclWPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6q289gKRooaShWW/5FyrV1WXvaAZWC4NyE+czjsiOE=;
 b=KTaCITJeoDf3OGWj7kbfdbUJZQgGob6GUVzuWvWb436/GfS22unfpFllkkES+XPuzpoIL2
 OUJw3yyFoq8henCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6q289gKRooaShWW/5FyrV1WXvaAZWC4NyE+czjsiOE=;
 b=lcGWD/SPndH58UDbzkuO0XzQDTM6/VHQuDZ+toF3x8qC8KLpBXmfyj5Gu+gu3EpwiX7OHr
 JqMVlNi+cLk3XHERNhQDYsmCQtmHz+AYvlx9QXUE0hxMHP04kItmli6CxyQL/4toWO+Ube
 /Tbsnq4oQ7MtgsoTEbMqMPRCKBclWPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6q289gKRooaShWW/5FyrV1WXvaAZWC4NyE+czjsiOE=;
 b=KTaCITJeoDf3OGWj7kbfdbUJZQgGob6GUVzuWvWb436/GfS22unfpFllkkES+XPuzpoIL2
 OUJw3yyFoq8henCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A08813946;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JXmItJ6q2aiVwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:08:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:08:41 +0200
MIME-Version: 1.0
Message-Id: <20240801-landlock-v5-4-663d7383b335@suse.com>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
In-Reply-To: <20240801-landlock-v5-0-663d7383b335@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17426;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=uiOWIc2KocB8kn5TlksEzmecwM0qoaP+inZRF27b1Lo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq3rQ5sxLIdiXOs2MSUaiaNQ6v26Pj4iuTOmN7
 3bSJKnnsd2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt60AAKCRDLzBqyILPm
 RnwWDACF33xvUvbo/KIAVI6op7dNBCKdYbeMBSLqc/5mbQeEcIHBEDRiUpcRretjr8rOYDNdN9H
 ldG9cg/h6Vatb3ouqaQApsHE6Bn1Y6w9JvJ21qdD30/OlQ4Sxuvhk+r4FXI/ONWY/WzAjNDYsyk
 GouS/aZB/9AJZxdQ/c7Z6bGvDDVEJxZeqTi1MvlXcj864w43/o2h7s5sjtzrSID65bmcFtVLoir
 fdrxVFL0vujKvJjX2wPDKe3c0J8W6h1Vy5Wz/zjx3weDYh7pJWnayr04wpvGPhTSxv05vmmWX46
 qAZZFwKvhZN6zSjrvqDqmZOxvtuwFZWkL4cg4aZ6Sd9+1MIHzv5CqyZWRT+SFeXDOIbhx4qSggZ
 2f+Kx3ukPzg4DZjiusMvFZc0snXK+RgKiQ6hXPDDLVSTQaBSQwcO+bGUJx+eeCWGMRmNr04oUOL
 9XM8/U2Cg2NDYy1g+fYSj2OrlFMKEyZeTBY8KH2sNycGp/g924JzM9hl1eVkHUxS4/9Kg=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.10 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/6] Add landlock04 test
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

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   2 +
 testcases/kernel/syscalls/landlock/landlock04.c    | 212 +++++++++++
 testcases/kernel/syscalls/landlock/landlock_exec.c |   9 +
 .../kernel/syscalls/landlock/landlock_tester.h     | 393 +++++++++++++++++++++
 5 files changed, 617 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 9b3cba667..67b2e2758 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -699,6 +699,7 @@ kill13 kill13
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
index 000000000..82d9a5a4e
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that all landlock filesystem rules are working properly.
+ * The way we do it is to verify that all disabled syscalls are not working but
+ * the one we enabled via specifc landlock rules.
+ */
+
+#include "landlock_common.h"
+#include "landlock_tester.h"
+#include "tst_safe_stdio.h"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+static int ruleset_fd = -1;
+
+static struct tvariant {
+	int access;
+	char *desc;
+} tvariants[] = {
+	{
+		LANDLOCK_ACCESS_FS_READ_FILE | LANDLOCK_ACCESS_FS_EXECUTE,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_EXECUTE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_WRITE_FILE,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_WRITE_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_READ_FILE,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_READ_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_READ_DIR,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_READ_DIR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_REMOVE_DIR,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_REMOVE_DIR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_REMOVE_FILE)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_CHAR,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_CHAR)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_BLOCK,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_BLOCK)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_REG,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_REG)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_SOCK,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_SOCK)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_FIFO,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_FIFO)
+	},
+	{
+		LANDLOCK_ACCESS_FS_MAKE_SYM,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_MAKE_SYM)
+	},
+	{
+		LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
+		TST_TO_STR_(LANDLOCK_ACCESS_FS_TRUNCATE)
+	},
+};
+
+static void run(void)
+{
+	struct tvariant  variant = tvariants[tst_variant];
+
+	tester_setup_files();
+
+	if (!SAFE_FORK()) {
+		enforce_ruleset(ruleset_fd);
+		tester_run_all_fs_rules(variant.access);
+
+		_exit(0);
+	}
+
+	tst_reap_children();
+	tester_cleanup_files();
+}
+
+static void enable_exec_libs(const int ruleset_fd)
+{
+	FILE *fp;
+	char line[1024];
+	char path[PATH_MAX];
+	char dependency[8][PATH_MAX];
+	int count = 0;
+	int duplicate = 0;
+
+	fp = SAFE_FOPEN("/proc/self/maps", "r");
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strstr(line, ".so") == NULL)
+			continue;
+
+		SAFE_SSCANF(line, "%*x-%*x %*s %*x %*s %*d %s", path);
+
+		for (int i = 0; i < count; i++) {
+			if (strcmp(path, dependency[i]) == 0) {
+				duplicate = 1;
+				break;
+			}
+		}
+
+		if (duplicate) {
+			duplicate = 0;
+			continue;
+		}
+
+		strncpy(dependency[count], path, PATH_MAX);
+		count++;
+
+		tst_res(TINFO, "Enable read/exec permissions for %s", path);
+
+		path_beneath_attr->allowed_access =
+			LANDLOCK_ACCESS_FS_READ_FILE |
+			LANDLOCK_ACCESS_FS_EXECUTE;
+		path_beneath_attr->parent_fd = SAFE_OPEN(path, O_PATH | O_CLOEXEC);
+
+		SAFE_LANDLOCK_ADD_RULE(
+			ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
+
+		SAFE_CLOSE(path_beneath_attr->parent_fd);
+	}
+
+	SAFE_FCLOSE(fp);
+}
+
+static void setup(void)
+{
+	struct tvariant variant = tvariants[tst_variant];
+
+	verify_landlock_is_enabled();
+
+	tst_res(TINFO, "Testing %s", variant.desc);
+
+	ruleset_attr->handled_access_fs = tester_get_all_fs_rules();
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	/* since our binary is dynamically linked, we need to enable dependences
+	 * to be read and executed
+	 */
+	enable_exec_libs(ruleset_fd);
+
+	/* sandbox folder has to exist before creating the rule */
+	if (access(SANDBOX_FOLDER, F_OK) == -1)
+		SAFE_MKDIR(SANDBOX_FOLDER, PERM_MODE);
+
+	path_beneath_attr->allowed_access = variant.access;
+	path_beneath_attr->parent_fd = SAFE_OPEN(
+		SANDBOX_FOLDER, O_PATH | O_CLOEXEC);
+
+	SAFE_LANDLOCK_ADD_RULE(
+		ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,	path_beneath_attr, 0);
+
+	SAFE_CLOSE(path_beneath_attr->parent_fd);
+}
+
+static void cleanup(void)
+{
+	if (ruleset_fd != -1)
+		SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1,
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
+	.mount_device = 1,
+	.mntpoint = SANDBOX_FOLDER,
+	.all_filesystems = 1,
+	.max_runtime = 360,
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
index 000000000..dcebc45cd
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -0,0 +1,393 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LANDLOCK_TESTER_H__
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
+static int tester_get_all_fs_rules(void)
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
+	if (abi < 5)
+		all_rules &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+
+	return all_rules;
+}
+
+/* This function setup the sandbox folder before running the test.
+ * Run it __before__ enforcing the sandbox rules and ensure that SANDBOX_FOLDER
+ * has been created already.
+ */
+static void tester_setup_files(void)
+{
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
+static void _remove_file(const char *path)
+{
+	if (access(path, F_OK) != -1)
+		SAFE_UNLINK(path);
+}
+
+/* This function cleanup the sandbox folder after running the tests.
+ * Run it after getting out from the sandbox.
+ */
+static void tester_cleanup_files(void)
+{
+	if (access(DIR_RMDIR, F_OK) != -1)
+		SAFE_RMDIR(DIR_RMDIR);
+
+	for (size_t i = 0; i < ARRAY_SIZE(readdir_files); i++)
+		_remove_file(readdir_files[i]);
+
+	if (access(DIR_READDIR, F_OK) != -1)
+		SAFE_RMDIR(DIR_READDIR);
+
+	struct stat st;
+
+	if (lstat(FILE_SYM1, &st) != -1)
+		SAFE_UNLINK(FILE_SYM1);
+
+	_remove_file(FILE_READ);
+	_remove_file(FILE_WRITE);
+	_remove_file(FILE_REMOVE);
+	_remove_file(FILE_UNLINK);
+	_remove_file(FILE_UNLINKAT);
+	_remove_file(FILE_TRUNCATE);
+	_remove_file(FILE_SYM0);
+	_remove_file(FILE_EXEC);
+
+	_remove_file(DEV_BLK0);
+	_remove_file(DEV_CHAR0);
+	_remove_file(FILE_FIFO);
+	_remove_file(FILE_SOCKET);
+	_remove_file(FILE_REGULAR);
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
+		fd = SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
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
+static void tester_run_fs_rules(const int rules, const int result)
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
+	if (rules & LANDLOCK_ACCESS_FS_MAKE_REG)
+		_test_make(FILE_REGULAR, S_IFREG, 0, result);
+
+	if (strcmp(tst_device->fs_type, "vfat") &&
+		strcmp(tst_device->fs_type, "exfat")) {
+		if (rules & LANDLOCK_ACCESS_FS_MAKE_CHAR)
+			_test_make(DEV_CHAR0, S_IFCHR, dev_chr, result);
+
+		if (rules & LANDLOCK_ACCESS_FS_MAKE_BLOCK)
+			_test_make(DEV_BLK0, S_IFBLK, dev_blk, result);
+
+		if (rules & LANDLOCK_ACCESS_FS_MAKE_SOCK)
+			_test_make(FILE_SOCKET, S_IFSOCK, 0, result);
+
+		if (rules & LANDLOCK_ACCESS_FS_MAKE_FIFO)
+			_test_make(FILE_FIFO, S_IFIFO, 0, result);
+
+		if (rules & LANDLOCK_ACCESS_FS_MAKE_SYM)
+			_test_symbolic(result);
+	}
+
+	if (rules & LANDLOCK_ACCESS_FS_TRUNCATE) {
+		int abi;
+
+		abi = SAFE_LANDLOCK_CREATE_RULESET(
+			NULL, 0, LANDLOCK_CREATE_RULESET_VERSION);
+
+		if (abi < 3) {
+			tst_res(TINFO, "Skip truncate test. Minimum ABI version is 3");
+			return;
+		}
+
+		_test_truncate(result);
+	}
+}
+
+static inline void tester_run_all_fs_rules(const int pass_rules)
+{
+	int fail_rules;
+	int all_rules;
+
+	all_rules = tester_get_all_fs_rules();
+	fail_rules = all_rules & ~pass_rules;
+
+	tester_run_fs_rules(pass_rules, TPASS);
+	tester_run_fs_rules(fail_rules, TFAIL);
+}
+
+#endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
