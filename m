Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D04C3DA41
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 17:58:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71C3E3D3893
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 19:58:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 760223D3818
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:01 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7E8911000A66
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 19:57:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D2CE41F84C;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REz6xYKSjt649+nIMXtZ2tSMpwkz6gP/mvw4GeuwShE=;
 b=uKFGQG8AZ2QTV3yPFjfRNnAjMYxLVRazhKtcAi2Ly8N6/svCqfYzgdJ+3p2L3k3Ya+I9Yk
 gmreCDBGwDig8zGKlsp9UHRuc0V0OfgrRnkfEXIaRtStNAvSu/1mn5MGXG4pimW+5V1mMp
 pNxLusBTM/M7pcntVx/qniYWapDppvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REz6xYKSjt649+nIMXtZ2tSMpwkz6gP/mvw4GeuwShE=;
 b=7+w7NqV6wQCXoQQHYpCnK/0u7PRWhabS/D7/7EWIHG3LjPv9gzbZxxTq3D66t2GN+5zcoY
 Sq9tiEmaM0+mVJBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720634219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REz6xYKSjt649+nIMXtZ2tSMpwkz6gP/mvw4GeuwShE=;
 b=uKFGQG8AZ2QTV3yPFjfRNnAjMYxLVRazhKtcAi2Ly8N6/svCqfYzgdJ+3p2L3k3Ya+I9Yk
 gmreCDBGwDig8zGKlsp9UHRuc0V0OfgrRnkfEXIaRtStNAvSu/1mn5MGXG4pimW+5V1mMp
 pNxLusBTM/M7pcntVx/qniYWapDppvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720634219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REz6xYKSjt649+nIMXtZ2tSMpwkz6gP/mvw4GeuwShE=;
 b=7+w7NqV6wQCXoQQHYpCnK/0u7PRWhabS/D7/7EWIHG3LjPv9gzbZxxTq3D66t2GN+5zcoY
 Sq9tiEmaM0+mVJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7E5713942;
 Wed, 10 Jul 2024 17:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNOPK2vLjmaZegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 17:56:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 19:56:44 +0200
MIME-Version: 1.0
Message-Id: <20240710-landlock-v2-6-478d8c2f6bab@suse.com>
References: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
In-Reply-To: <20240710-landlock-v2-0-478d8c2f6bab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4081;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=5XlK4rtEjskkE4URmCuJ7dSUhd84VCQnT8Q0PdXWOm8=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjsteitovq0334TbRUbsEfs9rZSwFFLc46QJ86
 M4cuSQBbiyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo7LXgAKCRDLzBqyILPm
 RogcC/957tQFooocBMFxoGB54X7xwki8X/i7TwtTMgAUZNo5DENfwE8C6VtL2K/1JEoll1DKgkB
 vRVoiU6xy/MxS/xCT/IjlNf6dgutOgkE0+rJ5lrGUQ7ye8H+7VPbcwf+Ku2oEob9cgejEFFejMW
 48zUNnHkNMPNjE984VWA0rWDn5dRdxFc6kSlOWkkUF+0YV5EFnogGu3ytbrq57zej0Por3bFXfy
 P9qj5OfLNUrqK2+hWT8c4dCns6fHKs+ahtmhN+0ZYTC6IrkhZ/4k1wYbAhei1sjXw0tNyawXejf
 3tCe5qrcC7SlyxslHcpjogy9uaSwvfYc6NdM8bUkLcfAFhV+SG96oeOujxdS2GNVHQRCETsBd1E
 jzpjdvlUBvtbOU5JS85IIOinXgP/+rgYaiO/0Mkr1QQrhFzHAWUfdV8ta96SUm132wVGMGQDZcq
 foY6//2cLn6EK9QXM4i6trKQ69bIMReC9hfDahpvPOtJt4F5H2I/mK3ho6wMlzXofJCZI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] Add landlock05 test
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                |   1 +
 testcases/kernel/syscalls/landlock/.gitignore   |   1 +
 testcases/kernel/syscalls/landlock/landlock05.c | 114 ++++++++++++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 10b54ae84..bb54538ed 100644
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
index 000000000..0ab93efbd
--- /dev/null
+++ b/testcases/kernel/syscalls/landlock/landlock05.c
@@ -0,0 +1,114 @@
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
+		TST_EXP_PASS(rename(FILENAME2, FILENAME1));
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
