Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D375C3DA59
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 14:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 004673D1BED
	for <ltp@archiver.kernel.org>; Mon, 22 Jul 2024 16:30:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447F23D0BC9
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7657B60140B
 for <ltp@lists.linux.it>; Mon, 22 Jul 2024 16:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEB871FB7D;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvucEIdry0LYhkBykhT60oI2qMDIV/JPocWbCgODFYs=;
 b=LVwd3j2tyzskxm7xsWtLdXceGgfCN2dMvFYXPW9Wxw66WV/MmmKK6kS0WY5q9xjTvNXhkC
 AxNEqFfejXJ+92e3i7Qzl4HvdMMarHFEtVqaOEuc0ko+fQkadFPTM14cUGtfZvsSp1qR0g
 4WMMqOhE+3ZUJQUQoyQzemSpcEw4pmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvucEIdry0LYhkBykhT60oI2qMDIV/JPocWbCgODFYs=;
 b=bRCBERv1H1bGViQDBcoX5jARbin3sWRtq7AV/3vD2pvtmFy1Q4CylfA/BfKfuu26C4sdzU
 iDImy8M3oiDTY1Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LVwd3j2t;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bRCBERv1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721658564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvucEIdry0LYhkBykhT60oI2qMDIV/JPocWbCgODFYs=;
 b=LVwd3j2tyzskxm7xsWtLdXceGgfCN2dMvFYXPW9Wxw66WV/MmmKK6kS0WY5q9xjTvNXhkC
 AxNEqFfejXJ+92e3i7Qzl4HvdMMarHFEtVqaOEuc0ko+fQkadFPTM14cUGtfZvsSp1qR0g
 4WMMqOhE+3ZUJQUQoyQzemSpcEw4pmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721658564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EvucEIdry0LYhkBykhT60oI2qMDIV/JPocWbCgODFYs=;
 b=bRCBERv1H1bGViQDBcoX5jARbin3sWRtq7AV/3vD2pvtmFy1Q4CylfA/BfKfuu26C4sdzU
 iDImy8M3oiDTY1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9460113996;
 Mon, 22 Jul 2024 14:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2DszIsRsnmazSwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jul 2024 14:29:24 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jul 2024 16:28:41 +0200
MIME-Version: 1.0
Message-Id: <20240722-cachestat-v3-2-a0386f7cdaaa@suse.com>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
In-Reply-To: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5392;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=neTU2zW/6UEhUO17K1yncvKwJtTkPTAK2HSuqsYgfO0=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmnmyvR7IPKnekL5RneSQ/pMWPMOz6G1hD7oq0u
 S99S2hVsLeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp5srwAKCRDLzBqyILPm
 RnbqC/sGVzrxmnNOMadgoNHGyyRFNptZBP7onYGjgA1Umby5lgD+HaUpF1yacZbJDQK2csTeL3X
 0QqLuby6cWOm0hTRalb1JoVB773wwLguaAa2sn/z3hoTvF47y4w9Mg2Kbxbh3QTnRCalD8oL1ui
 DO1HsQ+M63u7gCyXV+ZvsbKnhbLQoQUPamikb+9yjfS6Uz8MT5keLnEEyvIXEYG6ImB4GDbP31P
 H2vgVq9fBGF+jB7Oo+vPSzVpkA70+zucdf3Cy5RYAvdxo7JdAwihcZ6Jo73LKbZY+OW8dmh23/J
 JaZu0br/zgQgW3QSwgi69c/9+nWbFtA34NOduc6CKqblmY4BFq89dt2vRchROh1/v+EbsiNZ+by
 SjwjG49vkkOFeL4embiGpExxehLO6jqYdXObsVpcAfuYi1k0UCAayXtiAgmw+adJ2jfOI6H2hpK
 VEgQw3bO8T+Y7ZFLgfAqM8sXmac65YDxO95aotsNxjAUGRDfpO5hy+C82bkObwMtBFzIk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BEB871FB7D
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/5] Add cachestat01 test
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

This test verifies that cachestat() syscall is properly counting
cached pages written inside a file. If storage device synchronization
is requested, test will check if the number of dirty pages is zero.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/cachestat/.gitignore    |   1 +
 testcases/kernel/syscalls/cachestat/Makefile      |  10 ++
 testcases/kernel/syscalls/cachestat/cachestat.h   |  27 ++++++
 testcases/kernel/syscalls/cachestat/cachestat01.c | 106 ++++++++++++++++++++++
 5 files changed, 146 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 27eb9a86b..ce974b317 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -62,6 +62,8 @@ capset04 capset04
 
 cacheflush01 cacheflush01
 
+cachestat01 cachestat01
+
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
 chdir04 chdir04
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
new file mode 100644
index 000000000..daea1f4be
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -0,0 +1 @@
+cachestat01
diff --git a/testcases/kernel/syscalls/cachestat/Makefile b/testcases/kernel/syscalls/cachestat/Makefile
new file mode 100644
index 000000000..62b00d2f4
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+LDLIBS += -lrt
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/cachestat/cachestat.h b/testcases/kernel/syscalls/cachestat/cachestat.h
new file mode 100644
index 000000000..efce6dc7f
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef CACHESTAT_H__
+#define CACHESTAT_H__
+
+#include "tst_test.h"
+#include "lapi/mman.h"
+
+static inline void print_cachestat(struct cachestat *cs)
+{
+	tst_res(TDEBUG,
+		"nr_cache=%lu "
+		"nr_dirty=%lu "
+		"nr_writeback=%lu "
+		"nr_evicted=%lu "
+		"nr_recently_evicted=%lu",
+		cs->nr_cache,
+		cs->nr_dirty,
+		cs->nr_writeback,
+		cs->nr_evicted,
+		cs->nr_recently_evicted);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
new file mode 100644
index 000000000..7b0700f2c
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that cachestat() syscall is properly counting cached pages
+ * written inside a file. If storage device synchronization is requested, test
+ * will check if the number of dirty pages is zero.
+ *
+ * [Algorithm]
+ *
+ * - create a file with specific amount of pages
+ * - synchronize storage device, if needed
+ * - monitor file with cachestat()
+ * - check if the right amount of pages have been moved into cache
+ * - if storage device synchronization is requested, check that dirty pages is
+ *    zero
+ */
+
+#include <stdlib.h>
+#include "cachestat.h"
+
+#define MNTPOINT "mntpoint"
+#define FILENAME MNTPOINT "/myfile.bin"
+
+static int page_size;
+static char *page_data;
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static void test_cached_pages(const unsigned int use_sync, const int num_pages)
+{
+	int fd;
+
+	tst_res(TINFO, "%s file synchronization", use_sync ? "Enable" : "Disable");
+	tst_res(TINFO, "Number of pages: %d", num_pages);
+
+	memset(cs, 0, sizeof(struct cachestat));
+
+	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0600);
+
+	for (int i = 0; i < num_pages; i++)
+		SAFE_WRITE(0, fd, page_data, page_size);
+
+	if (use_sync)
+		fsync(fd);
+
+	cs_range->off = 0;
+	cs_range->len = page_size * num_pages;
+
+	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
+	print_cachestat(cs);
+
+	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, num_pages);
+
+	if (use_sync)
+		TST_EXP_EQ_LI(cs->nr_dirty, 0);
+
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK(FILENAME);
+}
+
+static void run(unsigned int use_sync)
+{
+	for (int i = 0; i < 15; i++)
+		test_cached_pages(use_sync, 1 << i);
+}
+
+static void setup(void)
+{
+	page_size = (int)sysconf(_SC_PAGESIZE);
+
+	page_data = SAFE_MALLOC(page_size);
+	memset(page_data, 'a', page_size);
+}
+
+static void cleanup(void)
+{
+	if (page_data)
+		free(page_data);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "6.5",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		"tmpfs",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
