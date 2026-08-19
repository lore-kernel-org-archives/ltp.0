Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB84C5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:23:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29B63C9B32
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:23:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17F843C731E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9144B60084E
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:17:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5B2C84C17
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=odVspZbjvM4C3gVAEXqmlfEjSQFnhOWClILRTjTiRIsMr+uelCu3enM3054vtC9Ayc5Qwu
 5H4Nj5EDDdFV0oa+teKxr/XtgEHOEfEyEupmIUvAs32/QLjW3zvVgi8XK4B3muzx1g70qp
 kdUir64IibXJIafBCZJwKJ4/m8ho/6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=JQYAtDa7QB9EcCbzNydIptPkJdHXoOOSHjUVhx9Zc7YPygCVIz56gq2A1CH+895k87jS+i
 qlOR46zjLtRXHWDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=OYojTTWbLtMGE4hDahRFcvsUgb4iVhO9HkLqVND1xcTEI65AYsD447uBOkbJjkhM41xw/F
 zThYHCvHCX2iW6tQk/xteyk8vMcAKlMg61AlGRFnE4btIJ8mZ1BQo82vZwC9t3vNMJs66R
 JTWyYFVmY1Vrc2WWOxjVg1yUpQ0s/sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjbHy8WNzGi6/IhksuujVi03EXDcQTvnlITbQcfLjc8=;
 b=3zbxyFrbnjbkqlT0o+oUGyU2Po1LvuHL477/uiqNm4Awhz5SsJ7J571t5jWBCj93BPj8fq
 VUwiHlCmtnP4IoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80E5367B
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 16PWM/zWhWq6cwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:17:00 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:30 +0200
Message-ID: <20260819161634.1341577-28-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.952];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 27/31] testcases: sysfs: Add sys_hugepages01
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
