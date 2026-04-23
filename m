Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453D7F9937D
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:05:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D89EC3E28E6
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:05:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E0863E538C
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D0C111A0036A
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:03:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5C9045BD68
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DboEkEoPiAYbgEGOrXL+4OQxuE+xE8PdVUsGitSQgak=;
 b=QwMlyvXpKH+ANuj4/QBO822apWmlMPt+W9AIyFsMHBgyc6EJ1KE/RqSb1es0ikiM9+J5Jc
 989aNsjLbqFk6TMAz7hS2ysDA0EFSt9nzU2Bj6+HeKqOvd5l3edTweM6Y3doQ2DYtFto1m
 9qgTuWC5rHaHdnE10UUm5vXifafzlZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DboEkEoPiAYbgEGOrXL+4OQxuE+xE8PdVUsGitSQgak=;
 b=Qam7i0kERrt/kitsWKk+jTBcsZ7Jzy59CZXr53qOXLAZdE71P9z4twyfGWierfhtd9DBc4
 eB7ZTfBfM4qtwnBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aHC100+f;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="HY/OAOQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776945786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DboEkEoPiAYbgEGOrXL+4OQxuE+xE8PdVUsGitSQgak=;
 b=aHC100+fcZs2gnO9VKcbD244SgATjphyqFKncdtdOVRfLIpOaIM9CJZAfkmn6MtznvAzDS
 wOqv/atDPJGKknf9gqiOJzmJtvT2Sd72w5lYDRPYqBggk4EmFb6dctTH0YiEgs7X0q1/XF
 ah6HlN9gzdkWAYbOSKQBbGGrwgqX0uc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776945786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DboEkEoPiAYbgEGOrXL+4OQxuE+xE8PdVUsGitSQgak=;
 b=HY/OAOQBDQMhut/LdQxUhJqbQx1uR0KDJ7sbL3QCgtlBpP5YfN7MDFW6GDcMNIZ7L9nPxM
 zltmffXWEdQd9EBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C381593A3
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tp24EXUK6mmzUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 12:03:01 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 14:03:02 +0200
Message-ID: <20260423120309.18049-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423120309.18049-1-chrubis@suse.cz>
References: <20260423120309.18049-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ASN_FAIL(0.00)[7.9.0.0.4.6.0.0.0.5.1.0.0.1.0.0.4.0.1.0.1.8.2.b.0.4.e.d.7.0.a.2.asn6.rspamd.com:server
 fail]; FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5C9045BD68
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/8] syscalls: Add epoll_create03
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

Test that checks that we get EMFILE when limit on per-process file
descriptors is hit.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/syscalls                              |  2 +
 .../kernel/syscalls/epoll_create/.gitignore   |  1 +
 .../syscalls/epoll_create/epoll_create03.c    | 72 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/epoll_create/epoll_create03.c

diff --git a/runtest/syscalls b/runtest/syscalls
index df5dc02b5..d890c5516 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -177,6 +177,8 @@ dup3_02 dup3_02
 
 epoll_create01 epoll_create01
 epoll_create02 epoll_create02
+epoll_create03 epoll_create03
+
 epoll_create1_01 epoll_create1_01
 epoll_create1_02 epoll_create1_02
 epoll01 epoll-ltp
diff --git a/testcases/kernel/syscalls/epoll_create/.gitignore b/testcases/kernel/syscalls/epoll_create/.gitignore
index 5c16cfa8c..855bf255c 100644
--- a/testcases/kernel/syscalls/epoll_create/.gitignore
+++ b/testcases/kernel/syscalls/epoll_create/.gitignore
@@ -1,2 +1,3 @@
 epoll_create01
 epoll_create02
+epoll_create03
diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create03.c b/testcases/kernel/syscalls/epoll_create/epoll_create03.c
new file mode 100644
index 000000000..d0e66c4e5
--- /dev/null
+++ b/testcases/kernel/syscalls/epoll_create/epoll_create03.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verify that epoll_create() fails with EMFILE when the per-process limit on
+ * the number of open file descriptors has been reached.
+ */
+
+#include <stdlib.h>
+#include <sys/epoll.h>
+
+#include "tst_test.h"
+#include "lapi/epoll.h"
+#include "lapi/syscalls.h"
+
+#include "epoll_create.h"
+
+static int *fds;
+static int nfds;
+static long maxfds;
+
+static void setup(void)
+{
+	int fd;
+
+	variant_info();
+
+	maxfds = SAFE_SYSCONF(_SC_OPEN_MAX);
+	fds = SAFE_MALLOC(maxfds * sizeof(int));
+	memset(fds, -1, maxfds * sizeof(int));
+
+	fds[0] = SAFE_OPEN("dummy", O_RDWR | O_CREAT, 0700);
+	nfds = 1;
+
+	for (long i = 1; i < maxfds; i++) {
+		fd = dup(fds[0]);
+		if (fd == -1)
+			break;
+		fds[nfds++] = fd;
+	}
+}
+
+static void run(void)
+{
+	TST_EXP_FAIL2(do_epoll_create(1), EMFILE,
+		      "epoll_create(1) with exhausted fds");
+
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
+}
+
+static void cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < nfds; i++) {
+		if (fds[i] != -1)
+			SAFE_CLOSE(fds[i]);
+	}
+
+	free(fds);
+}
+
+static struct tst_test test = {
+	.test_variants = EPOLL_CREATE_VARIANTS,
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+};
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
