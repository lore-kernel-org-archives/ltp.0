Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4E1C2BD09
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 15:45:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 458393D3FE6
	for <ltp@archiver.kernel.org>; Mon,  1 Jul 2024 17:45:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3025F3D0E3E
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8ADBC601A37
 for <ltp@lists.linux.it>; Mon,  1 Jul 2024 17:42:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82E4221A85;
 Mon,  1 Jul 2024 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBXH7fG5uHJnoXRlFy9vwkD7v9m9DRqXNpEY80F4Vew=;
 b=EaugrlQ6/4a5LBSgAqGyFM9xt555bF3PgkGt7D7vbnPoI8CUiZ1bVlL+nj1Ux5GE4MG1Cj
 3Us3riLJHuWgnHyjhBB6F5NOWPfRIxSDzks4otBpDmbLUj4pq9t4nEgo9ArMVVvVd3QlQF
 C0YJFYnCZV2SPJhj74Sd+qVQ4tdCF3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBXH7fG5uHJnoXRlFy9vwkD7v9m9DRqXNpEY80F4Vew=;
 b=DMjN+KZswlSmD1/tmDpW2QB19ivbyR49jVnU6CSpBECTijq8foI589qLpKtaN5nwGsNm/M
 O84FpeqAT4TcWUDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EaugrlQ6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DMjN+KZs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719848575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBXH7fG5uHJnoXRlFy9vwkD7v9m9DRqXNpEY80F4Vew=;
 b=EaugrlQ6/4a5LBSgAqGyFM9xt555bF3PgkGt7D7vbnPoI8CUiZ1bVlL+nj1Ux5GE4MG1Cj
 3Us3riLJHuWgnHyjhBB6F5NOWPfRIxSDzks4otBpDmbLUj4pq9t4nEgo9ArMVVvVd3QlQF
 C0YJFYnCZV2SPJhj74Sd+qVQ4tdCF3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719848575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBXH7fG5uHJnoXRlFy9vwkD7v9m9DRqXNpEY80F4Vew=;
 b=DMjN+KZswlSmD1/tmDpW2QB19ivbyR49jVnU6CSpBECTijq8foI589qLpKtaN5nwGsNm/M
 O84FpeqAT4TcWUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62D0713800;
 Mon,  1 Jul 2024 15:42:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gGcHFn/OgmZfCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 01 Jul 2024 15:42:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 01 Jul 2024 17:42:14 +0200
MIME-Version: 1.0
Message-Id: <20240701-landlock-v1-9-58e9af649a72@suse.com>
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-0-58e9af649a72@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3991;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=v1VKiX98hsrmlh4h26DuW3DZTdiXlAnDlGkwGbrWz+8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmgs51QAZp1/nZgHaCYRcuZyaht1ONNerz26Nfp
 LYRHx7Vjb2JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoLOdQAKCRDLzBqyILPm
 Rl8aC/0ejRYzc0h5TVtH1M61AT9F0BSeApZb0KRHENfoIHs4YwGos50YMvsXYiZCot0l+gSp5DE
 JrmSPtgo4l7Nfm0vXTVsHObDhFi5I7yr1H6299tC4lG7QbDft9KWM01pPxOJnpcigeRZFDuhL3f
 B29OkCpMq9Hl3fz+uLs5ALeUOH0Tm3nXwefqiZ7xULMw4hpY9x65ZgSbV3avJI9+SkvjKmzmCC9
 3L4GtYmnQivjG/mEe0Ev9RyMkuscWVOL9CGgsPzn57g5SWyxqVqPnjmju/tt5h6YfI6YCWBJcAH
 Aa+hlCBt5N3EfMpqoZXk8XuLWQ7WoSmmM47dNsrNIFgIYuX630H2fTomfzCPukRjEac1DxpORIp
 vdFj1gq0+lJ0btSN/SClIKL4BlThRjm4uZc2U/jFhNnZjIApHGQMg6GEjBtdZ1HQ+g0hp/X2DBE
 iofbP+uwpdBvgYBsG04IjGFccBm76HFjdV/R/ExQM/QY0LqWc6JdK7t0e780A+W3qP/Q4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 82E4221A85
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/10] Add landlock05 test
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

This test verifies LANDLOCK_ACCESS_FS_REFER access in the
landlock sandbox. The feature is available since kernel 5.19.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock05.c | 113 ++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 9acdaf760..a3ade6dc1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -688,6 +688,7 @@ landlock01 landlock01
 landlock02 landlock02
 landlock03 landlock03
 landlock04 landlock04
+landlock05 landlock05
 
 lchown01 lchown01
 lchown01_16 lchown01_16
diff --git a/testcases/kernel/syscalls/landlock/.gitignore b/testcases/kernel/syscalls/landlock/.gitignore
index 4fe8d7cba..a7ea6be2e 100644
--- a/testcases/kernel/syscalls/landlock/.gitignore
+++ b/testcases/kernel/syscalls/landlock/.gitignore
@@ -3,3 +3,4 @@ landlock01
 landlock02
 landlock03
 landlock04
+landlock05
diff --git a/testcases/kernel/syscalls/landlock/landlock05.c b/testcases/kernel/syscalls/landlock/landlock05.c
new file mode 100644
index 000000000..57ed67e9f
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies LANDLOCK_ACCESS_FS_REFER access in the
+ * landlock sandbox.
+ *
+ * [Algorithm]
+ *
+ * - apply LANDLOCK_ACCESS_FS_REFER in the folder1
+ * - apply LANDLOCK_ACCESS_FS_REFER in the folder2
+ * - create folder3
+ * - verify that file can be moved from folder1 to folder2
+ * - verify that file can't be moved from folder1 to folder3
+ */
+
+#include "landlock_common.h"
+
+#define MNTPOINT "sandbox"
+#define DIR1 MNTPOINT"/folder1"
+#define DIR2 MNTPOINT"/folder2"
+#define DIR3 MNTPOINT"/folder3"
+#define FILENAME1 DIR1"/file"
+#define FILENAME2 DIR2"/file"
+#define FILENAME3 DIR3"/file"
+
+static struct landlock_ruleset_attr *ruleset_attr;
+static struct landlock_path_beneath_attr *path_beneath_attr;
+
+static void run(void)
+{
+	if (!SAFE_FORK()) {
+		TST_EXP_PASS(rename(FILENAME1, FILENAME2));
+		if (TST_RET == -1)
+			return;
+
+		TST_EXP_FAIL(rename(FILENAME2, FILENAME3), EXDEV);
+
+		_exit(0);
+	}
+}
+
+static void setup(void)
+{
+	int ruleset_fd;
+
+	verify_landlock_is_enabled();
+
+	SAFE_MKDIR(DIR1, 0640);
+	SAFE_MKDIR(DIR2, 0640);
+	SAFE_MKDIR(DIR3, 0640);
+	SAFE_TOUCH(FILENAME1, 0640, NULL);
+
+	tst_res(TINFO, "Applying LANDLOCK_ACCESS_FS_REFER");
+
+	ruleset_attr->handled_access_fs =
+		LANDLOCK_ACCESS_FS_READ_FILE |
+		LANDLOCK_ACCESS_FS_WRITE_FILE |
+		LANDLOCK_ACCESS_FS_REFER;
+
+	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
+		ruleset_attr, sizeof(struct landlock_ruleset_attr), 0);
+
+	apply_landlock_rule(
+		path_beneath_attr,
+		ruleset_fd,
+		LANDLOCK_ACCESS_FS_REFER,
+		DIR1);
+
+	apply_landlock_rule(
+		path_beneath_attr,
+		ruleset_fd,
+		LANDLOCK_ACCESS_FS_REFER,
+		DIR2);
+
+	enforce_ruleset(ruleset_fd);
+
+	SAFE_CLOSE(ruleset_fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "5.19",
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.forks_child = 1,
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
+		{}
+	},
+	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *[]) {
+		"vfat",
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
