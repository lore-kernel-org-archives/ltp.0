Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FED3C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 030963C95CA
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:14:50 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E3123C95E8
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 72DEA600875
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C25738B68
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660223653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLmkRFINwRcaQpn2BybBiwLGq4vojHhE5Onku38ZmQk=;
 b=lYAnUFsMTDrWdx8A8DNkibvZX0SKmRv30PNLqPDyk0VGIaVMbjbXhWA4+wYwlfqQL9ovI1
 /ABoJPcuN3DybGDfDWdgJ2hDteklYEZ6s6uUWNSzB47r+/0M5Rh0wXL+FbUp69BJ1AKngE
 ESVZXtC24IX76rVlarS2g8c6sxSU6ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660223653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLmkRFINwRcaQpn2BybBiwLGq4vojHhE5Onku38ZmQk=;
 b=SxBXfXg/u1vPLY87QFWLC0WM9LgNgk0BA/2ohLhZgEJUfwEkU6FDplXTT9cuyFJPUo/7+x
 8IjqAfuigWSHYlDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED9DD13AF7
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1tmzKqQA9WKvXgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:12 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 18:43:57 +0530
Message-Id: <20220811131358.18906-4-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220811131358.18906-1-akumar@suse.de>
References: <20220811131358.18906-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] alarm06: cleanup and simplify
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

- turn description comment into docparse and reword
- remove duplicated headers
- make check fix: un-initialize static var
- test using TST_EXP_* macros

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/alarm/alarm06.c | 34 +++++------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm06.c b/testcases/kernel/syscalls/alarm/alarm06.c
index eee9429a1..e5c0d3768 100644
--- a/testcases/kernel/syscalls/alarm/alarm06.c
+++ b/testcases/kernel/syscalls/alarm/alarm06.c
@@ -5,25 +5,15 @@
  * Ported to LTP: Wayne Boyer
  */
 
-/*
- * Check the functionality of the Alarm system call when the time input
- * parameter is zero.
+/*\
+ * [Description]
  *
- * Expected Result:
- * The previously specified alarm request should be cancelled and the
- * SIGALRM should not be received.
+ * Verify that any pending alarm() is canceled when seconds is zero.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <string.h>
-#include <signal.h>
-
 #include "tst_test.h"
 
-static volatile int alarms_received = 0;
+static volatile int alarms_received;
 
 static void sigproc(int sig)
 {
@@ -38,25 +28,15 @@ static void setup(void)
 
 static void verify_alarm(void)
 {
-	int ret;
-
-	alarm(2);
+	TST_EXP_PASS_SILENT(alarm(2));
 	sleep(1);
 
-	ret = alarm(0);
+	TST_EXP_VAL(alarm(0), 1);
 
 	/* Wait for signal SIGALRM */
 	sleep(2);
 
-	if (alarms_received)
-		tst_res(TFAIL, "Received %i alarms", alarms_received);
-	else
-		tst_res(TPASS, "Received 0 alarms");
-
-	if (ret == 1)
-		tst_res(TPASS, "alarm(0) returned 1");
-	else
-		tst_res(TFAIL, "alarm(0) returned %i, expected 1", ret);
+	TST_EXP_EQ_LU(alarms_received, 0);
 }
 
 static struct tst_test test = {
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
