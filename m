Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED58CECE579
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:03:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D4FC3C1773
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:03:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F3C13C180C
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:36 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD1271000B54
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:00:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A29441F7AF
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS6jyF5M4JfM7GA9Tl96xtfQwC2UEEoPys7z4wEL4Vs=;
 b=tBVJBgMs0Ig60KGBokSfRd4eY6yLF4CQM++025pF7f/4aUF5r8n0hWHwQwpHVzm5A/EMG6
 yqxN/UEAQR1pTHXa/ZViu6l6cmNvFdPqrjLzdm7FikR5lQSWHgLYfpQGG9v7OOGmIqSfsy
 3EbBBOpyJra8jDd98fg9/fAhUvZOeqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS6jyF5M4JfM7GA9Tl96xtfQwC2UEEoPys7z4wEL4Vs=;
 b=jT4vOYnH22hIkqvZc5Jrb0SEcag226nvV1Sj1r1mA/P7a8GNnlIqMx0ZeEI4KeYyDiSdJp
 EzNwgqAYfRgAjLDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS6jyF5M4JfM7GA9Tl96xtfQwC2UEEoPys7z4wEL4Vs=;
 b=tBVJBgMs0Ig60KGBokSfRd4eY6yLF4CQM++025pF7f/4aUF5r8n0hWHwQwpHVzm5A/EMG6
 yqxN/UEAQR1pTHXa/ZViu6l6cmNvFdPqrjLzdm7FikR5lQSWHgLYfpQGG9v7OOGmIqSfsy
 3EbBBOpyJra8jDd98fg9/fAhUvZOeqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876034;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vS6jyF5M4JfM7GA9Tl96xtfQwC2UEEoPys7z4wEL4Vs=;
 b=jT4vOYnH22hIkqvZc5Jrb0SEcag226nvV1Sj1r1mA/P7a8GNnlIqMx0ZeEI4KeYyDiSdJp
 EzNwgqAYfRgAjLDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4952313312
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +B7ACkLH3mb+DgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 10:00:34 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 09 Sep 2024 12:00:30 +0200
MIME-Version: 1.0
Message-Id: <20240909-listmount_statmount-v4-8-39558204ddf0@suse.com>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
In-Reply-To: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725876026; l=6432;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=K3hWaILSr4OKOe+lw8db/vHsw3ahyari6FlG57AQpmk=;
 b=7p4n8rcK/w5/y8wRbBuK63BbFQPw3HqJ5u+xe8VNlSJ+NWKH11fmQIQCl0kS43tySUeUyQ91J
 g7meNKlsF77DXv3Qauiyn9OrKgEA47L2o9uabz8jifm/mj7TKXWhKnE
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 08/13] Add statmount03 test
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

This test verifies that statmount() is correctly reading mount
information (mount id, parent mount id, mount attributes etc.)
using STATMOUNT_MNT_BASIC.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount.h   |  24 ++++
 testcases/kernel/syscalls/statmount/statmount03.c | 137 ++++++++++++++++++++++
 4 files changed, 163 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index e028baf19..ec11a3a21 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1570,6 +1570,7 @@ stat04_64 stat04_64
 
 statmount01 statmount01
 statmount02 statmount02
+statmount03 statmount03
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index a30b9565f..2a02bf721 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -1,2 +1,3 @@
 statmount01
 statmount02
+statmount03
diff --git a/testcases/kernel/syscalls/statmount/statmount.h b/testcases/kernel/syscalls/statmount/statmount.h
index e807c8288..5cd54242c 100644
--- a/testcases/kernel/syscalls/statmount/statmount.h
+++ b/testcases/kernel/syscalls/statmount/statmount.h
@@ -10,6 +10,7 @@
 #include "tst_test.h"
 #include "lapi/mount.h"
 #include "lapi/syscalls.h"
+#include "tst_safe_stdio.h"
 
 static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *buf,
 		     size_t bufsize, unsigned int flags)
@@ -23,4 +24,27 @@ static inline int statmount(uint64_t mnt_id, uint64_t mask, struct statmount *bu
 	return tst_syscall(__NR_statmount, &req, buf, bufsize, flags);
 }
 
+static inline int read_peer_group(const char *path)
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
+		if (strcmp(mroot, path) == 0)
+			break;
+	}
+
+	if (group == -1)
+		tst_brk(TBROK, "Can't reed peer group ID for %s", path);
+
+	return group;
+}
+
 #endif
diff --git a/testcases/kernel/syscalls/statmount/statmount03.c b/testcases/kernel/syscalls/statmount/statmount03.c
new file mode 100644
index 000000000..634c4b447
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount03.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading mount information
+ * (mount id, parent mount id, mount attributes etc.) using STATMOUNT_MNT_BASIC.
+ *
+ * [Algorithm]
+ *
+ * - create a mount point
+ * - create a new parent folder inside the mount point and obtain its mount info
+ * - create the new "/" mount folder and obtain its mount info
+ * - run statmount() on the mount point using STATMOUNT_MNT_BASIC
+ * - read results and check if mount info are correct
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define DIR_A "LTP_DIR_A"
+#define DIR_B "LTP_DIR_B"
+
+static uint64_t mnt_id;
+static uint64_t mnt_id_old;
+static uint64_t parent_id;
+static uint64_t parent_id_old;
+static uint64_t mnt_peer_group;
+static uint64_t mnt_master;
+static struct statmount *st_mount;
+
+static void read_mnt_id(
+	const char *path,
+	uint64_t *mnt_id,
+	uint64_t *mnt_id_unique)
+{
+	struct ltp_statx sx;
+
+	if (mnt_id) {
+		SAFE_STATX(AT_FDCWD, path, 0, STATX_MNT_ID, &sx);
+		*mnt_id = sx.data.stx_mnt_id;
+	}
+
+	if (mnt_id_unique) {
+		SAFE_STATX(AT_FDCWD, path, 0, STATX_MNT_ID_UNIQUE, &sx);
+		*mnt_id_unique = sx.data.stx_mnt_id;
+	}
+}
+
+static struct tcase {
+	uint64_t prop_type;
+	char *msg;
+} tcases[] = {
+	{ MS_PRIVATE, TST_TO_STR_(MS_PRIVATE) },
+	{ MS_SHARED, TST_TO_STR_(MS_SHARED) },
+	{ MS_SLAVE, TST_TO_STR_(MS_SLAVE) },
+	{ MS_UNBINDABLE, TST_TO_STR_(MS_UNBINDABLE) },
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	tst_res(TINFO,  "Testing statmount() on %s", tc->msg);
+
+	SAFE_MOUNT(DIR_B, DIR_A, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_A, "none", tc->prop_type, NULL);
+	read_mnt_id(DIR_A, &mnt_id_old, &mnt_id);
+
+	memset(st_mount, 0, sizeof(struct statmount));
+
+	TST_EXP_PASS(statmount(mnt_id, STATMOUNT_MNT_BASIC, st_mount,
+		sizeof(struct statmount), 0));
+
+	SAFE_UMOUNT(DIR_A);
+
+	if (TST_RET == -1)
+		return;
+
+	/* s->sm.mnt_peer_group = IS_MNT_SHARED(m) ? m->mnt_group_id : 0;
+	 * s->sm.mnt_master = IS_MNT_SLAVE(m) ? m->mnt_master->mnt_group_id : 0;
+	 */
+	mnt_peer_group = tc->prop_type == MS_SHARED ? read_peer_group(DIR_A) : 0;
+	mnt_master = tc->prop_type == MS_SLAVE ? read_peer_group(DIR_A) : 0;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_BASIC);
+	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
+	TST_EXP_EQ_LI(st_mount->mnt_id, mnt_id);
+	TST_EXP_EQ_LI(st_mount->mnt_id_old, mnt_id_old);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id, parent_id);
+	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, parent_id_old);
+	TST_EXP_EQ_LU(st_mount->mnt_propagation & tc->prop_type, tc->prop_type);
+	TST_EXP_EQ_LI(st_mount->mnt_master, mnt_master);
+	TST_EXP_EQ_LI(st_mount->mnt_peer_group, mnt_peer_group);
+}
+
+static void setup(void)
+{
+	SAFE_MKDIR(DIR_A, 0700);
+	SAFE_MKDIR(DIR_B, 0700);
+
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_MOUNT("none", "/", "none", MS_REC | MS_PRIVATE, NULL);
+
+	SAFE_MOUNT(DIR_B, DIR_B, "none", MS_BIND, NULL);
+	SAFE_MOUNT("none", DIR_B, "none", MS_SHARED, NULL);
+
+	read_mnt_id(DIR_A, &parent_id_old, &parent_id);
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(DIR_B))
+		SAFE_UMOUNT(DIR_B);
+
+	if (tst_is_mounted(DIR_A))
+		SAFE_UMOUNT(DIR_A);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.8",
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = sizeof(struct statmount)},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
