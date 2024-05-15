Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0173C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F3573CF75A
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:35:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 289CE3CD986
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:58 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 97C1811F4D2D
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C99E339F4;
 Wed, 15 May 2024 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dgu2rRXne7PpTs+AecDO4WyzAOKC9C5BPD8jMjXz7vc=;
 b=0hRuAuCU/b1i5qOVKIwcHQVNgtHCBmGEvZP33HMvq7mAIacxXFbUlV85bjKZ07yP5l0Sr5
 ZJC6Bps5GkmFXHlidyhulhRFkcM1OCysetkMSFiLpNLXIW0VzBpC4BMuyVgg+yJ6TqvYaZ
 hMwYI+uk7V1hnOAafiYG9h0zisebqtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dgu2rRXne7PpTs+AecDO4WyzAOKC9C5BPD8jMjXz7vc=;
 b=a/IOsTccfIr2eC3w25zgZ2v34loN8S1LYRNTfx2s8Oxmz9wD+1M2CmHKqTrtKpZ4a9GoXj
 UnsB0aKAboWEImDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dgu2rRXne7PpTs+AecDO4WyzAOKC9C5BPD8jMjXz7vc=;
 b=0hRuAuCU/b1i5qOVKIwcHQVNgtHCBmGEvZP33HMvq7mAIacxXFbUlV85bjKZ07yP5l0Sr5
 ZJC6Bps5GkmFXHlidyhulhRFkcM1OCysetkMSFiLpNLXIW0VzBpC4BMuyVgg+yJ6TqvYaZ
 hMwYI+uk7V1hnOAafiYG9h0zisebqtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dgu2rRXne7PpTs+AecDO4WyzAOKC9C5BPD8jMjXz7vc=;
 b=a/IOsTccfIr2eC3w25zgZ2v34loN8S1LYRNTfx2s8Oxmz9wD+1M2CmHKqTrtKpZ4a9GoXj
 UnsB0aKAboWEImDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0674013A62;
 Wed, 15 May 2024 09:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eEovO4SBRGb1TwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 May 2024 09:33:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:33:47 +0200
Message-Id: <20240515093349.7347-9-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240515093349.7347-1-andrea.cervesato@suse.de>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 08/10] Add statmount04 test
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

This test verifies that statmount() is correctly reading propagation
from what mount in current namespace using STATMOUNT_PROPAGATE_FROM.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/statmount/.gitignore      |   1 +
 .../kernel/syscalls/statmount/statmount04.c   | 133 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statmount/statmount04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 116106521..3c262ca3e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1540,6 +1540,7 @@ stat04_64 symlink01 -T stat04_64
 statmount01 statmount01
 statmount02 statmount02
 statmount03 statmount03
+statmount04 statmount04
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index 2a02bf721..e720050b5 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -1,3 +1,4 @@
 statmount01
 statmount02
 statmount03
+statmount04
diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
new file mode 100644
index 000000000..cfb0e9962
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount04.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/**
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading propagation from
+ * what mount in current namespace using STATMOUNT_PROPAGATE_FROM.
+ *
+ * [Algorithm]
+ *
+ * * create a mount point
+ * * propagate a mounted folder inside the mount point
+ * * run statmount() on the mount point using STATMOUNT_PROPAGATE_FROM
+ * * read results and check propagated_from parameter contains the propagated
+ *   folder ID
+ */
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+#include "tst_safe_stdio.h"
+
+#define MNTPOINT "mntpoint"
+#define DIR_A MNTPOINT "/LTP_DIR_A"
+#define DIR_C_SUBFOLDER "/LTP_DIR_A/propagated"
+#define DIR_C (MNTPOINT DIR_C_SUBFOLDER)
+#define DIR_B MNTPOINT "/LTP_DIR_B"
+#define DIR_D MNTPOINT "/LTP_DIR_B/propagated"
+
+static uint64_t peer_group_id;
+static uint64_t dird_id;
+static struct statmount *st_mount;
+
+static int read_peer_group(void)
+{
+	FILE *file;
+	char line[PATH_MAX];
+	char mroot[PATH_MAX];
+	int group = -1;
+
+	file = SAFE_FOPEN("/proc/self/mountinfo", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		if (sscanf(line, "%*d %*d %*d:%*d %s %*s %*s shared:%d", mroot, &group) != 2)
+			continue;
+
+		if (strcmp(mroot, DIR_C_SUBFOLDER) == 0)
+			break;
+	}
+
+	if (group == -1)
+		tst_brk(TBROK, "Can't reed peer group ID for %s", DIR_C_SUBFOLDER);
+
+	return group;
+}
+
+static void run(void)
+{
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(
+		dird_id,
+		STATMOUNT_PROPAGATE_FROM,
+		st_mount,
+		sizeof(struct statmount),
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_PROPAGATE_FROM);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->propagate_from, peer_group_id);
+}
+
+static void setup(void)
+{
+	struct statx sx;
+
+	/* create DIR_A / DIR_C structure with DIR_C mounted */
+	SAFE_MKDIR(DIR_A, 0700);
+	SAFE_MOUNT(DIR_A, DIR_A, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_A, "none", MS_SHARED, NULL);
+
+	SAFE_MKDIR(DIR_C, 0700);
+	SAFE_MOUNT(DIR_C, DIR_C, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_C, "none", MS_SHARED, NULL);
+
+	/* DIR_A mounts into DIR_B. DIR_D is propagated */
+	SAFE_MKDIR(DIR_B, 0700);
+	SAFE_MOUNT(DIR_A, DIR_B, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_B, "none", MS_SLAVE, NULL);
+
+	SAFE_STATX(AT_FDCWD, DIR_D, 0, STATX_MNT_ID_UNIQUE, &sx);
+	dird_id = sx.stx_mnt_id;
+
+	peer_group_id = read_peer_group();
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(DIR_C))
+		SAFE_UMOUNT(DIR_C);
+
+	if (tst_is_mounted(DIR_B))
+		SAFE_UMOUNT(DIR_B);
+
+	if (tst_is_mounted(DIR_A))
+		SAFE_UMOUNT(DIR_A);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.8",
+	.needs_tmpdir = 1,
+	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
