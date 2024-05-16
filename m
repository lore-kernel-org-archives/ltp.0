Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63453C25B77
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:30:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD423CFA36
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:30:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3BBA3CF95E
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0CD921000F79
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A4265C34F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEZoiWI1HDDyKKFotC2j3L82XgzUt0ipCj9k/PGE91E=;
 b=nSaD8wgR5S3+hcM9JKgQ0VcaHmBxGkCOC+enEVxkuzNmvDgfbakWTGl3QIoy7r9JiWQxaE
 /KYd9gcx+825lFk736q7XfbuEg8QvdIoeGZLPocd4+wZraoBr3ZJOi0PrToMr2jRduH9b0
 G/Ataeei3aJe++F/mnJTqaadtkuJb/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEZoiWI1HDDyKKFotC2j3L82XgzUt0ipCj9k/PGE91E=;
 b=1V/pSWsUAxm8gw8U0+GEjXULNaaWjfRqKjfyA4d8dJyAGI/GXBX0JrwErekOufn1EL3MVa
 AVYaScmyFMIePTDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nSaD8wgR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="1V/pSWsU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEZoiWI1HDDyKKFotC2j3L82XgzUt0ipCj9k/PGE91E=;
 b=nSaD8wgR5S3+hcM9JKgQ0VcaHmBxGkCOC+enEVxkuzNmvDgfbakWTGl3QIoy7r9JiWQxaE
 /KYd9gcx+825lFk736q7XfbuEg8QvdIoeGZLPocd4+wZraoBr3ZJOi0PrToMr2jRduH9b0
 G/Ataeei3aJe++F/mnJTqaadtkuJb/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DEZoiWI1HDDyKKFotC2j3L82XgzUt0ipCj9k/PGE91E=;
 b=1V/pSWsUAxm8gw8U0+GEjXULNaaWjfRqKjfyA4d8dJyAGI/GXBX0JrwErekOufn1EL3MVa
 AVYaScmyFMIePTDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B149137C3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QJEcDS/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:13 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-5-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3766;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=xbgV+pzivGC7E4r80ESIhvD9j7U+FfCrJgP3xp6Ag/4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwuHEqTFCsZjDvXHgvuV+zFw10BLsRP/XrSU
 NEyLF0wY9SJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 Rh5/C/0R5e/aO2haOwUMaL5YLdIKbq+2PZrqeaXrqOjs1uUPy4wd3W02S1P0JC8r8SkKGJcg008
 EPn8/w+DtqMs26HbB9c8ecDz/XZCoQPYxR/UBRKC76fpjrIu2EiCf5CvgrvXm/V1D+hAVQU31we
 7hoYC/pJmX3ZvE+P3TUuGJmsDHlxZu71zixrVgfZak1w2Mo5l1/PhGguziOtHCMif1+L7mOir8h
 Lpa7q66COZ46espuA+78URPdjQ68RDo+u912rTA4FzZzeAX8ZyrkR5yXV5V1BH4LTBnjumONleI
 mWLgsMgsyOe2UFdY2boFNRZlFipZhOSlO7Ghi1FdI5aK0ex4knCdIOphTRzzGN0PudOGd9v2V0r
 kwTx7ZzvMnwsuFrUhal4t7BiFhuck82JEM0vHzIiDUn7lXmGX/4F3Kx0RbGdsQddlp+6aFDp+aA
 bd+8+MVuOrCWkScbc8ESOAXW6VytX3AlzWlOenswYtqdJrvF0GzXxr2nFpr37gp1jvDvM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4A4265C34F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 05/11] Add listmount02 test
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

This test verifies that listmount() is properly reading groups of
mount IDs.
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/listmount/.gitignore    |   1 +
 testcases/kernel/syscalls/listmount/listmount02.c | 106 ++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index bce04c0cf..8831c0aec 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -707,6 +707,7 @@ linkat02 linkat02
 listen01 listen01
 
 listmount01 listmount01
+listmount02 listmount02
 
 listxattr01 listxattr01
 listxattr02 listxattr02
diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
index 5257b298c..30bbf9f02 100644
--- a/testcases/kernel/syscalls/listmount/.gitignore
+++ b/testcases/kernel/syscalls/listmount/.gitignore
@@ -1 +1,2 @@
 listmount01
+listmount02
diff --git a/testcases/kernel/syscalls/listmount/listmount02.c b/testcases/kernel/syscalls/listmount/listmount02.c
new file mode 100644
index 000000000..cd742bd64
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount02.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that listmount() is properly reading groups of mount IDs.
+ *
+ * [Algorithm]
+ *
+ * * move into a new unshared namespace
+ * * mount() our new root inside temporary folder
+ * * generate a full mounts tree inside root folder
+ * * read the full list of mounted IDs using listmount(LSMT_ROOT, ..)
+ * * read the list of mounted IDs using groups of fixed size
+ * * compare the first mount list with the second mount list
+ */
+
+#include "listmount.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define BIND_MOUNTS 7
+#define GROUPS_SIZE 3
+#define LISTSIZE (1 << BIND_MOUNTS)
+
+static void run(void)
+{
+	ssize_t ret;
+	size_t id, tot_ids, count = 0;
+	uint64_t mount_ids[LISTSIZE];
+	uint64_t list[LISTSIZE];
+
+	for (int i = 0; i < BIND_MOUNTS; i++)
+		SAFE_MOUNT("/", "/", NULL, MS_BIND, NULL);
+
+	tst_res(TINFO, "Reading all %d mount IDs in once", LISTSIZE);
+
+	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, mount_ids, LISTSIZE, 0));
+	if (TST_RET == -1)
+		goto end;
+
+	tot_ids = (size_t)TST_RET;
+
+	if (tot_ids != LISTSIZE) {
+		tst_res(TFAIL, "listmount() returned %lu but %d was expected",
+			tot_ids, LISTSIZE);
+		goto end;
+	}
+
+	tst_res(TINFO, "Reading groups of %d mount IDs", GROUPS_SIZE);
+
+	while (count < LISTSIZE) {
+		id = count ? list[count - 1] : 0;
+		ret = listmount(LSMT_ROOT, id, list + count, GROUPS_SIZE, 0);
+
+		tst_res(TDEBUG, "listmount(LSMT_ROOT, %lu, list + %lu, %d, 0)",
+			id, count, GROUPS_SIZE);
+
+		if (ret == -1) {
+			tst_res(TFAIL, "listmount() failed with %s", tst_strerrno(errno));
+			goto end;
+		}
+
+		count += ret;
+
+		if (TST_RET < GROUPS_SIZE)
+			break;
+	}
+
+	for (size_t i = 0; i < LISTSIZE; i++) {
+		if (mount_ids[i] != list[i]) {
+			tst_res(TFAIL, "Mount ID differs at %ld index", i);
+			goto end;
+		}
+	}
+
+	tst_res(TPASS, "All mount IDs have been correctly read");
+
+end:
+	SAFE_UMOUNT("/");
+}
+
+static void setup(void)
+{
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_CHROOT(MNTPOINT);
+
+	SAFE_MOUNT("", "/", NULL, MS_REC | MS_SHARED, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
