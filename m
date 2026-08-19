Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8395DC5DF81
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 16:19:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 302C83CD62C
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 18:19:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BA8B3CD638
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 471741000964
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 18:16:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2C5284C12
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=XJr1ri2g5GJ5l8hkuNUqSLNLbkWnVBTEbK/f4FRvzKVqfg3a1SbrBUBW5pRl5xvYRZaZQi
 qPp8oa3yHVZAO4CuSx5XdkFu0MVaUogSYsMXvbve02xz1udTwltPConmgyiYaZi3RqJSsB
 YtvwyWe2RROSXNTcw0kZik5Hb5Bj2jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156210;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=qyp2Rz7O3ZJToNVfs+18dbsFCJ5tG5/EKMcLi0BnLulibL/B7hD6/dpow1edJvlgnFyb8q
 EXDYn0tWbwP6dWAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787156206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=bsIMHDPJZy8rvJpw5Dbw5nrWsssE8TIX8VwABfeVov6caPgEiRVPU9NGX6/hpjOHrv64KY
 4pLxeFzgETgTtOM0igK2Rm9z5OWO0SlxKxpLUTALayDseLzSRMjVaabuGyD2o4K8iEuxk6
 rIEX0/HnV/+wYi9V9o1zwbixvo4xv9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787156206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=MMbCF97mnkirBj9vi8jcMaKukfeKnZDqElBgcXG9Vsc1ubAcqC4lGCYT4gUM7c69LLopuT
 DAlkcRmb3w5xkYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 485C7367F
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IfDlEOnWhWr5cgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 16:16:41 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Aug 2026 18:16:11 +0200
Message-ID: <20260819161634.1341577-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819161634.1341577-1-chrubis@suse.cz>
References: <20260819161634.1341577-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.951];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/31] testcases: sysfs: Add
 sys_cpu_vulnerabilities01
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

A test for /sys/devices/system/cpu/vulnerabilities/* files.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |  1 +
 .../sysfs/devices/system/cpu/.gitignore       |  1 +
 .../system/cpu/sys_cpu_vulnerabilities01.c    | 85 +++++++++++++++++++
 3 files changed, 87 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index b1daab68f..663c1d203 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -4,3 +4,4 @@ sys_clocksource01 sys_clocksource01
 sys_node01 sys_node01
 sys_cpu_topology01 sys_cpu_topology01
 sys_cpu_topology02 sys_cpu_topology02
+sys_cpu_vulnerabilities01 sys_cpu_vulnerabilities01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/.gitignore b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
index a688a9b50..3ae5f494f 100644
--- a/testcases/kernel/sysfs/devices/system/cpu/.gitignore
+++ b/testcases/kernel/sysfs/devices/system/cpu/.gitignore
@@ -1,2 +1,3 @@
 /sys_cpu_topology01
 /sys_cpu_topology02
+/sys_cpu_vulnerabilities01
diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c
new file mode 100644
index 000000000..ae1bb8b7c
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Sanity checks for the CPU vulnerability reports exported under
+ * /sys/devices/system/cpu/vulnerabilities/.
+ *
+ * Each file describes the status of one hardware vulnerability. The kernel
+ * always prints a human readable status that starts with one of a few known
+ * prefixes. The test verifies that every vulnerability file:
+ *
+ * - is non-empty
+ * - starts with one of the known status prefixes (Not affected, Vulnerable,
+ *   Mitigation:, Unknown, Processor vulnerable)
+ *
+ * The test skips with TCONF when the vulnerabilities directory is not present,
+ * which is the case on architectures that do not report them.
+ */
+
+#include <string.h>
+#include <dirent.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_sysfs_assert.h"
+
+#define VULN "/sys/devices/system/cpu/vulnerabilities"
+
+static const char *const known_prefixes[] = {
+	"Not affected",
+	"Vulnerable",
+	"Mitigation:",
+	"Unknown",
+	"Processor vulnerable",
+};
+
+static void check_vuln(const char *name)
+{
+	char status[256] = "";
+	unsigned int i;
+
+	TST_SYSFS_READ_STR(status, sizeof(status), VULN "/%s", name);
+
+	if (status[0] == '\0') {
+		tst_res(TFAIL, "%s/%s is empty", VULN, name);
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(known_prefixes); i++) {
+		if (!strncmp(status, known_prefixes[i],
+			     strlen(known_prefixes[i]))) {
+			tst_res(TPASS, "%s: '%s'", name, status);
+			return;
+		}
+	}
+
+	tst_res(TFAIL, "%s has unexpected status '%s'", name, status);
+}
+
+static void do_test(void)
+{
+	DIR *d;
+	struct dirent *ent;
+
+	if (access(VULN, F_OK)) {
+		tst_res(TCONF, VULN " is not available");
+		return;
+	}
+
+	d = SAFE_OPENDIR(VULN);
+
+	while ((ent = SAFE_READDIR(d))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		check_vuln(ent->d_name);
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
