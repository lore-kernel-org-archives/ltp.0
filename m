Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D80EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:02:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0316E3CACC1
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:02:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF26B3CACC1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C7A71400BC9
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70CD31F38A;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687262523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/Ew6eD339fWI1bgNvMF0bYZJWt1nrBsQKKLqLaONTE=;
 b=viNG3+qPAp01zDco9tFfACIQ6SSKzTBVcu2BB+nrqFIDnKu6Y+nx8hP38zLrhkG+8cDynd
 LMU48oDPDx6jimaHosyQJhlX21SQuDBV8VhZhQvdMOdK6WaZcP2VUIBaqror+jVGsiTi6f
 sq+/29aOSxbwx17JhmMCfx6Ze9yhr3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687262523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/Ew6eD339fWI1bgNvMF0bYZJWt1nrBsQKKLqLaONTE=;
 b=Ivl78fKMJrS25nH0hJnSr6DgHPvKCs3WK0R3cNRa7BYdm3yhUNQDVtUxWdgxHvvMHTmouO
 YJ/GCCOIkXqxjkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 456C6133A9;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4HaUDzuVkWSQDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 12:02:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 14:01:58 +0200
Message-Id: <20230620120159.320052-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620120159.320052-1-pvorel@suse.cz>
References: <20230620120159.320052-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ioprio: Add docparse markers
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioprio/ioprio_get01.c | 6 +++++-
 testcases/kernel/syscalls/ioprio/ioprio_set01.c | 6 +++++-
 testcases/kernel/syscalls/ioprio/ioprio_set02.c | 6 +++++-
 testcases/kernel/syscalls/ioprio/ioprio_set03.c | 6 +++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
index ceac5a758..f1325be31 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_get01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (c) 2023 Linux Test Project
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Basic ioprio_get() test. Gets the current process I/O priority and
  * checks that the values are sane.
  */
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
index 243337bd2..0868cea7c 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (c) 2019-2023 Linux Test Project
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Basic ioprio_set() test. Gets the current process I/O priority and
  * bumps it up one notch, then down two notches and checks that the
  * new priority is reported back correctly.
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
index 0faf03767..37db7bf42 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set02.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (c) 2023 Linux Test Project
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Extended ioprio_set() test.
  * Tests to set all 8 priority levels for best effort priority, then
  * switches to test all 8 priority levels for idle priority.
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
index b67887205..6efcacc1c 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set03.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
@@ -1,8 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (c) 2023 Linux Test Project
+ */
+
+/*\
+ * [Description]
  *
- * Description:
  * Negative ioprio_set() test. Test some non-working priorities to make
  * sure they don't work.
  */
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
