Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67080C25B78
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:31:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6B443CF9E6
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:31:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D7D23CF97F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 88EA41A0123D
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8CBC5C357
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN4lTr1ZNgLCcs5/K3J2RfJtYxeZHwhoeH4gCpIzH2s=;
 b=P9dHX94AjWFP8yeYeyKhM6C7UilJ9sMOi+0b/oa9iYThhzs95QBZRUzewomAIigUgRya8f
 bTEXNuN+7SAGi1Ag3gxF9jaDokIZuhOrfNklAeWJqSrZHlg9MwGH37eixLYxTttIskXp7B
 PzIEVxifzha3rHxW8MdQCYKyEe9aEig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN4lTr1ZNgLCcs5/K3J2RfJtYxeZHwhoeH4gCpIzH2s=;
 b=1qDXsCa5lpjQCplK9btTuSd25P+2KiDnR1smbr8gXMY8AZnwvKu08pCPtiqicPt2ex6Gj8
 W3TyvvWWIrh8JhCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=P9dHX94A;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1qDXsCa5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN4lTr1ZNgLCcs5/K3J2RfJtYxeZHwhoeH4gCpIzH2s=;
 b=P9dHX94AjWFP8yeYeyKhM6C7UilJ9sMOi+0b/oa9iYThhzs95QBZRUzewomAIigUgRya8f
 bTEXNuN+7SAGi1Ag3gxF9jaDokIZuhOrfNklAeWJqSrZHlg9MwGH37eixLYxTttIskXp7B
 PzIEVxifzha3rHxW8MdQCYKyEe9aEig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN4lTr1ZNgLCcs5/K3J2RfJtYxeZHwhoeH4gCpIzH2s=;
 b=1qDXsCa5lpjQCplK9btTuSd25P+2KiDnR1smbr8gXMY8AZnwvKu08pCPtiqicPt2ex6Gj8
 W3TyvvWWIrh8JhCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8C0213991
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ABPyJy/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:18 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-10-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4566;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=/DQLB3VToWHb6kcU3+8m//HwaL2/mHjFsY7WFdLzq9o=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwuRdwND/KUaa9g95iaG07hIJVyK2Xknqk3S
 VghQrdxNUyJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 RtonC/wOoTmsllO0yGLBxZ/OcpTc4MVbk2+dexKNs8KiAJ4n+dH8eKZ2AK0de4bd+rPoePc3rn5
 IazLIMyZpGZShHK+GPtldqzSJYgK96iVHiSNg2MddNBZjYP4D4nK7h2y212dWFxdRps/eJZVMur
 JKq5rynXzBQybzu8r6NsI9yMy5p9snXRhRECPiHRkGSmAdz01B6gYEb1Y4dp0lsxDeJfsFEQasE
 MY3x7Wxm488XAgdMRafUz8NdEuNdAdGi5lxjR/CkvIDYGm05/OwdT5XqWMm6II2FBmWbGrhIio+
 9O8L93bK3ZqH+IdHbNBypm2qnO//Etq3KO7bWMND9df+pmxN4NWWfAEKkQPXp871gDpSSWYhd4q
 OmX5qsUpaaMz3BQ4X3YUkrtdqLuihFDNWOzeOHGOIDQR8AdaRcF+74vNk6v23MWnGiGo4M4BeSz
 rg5IoV2Bwe7NHX8N0VOdcLQbe/gxCA9kUJTxSQJPAFArJfD6Ti4qTrQogCXQWvO/N1NFM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B8CBC5C357
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 10/11] Add statmount05 test
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

This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT
functionalities of statmount().
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/statmount/.gitignore    |   1 +
 testcases/kernel/syscalls/statmount/statmount05.c | 136 ++++++++++++++++++++++
 3 files changed, 138 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 81c2f9740..b04aabc6f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1542,6 +1542,7 @@ statmount01 statmount01
 statmount02 statmount02
 statmount03 statmount03
 statmount04 statmount04
+statmount05 statmount05
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index e720050b5..f64763242 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -2,3 +2,4 @@ statmount01
 statmount02
 statmount03
 statmount04
+statmount05
diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
new file mode 100644
index 000000000..61ac462e1
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount05.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies STATMOUNT_MNT_ROOT and STATMOUNT_MNT_POINT functionalities
+ * of statmount(). In particular, STATMOUNT_MNT_ROOT will give the mount root
+ * (i.e. mount --bind /mnt /bla -> /mnt) and STATMOUNT_MNT_POINT will
+ * give the mount point (i.e. mount --bind /mnt /bla -> /bla).
+ *
+ * [Algorithm]
+ *
+ * * create a mount point
+ * * mount a folder inside the mount point
+ * * run statmount() on the mounted folder using STATMOUNT_MNT_ROOT
+ * * read results and check if contain the mount root path
+ * * run statmount() on the mounted folder using STATMOUNT_MNT_POINT
+ * * read results and check if contain the mount point path
+ */
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define DIRA MNTPOINT "/LTP_DIR_A"
+#define DIRB MNTPOINT "/LTP_DIR_B"
+#define SM_SIZE (1 << 10)
+
+static uint64_t root_id;
+static struct statmount *st_mount;
+static char mnt_root[PATH_MAX];
+static char mnt_point[PATH_MAX];
+
+static void test_mount_root(void)
+{
+	tst_res(TINFO, "Testing STATMOUNT_MNT_ROOT");
+
+	char *last_root;
+
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_PASS(statmount(
+		root_id,
+		STATMOUNT_MNT_ROOT,
+		st_mount,
+		SM_SIZE,
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	last_root = strrchr(mnt_root, '/');
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_ROOT);
+	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_root, last_root) == 0,
+		"statmount() read '%s', expected '%s'",
+		st_mount->str + st_mount->mnt_root,
+		last_root);
+}
+
+static void test_mount_point(void)
+{
+	tst_res(TINFO, "Testing STATMOUNT_MNT_POINT");
+
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_POSITIVE(statmount(
+		root_id,
+		STATMOUNT_MNT_POINT,
+		st_mount,
+		SM_SIZE,
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_POINT);
+	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->mnt_point, mnt_point) == 0,
+		"mount point is '%s'",
+		st_mount->str + st_mount->mnt_point);
+}
+
+static void run(void)
+{
+	test_mount_root();
+	test_mount_point();
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+	struct statx sx;
+
+	tmpdir = tst_get_tmpdir();
+	snprintf(mnt_root, PATH_MAX, "%s/%s", tmpdir, DIRA);
+	snprintf(mnt_point, PATH_MAX, "%s/%s", tmpdir, DIRB);
+	free(tmpdir);
+
+	SAFE_MKDIR(mnt_root, 0700);
+	SAFE_MKDIR(mnt_point, 0700);
+	SAFE_MOUNT(mnt_root, mnt_point, "none", MS_BIND, NULL);
+
+	SAFE_STATX(AT_FDCWD, mnt_point, 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.stx_mnt_id;
+}
+
+static void cleanup(void)
+{
+	if (tst_is_mounted(DIRB))
+		SAFE_UMOUNT(DIRB);
+
+	if (tst_is_mounted(DIRA))
+		SAFE_UMOUNT(DIRA);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = SM_SIZE},
+		{}
+	}
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
