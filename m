Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A93E77188
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:58:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3E293C30B7
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:58:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3B7E3C308A
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:45 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3781110343C8
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D458A1F454;
 Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wxhdf+nQ4VzhoUVWSEik6PgxcPTtwECn6+J8x0x6wM=;
 b=0Q/282mJGThMcXXUQTXyRl0hCcUaj1gNK+EfCdobpUxUpU93dNcZnzfHRysdezofu28Wlx
 8fyLhZj+BkSYCG9Z3onXbuTPGNtYQ+DeA1tGkhWL+tEbXHvoe4n9185/P9C5cAUUAS+n0D
 qDIT2pb5vhGsfJ6v4mHoHoGm/C3x4vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wxhdf+nQ4VzhoUVWSEik6PgxcPTtwECn6+J8x0x6wM=;
 b=pb8wMowdStx0TF4r4SM/rs3sV8S99T/JpFolotqs6RYg67oEf1r/FSioklUfXabW5nWG8H
 H8zt1SecICEPGjDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wxhdf+nQ4VzhoUVWSEik6PgxcPTtwECn6+J8x0x6wM=;
 b=dZbWJZqNDAI/+lrJaRABYlXZL2zgyU93hb+v+0ce2qhUKxqMXEl0tm9X3J77eM9AbzutK2
 XI+Z/jj7SNPSRFFnegFhZKiXLr3uyECI1NJdICeza1HqR/3Qe/4/KqBJB8a4L1+kdpvriH
 1Wikm+NWC9/jjaG+NutVbLDJ6QpQm3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wxhdf+nQ4VzhoUVWSEik6PgxcPTtwECn6+J8x0x6wM=;
 b=AMKRPdE9NeXuQ07RCB77EGigLv1BypioYq1rA19s7WIrBJbZG08cJt7tsSSz06DIHLur/s
 EcTK9it2fkRXb6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B855613A86;
 Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UAMYK88YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 10 Jan 2025 12:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:44 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-5-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=3121;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Y92Ql1VSmyqEa2ydZkAI2pw4crhe14sgLcACftaOrN8=;
 b=2yb9JJrvdXD2wLPNDMRP9mGGJf54fpI/y/Taf2xXifZIHh1nv8JKIvnk4kbwNrlzBR0JnwlFt
 GNsKUMudMqkBRr4Bey+hE/jRsjOVFXrVIeRRq5NNOHglS3jhbRFIs8C
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/7] Add lsm_list_modules01 test
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

Verify that lsm_list_modules syscall is raising errors when invalid
data is provided.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c | 77 ++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 56eb6449c11102f0148215f8a1efbea51fad6a27..ae1f430e3dcfebb5167990fcef45b1f3658f6dba 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -759,6 +759,7 @@ lseek11 lseek11
 lsm_get_self_attr01 lsm_get_self_attr01
 lsm_get_self_attr02 lsm_get_self_attr02
 lsm_get_self_attr03 lsm_get_self_attr03
+lsm_list_modules01 lsm_list_modules01
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 19956fdf8b9952b4850c3a20826e29ec67ea3560..501d332549a84cceb9741346bdb8b83eb02467c5 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1,3 +1,4 @@
 lsm_get_self_attr01
 lsm_get_self_attr02
 lsm_get_self_attr03
+lsm_list_modules01
diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules01.c b/testcases/kernel/syscalls/lsm/lsm_list_modules01.c
new file mode 100644
index 0000000000000000000000000000000000000000..6aa401ab19bd3fb303fe28df878c3238bacdd4fb
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules01.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that lsm_list_modules syscall is raising errors when invalid data is
+ * provided.
+ */
+
+#include "lsm_common.h"
+
+#define MAX_LSM_NUM 32
+
+static uint64_t lsm_ids[MAX_LSM_NUM];
+static uint32_t page_size;
+static uint32_t ids_size;
+static uint32_t ids_size_small;
+
+static struct tcase {
+	uint64_t *ids;
+	uint32_t *size;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.size = &ids_size,
+		.exp_errno = EFAULT,
+		.msg = "ids is NULL",
+	},
+	{
+		.ids = lsm_ids,
+		.exp_errno = EFAULT,
+		.msg = "size is NULL",
+	},
+	{
+		.ids = lsm_ids,
+		.size = &ids_size_small,
+		.exp_errno = E2BIG,
+		.msg = "size is too small",
+	},
+	{
+		.ids = lsm_ids,
+		.size = &ids_size,
+		.flags = 1,
+		.exp_errno = EINVAL,
+		.msg = "flags must be zero",
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(lsm_ids, 0, sizeof(lsm_ids));
+	ids_size = page_size;
+	ids_size_small = 0;
+
+	TST_EXP_FAIL(lsm_list_modules(tc->ids, tc->size, tc->flags),
+	      tc->exp_errno,
+	      "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.8",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
