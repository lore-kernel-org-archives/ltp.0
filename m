Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CC3ECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:02:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A601C3C14BD
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:02:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 179F93C149D
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E9A98206C51
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58F1B21BE0
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/RLWrWYvKLaxtDFRSbsYsDQiGPDY5bGdkv6/hRzwiY=;
 b=MewOMbxmtMCNHeB9cTFt4OfxB9Dd3UfSKdr+kEkJV+D1WwDkskMaHpB73DMKA1/3z8GTzn
 ZJNQO5DAiJp0Ix1ebNeXNvFK8HVOZGQTaC7zjqu5TCZVPhpXDBQoPvr9O5UazvHZJnznGi
 kQpR5Y//3BeqFoBLKZ74cudl1fEzsTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/RLWrWYvKLaxtDFRSbsYsDQiGPDY5bGdkv6/hRzwiY=;
 b=lxHceakYL6ztxMf8My9m0Y84qdAQrYlbbwsCpk7uKMViOKD1YifkEEkKBBL4Cjz54uLe6D
 nkyjATvEuW2PFfDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MewOMbxm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lxHceakY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/RLWrWYvKLaxtDFRSbsYsDQiGPDY5bGdkv6/hRzwiY=;
 b=MewOMbxmtMCNHeB9cTFt4OfxB9Dd3UfSKdr+kEkJV+D1WwDkskMaHpB73DMKA1/3z8GTzn
 ZJNQO5DAiJp0Ix1ebNeXNvFK8HVOZGQTaC7zjqu5TCZVPhpXDBQoPvr9O5UazvHZJnznGi
 kQpR5Y//3BeqFoBLKZ74cudl1fEzsTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c/RLWrWYvKLaxtDFRSbsYsDQiGPDY5bGdkv6/hRzwiY=;
 b=lxHceakYL6ztxMf8My9m0Y84qdAQrYlbbwsCpk7uKMViOKD1YifkEEkKBBL4Cjz54uLe6D
 nkyjATvEuW2PFfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11B713312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uN5VJz7H3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:26 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-4-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=4177;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ZH8XP2NXwdT7axCqVcMjiono1CnKhnaFdredgSvW3jg=;
 b=5VkEk9iY4nEL+yrNrhlL3FY301MVucOy3N7L+flsLIbzqKvzfkLNU662xml/3k07xfQcsCfI5
 q05ew1YLQ2FANHUffc824DMJLpeOIkNFgSctVJSKOlqCYeOyjRqO7Jv
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 58F1B21BE0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 04/13] Add listmount01 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/listmount/.gitignore    |  1 +
 testcases/kernel/syscalls/listmount/Makefile      |  7 +++
 testcases/kernel/syscalls/listmount/listmount.h   | 26 ++++++++++
 testcases/kernel/syscalls/listmount/listmount01.c | 63 +++++++++++++++++++++++
 5 files changed, 99 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a9fc8c432..48db6259b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -730,6 +730,8 @@ linkat02 linkat02
 
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
index 000000000..93766cd33
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef LISTMOUNT_H
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
index 000000000..ab74b776b
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
+	if (TST_RET == -1)
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
