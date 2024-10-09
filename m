Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49695CED628
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:34:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D88653C4BD4
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:34:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BD723C25C9
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:31 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 648F1600D0C
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 324921FB8E;
 Wed,  9 Oct 2024 08:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=zNAEKGK+95lwCiXLQa6h7CaxuiJ46mQfdGDb0K6Z4APSb98Umb7uPaPkbbBq3j/jgexRC7
 sta16i2e4D8htWwU5KjW3oN1bjphFbgMnt5VsGT37mCkrHlp7RG5Lra4WiQCERWWP8+rnU
 GH7V6UahFfc/JwFClJ0k+S6kqkJBNig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=cnnuApEQ2jVbr7uDFymiOILKMZrt21z4iGZE6nJI4xzHR1sdjJ8oH55Ik5zRa7LhDNi9JY
 o4T2LRerO84h7ECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=zNAEKGK+95lwCiXLQa6h7CaxuiJ46mQfdGDb0K6Z4APSb98Umb7uPaPkbbBq3j/jgexRC7
 sta16i2e4D8htWwU5KjW3oN1bjphFbgMnt5VsGT37mCkrHlp7RG5Lra4WiQCERWWP8+rnU
 GH7V6UahFfc/JwFClJ0k+S6kqkJBNig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=cnnuApEQ2jVbr7uDFymiOILKMZrt21z4iGZE6nJI4xzHR1sdjJ8oH55Ik5zRa7LhDNi9JY
 o4T2LRerO84h7ECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13BC4136BA;
 Wed,  9 Oct 2024 08:29:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YMMHNOc+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:17 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-15-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=2494;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Z0b/aD4FZYQ8CAqWC4RppSMJqFveuwtmN3ptfLEccrE=;
 b=fotvUQ26HtbTsSGI5Mf7e3AkNT0eUsT4OZ2B1C3FFl2iGrplAbbk9phzpkGlihdFLCOAxfNl5
 a/B/4J8i35TDSPUcOUEy80ihjFqnuIzT1u2eIDhJorQKEj9KG4Agwwl
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 15/16] Add listmount03 test
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

Verify that listmount() raises EPERM when mount point is not accessible.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/listmount/.gitignore    |  1 +
 testcases/kernel/syscalls/listmount/listmount03.c | 62 +++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index f8ae25344..7e6d7aacf 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -733,6 +733,7 @@ listen01 listen01
 
 listmount01 listmount01
 listmount02 listmount02
+listmount03 listmount03
 
 listxattr01 listxattr01
 listxattr02 listxattr02
diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
index 30bbf9f02..e4273f319 100644
--- a/testcases/kernel/syscalls/listmount/.gitignore
+++ b/testcases/kernel/syscalls/listmount/.gitignore
@@ -1,2 +1,3 @@
 listmount01
 listmount02
+listmount03
diff --git a/testcases/kernel/syscalls/listmount/listmount03.c b/testcases/kernel/syscalls/listmount/listmount03.c
new file mode 100644
index 000000000..befe0edaf
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount03.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that listmount() raises EPERM when mount point is not accessible.
+ */
+
+#define _GNU_SOURCE
+
+#include <pwd.h>
+#include "listmount.h"
+#include "lapi/stat.h"
+
+#define LISTSIZE 32
+
+static uint64_t root_id;
+static gid_t nobody_gid;
+static uid_t nobody_uid;
+
+static void run(void)
+{
+	if (SAFE_FORK())
+		return;
+
+	uint64_t list[LISTSIZE];
+
+	SAFE_SETEGID(nobody_gid);
+	SAFE_SETEUID(nobody_uid);
+
+	TST_EXP_FAIL(listmount(root_id, 0, list, LISTSIZE, 0), EPERM);
+
+	exit(0);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+	struct passwd *pw;
+
+	pw = SAFE_GETPWNAM("nobody");
+	nobody_gid = pw->pw_gid;
+	nobody_uid = pw->pw_uid;
+
+	SAFE_STATX(AT_FDCWD, "/", 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+
+	SAFE_CHROOT(tst_tmpdir_path());
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.min_kver = "6.8",
+};
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
