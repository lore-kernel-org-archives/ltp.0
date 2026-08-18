Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557BDC5DF74
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 14:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FF4A3CD51F
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 16:15:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBEEE3CD51F
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5D26B10007F9
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 16:13:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84026845BA
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=2jWqrLoX7+Ww0bFjLfTRmAPKmQ2MhgmL+GZipPygqqf7jMusTuVVhZo5jD/gBkm81KBJqL
 PuL3IWoPcitUpkCB4pDDPftRT2N8Z4xxYnh4gLs/GqnZt/bveMNmxHX6rfLW2XJ9FAPfsS
 LCjAevBa0tABUj09nA1Ei3sS5vz8OHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=F2yCf17yP2NwGq7vsvXV6E7ypgAadpUaB+mpKXeAIq4nuiZRbAEyuVsUoCRETzINnCEio6
 UhIpu5vTig95q2Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="g/ck5S/R";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=J8GYnxDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787062396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=g/ck5S/RtqwyL6vz/OFwCwBZTm1+ZUV4iG8sRkak3rKDs1Uf+qADXtuZTI4fsnRwpuGHA+
 /6PibpLaJgbt3YAeevQCf9HY/4wsL538ucagxE4NjLfNwFewy5c2kYr55e/9kCBwXfkFG/
 Hm1GAO0C9d8xPEmR9eP5LDAisVpvI9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787062396;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ciLw3T+s4whr3e1VV2elVzoColPRgVaUNKOreBwX7Q=;
 b=J8GYnxDTm5klMZFxoYPFng+1r+NtDUWjxaKJ1xFl+eX1vBm93gEt4qJpdyFWn3oxJ9+K68
 E1vCPRa+Q/+7nLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD1A367E
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XYD8DXtohGrXcAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 14:13:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Aug 2026 16:12:48 +0200
Message-ID: <20260818141311.1265557-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818141311.1265557-1-chrubis@suse.cz>
References: <20260818141311.1265557-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 84026845BA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 08/31] testcases: sysfs: Add
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
