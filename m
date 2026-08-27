Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEFCC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:24:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8EAE3D236B
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:24:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6F983D2321
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 71B481400125
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 754A41F8A3
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqRQrYMHEafVnpON6vXOIXrT5BS5diMLgMiZRiq17xY=;
 b=OiVKoSnI29uh/hTFxinax/LV03eWRwUBgnftARg1KwLPULkohZDnRqRilqX7pmf15mY/Gh
 LQoaPFxX/y+4RfvhD1jWzeZvVTZcQZJ7kBZRTBQqCzSg45/Ej+1LWt67OY2R2n3XrJJxiF
 VmMhtGa2iSHwnFSHo8bTxBVzXGbrJLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqRQrYMHEafVnpON6vXOIXrT5BS5diMLgMiZRiq17xY=;
 b=f5+UEhADDXWLfuAzNXBlua+bKqDvJuLk2tI8uANANTEJJUkS3Tea3TC0oVOSdy7O1G33vM
 TY2xyYP2YBuXI2CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqRQrYMHEafVnpON6vXOIXrT5BS5diMLgMiZRiq17xY=;
 b=fJyL6HyDm3KGwcP7fTS0zXrnIrimFGm9LpjW3VZ7qNeiGutkOBYSa+KFcA9G6alt3icIl+
 eZ4MqoywkzTNsAS8AOx3JKaIdgEeuHEV0za1HJI2hPFyBv1+fKAQat/WYSqrZpONFu/Ip+
 X2iyg/YwbuLJ+fE68wWVERBgokFVZ2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqRQrYMHEafVnpON6vXOIXrT5BS5diMLgMiZRiq17xY=;
 b=zFn/6ZDX1KY9I5bzE1lXc2QWmqAL3g5YwQ4mmmPYk2lUKkcR8t/JUsPNGLCTmD84a1IGdn
 Nw01DzE8TkH2BzAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53EBA13688
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FANqE9sdkGpWawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:03 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:34 +0200
Message-ID: <20260827112157.1748734-9-chrubis@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 08/31] testcases: sysfs: Add
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
 include/tst_path_defs.h                       |  1 +
 runtest/sysfs                                 |  1 +
 .../sysfs/devices/system/cpu/.gitignore       |  1 +
 .../system/cpu/sys_cpu_vulnerabilities01.c    | 91 +++++++++++++++++++
 4 files changed, 94 insertions(+)
 create mode 100644 testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index d915ecdb0..31581482d 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -95,6 +95,7 @@
 /* SYSFS DEVICES */
 #define PATH_SYS_CLOCKSOURCE			"/sys/devices/system/clocksource"
 #define PATH_SYS_CPU				"/sys/devices/system/cpu"
+#define PATH_SYS_CPU_VULN			"/sys/devices/system/cpu/vulnerabilities"
 #define PATH_SYS_NODE				"/sys/devices/system/node"
 
 /* SYSFS */
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
index 000000000..7990f8285
--- /dev/null
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_vulnerabilities01.c
@@ -0,0 +1,91 @@
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
+ *   Mitigation:, Unknown, Processor vulnerable, KVM:)
+ *
+ * KVM: is used by itlb_multihit_show_state() in arch/x86/kernel/cpu/bugs.c
+ * (guarded by CONFIG_KVM_INTEL, i.e. present on most x86_64 distribution
+ * kernels), e.g. ``KVM: Mitigation: VMX disabled`` or ``KVM: Vulnerable``,
+ * for hosts where the vulnerability only matters to KVM guests, not the
+ * host itself.
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
+#include "tst_path_defs.h"
+
+static const char *const known_prefixes[] = {
+	"Not affected",
+	"Vulnerable",
+	"Mitigation:",
+	"Unknown",
+	"Processor vulnerable",
+	"KVM:",
+};
+
+static void check_vuln(const char *name)
+{
+	char status[256] = "";
+	unsigned int i;
+
+	TST_SYSFS_READ_STR(status, sizeof(status), PATH_SYS_CPU_VULN "/%s", name);
+
+	if (status[0] == '\0') {
+		tst_res(TFAIL, "%s/%s is empty", PATH_SYS_CPU_VULN, name);
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
+	if (access(PATH_SYS_CPU_VULN, F_OK)) {
+		tst_res(TCONF, PATH_SYS_CPU_VULN " is not available");
+		return;
+	}
+
+	d = SAFE_OPENDIR(PATH_SYS_CPU_VULN);
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
