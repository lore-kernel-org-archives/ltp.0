Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEA0C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 11:44:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4D903C57AC
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 13:44:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BB513C59DD
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3ACF1400C77
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 13:36:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5AD686E90
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z71vVXWXuFtYp8ls8VIfRMxo0PTOT+vxtiz78zSTYZg=;
 b=quBx7PNun/ps0/4FT3COB6Kxd4MLvKZFjucoObLkRC1KIT7FlkDbAghp0pDBkNcz9wQ19p
 QisjmTcrimgsEoiTT/ILY9RDYwHbZr2eadLdR1kGf1LGhwki6uzSmezZd13rzWYdiWyD5C
 kLMf5GYu05NtGexKQP9PHXT8Jmo6hIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z71vVXWXuFtYp8ls8VIfRMxo0PTOT+vxtiz78zSTYZg=;
 b=Aoz34mQFGNc/L6pOKkY31IiaIMQJzCxs8jj0AaA94bGqVIp8OT2epmpqaS9ZA24D7aGfdp
 4tv+QVBo6eGBGrCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787657806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z71vVXWXuFtYp8ls8VIfRMxo0PTOT+vxtiz78zSTYZg=;
 b=WFUMBnDQ2ldm4ChYutv/KdrISk2VVTDcJW9RQijiqqmwdm8A8llMsWJy/wLd6S0SvOuPj5
 RWyisEa4vXIoJS6pxOwP6LGBL8q7LRsOQcB1j7VZK2Nv2dBW56KA+3TQrYmEUMhDeYJZR8
 Gmd2vPNgaJwlU1KsCK0ZMeA1cCx8HMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787657806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z71vVXWXuFtYp8ls8VIfRMxo0PTOT+vxtiz78zSTYZg=;
 b=nAcHLkIH1zBt86Qc1xx0ihVJIlhswIihjgEd7P2S4mKBz9c9s08LVNRqigRHsQbAMtgKsG
 PVtZExsec377EnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3B931339C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v4zKMk5+jWpySQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 11:36:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 13:36:22 +0200
Message-ID: <20260825113625.1624134-29-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825113625.1624134-1-chrubis@suse.cz>
References: <20260825113625.1624134-1-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 28/31] testcases: sysfs: Add sys_hugepages02
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

A test for /sys/kernel/mm/hugepages/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../sysfs/kernel/mm/hugepages/.gitignore      |  1 +
 .../kernel/mm/hugepages/sys_hugepages02.c     | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c

diff --git a/runtest/sysfs b/runtest/sysfs
index a81fbc12e..ec38d8b44 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -23,3 +23,4 @@ sys_block_loop01 sys_block_loop01
 sys_block_queue01 sys_block_queue01
 sys_block_size01 sys_block_size01
 sys_hugepages01 sys_hugepages01
+sys_hugepages02 sys_hugepages02
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
index 1c66028fb..1bebeb2c0 100644
--- a/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
@@ -1 +1,2 @@
 /sys_hugepages01
+/sys_hugepages02
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c
new file mode 100644
index 000000000..29d89d491
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages02.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Cross-checks the default hugepage pool in sysfs against /proc/meminfo.
+ *
+ * /proc/meminfo describes the default hugepage size pool, which corresponds to
+ * one of the hugepages-<size>kB directories under /sys/kernel/mm/hugepages/.
+ * The test verifies that for the default pool:
+ *
+ * - Hugepagesize in /proc/meminfo matches the default pool directory size
+ * - HugePages_Total matches nr_hugepages
+ * - HugePages_Free matches free_hugepages
+ * - HugePages_Rsvd matches resv_hugepages
+ * - HugePages_Surp matches surplus_hugepages
+ *
+ * The test skips with TCONF when hugepages are not available.
+ */
+
+#include <stdio.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define HUGEPAGES "/sys/kernel/mm/hugepages"
+
+static void compare(const char *what, const char *meminfo_key, const char *attr,
+		    long hugepagesize)
+{
+	char path[PATH_MAX];
+	long meminfo_val, sysfs_val;
+
+	SAFE_FILE_LINES_SCANF("/proc/meminfo", meminfo_key, &meminfo_val);
+
+	snprintf(path, sizeof(path), HUGEPAGES "/hugepages-%ldkB/%s",
+		 hugepagesize, attr);
+	SAFE_FILE_SCANF(path, "%ld", &sysfs_val);
+
+	if (meminfo_val == sysfs_val) {
+		tst_res(TPASS, "%s: /proc/meminfo (%ld) == %s (%ld)",
+			what, meminfo_val, attr, sysfs_val);
+	} else {
+		tst_res(TFAIL, "%s: /proc/meminfo (%ld) != %s (%ld)",
+			what, meminfo_val, attr, sysfs_val);
+	}
+}
+
+static void do_test(void)
+{
+	long hugepagesize;
+
+	SAFE_FILE_LINES_SCANF("/proc/meminfo", "Hugepagesize: %ld",
+			      &hugepagesize);
+
+	if (!tst_sysfs_exists(HUGEPAGES "/hugepages-%ldkB", hugepagesize)) {
+		tst_res(TCONF,
+			"Default hugepage pool hugepages-%ldkB not found in sysfs",
+			hugepagesize);
+		return;
+	}
+
+	tst_res(TPASS,
+		"/proc/meminfo Hugepagesize (%ld kB) has a matching sysfs pool",
+		hugepagesize);
+
+	compare("HugePages_Total", "HugePages_Total: %ld",
+		"nr_hugepages", hugepagesize);
+	compare("HugePages_Free", "HugePages_Free: %ld",
+		"free_hugepages", hugepagesize);
+	compare("HugePages_Rsvd", "HugePages_Rsvd: %ld",
+		"resv_hugepages", hugepagesize);
+	compare("HugePages_Surp", "HugePages_Surp: %ld",
+		"surplus_hugepages", hugepagesize);
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_HUGETLBFS=y",
+		NULL
+	},
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
