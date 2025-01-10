Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC1BE7719D
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:56:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D93E3C30CE
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:56:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94D43C308A
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51CFC62E783
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D8202117D
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqTDfHRwYiHhvVXW9lKmysUSqqx1tG4ufO9036NWIG8=;
 b=KTjYtP2PQwChRZGvKuj01f9WcR7k1wS+KNNpD3wjlTWputicOOM9ew8/I7In3ZMHNOEeJR
 QmTF5uLtSYyL5IA5uOH1oXG+Jj+diITqjA6to0bxMjxIqCGKuPSh+6zu3z/vW46qf+Dsg6
 EuJvK/7chzM/fue11rasYt1bRJOr8sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqTDfHRwYiHhvVXW9lKmysUSqqx1tG4ufO9036NWIG8=;
 b=BTICLAAFkcqIBaIGsXKPJUe5f2/QvSRtHsPhUxSKp3EU15bOMZDf3KjtbW+CWtSjt9XpeT
 vczjgKC1ukJu53Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqTDfHRwYiHhvVXW9lKmysUSqqx1tG4ufO9036NWIG8=;
 b=KTjYtP2PQwChRZGvKuj01f9WcR7k1wS+KNNpD3wjlTWputicOOM9ew8/I7In3ZMHNOEeJR
 QmTF5uLtSYyL5IA5uOH1oXG+Jj+diITqjA6to0bxMjxIqCGKuPSh+6zu3z/vW46qf+Dsg6
 EuJvK/7chzM/fue11rasYt1bRJOr8sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CqTDfHRwYiHhvVXW9lKmysUSqqx1tG4ufO9036NWIG8=;
 b=BTICLAAFkcqIBaIGsXKPJUe5f2/QvSRtHsPhUxSKp3EU15bOMZDf3KjtbW+CWtSjt9XpeT
 vczjgKC1ukJu53Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 789CF13A86
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CA2iG88YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:42 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-3-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=3115;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=eKKRUzJXyunX6bEtSTTNg6YBsJ1PZGKNVsTgnfeho8I=;
 b=8cqblikjFzMc56139gt+tSCOC8UHTMgl73A3IqI+4RYpHFaql6fdGdsFB7e7y2ULkY40xyTmZ
 jk7t+e0975uC990QB25y818vqRrnxQA0+UQBxeyl4GFwm6n0uIakNG+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/7] Add lsm_get_self_attr02 test
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

Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
The syscall can behave in different ways according to the current system
status:

- if any LSM is running inside the system, the syscall will pass and it will
  provide a size as big as the attribute
- if no LSM(s) are running inside the system, the syscall will fail with -1
  return code and it will provide EOPNOTSUPP errno

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      | 55 ++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 77ed36b2d6877bce15f29e263582e7d81f804f92..63855dd786a62fe017882549c5edcc715d9e7e18 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -757,6 +757,7 @@ lseek07 lseek07
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
index 0000000000000000000000000000000000000000..de8ff95dcd0be1cdc9b80de6cde56edb1373bf0d
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
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
+
+	if (verify_enabled_lsm("selinux"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("apparmor"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("smack"))
+		lsm_count++;
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
