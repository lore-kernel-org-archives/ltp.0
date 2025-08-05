Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E5AC87FCB
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:05:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 255803C58EE
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 15:05:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9CD83C2CC1
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EFFA6008E7
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2735E211D4;
 Tue,  5 Aug 2025 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbRWGH4QYj77irv1PLievON8EzRwW2GeGEfhsPMRM2w=;
 b=B+A6ysqDRbuTDqkLOUKSDsmhYp/+lhfBalKJZDgjWxNF33SUNuTdHq23jX6F5I0OlEqFV0
 wTN+A+VpCzOLuGlS73IYlnfQgX+yLWnj47glgVMxVTDBkT78jaJiuLkpl/pSVNErYyqzdH
 XU8Y78cGVCUzUVTewlw4SrVu5DkGzb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbRWGH4QYj77irv1PLievON8EzRwW2GeGEfhsPMRM2w=;
 b=m0VQtDwv4D+a8ZsNM0qmJpkbSApzehpcrJ0UbLB7esVTdaiTIzLvwR5j+sBVrNWdYGtHGr
 hxkA6iIHCQz11DCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbRWGH4QYj77irv1PLievON8EzRwW2GeGEfhsPMRM2w=;
 b=B+A6ysqDRbuTDqkLOUKSDsmhYp/+lhfBalKJZDgjWxNF33SUNuTdHq23jX6F5I0OlEqFV0
 wTN+A+VpCzOLuGlS73IYlnfQgX+yLWnj47glgVMxVTDBkT78jaJiuLkpl/pSVNErYyqzdH
 XU8Y78cGVCUzUVTewlw4SrVu5DkGzb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbRWGH4QYj77irv1PLievON8EzRwW2GeGEfhsPMRM2w=;
 b=m0VQtDwv4D+a8ZsNM0qmJpkbSApzehpcrJ0UbLB7esVTdaiTIzLvwR5j+sBVrNWdYGtHGr
 hxkA6iIHCQz11DCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE3F713A50;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sP33NhoBkmhpFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 13:03:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 15:03:20 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v4-7-08e23354abc8@suse.com>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754399000; l=2858;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=l0ITW6Blo/y/itPApPR47dXqp70S6ZmytZ/dQ+RVZuQ=;
 b=8Yftuf9TS72oOzCEddLrKzIDnrNglq69yJzd/Z7K8E7vVy3MWnKNFxguxG06RW5onsCJYZbxU
 DROZXUFTU9YDhbVLwgTAXUT47PM6d0csb4zLnP6/Bq1h7XOc6HDtfSB
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 7/7] Add file_attr04 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr04.c | 59 +++++++++++++++++++++++
 3 files changed, 61 insertions(+)

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
index 0000000000000000000000000000000000000000..5ca872d2ae6b2f2359c36dbc9a51395fa5369495
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr04.c
@@ -0,0 +1,59 @@
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
+static int exp_errnos[] = {
+	ENOENT,
+	ENOTDIR,
+};
+
+static void test_invalid_fd(struct tst_fd *fd)
+{
+	memset(attr, 0, sizeof(*attr));
+
+	if (tst_variant) {
+		TST_EXP_FAIL_ARR(file_getattr(
+			fd->fd, FILENAME,
+			attr, FILE_ATTR_SIZE_LATEST,
+			0), exp_errnos, ARRAY_SIZE(exp_errnos));
+	} else {
+		TST_EXP_FAIL_ARR(file_setattr(
+			fd->fd, FILENAME,
+			attr, FILE_ATTR_SIZE_LATEST,
+			0), exp_errnos, ARRAY_SIZE(exp_errnos));
+	}
+}
+
+static void run(void)
+{
+	TST_FD_FOREACH(fd)
+		test_invalid_fd(&fd);
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
