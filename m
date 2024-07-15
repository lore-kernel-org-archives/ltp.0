Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C41C3DA59
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:19:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4863D1A36
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:19:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 669BB3D1A1A
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:57 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B1FB1400F53
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C645B21BAC;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6noSyKEmLlKMtB5lz0RpacqF7sOAOZZNw/gLPdVk4+8=;
 b=UeHP1BAIJwG/5Et80Tok1c9JZci71k2QzHZzFRUwb4WX72nX09kZ7pVvKttoVlPAPUPRdQ
 BhKoCUPi5+yXQ8Wo1TtzOPRjiEo3gQmTo/tdjq57Ca3HmBJ0a0+lL5rFw+izAoTSy3EsMD
 cr3nhun9ZXbWfV4t0Etq8YIrv2rwJoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6noSyKEmLlKMtB5lz0RpacqF7sOAOZZNw/gLPdVk4+8=;
 b=jUHJCM0ogAn3FnBg33Sy7pHQCOsx19U95/SZCKI2SPDst4J+Ner8VbViWEU7s1JTUw4XVr
 UUFUcqIMmB68wIAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UeHP1BAI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jUHJCM0o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6noSyKEmLlKMtB5lz0RpacqF7sOAOZZNw/gLPdVk4+8=;
 b=UeHP1BAIJwG/5Et80Tok1c9JZci71k2QzHZzFRUwb4WX72nX09kZ7pVvKttoVlPAPUPRdQ
 BhKoCUPi5+yXQ8Wo1TtzOPRjiEo3gQmTo/tdjq57Ca3HmBJ0a0+lL5rFw+izAoTSy3EsMD
 cr3nhun9ZXbWfV4t0Etq8YIrv2rwJoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6noSyKEmLlKMtB5lz0RpacqF7sOAOZZNw/gLPdVk4+8=;
 b=jUHJCM0ogAn3FnBg33Sy7pHQCOsx19U95/SZCKI2SPDst4J+Ner8VbViWEU7s1JTUw4XVr
 UUFUcqIMmB68wIAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADEF51396E;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4EUVKa8TlWbpQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jul 2024 12:18:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jul 2024 14:18:33 +0200
MIME-Version: 1.0
Message-Id: <20240715-cachestat-v2-2-55817ad1a408@suse.com>
References: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
In-Reply-To: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5371;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=YAIU2MG2YQlXMwj3T9mJqXxru//ySlRPGssw2JOLGgQ=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmlROggzdjGmBlz7MQTw1vEGo4hBuV7++7NdTxc
 gaU/OboqzqJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZpUToAAKCRDLzBqyILPm
 RrXVC/9Qkv/lmYBBI/FibXEdSJNyp1woMmm+T0dG8L41xFQJ8CiZ+SKfKjt5T4L9Qo4e70nJyeB
 DZcpYRNo6mRVHmiM6kDrRagG+CHDR7BBe/FS84iQp33uDJ9SDnV9JsCXlb+nAZDGu91cZfFAjyf
 uKroPJqUScdPNwtFpQq8RFbdavf3KX8SGp4EgdOdKJ113SZsUOOkkti0E3fMksvJmznyC/Qrvoo
 QovQkIl0SEQEKtIGNbvqQPLTxkhmtRxIM4XBOIU4Ne6X4IDOR7BH6qbFfKIRyZ7eaBYn5mMFR/l
 3Tgw+u4B6NwEL2RCc2NPZdoRtJS07OS2SlODcI+Qxznk50S/luIfGnPvkTL/QVhRDRWwrUOd8X0
 mL2RTneJNh86zsOU/+ClgzkRhxQdHQAQmglBF0Yzr7xSF1PZ55TQZ4vPWc3Yf4lAX0TlDy0gyTf
 ZhuBDYeNMm4PbKEUMxc9EemJttlO8SOJzzxTtHTdLr8n4x7G3icA1iEBdzXRSnHOdlP/A=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: C645B21BAC
X-Spamd-Result: default: False [-1.51 / 50.00];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] Add cachestat01 test
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
 testcases/kernel/syscalls/cachestat/Makefile      |  10 +++
 testcases/kernel/syscalls/cachestat/cachestat.h   |  27 ++++++
 testcases/kernel/syscalls/cachestat/cachestat01.c | 105 ++++++++++++++++++++++
 5 files changed, 145 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 136fd03fa..9a1827e88 100644
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
index 000000000..2e44b2507
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -0,0 +1,105 @@
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
