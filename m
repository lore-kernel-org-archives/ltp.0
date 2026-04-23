Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1C5F99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 09:59:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B63153E5376
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 11:59:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2383E5389
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 12E5E60097F
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 11:58:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E47F95BD03
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNqCLbSdNvqWp5hOMtcWrf4lXywNxLNJ/VdEfa6FiX0=;
 b=ufmDnsZqoFyGt06bX2IAksqmvAlciCjtnqIVcIojR+PoCOfcmjUEJaHMJns7dPoTVhAO2m
 lfAzCRIiZ71l4SCv0q/GpxfKgkcediXGRNgkcO5ms8eh4YWJGUSyyToEcujtisBCM+mwaE
 YtYe0UZ2D+8+IPAHzGi/74ty09s6tq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNqCLbSdNvqWp5hOMtcWrf4lXywNxLNJ/VdEfa6FiX0=;
 b=a9AJG+9QiAfAn1yJsur0g/motUdygNcln/0Gaq/AANCcx0UZyPAHW85l97M8V/d8iy8L8I
 nOVx0wJ5IIAvQRDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776938298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNqCLbSdNvqWp5hOMtcWrf4lXywNxLNJ/VdEfa6FiX0=;
 b=ufmDnsZqoFyGt06bX2IAksqmvAlciCjtnqIVcIojR+PoCOfcmjUEJaHMJns7dPoTVhAO2m
 lfAzCRIiZ71l4SCv0q/GpxfKgkcediXGRNgkcO5ms8eh4YWJGUSyyToEcujtisBCM+mwaE
 YtYe0UZ2D+8+IPAHzGi/74ty09s6tq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776938298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNqCLbSdNvqWp5hOMtcWrf4lXywNxLNJ/VdEfa6FiX0=;
 b=a9AJG+9QiAfAn1yJsur0g/motUdygNcln/0Gaq/AANCcx0UZyPAHW85l97M8V/d8iy8L8I
 nOVx0wJ5IIAvQRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEF6B593B0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qr9SMTrt6WlqUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 09:58:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 11:58:27 +0200
Message-ID: <20260423095834.11932-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260423095834.11932-1-chrubis@suse.cz>
References: <20260423095834.11932-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/8] syscalls: Add epoll_create03
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
index 5025b259f..b156eed40 100644
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
