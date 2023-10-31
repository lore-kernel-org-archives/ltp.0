Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A472C4167B
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 13:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15DFE3CE9E5
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 14:27:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80C293CC90F
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 14:27:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C499B10009DD
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 14:27:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8553221ADA
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698758845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J2UGdxqfFlVgo5r35V4BFF4P8TBHDHqyhMcjidnfC4c=;
 b=kUpJTW89THGwS/vSE4k7MEVn8PZ3BQ/H2qeguGXZTbwIbHaG5euJcpOpnrMsc3qJqTOY5x
 qRuaKrOBBwoRnyQyIhGoEodCX52UKrixqKjgsLZKn0rFwv61oUwORYbelfpGhf8U8Gdb/F
 y3TaCsivVTkkkwkMsccDZ/w8+uemx0Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698758845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J2UGdxqfFlVgo5r35V4BFF4P8TBHDHqyhMcjidnfC4c=;
 b=7rDaou9PCJOXyWVsQPqbgcm79aUrXppvF85HSyx9b63xXkvk5jy8mxmyUEHhng2X9wl/d4
 tL04ntFMlAJ2uIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7410A138EF
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cuLZG70AQWVDcAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 13:27:25 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 31 Oct 2023 14:27:56 +0100
Message-ID: <20231031132756.12799-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/sched_rr_get_interval: Convert to docparse
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../sched_rr_get_interval01.c                 | 19 +++++++++++++++---
 .../sched_rr_get_interval02.c                 |  3 +++
 .../sched_rr_get_interval03.c                 | 20 ++++++++++++-------
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 597de4665..520f44fe0 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -2,13 +2,26 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
+ */
+/*\
+ * [Description]
  *
  * Gets round-robin time quantum by calling sched_rr_get_interval() and
  * checks that the value is sane.
  *
- * It is also a regression test for kernel
- * commit 975e155ed873 ("sched/rt: Show the 'sched_rr_timeslice' SCHED_RR
- * timeslice tuning knob in milliseconds").
+ * It is also a regression test for:
+ *
+ *  commit 975e155ed8732cb81f55c021c441ae662dd040b5
+ *  Author: Shile Zhang <shile.zhang@nokia.com>
+ *  Date:   Sat Jan 28 22:00:49 2017 +0800
+ *
+ *    sched/rt: Show the 'sched_rr_timeslice' SCHED_RR timeslice tuning knob in milliseconds
+ *
+ *  commit c7fcb99877f9f542c918509b2801065adcaf46fa
+ *  Author: Cyril Hrubis <chrubis@suse.cz>
+ *  Date:   Wed Aug 2 17:19:05 2023 +0200
+ *
+ *    sched/rt: Fix sysctl_sched_rr_timeslice intial value
  */
 
 #include "time64_variants.h"
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
index 15e4a3053..a61e2969b 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval02.c
@@ -2,6 +2,9 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
+ */
+/*\
+ * [Description]
  *
  * Verify that for a process with scheduling policy SCHED_FIFO,
  * sched_rr_get_interval() writes zero into timespec structure
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index f5a88f084..731c50082 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -2,14 +2,20 @@
 /*
  * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
  *    AUTHOR		: Saji Kumar.V.R <saji.kumar@wipro.com>
+ */
+/*\
+ * [Description]
+ *
+ * Verify that:
+ *
+ * - sched_rr_get_interval() fails with errno set to EINVAL for an
+ *   invalid pid
+ *
+ * - sched_rr_get_interval() fails with errno set to ESRCH if the
+ *   process with specified pid does not exists
  *
- * Verify that
- *  1) sched_rr_get_interval() fails with errno set to EINVAL for an
- *     invalid pid
- *  2) sched_rr_get_interval() fails with errno set to ESRCH if the
- *     process with specified pid does not exists
- *  3) sched_rr_get_interval() fails with errno set to EFAULT if the
- *     address specified as &tp is invalid
+ * - sched_rr_get_interval() fails with errno set to EFAULT if the
+ *   address specified as &tp is invalid
  */
 
 #include "time64_variants.h"
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
