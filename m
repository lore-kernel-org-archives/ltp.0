Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5714EC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:29:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC9613D8761
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:29:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E62A3D2321
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AA9E0140015F
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 750F921967
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOWYuZ+MsZZg6Yfq1s6RwKGswgXBpxmbvL7KscgMKDc=;
 b=SYTFBkIt2N0eXA+KMzea4j1xUZZOCs+P7Gb8dDUBAdRUw+Q8SsQO5ZR284u53zVNo2Ka+D
 Lbs46cBRfciRoIv3nE9gFrdSPDaeHG1/DKyqVIx1u0m4Qgn+9GxK0ZtUB+2xV+dqP109zW
 2PpKptp+jAxQiLd5/0kDtLorwXtGEI4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOWYuZ+MsZZg6Yfq1s6RwKGswgXBpxmbvL7KscgMKDc=;
 b=85M4S0DMo0EBvrCcbhNtzSW3uutxYFXt4JFxI1YsDNSPL6D8qOe6nU4tIb0/o6vWsre5tb
 y1PwlDLmm4DM/tBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOWYuZ+MsZZg6Yfq1s6RwKGswgXBpxmbvL7KscgMKDc=;
 b=PAnajnRg154d+kC+xX4RZPOFnRuhnJ49eFnkeMlyYI8IksYugwpx7LuUJTGMUhnjb7CmGm
 h77vRQe895tybipvSFGgZfryj7ONqfEqKCl5zJSQ/H9pszd6qw2HS8P2k6kvvZVtqn/m1O
 e5StW//4IitGWL+xFWR75skUFxElBwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829753;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XOWYuZ+MsZZg6Yfq1s6RwKGswgXBpxmbvL7KscgMKDc=;
 b=BhvBEalb7TB+CBwJJfA6VzEg0HhJyQlqLvw+Yw85hH5oe+z7CNz3iivsIgDU7oRoKQRV8M
 3aFLdScSxmORPBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49A1113354
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cYdWEPgdkGqnawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:32 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:52 +0200
Message-ID: <20260827112157.1748734-27-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 26/31] testcases: sysfs: Add sys_block_size01
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

A test for /sys/block/*/{ro, size} files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/block/.gitignore       |   1 +
 .../kernel/sysfs/block/sys_block_size01.c     | 101 ++++++++++++++++++
 3 files changed, 103 insertions(+)
 create mode 100644 testcases/kernel/sysfs/block/sys_block_size01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index f7d35e0c2..46593b82f 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -21,3 +21,4 @@ sys_net03 sys_net03
 sys_net04 sys_net04
 sys_block_loop01 sys_block_loop01
 sys_block_queue01 sys_block_queue01
+sys_block_size01 sys_block_size01
diff --git a/testcases/kernel/sysfs/block/.gitignore b/testcases/kernel/sysfs/block/.gitignore
index c7011b79f..9fd4a1d82 100644
--- a/testcases/kernel/sysfs/block/.gitignore
+++ b/testcases/kernel/sysfs/block/.gitignore
@@ -1,2 +1,3 @@
 /sys_block_loop01
 /sys_block_queue01
+/sys_block_size01
diff --git a/testcases/kernel/sysfs/block/sys_block_size01.c b/testcases/kernel/sysfs/block/sys_block_size01.c
new file mode 100644
index 000000000..9ac228115
--- /dev/null
+++ b/testcases/kernel/sysfs/block/sys_block_size01.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Cross-checks the block device size reported in sysfs against /proc/partitions.
+ *
+ * /sys/block/<dev>/size holds the device size in 512 byte sectors while
+ * /proc/partitions lists the size in 1024 byte blocks. For every whole block
+ * device the test verifies that:
+ *
+ * - the two sources agree, i.e. sysfs_size_in_sectors / 2 == proc_blocks
+ * - the ro (read-only) attribute is a boolean
+ *
+ * The test skips with TCONF when a device is not present in /proc/partitions
+ * (for example device-mapper devices that are only listed under /sys/block).
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "tst_sysfs_assert.h"
+#include "tst_path_defs.h"
+
+static int proc_partition_blocks(const char *dev, long long *blocks)
+{
+	FILE *f;
+	char line[4096];
+	int found = 0;
+
+	f = SAFE_FOPEN("/proc/partitions", "r");
+
+	while (fgets(line, sizeof(line), f)) {
+		long long nblocks;
+		char name[256];
+
+		if (sscanf(line, "%*u %*u %lld %255s", &nblocks, name) != 2)
+			continue;
+
+		if (!strcmp(name, dev)) {
+			*blocks = nblocks;
+			found = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(f);
+
+	return found;
+}
+
+static void check_device(const char *dev)
+{
+	long long sectors, proc_blocks;
+
+	tst_res(TINFO, "Checking block device '%s'", dev);
+
+	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/ro", dev);
+
+	if (!proc_partition_blocks(dev, &proc_blocks)) {
+		tst_res(TCONF, "%s not listed in /proc/partitions", dev);
+		return;
+	}
+
+	sectors = TST_SYSFS_READ_LLI(PATH_SYS_BLOCK "/%s/size", dev);
+
+	/* sysfs size is in 512 byte sectors, /proc/partitions in 1024 byte blocks */
+	if (sectors / 2 == proc_blocks) {
+		tst_res(TPASS,
+			"%s: sysfs size %lld sectors matches /proc/partitions %lld blocks",
+			dev, sectors, proc_blocks);
+	} else {
+		tst_res(TFAIL,
+			"%s: sysfs size %lld sectors (/2 = %lld) != /proc/partitions %lld blocks",
+			dev, sectors, sectors / 2, proc_blocks);
+	}
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+
+	d = TST_SYSFS_TRY_OPENDIR(PATH_SYS_BLOCK);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		check_device(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
