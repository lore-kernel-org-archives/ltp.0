Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E58CEDD88
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:10:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B37403C268C
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:10:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAA1C3C2E4E
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:52 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 52BC6602795
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A40421E8B;
 Wed,  9 Oct 2024 12:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE3poBj6nwBid+yp8MIbwprv16pGjJvjeJ30mTvkF8k=;
 b=H/ewVsZOsxU8z5/rPdRI/mVNEyAE24TMEQDNakJvUUBRCFPFzpaauMf+jtpqwmx9BJOEqj
 JpnNm5xoBeRsVCKmgb39rQsIJejqzdgDL87kEIqdh6tXWX/jMW3zZN2Hd0GSuSAXArviNq
 41E3Jglc1BHFDf2PeljtvvloVzcARJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE3poBj6nwBid+yp8MIbwprv16pGjJvjeJ30mTvkF8k=;
 b=6DlJwrs8/sWUqm+UzK3ngGS0v7eEaHILf2AW8U7vLKhALndVpaqNV5C3bcsBI6mSU8rCpi
 aZuTc5EsmW9TXsDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="H/ewVsZO";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6DlJwrs8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE3poBj6nwBid+yp8MIbwprv16pGjJvjeJ30mTvkF8k=;
 b=H/ewVsZOsxU8z5/rPdRI/mVNEyAE24TMEQDNakJvUUBRCFPFzpaauMf+jtpqwmx9BJOEqj
 JpnNm5xoBeRsVCKmgb39rQsIJejqzdgDL87kEIqdh6tXWX/jMW3zZN2Hd0GSuSAXArviNq
 41E3Jglc1BHFDf2PeljtvvloVzcARJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE3poBj6nwBid+yp8MIbwprv16pGjJvjeJ30mTvkF8k=;
 b=6DlJwrs8/sWUqm+UzK3ngGS0v7eEaHILf2AW8U7vLKhALndVpaqNV5C3bcsBI6mSU8rCpi
 aZuTc5EsmW9TXsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6C913A58;
 Wed,  9 Oct 2024 12:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iJ/hI2JxBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:51 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-16-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=4674;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RfIUutDB9KNuhiyPPcaij15WEetkpAhALEgoonSjYM0=;
 b=BrAdI5HM4RZrVLkfZsYBpxfch3YuT3OjDRsemPqhY8DOV0QYf6xW5ryxiWMeVo2xhrAGsKxf7
 KAImuV4dH40DrigEugdjHMpIUxS3FKIU6XT95++8naye5JCESuq0cTU
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 0A40421E8B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 16/16] Add listmount04 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/listmount/.gitignore    |   1 +
 testcases/kernel/syscalls/listmount/listmount04.c | 143 ++++++++++++++++++++++
 3 files changed, 145 insertions(+)

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
index 000000000..d38408d2c
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -0,0 +1,143 @@
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
+		.exp_errno = EFAULT,
+		.msg = "request points to unaccessible memory",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ids = NULL,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EFAULT,
+		.msg = "mnt_ids points to unaccessible memory",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = -1,
+		.exp_errno = EINVAL,
+		.msg = "invalid flags",
+	},
+	{
+		.req_usage = 1,
+		.size = 0,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EINVAL,
+		.msg = "insufficient mnt_id_req.size",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.spare = -1,
+		.mnt_id = LSMT_ROOT,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.spare",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT,
+		.param = STATMOUNT_PROPAGATE_FROM + 1,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.param",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = 0,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.exp_errno = EINVAL,
+		.msg = "invalid mnt_id_req.mnt_id",
+	},
+	{
+		.req_usage = 1,
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = LSMT_ROOT - 1,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
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
