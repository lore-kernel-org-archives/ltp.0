Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA513C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:24:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF013CBC05
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:24:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9460D3CBBFC
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 141966008C3
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF0AF1F7FE;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGat+6zXm+2VZH7I++36Dbo1bxYKefbDOWmksIITS3Y=;
 b=H5Ie20tGE8+exO/XAQDBUp70AJ2ekPUuZIrBn/NLIZbKZPgycYugjleYauLs6t/prSbPoH
 fk1OkcywnuAFK2911r/+BIPIwDaZRHaNl3eaU4gT1Molvg0/H0D0IgDLmNYiz0kY/gG9qZ
 jlV4YiaDmi72k/V+7ukS06rvGW16QNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGat+6zXm+2VZH7I++36Dbo1bxYKefbDOWmksIITS3Y=;
 b=BWGuQS3CZBU8BhhYClL8JvwuzJahO4QEcRmK0KUIhYnvnY7OcKAn9HhIDwnmMc7lMAlf6l
 Ue++WXUmy/l5K2Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGat+6zXm+2VZH7I++36Dbo1bxYKefbDOWmksIITS3Y=;
 b=H5Ie20tGE8+exO/XAQDBUp70AJ2ekPUuZIrBn/NLIZbKZPgycYugjleYauLs6t/prSbPoH
 fk1OkcywnuAFK2911r/+BIPIwDaZRHaNl3eaU4gT1Molvg0/H0D0IgDLmNYiz0kY/gG9qZ
 jlV4YiaDmi72k/V+7ukS06rvGW16QNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGat+6zXm+2VZH7I++36Dbo1bxYKefbDOWmksIITS3Y=;
 b=BWGuQS3CZBU8BhhYClL8JvwuzJahO4QEcRmK0KUIhYnvnY7OcKAn9HhIDwnmMc7lMAlf6l
 Ue++WXUmy/l5K2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4E901340C;
 Tue, 29 Apr 2025 07:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4AqBKnJ+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:32 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-3-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=2965;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=SqaNpk8bpQX5S+yupz4f9YOAy3fjgAkzpL9qXA2zG0I=;
 b=n6+3FdmFIMYhma3zOosEzjPJOHb+XEaRRhYQ+iVFqAT0n1PY4BPJ1w7WtREosQOjlwGKV22k7
 XupbSwqZfP4DDyhfeWBaDAqKCOArc+ly1BniLUPKTHMd282Bp8RwwnE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/7] Add lsm_get_self_attr02 test
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

Verify that lsm_get_self_attr syscall is acting correctly when ctx
is NULL. The syscall can behave in different ways according to the
current system status:

- if any LSM is running inside the system, the syscall will pass
  and it will provide a size as big as the attribute
- if no LSM(s) are running inside the system, the syscall will fail
  with -1 return code and it will provide EOPNOTSUPP errno

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      | 45 ++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ba45c1945fb77b093ba578fdda3596a8d38c54b0..73b6b98c7748f5ed31ad23d7464f1ab4fbc5f42e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -760,6 +760,7 @@ lseek07 lseek07
 lseek11 lseek11
 
 lsm_get_self_attr01 lsm_get_self_attr01
+lsm_get_self_attr02 lsm_get_self_attr02
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 49f4a9263349ce633b8decb8fff1dd1d2111cf49..9f7c9b00b026a377f1b36f483ac2c1a0adba6249 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1 +1,2 @@
 lsm_get_self_attr01
+lsm_get_self_attr02
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
new file mode 100644
index 0000000000000000000000000000000000000000..889f3830fde8a5817936e67d9ee191a7513ff454
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
+ * The syscall can behave in different ways according to the current system
+ * status:
+ *
+ * - if any LSM is running inside the system, the syscall will pass and it will
+ *   provide a size as big as the attribute
+ * - if no LSM(s) are running inside the system, the syscall will fail with -1
+ *   return code
+ */
+#include "lsm_common.h"
+
+static uint32_t page_size;
+static uint32_t lsm_count;
+
+static void run(void)
+{
+	uint32_t size = page_size;
+
+	if (lsm_count) {
+		TST_EXP_POSITIVE(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0));
+		TST_EXP_EXPR(size > 1);
+	} else {
+		TST_EXP_FAIL(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0), EOPNOTSUPP);
+	}
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	lsm_count = count_supported_attr_current();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
