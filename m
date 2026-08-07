Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3D6C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 07:01:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAB03E2BF4
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 09:01:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 952AC3E5A1E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:59:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04BB22009DD
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 08:59:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 512433DFF;
 Fri,  7 Aug 2026 06:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786085964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jyUAy7yXehQ6EXhucJXjSUQPAKUn8WtWZZHVjNxzqM=;
 b=c1gewUfTEYmTpAI2dH8CdXC4KQiKCgxdS9LOApxZh2MTABgZcnoylFY0yvn6wV1h7o+waO
 DMTNoRtMESryW6fwE618jH7Ieb2Kk2rSW/8opsTFe3kThSvQoHvTMs8tYusnRQbV42Q34x
 1SriIh+vIu89ai5df+GxsjFLfd8+BJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786085964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jyUAy7yXehQ6EXhucJXjSUQPAKUn8WtWZZHVjNxzqM=;
 b=t3BBGM6yyaSBOA0vIC2P2ze491uFtjUUqwaXSWodh35DJNduoekRNG6HEEJLQhrPYNx8vq
 LR5iiLQ/eacUiTDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786085960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jyUAy7yXehQ6EXhucJXjSUQPAKUn8WtWZZHVjNxzqM=;
 b=FdKhOI57+tsvHLTWjF9SayZ029BXlFYrcZLjlbI1QZQ5jsiJyrMLGn7BjyQ4IUnpSryn9D
 gZ7hL37Rp5rdhFvyERMhHt84abNshhyPi3sH/GDixPnf8fMyXJu2IoRccZv7oNJrqBwUze
 +jiduhz5YtiugxdXU4cElVnQjsl1O3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786085960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+jyUAy7yXehQ6EXhucJXjSUQPAKUn8WtWZZHVjNxzqM=;
 b=RVhQEq5Wq8VR/wD9zczjHjIWfL5uBnV22WPz27y0wbwMjBfjXCjByHCwba9zcILXYgQzP4
 7ekaggv8ILQml/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E2D3779E0;
 Fri,  7 Aug 2026 06:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Le3G0KCdWrkcwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 06:59:14 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 08:59:11 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v2-6-1760ae8e3b8b@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v2-0-1760ae8e3b8b@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v2-0-1760ae8e3b8b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786085951; l=4447;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=k0uSpuig4+UABWqscJmBB1haslBxrfr1Pey9WMBB/2I=;
 b=OAe8b6ieeDjd/bjZ5rORjyz0JgyaDoymIblLLkqXMJjd3Octuy2tOi1xZdrGLxqRLXIKKzGOx
 faZ1bOJrC+UBXjlGHfM6dNFYLSyhsQPEiFcBKeaXIwFT7EvVFyQKudj
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.981]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] mremap08: Extract test from mremap05
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

Extract a new test from mremap05 that verifies the behavior of the
MREMAP_FIXED flag when:

- MREMAP_FIXED | MREMAP_MAYMOVE can move a mapping to a new, free
  address, preserving its content.
- MREMAP_FIXED | MREMAP_MAYMOVE unmaps a previously existing mapping
  at the target address range and replaces it with the moved mapping.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/mremap08.c | 128 ++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b024d4c43..ede795a48 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -946,6 +946,7 @@ mremap04 mremap04
 mremap05 mremap05
 mremap06 mremap06
 mremap07 mremap07
+mremap08 mremap08
 
 mseal01 mseal01
 mseal02 mseal02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index 292899e03..dd4bf4e8e 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -5,3 +5,4 @@
 /mremap05
 /mremap06
 /mremap07
+/mremap08
diff --git a/testcases/kernel/syscalls/mremap/mremap08.c b/testcases/kernel/syscalls/mremap/mremap08.c
new file mode 100644
index 000000000..8d8e82d8b
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap08.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify the behavior of the ``MREMAP_FIXED`` flag of :manpage:`mremap(2)`:
+ *
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` can move a mapping to a new, free
+ *   address, preserving its content.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` unmaps a previously existing mapping at
+ *   the target address range and replaces it with the moved mapping.
+ */
+
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include "tst_test.h"
+
+static int pagesize;
+
+static struct tcase {
+	size_t old_pages;
+	size_t new_pages;
+	int flags;
+	int free_dst;
+	const char *msg;
+} tcases[] = {
+	{
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 1,
+		.msg = "move mapping to free address",
+	},
+	{
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 0,
+		.msg = "move mapping onto an occupied address",
+	},
+};
+
+static void *get_test_area(size_t size, int free_area)
+{
+	void *p;
+
+	p = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (free_area)
+		SAFE_MUNMAP(p, size);
+
+	return p;
+}
+
+static void setup(void)
+{
+	pagesize = getpagesize();
+}
+
+static void fill_pattern(char *addr, size_t pages)
+{
+	size_t i;
+
+	for (i = 0; i < pages; i++)
+		addr[i * pagesize] = (char)(0x1 + i);
+}
+
+static int check_pattern(const char *msg, char *addr, size_t pages)
+{
+	size_t i;
+
+	for (i = 0; i < pages; i++) {
+		char got = addr[i * pagesize];
+		char exp = (char)(0x1 + i);
+
+		if (got != exp) {
+			tst_res(TFAIL, "%s: page %zu content 0x%x, expected 0x%x",
+				msg, i, (unsigned char)got, (unsigned char)exp);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	char *old_address;
+	char *new_address;
+	char *ret;
+	size_t old_size = tc->old_pages * pagesize;
+	size_t new_size = tc->new_pages * pagesize;
+
+	old_address = get_test_area(old_size, 0);
+	new_address = get_test_area(new_size, tc->free_dst);
+
+	fill_pattern(old_address, tc->old_pages);
+
+	if (!tc->free_dst)
+		*new_address = 0x7f;
+
+	TESTPTR(mremap(old_address, old_size, new_size, tc->flags, new_address));
+	ret = TST_RET_PTR;
+
+	if (ret == MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO, "%s failed", tc->msg);
+		SAFE_MUNMAP(old_address, old_size);
+		if (!tc->free_dst)
+			SAFE_MUNMAP(new_address, new_size);
+		return;
+	}
+
+	if (ret != new_address)
+		tst_res(TFAIL, "%s: ret %p, expected %p", tc->msg, ret, new_address);
+	else if (check_pattern(tc->msg, ret, tc->new_pages) == 0)
+		tst_res(TPASS, "%s", tc->msg);
+
+	SAFE_MUNMAP(ret, new_size);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
