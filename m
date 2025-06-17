Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF56C71136
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 12:46:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E94C3CC2B9
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 14:46:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8D403CB29D
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CAF911A00806
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 14:45:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0174B1F79D;
 Tue, 17 Jun 2025 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nY9Te/qSe5/M39qHmpbLmdKUVz3Yq6eS6AGUI8WHtUM=;
 b=pmZ9zyths6qZicuqtQkl4J1qWHueH8J1S0zfdYQxmPCdw6SqGEF2QW2zxtoowYZ6yd6gQF
 D9bjiUhtZHwKngc5D7dkq0lRQqZ/feBhQhg9dgUXeLttrjPVi405CUp/tGDGNW/emArj4W
 6xVtgRxjjbYGKq2CSx9IqnEvSdNGZqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nY9Te/qSe5/M39qHmpbLmdKUVz3Yq6eS6AGUI8WHtUM=;
 b=l09WEk3ISNjopGHQI8Po+HsW+A4x8kd0lrIt2WgY+FD6deoxyVAmUYyWmFIGEuDa3q8JvW
 A4unOyIDWRf2ynBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pmZ9zyth;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=l09WEk3I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750164338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nY9Te/qSe5/M39qHmpbLmdKUVz3Yq6eS6AGUI8WHtUM=;
 b=pmZ9zyths6qZicuqtQkl4J1qWHueH8J1S0zfdYQxmPCdw6SqGEF2QW2zxtoowYZ6yd6gQF
 D9bjiUhtZHwKngc5D7dkq0lRQqZ/feBhQhg9dgUXeLttrjPVi405CUp/tGDGNW/emArj4W
 6xVtgRxjjbYGKq2CSx9IqnEvSdNGZqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750164338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nY9Te/qSe5/M39qHmpbLmdKUVz3Yq6eS6AGUI8WHtUM=;
 b=l09WEk3ISNjopGHQI8Po+HsW+A4x8kd0lrIt2WgY+FD6deoxyVAmUYyWmFIGEuDa3q8JvW
 A4unOyIDWRf2ynBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2B5713AE1;
 Tue, 17 Jun 2025 12:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sKkpMXFjUWhRSQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 12:45:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 14:45:36 +0200
MIME-Version: 1.0
Message-Id: <20250617-statmount_mnt_ns_id-v1-3-d8d81637d73e@suse.com>
References: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
In-Reply-To: <20250617-statmount_mnt_ns_id-v1-0-d8d81637d73e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750164337; l=3198;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=0fnGUdKBQpL2an9niM0RSqUGqOhAxxpPSCxcz5j/0U4=;
 b=FnT+An34CHrmndgMjRvKj4zi7zpFuYe/8rFWNMV2J8YoTK+cO5t3kQn8Aa5LBkgZ37OTjGqfH
 IiQJbnYWRtfBfyfEa0QJcBrTkZxnQa4Rtv7DyfFikXeygs6EMTEO2Vs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0174B1F79D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Add statmount09 test
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

This test verifies that statmount() is correctly reading the mount ID for
the current namespace.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount09.c | 74 +++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d5582ca8da01f11adba75a56d22cb6e5c4996c68..fe4047161754b2c04f16e5cf69d4a5e94cb02d73 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1606,6 +1606,7 @@ statmount05 statmount05
 statmount06 statmount06
 statmount07 statmount07
 statmount08 statmount08
+statmount09 statmount09
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index 6106fcf07378b5360130e9d61d4150210eadf703..dc1b18963ffd18cdef18ebe3e94ee83a786f4352 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -6,3 +6,4 @@ statmount05
 statmount06
 statmount07
 statmount08
+statmount09
diff --git a/testcases/kernel/syscalls/statmount/statmount09.c b/testcases/kernel/syscalls/statmount/statmount09.c
new file mode 100644
index 0000000000000000000000000000000000000000..20c76ba24faee6c52a760bb85446c46bd68c056a
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount09.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * This test verifies that statmount() is correctly reading the mount ID for
+ * the current namespace.
+ *
+ * [Algorithm]
+ *
+ * - create a mount point
+ * - run statmount() on the mount point using STATMOUNT_MNT_NS_ID
+ * - read results and check if contain the correct mount ID for the current
+ *   namespace
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/ioctl_ns.h"
+
+#define MNTPOINT "mntpoint"
+#define SM_SIZE (1 << 10)
+
+static uint64_t root_id;
+static u_int64_t mnt_ns_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_PASS(statmount(root_id,	STATMOUNT_MNT_NS_ID, st_mount,
+		SM_SIZE, 0));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_NS_ID);
+	TST_EXP_EQ_LI(st_mount->mnt_ns_id, mnt_ns_id);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+	int fd;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+
+	fd = SAFE_OPEN("/proc/self/ns/mnt", O_RDONLY);
+	SAFE_IOCTL(fd, NS_GET_MNTNS_ID, &mnt_ns_id);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.11",
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
+

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
