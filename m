Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B752D41D5F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019AC3D5A0C
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:17:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 515063D5A02
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:42 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99129141CA07
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 68E492170C
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1VoQcClsUDF0n7hviWwxh7PgNWbpyq9aSA0SMRwRo0=;
 b=rlCOlImc2sBG8Dnxdf/sX1HdkMlnxkFXzjCWFLK8DZMbbQ/zn91lswfa7/miTKgMhi0H1Z
 1MtWp34qwlZAjclSNe4z1S8WYrV/UAM1zRjfVOu2yaaUQmr1ciNktmCso0UJURgwxaZbLj
 iYJscc4M+4jZAbBB9PskE8HTUzA3kBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1VoQcClsUDF0n7hviWwxh7PgNWbpyq9aSA0SMRwRo0=;
 b=fSM912Yl88lyzcLB8YqH6vukjduVTQD3NSqrUQJW93A2SooFrWx/2WYfanBlN1vQNfzlNA
 aJAlqhtsnctGwGCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rlCOlImc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fSM912Yl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1VoQcClsUDF0n7hviWwxh7PgNWbpyq9aSA0SMRwRo0=;
 b=rlCOlImc2sBG8Dnxdf/sX1HdkMlnxkFXzjCWFLK8DZMbbQ/zn91lswfa7/miTKgMhi0H1Z
 1MtWp34qwlZAjclSNe4z1S8WYrV/UAM1zRjfVOu2yaaUQmr1ciNktmCso0UJURgwxaZbLj
 iYJscc4M+4jZAbBB9PskE8HTUzA3kBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g1VoQcClsUDF0n7hviWwxh7PgNWbpyq9aSA0SMRwRo0=;
 b=fSM912Yl88lyzcLB8YqH6vukjduVTQD3NSqrUQJW93A2SooFrWx/2WYfanBlN1vQNfzlNA
 aJAlqhtsnctGwGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52B813721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKzHK5sAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:39 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:36 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-5-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=3076;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=GdeDUsrpoAyHMf/9035uv/BnHkI4WcFrW4cwImrLHYc=;
 b=PZVSYtnq2R3dPhApnvuftzZ3DrYUr5bIAaEtrh/8KJPTTtSAK7B2O35ESuektLS/qFcVcs6XL
 N8bEuBC7HlcCqTuYHZilOoewZDQwi/xZYkDt54CAx2NNYbbi2mp8oJ0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 68E492170C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/7] Add lsm_list_modules01 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c | 77 ++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index e6cff7763649d8b5c7eb9945473052c63b7a48aa..78b70e12b87bbbec88d641b9c11cac2989812ff7 100644
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
