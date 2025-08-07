Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0792DC87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 07:03:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854733C9252
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 09:03:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE6F43C9323
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1737610007C8
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 09:01:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EFF633C7E;
 Thu,  7 Aug 2025 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=024WwbEvPgeGdRaBTyF7eccW9ZzJ25W8Qiwf9LfkVHY=;
 b=NAV07AkZxF0sLRVGZFnUV7QAAehcAYdnkICuWwOhJLlahx7BpFU268Exva8ipdKO200tl7
 J884I4UVQrQ+BXECOTwG6iWUanZcslMeV7XgjlV7W7GVcOooJbqq3NqSQBYOFPoXnRWrqx
 WwXXMKwwz+c+S8XfqEpSJOo3ZKNshtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=024WwbEvPgeGdRaBTyF7eccW9ZzJ25W8Qiwf9LfkVHY=;
 b=rzIi08tF3zQj71a4fXWsWov1Red7SAd7pGcO08CttoNa5RCY0EiWxTY3JFCcVW/AezBUKs
 eHR0CmyGVjc62+AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754550104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=024WwbEvPgeGdRaBTyF7eccW9ZzJ25W8Qiwf9LfkVHY=;
 b=NAV07AkZxF0sLRVGZFnUV7QAAehcAYdnkICuWwOhJLlahx7BpFU268Exva8ipdKO200tl7
 J884I4UVQrQ+BXECOTwG6iWUanZcslMeV7XgjlV7W7GVcOooJbqq3NqSQBYOFPoXnRWrqx
 WwXXMKwwz+c+S8XfqEpSJOo3ZKNshtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754550104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=024WwbEvPgeGdRaBTyF7eccW9ZzJ25W8Qiwf9LfkVHY=;
 b=rzIi08tF3zQj71a4fXWsWov1Red7SAd7pGcO08CttoNa5RCY0EiWxTY3JFCcVW/AezBUKs
 eHR0CmyGVjc62+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 140C513969;
 Thu,  7 Aug 2025 07:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEqnAlhPlGhaDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 07 Aug 2025 07:01:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 07 Aug 2025 09:01:45 +0200
MIME-Version: 1.0
Message-Id: <20250807-file_setattr_getattr-v6-7-ebe32b282d49@suse.com>
References: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
In-Reply-To: <20250807-file_setattr_getattr-v6-0-ebe32b282d49@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754550102; l=2965;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=rBconfj32Txq/WeDi2eKYBjP7+RzC5v8upp1nf1ns1E=;
 b=XBylK6nuVM7RUpWWFhJyDsv/HMbz05EXPhnCuxJCqr5EBoi0EIIY8KuG5hEauNQynGeCT9F7k
 pLfK7VjkArBAvNiqicRDnwcPgKvO00HZ/SZAL1SQl7/D6y6RXWBMmFt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 7/7] Add file_attr04 test
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

Verify that `file_getattr` and `file_setattr` are correctly raising
an error when the wrong file descriptors types are passed to them.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr04.c | 62 +++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index c33987328d3d6ec96660260aaee4f9ca8c4f0aee..c9b46b8efe3217150ee0740e982ea5a133b3aa46 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -249,6 +249,7 @@ fsetxattr02 fsetxattr02
 file_attr01 file_attr01
 file_attr02 file_attr02
 file_attr03 file_attr03
+file_attr04 file_attr04
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index b79a340b733f7407dc135c5c3b0a9cd0e003e6c9..3fcb9004dd301ef4ee8cc1067c6a3763acb8d299 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -1,3 +1,4 @@
 file_attr01
 file_attr02
 file_attr03
+file_attr04
diff --git a/testcases/kernel/syscalls/file_attr/file_attr04.c b/testcases/kernel/syscalls/file_attr/file_attr04.c
new file mode 100644
index 0000000000000000000000000000000000000000..364fad08e339e713d590b166136dc1c506daac0d
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr04.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_getattr` and `file_setattr` are correctly raising an error
+ * when the wrong file descriptors types are passed to them.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define FILENAME "ltp_file"
+
+static struct file_attr *attr;
+
+static void test_invalid_fd(struct tst_fd *fd)
+{
+	if (fd->type == TST_FD_DIR || fd->type == TST_FD_OPEN_TREE) {
+		tst_res(TCONF, "Skipping DIR fd");
+		return;
+	}
+
+	memset(attr, 0, sizeof(*attr));
+
+	if (tst_variant) {
+		TST_EXP_FAIL(file_getattr(
+			fd->fd, FILENAME,
+			attr, FILE_ATTR_SIZE_LATEST,
+			0), ENOTDIR);
+	} else {
+		TST_EXP_FAIL(file_setattr(
+			fd->fd, FILENAME,
+			attr, FILE_ATTR_SIZE_LATEST,
+			0), ENOTDIR);
+	}
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd) {
+		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd));
+		test_invalid_fd(&fd);
+	}
+}
+
+static void setup(void)
+{
+	SAFE_TOUCH(FILENAME, 0640, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.test_variants = 2,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
