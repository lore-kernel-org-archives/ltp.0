Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766F4C4332F
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 17:09:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E69023CBC72
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 18:09:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A93D3C913E
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 18:09:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EB3FE1A009B9
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 18:09:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A6F93462F
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671210563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+R1B2k/gjpcziugoBQmVnbvMlMar51hmuhPk+IOCajk=;
 b=FYPfw2LEQnLcHyj9q9Qh0nTdWrA0+amzAgUdROkmW66SHAC2ya4c6T5LAJrcYrFqsghGBw
 rNGF2KmrHehLyfwJ0mm3jJCcHWHROthzxHdVFuuP1BHEmy2TVhQwlhpyOoIWbUugqanMVl
 tbC4edmnc2e2LLOhLKMEl3JTtfhqGgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671210563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+R1B2k/gjpcziugoBQmVnbvMlMar51hmuhPk+IOCajk=;
 b=kDGoYIhf5uutFAn12NN6yRSjpyqnQD22GzeSECrJ2qP/zTR2StaQbtgYylUQKnAc9J9gwT
 o7VaE1CGnUDBrhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28677138FD
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 17:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KIL7CEOmnGOCOgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 17:09:23 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 Dec 2022 18:09:22 +0100
Message-Id: <20221216170922.21752-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add test for CVE 2022-4378
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/cve                   |   1 +
 testcases/cve/.gitignore      |   1 +
 testcases/cve/cve-2022-4378.c | 108 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 testcases/cve/cve-2022-4378.c

diff --git a/runtest/cve b/runtest/cve
index fd0305aa3..1ba63c2a7 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -76,3 +76,4 @@ cve-2022-0847 dirtypipe
 cve-2022-2590 dirtyc0w_shmem
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
+cve-2022-4378 cve-2022-4378
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index eb0a8b37d..90e8b191c 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -10,4 +10,5 @@ stack_clash
 cve-2017-17052
 cve-2017-16939
 cve-2017-17053
+cve-2022-4378
 icmp_rate_limit01
diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
new file mode 100644
index 000000000..e1c5df325
--- /dev/null
+++ b/testcases/cve/cve-2022-4378.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2022 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*\
+ * CVE 2022-4378
+ *
+ * Check that writing several pages worth of whitespace into /proc/sys files
+ * does not cause kernel stack overflow. Kernel bug fixed in:
+ *
+ * commit bce9332220bd677d83b19d21502776ad555a0e73
+ * Author: Linus Torvalds <torvalds@linux-foundation.org>
+ * Date:   Mon Dec 5 12:09:06 2022 -0800
+ *
+ * proc: proc_skip_spaces() shouldn't think it is working on C strings
+ */
+
+#include <stdlib.h>
+#include "tst_test.h"
+
+static char *buf;
+static unsigned int bufsize;
+static int fd = -1;
+
+static struct testcase {
+	const char *path;
+	int err;
+} testcase_list[] = {
+	{"/proc/sys/net/ipv4/icmp_ratelimit", EINVAL},
+	{"/proc/sys/net/ipv4/icmp_ratemask", EINVAL},
+	{"/proc/sys/net/ipv4/icmp_echo_ignore_all", EINVAL},
+	{"/proc/sys/net/ipv4/tcp_probe_interval", EINVAL},
+	{"/proc/sys/net/ipv4/tcp_keepalive_time", EINVAL},
+	{"/proc/sys/net/ipv4/tcp_notsent_lowat", EINVAL},
+	{"/proc/sys/net/ipv4/ip_local_reserved_ports", 0}
+};
+
+static void setup(void)
+{
+	tst_setup_netns();
+
+	bufsize = 2 * SAFE_SYSCONF(_SC_PAGESIZE);
+	buf = SAFE_MALLOC(bufsize);
+	memset(buf, '\n', bufsize);
+}
+
+static void run(unsigned int n)
+{
+	const struct testcase *tc = testcase_list + n;
+
+	if (access(tc->path, W_OK)) {
+		tst_res(TCONF | TERRNO, "Skipping %s", tc->path);
+		return;
+	}
+
+	tst_res(TINFO, "Writing whitespace to %s", tc->path);
+
+	fd = SAFE_OPEN(tc->path, O_WRONLY);
+	TEST(write(fd, buf, bufsize));
+	SAFE_CLOSE(fd);
+
+	if (TST_RET >= 0 && tc->err == 0) {
+		tst_res(TPASS, "write() passed as expected");
+	} else if (TST_RET >= 0) {
+		tst_res(TFAIL, "write() unexpectedly passed");
+	} else if (TST_RET != -1) {
+		tst_res(TFAIL | TTERRNO, "Invalid write() return value %ld",
+			TST_RET);
+	} else if (TST_ERR != tc->err) {
+		tst_res(TFAIL | TTERRNO, "write() returned unexpected error");
+	} else {
+		tst_res(TPASS | TTERRNO, "write() failed as expected");
+	}
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "Kernel is vulnerable");
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+
+	if (buf)
+		free(buf);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.setup = setup,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.save_restore = (const struct tst_path_val[]) {
+		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bce9332220bd"},
+		{"CVE", "2022-4378"},
+	}
+};
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
