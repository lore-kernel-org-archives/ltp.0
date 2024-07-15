Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E32AC3DA4B
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 12:19:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96A743D1A37
	for <ltp@archiver.kernel.org>; Mon, 15 Jul 2024 14:19:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 524F53D1A0C
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:57 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 972661000F38
 for <ltp@lists.linux.it>; Mon, 15 Jul 2024 14:18:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFAC21F813;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJW7LuJ52jJkZF4C5+XgTQmsxjSdfaLqVyHU6Vhto=;
 b=s99TAFoaj6Xst6qtvwajLoiaTUqzslVltKyl7nnK4oW5ZrVnKiMNKk3nhJWpt7GW8hYHfj
 MDBQcMjpAemmCi+N1cggOUQbk8ZAWs4eHFZp4YQ+we87HowPMEIVXOlaN2cFfEre3gQVnA
 LJpVHqe6CA9uoOpuq6lxP//FKt+t5mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJW7LuJ52jJkZF4C5+XgTQmsxjSdfaLqVyHU6Vhto=;
 b=BMGL+PGwH7a9rFQPzlGUF+T7xqpPJdutM+DNyBG2f1tcQR+2JsrICrtwkO9ooB8+jvk2LB
 biTSxAbl0JcTtADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721045935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJW7LuJ52jJkZF4C5+XgTQmsxjSdfaLqVyHU6Vhto=;
 b=s99TAFoaj6Xst6qtvwajLoiaTUqzslVltKyl7nnK4oW5ZrVnKiMNKk3nhJWpt7GW8hYHfj
 MDBQcMjpAemmCi+N1cggOUQbk8ZAWs4eHFZp4YQ+we87HowPMEIVXOlaN2cFfEre3gQVnA
 LJpVHqe6CA9uoOpuq6lxP//FKt+t5mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721045935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4WOJW7LuJ52jJkZF4C5+XgTQmsxjSdfaLqVyHU6Vhto=;
 b=BMGL+PGwH7a9rFQPzlGUF+T7xqpPJdutM+DNyBG2f1tcQR+2JsrICrtwkO9ooB8+jvk2LB
 biTSxAbl0JcTtADg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C99B8137EB;
 Mon, 15 Jul 2024 12:18:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OEPwL68TlWbpQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Jul 2024 12:18:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Jul 2024 14:18:34 +0200
MIME-Version: 1.0
Message-Id: <20240715-cachestat-v2-3-55817ad1a408@suse.com>
References: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
In-Reply-To: <20240715-cachestat-v2-0-55817ad1a408@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3315;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=cHojzUTc1f1nP7NN2CScfhWqNz3Yq3zuwvGcNHKXrrg=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmlROheEeWRDjLj9V4R5GTXr7EEROLo1tmxKSZt
 sXg69RF1BiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZpUToQAKCRDLzBqyILPm
 RlZnC/99y2qx39E535D4TLPbFWUgn8+kQ6x4/J9w6Omo1boRSRMzkwml5Uk4wVHzG764GB3Nyy3
 +8Dh6QfiwGXJE2WjwARcpa1WFI6tTkv7kjfMVvBjDI5lfWXEv36p/mXxN1MWTrlJ6CVwPJDk1zh
 3Chuk2nZ31v2gayMzlenCFX8dbetVea4ikUcOdgo6f/23l0xU+SKValga7NUPmZkY5n424Ou0m5
 97Dl3VVgUcf7swNIIGkDpQ4fe2kaRF42RQAtuyHYTLUlHslRyeL6LtG0vPuAXg+WgH+sPC29mU0
 qVZ10TmsWYWw6Rc+zzWbVRZVXZ65ZQTKw8tERoPKDMBza4+QfqXv8gG77XjnOTg2lp1Oo7srGzg
 6JTXXz0GBEYLLYcWjGuuE7SvbnsAsTNFmapAWnxy3FEVDdcbrSEWHO4NpoWu1jkHuAv6dMSwilR
 JWOED040oal19Y94mgM+vJnzW6CmiW+P9a+deY68BgayVDHV+YbodDC64p7AFS+7DXo0w=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/4] Add cachestat02 test
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
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/cachestat/.gitignore    |  1 +
 testcases/kernel/syscalls/cachestat/cachestat02.c | 89 +++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 9a1827e88..887ac217b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -63,6 +63,7 @@ capset04 capset04
 cacheflush01 cacheflush01
 
 cachestat01 cachestat01
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
index 000000000..d71f5dab5
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
@@ -0,0 +1,89 @@
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
+ * - create a shared memory with a specific amount of pages
+ * - monitor file with cachestat()
+ * - check if the right amount of pages have been moved into cache
+ */
+
+#include "cachestat.h"
+
+#define FILENAME "myfile.bin"
+
+static int page_size;
+static char *page_data;
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static void test_cached_pages(const int num_pages)
+{
+	int fd, file_size;
+
+	tst_res(TINFO, "Number of pages: %d", num_pages);
+
+	memset(cs, 0, sizeof(struct cachestat));
+
+	fd = shm_open(FILENAME, O_RDWR | O_CREAT, 0600);
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "shm_open error");
+
+	file_size = page_size * num_pages;
+
+	cs_range->off = 0;
+	cs_range->len = file_size;
+
+	SAFE_FTRUNCATE(fd, file_size);
+	for (int i = 0; i < num_pages; i++)
+		SAFE_WRITE(0, fd, page_data, page_size);
+
+	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
+	print_cachestat(cs);
+
+	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, num_pages);
+
+	SAFE_CLOSE(fd);
+	shm_unlink(FILENAME);
+}
+
+static void run(void)
+{
+	for (int i = 0; i < 10; i++)
+		test_cached_pages(1 << i);
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
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
