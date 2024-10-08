Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE4CEF148
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 09:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A80673C1B71
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 11:46:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CF7B3C0939
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 942ED20828B
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 11:42:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2FB921A32
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1aIFjBocfGVBVHi4sRlN3YmuxN7T+AFvFfKGHgfG7g=;
 b=urg+FCn4g63jFRaFQ37fupUyWL2yu44wBQt2uOukiq+xVCztRxwdoW/ycrkN151jBsYRtI
 d2HclD4rWEdgstm0Wx4gNMXMXpjfAxHXbcqBXRehyvB9fxRwsr8WcgDOSEGOuAl27NxC2T
 m/gAU0ZGZdTWQcxANxRDE279FSsga6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1aIFjBocfGVBVHi4sRlN3YmuxN7T+AFvFfKGHgfG7g=;
 b=tw+yrbAzWTyTcwk+kcd/3EjCaGoGMZ1kxvuTd3R2ZkCMVjZx3s0sL8ak6ncVum80qJ2Xe0
 NJuPmsxDSlmzunDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=urg+FCn4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tw+yrbAz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728380564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1aIFjBocfGVBVHi4sRlN3YmuxN7T+AFvFfKGHgfG7g=;
 b=urg+FCn4g63jFRaFQ37fupUyWL2yu44wBQt2uOukiq+xVCztRxwdoW/ycrkN151jBsYRtI
 d2HclD4rWEdgstm0Wx4gNMXMXpjfAxHXbcqBXRehyvB9fxRwsr8WcgDOSEGOuAl27NxC2T
 m/gAU0ZGZdTWQcxANxRDE279FSsga6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728380564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1aIFjBocfGVBVHi4sRlN3YmuxN7T+AFvFfKGHgfG7g=;
 b=tw+yrbAzWTyTcwk+kcd/3EjCaGoGMZ1kxvuTd3R2ZkCMVjZx3s0sL8ak6ncVum80qJ2Xe0
 NJuPmsxDSlmzunDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7243A1340C
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 09:42:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QI8QFpT+BGcZPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 08 Oct 2024 09:42:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 11:42:09 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v5-16-66f4e1a9e7db@suse.com>
References: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
In-Reply-To: <20241008-listmount_statmount-v5-0-66f4e1a9e7db@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728380526; l=3602;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Xv8hOeTsJTGGlBMvXKBTp/DaTBSceAluMnDpqy1CkxQ=;
 b=Y+7uCfEVIp49IS+xfrtdHBP1GKsaSx9n0GjOOUCT4L1fGHzJIZ/bx0NAOqa5U9Vij+Eh531ga
 as3w+WTF0FIDs9v1b/9d/7LzQqYX+BTs5CchxmHj5FPqAoI5etPy8hk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: A2FB921A32
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 16/16] Add listmount04 test
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
- EINVAL: invalid flags or req with insufficient size

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/listmount/.gitignore    |  1 +
 testcases/kernel/syscalls/listmount/listmount04.c | 97 +++++++++++++++++++++++
 3 files changed, 99 insertions(+)

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
index 000000000..638bbf6fe
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -0,0 +1,97 @@
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
+ * - EINVAL: invalid flags or req with insufficient size
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
+static struct mnt_id_req *request_null;
+static struct mnt_id_req *request_small;
+static uint64_t mnt_ids[MNT_SIZE];
+
+static struct tcase {
+	struct mnt_id_req **req;
+	uint64_t *mnt_ids;
+	size_t nr_mnt_ids;
+	uint64_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.req = &request_null,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EFAULT,
+		.msg = "request points to unaccessible memory",
+	},
+	{
+		.req = &request,
+		.mnt_ids = NULL,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EFAULT,
+		.msg = "mnt_ids points to unaccessible memory",
+	},
+	{
+		.req = &request,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = -1,
+		.exp_errno = EINVAL,
+		.msg = "invalid flags",
+	},
+	{
+		.req = &request_small,
+		.mnt_ids = mnt_ids,
+		.nr_mnt_ids = MNT_SIZE,
+		.flags = 0,
+		.exp_errno = EINVAL,
+		.msg = "request has insufficient size",
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(tst_syscall(__NR_listmount, *tc->req, tc->mnt_ids,
+		tc->nr_mnt_ids, tc->flags), tc->exp_errno,
+		"%s", tc->msg);
+}
+
+static void setup(void)
+{
+	request->mnt_id = LSMT_ROOT;
+	request->size = MNT_ID_REQ_SIZE_VER0;
+	request->param = 0;
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers []) {
+		{ &request, .size = sizeof(struct mnt_id_req) },
+		{ &request_small, .size = sizeof(struct mnt_id_req) - 4 },
+		{},
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
