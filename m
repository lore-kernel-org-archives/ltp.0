Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62A0CEDD88
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 12:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C7123C3036
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 14:09:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 605813C2B8B
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7186601561
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 14:04:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E9141FE93;
 Wed,  9 Oct 2024 12:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=UOi1gAqZTIryNVmcDr+Hrr7YHXNWwaFnkqeP9RG5bjqIIYyp5h4T0abq1tLcAO1AJGdKM/
 8GTFFeDEDQwEl+qWVa0TtXixoB43xCeTwmQM9CK2Pbb4ZJxq34URob54/EktjKTkqJ+zhR
 AjkNQ6OW/ZfLOAjJOIVlIuuOGDFGEiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=J9GN8OL2O5S5XyRjvUrbU6a5t68Wn0a0DkzLtqGrtjsmC/8arDSXyfAPUwgv0VS6zbzPts
 geagZGZSeXKzKtBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728475490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=UOi1gAqZTIryNVmcDr+Hrr7YHXNWwaFnkqeP9RG5bjqIIYyp5h4T0abq1tLcAO1AJGdKM/
 8GTFFeDEDQwEl+qWVa0TtXixoB43xCeTwmQM9CK2Pbb4ZJxq34URob54/EktjKTkqJ+zhR
 AjkNQ6OW/ZfLOAjJOIVlIuuOGDFGEiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728475490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7VgMt1mkjM3QaBIbggdm1v6ccm1UBB1zPap3/Z7zVes=;
 b=J9GN8OL2O5S5XyRjvUrbU6a5t68Wn0a0DkzLtqGrtjsmC/8arDSXyfAPUwgv0VS6zbzPts
 geagZGZSeXKzKtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30F5113A58;
 Wed,  9 Oct 2024 12:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yMQdBWJxBmfLEwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 12:04:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 14:04:50 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v8-15-182cd6557223@suse.com>
References: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
In-Reply-To: <20241009-listmount_statmount-v8-0-182cd6557223@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728475481; l=2494;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Z0b/aD4FZYQ8CAqWC4RppSMJqFveuwtmN3ptfLEccrE=;
 b=dSxwVkpCPzl5KzR+85F7SKnCqPiHQPXvPiDCl+OxOLQU8c4VWYkngEF1rfhGmQF2m7RCfwheE
 0SQlpv7xA2tB5UhcgJoog+rELcbsz8Q43y8+h7t69CEP9RRs/WougVM
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 15/16] Add listmount03 test
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
