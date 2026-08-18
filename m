Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384EAC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:20:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B16AF3CC8C1
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:20:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5B7D3CD51F
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ECE7E10006B7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:14:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F8CB845AA
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=dlUmuuR5buTyR5bm/1mrBOctlqcAwuuN3U7mFWB651ckKb7rxnkxP/OUtwScktj0slz0UC
 tFaop2oJ06uJ96Z6CjFgUKygeJRofEoqF/K6nIFNxgOMBR4w/IXxPCMTxMItye0t6H15uW
 3LoaVWlrFcZvu1W4glB4VuHnF9+5R0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=6WUedW6X7G/7TSe8Fp32GsyHH9OBzn37tFv0HfJIrhwJct63PvVKAbdlFFQMw9pNmfeA4k
 Eh8H9ncQ9tv87gDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L+4bwiiV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jn8jmH21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=L+4bwiiV8stwX/rfmdFFk4HDWWjKdTe2+4ijBsvUN/hLKCGxmYwcnR2vkaRDIpZFasVCID
 nWK25MCGR5ABXIohKTdtQGxObpIHbibw3ylk+Vhg4NAEA3sOVrK38XImyfpWJMglZVTOaE
 cMDlNYK5q8SJHNUAaJzRZlkMpk50re0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=jn8jmH21fk/oQpuItauXqY0+4tqwUXFIdB2CvWHgAHEqx3zaurOIoU9JZDVNpNLbwwJiBV
 6Aj0ESHfXGvL3ECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59220367C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOjLFJ5ohGrBcQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:50 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:13:07 +0200
Message-ID: <20260818141311.1265557-28-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2F8CB845AA
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 27/31] testcases: sysfs: Add sys_hugepages01
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

A test for /sys/kernel/mm/hugepages/hugepages-*/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/kernel/mm/Makefile     |   7 +
 .../sysfs/kernel/mm/hugepages/.gitignore      |   1 +
 .../kernel/sysfs/kernel/mm/hugepages/Makefile |   7 +
 .../kernel/mm/hugepages/sys_hugepages01.c     | 133 ++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/sysfs/kernel/mm/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/Makefile
 create mode 100644 testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 46593b82f..a81fbc12e 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -22,3 +22,4 @@ sys_net04 sys_net04
 sys_block_loop01 sys_block_loop01
 sys_block_queue01 sys_block_queue01
 sys_block_size01 sys_block_size01
+sys_hugepages01 sys_hugepages01
diff --git a/testcases/kernel/sysfs/kernel/mm/Makefile b/testcases/kernel/sysfs/kernel/mm/Makefile
new file mode 100644
index 000000000..9bc26552c
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
new file mode 100644
index 000000000..1c66028fb
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/.gitignore
@@ -0,0 +1 @@
+/sys_hugepages01
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/Makefile b/testcases/kernel/sysfs/kernel/mm/hugepages/Makefile
new file mode 100644
index 000000000..781865569
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages01.c b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages01.c
new file mode 100644
index 000000000..13bcec3fc
--- /dev/null
+++ b/testcases/kernel/sysfs/kernel/mm/hugepages/sys_hugepages01.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the hugepage pool attributes exported under
+ * /sys/kernel/mm/hugepages/.
+ *
+ * Each supported hugepage size has its own hugepages-<size>kB directory with a
+ * set of counters describing its pool. For each such directory the test
+ * verifies that:
+ *
+ * - the size encoded in the directory name is a power of two (in kB)
+ * - nr_hugepages, free_hugepages, resv_hugepages and surplus_hugepages are
+ *   all non-negative
+ * - free_hugepages <= nr_hugepages + surplus_hugepages (the free count cannot
+ *   exceed the total pool)
+ * - resv_hugepages <= free_hugepages (reserved pages are a subset of free)
+ *
+ * All checks skip gracefully with TCONF when a particular attribute is not
+ * present.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <limits.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define HUGEPAGES "/sys/kernel/mm/hugepages"
+
+static int read_count(const char *dir, const char *attr, long *val)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), HUGEPAGES "/%s/%s", dir, attr);
+
+	if (access(path, F_OK))
+		return 1;
+
+	if (FILE_SCANF(path, "%ld", val))
+		return 1;
+
+	return 0;
+}
+
+static void check_size(const char *dir)
+{
+	long size;
+
+	if (sscanf(dir, "hugepages-%ldkB", &size) != 1) {
+		tst_res(TFAIL, "Malformed hugepage directory name '%s'", dir);
+		return;
+	}
+
+	if (size > 0 && !(size & (size - 1))) {
+		tst_res(TPASS, "%s: size %ld kB is a power of two", dir, size);
+	} else {
+		tst_res(TFAIL, "%s: size %ld kB is not a power of two",
+			dir, size);
+	}
+}
+
+static void check_counts(const char *dir)
+{
+	long nr, free, resv, surplus;
+
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, HUGEPAGES "/%s/nr_hugepages", dir);
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, HUGEPAGES "/%s/free_hugepages", dir);
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX, HUGEPAGES "/%s/resv_hugepages", dir);
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
+			       HUGEPAGES "/%s/surplus_hugepages", dir);
+
+	if (read_count(dir, "nr_hugepages", &nr) ||
+	    read_count(dir, "free_hugepages", &free) ||
+	    read_count(dir, "surplus_hugepages", &surplus))
+		return;
+
+	if (free <= nr + surplus) {
+		tst_res(TPASS,
+			"%s: free_hugepages (%ld) <= nr_hugepages (%ld) + surplus_hugepages (%ld)",
+			dir, free, nr, surplus);
+	} else {
+		tst_res(TFAIL,
+			"%s: free_hugepages (%ld) > nr_hugepages (%ld) + surplus_hugepages (%ld)",
+			dir, free, nr, surplus);
+	}
+
+	if (read_count(dir, "resv_hugepages", &resv))
+		return;
+
+	if (resv <= free) {
+		tst_res(TPASS, "%s: resv_hugepages (%ld) <= free_hugepages (%ld)",
+			dir, resv, free);
+	} else {
+		tst_res(TFAIL, "%s: resv_hugepages (%ld) > free_hugepages (%ld)",
+			dir, resv, free);
+	}
+}
+
+static void run(void)
+{
+	DIR *d;
+	struct dirent *ent;
+	int found = 0;
+
+	d = SAFE_OPENDIR(HUGEPAGES);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (strncmp(ent->d_name, "hugepages-", 10))
+			continue;
+
+		found = 1;
+		tst_res(TINFO, "Checking hugepage pool '%s'", ent->d_name);
+		check_size(ent->d_name);
+		check_counts(ent->d_name);
+	}
+
+	SAFE_CLOSEDIR(d);
+
+	if (!found)
+		tst_res(TCONF, "No hugepage pools found");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_HUGETLBFS=y",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
