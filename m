Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CCDCED62A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:34:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BD523C4D4B
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:34:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 971193C27D1
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D8819600D0C
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5F531FB8F
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 08:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZGC1KmIkSao/VTqpebDBNzyAkVdQu1Y0N0qRuEz8WM=;
 b=ABtnW3bScP1J1rEu1iFB2NSiSPoowEF4gJ+dfmOycq5G3dgTVVzgzA/acfadvZFQlV+7xz
 3b5Hn9tFvsAwFvlshRV+V+Gy2r2NgDyD0ElR+sVwuRnFKpJ8P3OnajUKB5Ifp+jCJ0Wmz0
 eMnyVoPDaRDlY4wuMZaRFmnakhoAJ7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZGC1KmIkSao/VTqpebDBNzyAkVdQu1Y0N0qRuEz8WM=;
 b=6fVBS6MQDvpqGYsgy2/da8Iw8KOxJ12c2pZIcQZ0Lp3BLQN2Y8TitkVPs64ymejUlyrB0B
 zRnOXxSnxv52YcAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZGC1KmIkSao/VTqpebDBNzyAkVdQu1Y0N0qRuEz8WM=;
 b=ABtnW3bScP1J1rEu1iFB2NSiSPoowEF4gJ+dfmOycq5G3dgTVVzgzA/acfadvZFQlV+7xz
 3b5Hn9tFvsAwFvlshRV+V+Gy2r2NgDyD0ElR+sVwuRnFKpJ8P3OnajUKB5Ifp+jCJ0Wmz0
 eMnyVoPDaRDlY4wuMZaRFmnakhoAJ7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZGC1KmIkSao/VTqpebDBNzyAkVdQu1Y0N0qRuEz8WM=;
 b=6fVBS6MQDvpqGYsgy2/da8Iw8KOxJ12c2pZIcQZ0Lp3BLQN2Y8TitkVPs64ymejUlyrB0B
 zRnOXxSnxv52YcAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF188136BA
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 08:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mFGfEuk+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Wed, 09 Oct 2024 08:29:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:18 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-16-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=4933;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=gXFtkuVZJJyiqLMVqFkiPqnAPJ+p2lCZFwI3WhTKHNE=;
 b=xUx9khwOBjxhZw3HWQbSLcmTWWj/lHxHmvuGNoZ/wCYA9wffY/HAXXXbIHI9ry8wWV38Lbmdf
 yyT2E7OoI/QCfSEqW2vvFTCrq6/Oe5DhvHGBN2pd4dC+zW7PLXRDcic
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 16/16] Add listmount04 test
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

Verify that listmount() raises the correct errors according with
invalid data:

- EFAULT: req or mnt_id are unaccessible memories
- EINVAL: invalid flags or mnt_id request
- ENOENT: non-existent mount point

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/listmount/.gitignore    |   1 +
 testcases/kernel/syscalls/listmount/listmount04.c | 162 ++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7e6d7aacf..80c4888ee 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -734,6 +734,7 @@ listen01 listen01
 listmount01 listmount01
 listmount02 listmount02
 listmount03 listmount03
+listmount04 listmount04
 
 listxattr01 listxattr01
 listxattr02 listxattr02
diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
index e4273f319..4d709bae5 100644
--- a/testcases/kernel/syscalls/listmount/.gitignore
+++ b/testcases/kernel/syscalls/listmount/.gitignore
@@ -1,3 +1,4 @@
 listmount01
 listmount02
 listmount03
+listmount04
diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
new file mode 100644
index 000000000..b14ad4f01
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that listmount() raises the correct errors according with
+ * invalid data:
+ *
+ * - EFAULT: req or mnt_id are unaccessible memories
+ * - EINVAL: invalid flags or mnt_id request
+ * - ENOENT: non-existent mount point
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/mount.h"
+#include "lapi/syscalls.h"
+
+#define MNT_SIZE 32
+
+static struct mnt_id_req *request;
+static uint64_t mnt_ids[MNT_SIZE];
+
+static struct tcase {
+	int req_usage;
+	uint32_t size;
+	uint32_t spare;
+	uint64_t mnt_id;
+	uint64_t param;
+	uint64_t *mnt_ids;
+	size_t nr_mnt_ids;
+	uint64_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.req_usage = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EFAULT,
+		.msg = "request points to unaccessible memory",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = 0,
+		.mnt_id = LSMT_ROOT,
+		.param = 0,
+		.mnt_ids = NULL,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EFAULT,
+		.msg = "mnt_ids points to unaccessible memory",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = 0,
+		.mnt_id = LSMT_ROOT,
+		.param = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = -1,
+		.exp_errno = EINVAL,
+		.msg = "invalid flags",
+	},
+	{
+		.req_usage = 1,
+		.size = 0,
+		.spare = 0,
+		.mnt_id = LSMT_ROOT,
+		.param = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EINVAL,
+		.msg = "insufficient mnt_id_req.size",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = -1,
+		.mnt_id = LSMT_ROOT,
+		.param = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.spare",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = 0,
+		.mnt_id = LSMT_ROOT,
+		.param = STATMOUNT_PROPAGATE_FROM + 1,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.param",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = 0,
+		.mnt_id = 0,
+		.param = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.mnt_id",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = 0,
+		.mnt_id = LSMT_ROOT - 1,
+		.param = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = ENOENT,
+		.msg = "non-existant mnt_id",
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct mnt_id_req *req = NULL;
+
+	memset(mnt_ids, 0, sizeof(mnt_ids));
+
+	if (tc->req_usage) {
+		req = request;
+		req->mnt_id = tc->mnt_id;
+		req->param = tc->param;
+		req->size = tc->size;
+		req->spare = tc->spare;
+	}
+
+	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
+		tc->nr_mnt_ids, tc->flags), tc->exp_errno,
+		"%s", tc->msg);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers []) {
+		{ &request, .size = sizeof(struct mnt_id_req) },
+		{},
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
