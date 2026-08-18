Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F26AC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:21:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18EB23CD674
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:21:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E04523CD55A
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E59671400063
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 31B9B845BE
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwnhudhnNW9ErVivdSkrjYoThetlAW+L1YhV4rhTD1k=;
 b=0x2OIO7ZHENNKlx4ll9ZZiT+UPOm6W3YiX/3Cgr52M93j4+jAVjUInqWtpdOs+Is1elI2c
 PxrdkhdaXFB7/qfHwJebEW0cGnCw8wOBHzVsIQo/1d1BJBnd+uMKQPQPLLXDMk6GKZBN+d
 OjlR9TNIESTEuXk32Vri5jD/8PRMD0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwnhudhnNW9ErVivdSkrjYoThetlAW+L1YhV4rhTD1k=;
 b=B8lenZpc0COWwL7VfI2GvAVPW39RmSqFw/7G1jZTeHz1JXQgVsYG1X0EUuDUWMZnEbUzZp
 rs32D727056Y72Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwnhudhnNW9ErVivdSkrjYoThetlAW+L1YhV4rhTD1k=;
 b=0LvzvdmflVYE+H6OLT+198znvP6ASaZfZV9oSQTVsrL36CBiCXcrcGI5d3iONdME4A/kHm
 ZMeQsmnaMLO5WWYfRSttT8eVX68IdDLQQMmIE6nVF7Q6bg8ii8VbGAmwj4gYmtyrFtQgyJ
 pOhDYs1AfRDTe9T7VDLXNbF1Kfqh2CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AwnhudhnNW9ErVivdSkrjYoThetlAW+L1YhV4rhTD1k=;
 b=DDHas8cHEk2AeQ7U21eR1ZVgoVoJkqjtwN6QwYy5FvF9Uot+4b3rl13csAXIQFc8JOY8X+
 1P0gGss5n7HWUSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E94C8367B
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZfADOJ1ohGq/cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:06 +0200
Message-ID: <20260818141311.1265557-27-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 26/31] testcases: sysfs: Add sys_block_size01
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
 .../kernel/sysfs/block/sys_block_size01.c     | 102 ++++++++++++++++++
 3 files changed, 104 insertions(+)
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
index 000000000..c376d3a6c
--- /dev/null
+++ b/testcases/kernel/sysfs/block/sys_block_size01.c
@@ -0,0 +1,102 @@
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
+
+#define SYS_BLOCK "/sys/block"
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
+		if (sscanf(line, "%*u %*u %lld %255s", &nblocks, name) != 4)
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
+	TST_SYSFS_ASSERT_BOOL(SYS_BLOCK "/%s/ro", dev);
+
+	if (!proc_partition_blocks(dev, &proc_blocks)) {
+		tst_res(TCONF, "%s not listed in /proc/partitions", dev);
+		return;
+	}
+
+	sectors = TST_SYSFS_READ_LLI(SYS_BLOCK "/%s/size", dev);
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
+	d = SAFE_OPENDIR(SYS_BLOCK);
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
