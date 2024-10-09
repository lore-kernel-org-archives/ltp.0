Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA38BCED62A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:30:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FC663C2DFE
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:30:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40D293C1CF0
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:16 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B177100093A
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BBD1A21D02;
 Wed,  9 Oct 2024 08:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM/a7AGcWazbR/Bmu2a1GoikKnwsqmCQJU55vjh3xbU=;
 b=oj/O1C2zMv9k4/7uNsa0wISlkKbqxgFTykPj5D6PCk0SDf4XYO6jecuzx5pGiQ93Kr5JsH
 lQQ3OZblNAknwLXd1fCepi3cxGdxR3G4LDd9mHnCvgpYofrqvrp97sXcnddHCxtrLHKHk/
 puppavvQwkVNRtqq7vN1xVVz9QhaMJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM/a7AGcWazbR/Bmu2a1GoikKnwsqmCQJU55vjh3xbU=;
 b=MQMdd+IPzh9duNccQAsOIFFelnFpqjhC9Ij/9WU+GZcGHNJjkaVIvPa0SBf/VaFD4rgBJc
 AEi/QaTPWOM8XFCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM/a7AGcWazbR/Bmu2a1GoikKnwsqmCQJU55vjh3xbU=;
 b=oj/O1C2zMv9k4/7uNsa0wISlkKbqxgFTykPj5D6PCk0SDf4XYO6jecuzx5pGiQ93Kr5JsH
 lQQ3OZblNAknwLXd1fCepi3cxGdxR3G4LDd9mHnCvgpYofrqvrp97sXcnddHCxtrLHKHk/
 puppavvQwkVNRtqq7vN1xVVz9QhaMJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM/a7AGcWazbR/Bmu2a1GoikKnwsqmCQJU55vjh3xbU=;
 b=MQMdd+IPzh9duNccQAsOIFFelnFpqjhC9Ij/9WU+GZcGHNJjkaVIvPa0SBf/VaFD4rgBJc
 AEi/QaTPWOM8XFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B020E136BA;
 Wed,  9 Oct 2024 08:29:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mDD6I9g+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:07 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-5-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=4241;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Z7NozK0DfRaFU2aq2fiF722DyKYl+Cy+Zu+m3CKZXvo=;
 b=S/xKisoPC4rgb2AP2xJGxxvs936IKxtmbkwi5boaCuBAXxsK+kX5lb+6nwEbz9NODp5HncZ/u
 Mi5UPRVA3ghC3xAOY/BVLtEmNfi6ocWUCypBsJip23psUjW+QvptN1k
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 05/16] Add listmount01 test
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

This test verifies that listmount() is properly recognizing a mounted
root directory using LSMT_ROOT flag.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/listmount/.gitignore    |  1 +
 testcases/kernel/syscalls/listmount/Makefile      |  7 +++
 testcases/kernel/syscalls/listmount/listmount.h   | 27 ++++++++++
 testcases/kernel/syscalls/listmount/listmount01.c | 63 +++++++++++++++++++++++
 5 files changed, 100 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 02e721df9..09e3025a6 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -731,6 +731,8 @@ linkat02 linkat02
 
 listen01 listen01
 
+listmount01 listmount01
+
 listxattr01 listxattr01
 listxattr02 listxattr02
 listxattr03 listxattr03
diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
new file mode 100644
index 000000000..5257b298c
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/.gitignore
@@ -0,0 +1 @@
+listmount01
diff --git a/testcases/kernel/syscalls/listmount/Makefile b/testcases/kernel/syscalls/listmount/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/listmount/listmount.h b/testcases/kernel/syscalls/listmount/listmount.h
new file mode 100644
index 000000000..aad927f71
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LISTMOUNT_H
+#define LISTMOUNT_H
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/mount.h"
+#include "lapi/syscalls.h"
+
+static inline ssize_t listmount(uint64_t mnt_id, uint64_t last_mnt_id,
+			 uint64_t list[], size_t num, unsigned int flags)
+{
+	struct mnt_id_req req = {
+		.size = MNT_ID_REQ_SIZE_VER0,
+		.mnt_id = mnt_id,
+		.param = last_mnt_id,
+	};
+
+	return tst_syscall(__NR_listmount, &req, list, num, flags);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/listmount/listmount01.c b/testcases/kernel/syscalls/listmount/listmount01.c
new file mode 100644
index 000000000..604e5ce92
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount01.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that listmount() is properly recognizing a mounted
+ * root directory using LSMT_ROOT flag.
+ *
+ * [Algorithm]
+ *
+ * - move into a new unshared namespace
+ * - mount() a root inside temporary folder and get its mount ID
+ * - get list of mounted IDs using listmount(LSMT_ROOT, ..)
+ * - verify that the root mount ID is the only mount ID present inside the list
+ */
+
+#define _GNU_SOURCE
+
+#include "listmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define LISTSIZE 32
+
+static uint64_t root_id;
+
+static void run(void)
+{
+	uint64_t list[LISTSIZE];
+
+	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, list, LISTSIZE, 0));
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(TST_RET, 1);
+	TST_EXP_EQ_LI(list[0], root_id);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	SAFE_UNSHARE(CLONE_NEWNS);
+
+	SAFE_CHROOT(MNTPOINT);
+	SAFE_MOUNT("", "/", NULL, MS_REC | MS_PRIVATE, NULL);
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
+
+	root_id = sx.data.stx_mnt_id;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
