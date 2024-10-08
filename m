Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C479CEFC21
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:05:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 189103C2A38
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:05:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07AC33C2034
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:15 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D6C4620119E
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4A8C21D30;
 Tue,  8 Oct 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zm9GZjqzEp3NBKwml+kDia9nkjt75pQne+ZRpNyNQ00=;
 b=qgnmxirVWwKdfQ8Qs1r1pTSNjYLBqPVkd+ynG6vmrTSpFY/Cwby1zyu7lBjKirfwH7U3dm
 5zU64qy27B5+W1hV2H1Uss3UE7oY9H2pFcE+WoiiTzpj2xGP8FE+Ug2ZKYkqLmivxDq//6
 f2nbVI2s4wsrXFFmSyvinpbIdiYjwiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zm9GZjqzEp3NBKwml+kDia9nkjt75pQne+ZRpNyNQ00=;
 b=7sQ6ajDwnp/Wtw59ms56sVkNBerPPkaXUe5TMWmzOGrjGd3eAYrxSWcuLTcuNegbHN6qfq
 mtZ5ZNu3+Ai0gVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zm9GZjqzEp3NBKwml+kDia9nkjt75pQne+ZRpNyNQ00=;
 b=qgnmxirVWwKdfQ8Qs1r1pTSNjYLBqPVkd+ynG6vmrTSpFY/Cwby1zyu7lBjKirfwH7U3dm
 5zU64qy27B5+W1hV2H1Uss3UE7oY9H2pFcE+WoiiTzpj2xGP8FE+Ug2ZKYkqLmivxDq//6
 f2nbVI2s4wsrXFFmSyvinpbIdiYjwiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zm9GZjqzEp3NBKwml+kDia9nkjt75pQne+ZRpNyNQ00=;
 b=7sQ6ajDwnp/Wtw59ms56sVkNBerPPkaXUe5TMWmzOGrjGd3eAYrxSWcuLTcuNegbHN6qfq
 mtZ5ZNu3+Ai0gVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 968E613A6E;
 Tue,  8 Oct 2024 15:00:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MDQkIv1IBWf6KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 15:00:13 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 17:00:08 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v6-13-0fd456b6b9bf@suse.com>
References: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
In-Reply-To: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728399605; l=4055;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=sVvCw6TyXSioWnHOBkY/Viw5NzO+7LWCGjIwlvuIod8=;
 b=xCzfgDs0w3HzLjZKDs9/mmUZq+rULMqATxGyTRFu8akkWaOJDSYy5Gu0qc7nFfWPVJw22piOU
 R+kYd4ezH7TBInIxHq3VsDyn3YQeEiPkOHNP1TUMtkpiqa47i7IBIsr
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.19)[-0.943]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 13/16] Add statmount07 test
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

This test is verifying that statmount syscall is raising the correct
errors according with invalid input values.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount07.c | 144 ++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a742e405b..bf222e466 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1580,6 +1580,7 @@ statmount03 statmount03
 statmount04 statmount04
 statmount05 statmount05
 statmount06 statmount06
+statmount07 statmount07
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index 03a75bd40..b2a55c077 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -4,3 +4,4 @@ statmount03
 statmount04
 statmount05
 statmount06
+statmount07
diff --git a/testcases/kernel/syscalls/statmount/statmount07.c b/testcases/kernel/syscalls/statmount/statmount07.c
new file mode 100644
index 000000000..0cc834298
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount07.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is raising the correct errors according
+ * with invalid input values.
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mntpoint"
+
+static struct statmount *st_mount;
+static struct statmount *st_mount_null;
+static struct statmount *st_mount_small;
+static uint64_t mnt_id;
+static uint64_t mnt_id_dont_exist = -1;
+static size_t buff_size;
+static size_t buff_size_invalid = -1;
+
+struct tcase {
+	int exp_errno;
+	char *msg;
+	uint64_t *mnt_id;
+	uint64_t mask;
+	unsigned int flags;
+	size_t *buff_size;
+	struct statmount **buff;
+} tcases[] = {
+	{
+		ENOENT,
+		"mount id doesn't exist'",
+		&mnt_id_dont_exist,
+		0,
+		0,
+		&buff_size,
+		&st_mount
+	},
+	{
+		EOVERFLOW,
+		"invalid mask",
+		&mnt_id,
+		-1,
+		0,
+		&buff_size,
+		&st_mount
+	},
+	{
+		EOVERFLOW,
+		"small buffer for fs type",
+		&mnt_id,
+		STATMOUNT_FS_TYPE,
+		0,
+		&buff_size,
+		&st_mount_small
+	},
+	{
+		EOVERFLOW,
+		"small buffer for mnt root",
+		&mnt_id,
+		STATMOUNT_MNT_ROOT,
+		0,
+		&buff_size,
+		&st_mount_small
+	},
+	{
+		EOVERFLOW,
+		"small buffer for mnt point",
+		&mnt_id,
+		STATMOUNT_MNT_POINT,
+		0,
+		&buff_size,
+		&st_mount_small
+	},
+	{
+		EINVAL,
+		"flags must be zero",
+		&mnt_id,
+		0,
+		1,
+		&buff_size,
+		&st_mount
+	},
+	{
+		EFAULT,
+		"invalid buffer size",
+		&mnt_id,
+		0,
+		0,
+		&buff_size_invalid,
+		&st_mount
+	},
+	{
+		EFAULT,
+		"invalid buffer pointer",
+		&mnt_id,
+		0,
+		0,
+		&buff_size,
+		&st_mount_null
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_FAIL(statmount(*tc->mnt_id, tc->mask,
+		*tc->buff, *tc->buff_size, tc->flags),
+		tc->exp_errno, "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+
+	mnt_id = sx.data.stx_mnt_id;
+	buff_size = sizeof(struct statmount);
+}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{&st_mount_small, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
