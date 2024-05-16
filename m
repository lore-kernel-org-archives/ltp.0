Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46543C25B78
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 10:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41E713CFA1E
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:42:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46FB73CF9C7
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:34 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D3E4601FC2
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:42:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 12DB35C194;
 Thu, 16 May 2024 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmnso/iw81B7NPXDWWCJBw2iM0w1yyRIvNgZXTroXjw=;
 b=GNHixUl5vDpbayNc9HqKP+xLFkNelIiQTW7O/DwfaDI9lOE1OuK+ban7nlynmvoF770xw5
 lVx7ep4PwcNG1k8V7G9TYQlGjpK2CABpoIXXWlG/5RqwbyZoPOJkwxIVBNIy7BZ74Bm3Vb
 VAsMBGGcxyNusCh1bMBSPxHrYZKj/Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmnso/iw81B7NPXDWWCJBw2iM0w1yyRIvNgZXTroXjw=;
 b=Impg/Qm7mFsmsOvppEK6E5n2Y3g8eurfLtrVrlkxs6HpSRmJ+D0FrqEurFLExbGDusjnV0
 UlHIxCe9FK9aeVAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GNHixUl5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Impg/Qm7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715856153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmnso/iw81B7NPXDWWCJBw2iM0w1yyRIvNgZXTroXjw=;
 b=GNHixUl5vDpbayNc9HqKP+xLFkNelIiQTW7O/DwfaDI9lOE1OuK+ban7nlynmvoF770xw5
 lVx7ep4PwcNG1k8V7G9TYQlGjpK2CABpoIXXWlG/5RqwbyZoPOJkwxIVBNIy7BZ74Bm3Vb
 VAsMBGGcxyNusCh1bMBSPxHrYZKj/Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715856153;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bmnso/iw81B7NPXDWWCJBw2iM0w1yyRIvNgZXTroXjw=;
 b=Impg/Qm7mFsmsOvppEK6E5n2Y3g8eurfLtrVrlkxs6HpSRmJ+D0FrqEurFLExbGDusjnV0
 UlHIxCe9FK9aeVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF4AF137C3;
 Thu, 16 May 2024 10:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EIw9NRjjRWbwGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 May 2024 10:42:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 12:42:27 +0200
Message-Id: <20240516104227.25381-4-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240516104227.25381-1-andrea.cervesato@suse.de>
References: <20240516104227.25381-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-5.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 12DB35C194
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 3/3] Add cachestat02 test
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

This test verifies that cachestat() syscall is properly counting cached
pages written inside a shared memory.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/cachestat/.gitignore      |  1 +
 .../kernel/syscalls/cachestat/cachestat02.c   | 82 +++++++++++++++++++
 3 files changed, 84 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 961775cf7..1b0a3bb23 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -64,6 +64,7 @@ cacheflush01 cacheflush01
 
 cachestat01 cachestat01
 cachestat01A cachestat01 -s
+cachestat02 cachestat02
 
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
index daea1f4be..0f70fb801 100644
--- a/testcases/kernel/syscalls/cachestat/.gitignore
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -1 +1,2 @@
 cachestat01
+cachestat02
diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
new file mode 100644
index 000000000..0221cead4
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that cachestat() syscall is properly counting cached pages
+ * written inside a shared memory.
+ *
+ * [Algorithm]
+ *
+ * * create a shared memory with a specific amount of pages
+ * * monitor file with cachestat()
+ * * check if the right amount of pages have been moved into cache
+ */
+
+#include "cachestat.h"
+
+#define FILENAME "myfile.bin"
+#define NUMPAGES 32
+
+static char *data;
+static int file_size;
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static void run(void)
+{
+	int fd;
+
+	memset(cs, 0, sizeof(struct cachestat));
+
+	fd = shm_open(FILENAME, O_RDWR | O_CREAT, 0600);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "shm_open error");
+
+	SAFE_FTRUNCATE(fd, file_size);
+	SAFE_WRITE(0, fd, data, file_size);
+
+	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
+	print_cachestat(cs);
+
+	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, NUMPAGES);
+
+	SAFE_CLOSE(fd);
+	shm_unlink(FILENAME);
+}
+
+static void setup(void)
+{
+	int page_size;
+
+	page_size = (int)sysconf(_SC_PAGESIZE);
+	file_size = page_size * NUMPAGES;
+
+	data = SAFE_MALLOC(file_size);
+	memset(data, 'a', file_size);
+
+	cs_range->off = 0;
+	cs_range->len = file_size;
+}
+
+static void cleanup(void)
+{
+	if (data)
+		free(data);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "6.5",
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
