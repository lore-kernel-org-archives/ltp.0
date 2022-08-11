Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BF8C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:15:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 946D33C95EF
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:15:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0DB3C9739
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 174AD600A65
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64F245CD0A
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660223657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0M8gY0tQWONO46k7dGSfUGmhgB283cxXHoVKKgt/kzg=;
 b=JjAhkZ7HMNKYrgFr2gmAvbhcZc4hjSHn9jVInMuGfMqB/KmiaTXOA9dtnwfKxZf+FU96qx
 v4ThP1u0FdN5+LPDS6V5oUMDvwCzUhZCfP40zQTh3wCDRXDUh5TwyL4o63Vcy2kvYeYCkG
 VoESOafFETUeuGoXwjD9Jbp6WLQg5Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660223657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0M8gY0tQWONO46k7dGSfUGmhgB283cxXHoVKKgt/kzg=;
 b=gbD3cjo2U1L4qjV8vwCCvHlX4tASGCG+obOqVoIqPd1rwZQk/0GC68mzpAhD5cOd5CZt6r
 loOBW/EilZLicmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDA0B13A9B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VaMDIqgA9WK9XgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:16 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 18:43:58 +0530
Message-Id: <20220811131358.18906-5-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220811131358.18906-1-akumar@suse.de>
References: <20220811131358.18906-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] alarm07: cleanup and simplify
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

- copyright update
- description comment into docparse format and reword
- remove duplicated headers
- make check fix: un-initialize static var
- use TST_EXP_* macros

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/alarm/alarm07.c | 31 +++++++++--------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index 47c30dc76..17d81f594 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -2,45 +2,38 @@
 /*
  * Copyright (c) International Business Machines  Corp., 2001
  * Author: Wayne Boyer
+ * Copyright (c) Linux Test Project, 2009-2022
+ */
+
+/*\
+ * [Description]
  *
- * Test Description:
- *  By the SIGALRM signal, check whether the previously specified alarm request
- *  was cleared in the child process or not.
+ * Verify that SIGALRM signal scheduled by alarm() in the parent process
+ * is not delivered to the child process.
  */
 
-#include <unistd.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <signal.h>
-
 #include "tst_test.h"
 
-static volatile int alarm_cnt = 0;
+static volatile int alarm_cnt;
 
 static void verify_alarm(void)
 {
 	pid_t pid;
+
 	alarm_cnt = 0;
 
-	TEST(alarm(1));
+	TST_EXP_PASS_SILENT(alarm(1));
 	pid = SAFE_FORK();
 
 	sleep(3);
 
 	if (pid == 0) {
-		if (alarm_cnt == 0) {
-			tst_res(TPASS, "alarm() request cleared in child");
-		} else {
-			tst_res(TFAIL, "alarm() request not cleared in "
-				"child; alarms received:%d", alarm_cnt);
-		}
+		TST_EXP_EQ_LU(alarm_cnt, 0);
 		exit(0);
 	}
 
-	if (alarm_cnt != 1)
-		tst_res(TFAIL, "Sigalarms in parent %i, expected 1", alarm_cnt);
-	else
-		tst_res(TPASS, "Got 1 sigalarm in parent");
+	TST_EXP_EQ_LU(alarm_cnt, 1);
 }
 
 static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
