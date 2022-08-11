Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3946CC19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:14:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AC133C9613
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:14:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD60C3C9639
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 626001A00CC6
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:14:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D11F738B65
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1660223649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+6g8fp4rIfMcWutDNnK5aKqIOt4uAcboHlZhdm63c8=;
 b=IUYCNrXaiGf3BByAPxiaD1At841JHT8Rrn+TnJXcxHZMWJylgu6VshjhxyA1akXCazZYWZ
 Zf+y/Hpm0hMIUTsAII6fu4Rk0qG3QqcY/L7krkXmWo9CWSpFb0d2shwlG/VRJa/CkbiTCf
 gCiZft38iQ/Ki6rqglfGZsc0EwqoUFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1660223649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+6g8fp4rIfMcWutDNnK5aKqIOt4uAcboHlZhdm63c8=;
 b=vDYUeVus1IXIy6iZXn3ht7khhHK/lcFlWRGI8ElizQr7YOIv9tb6ju9UwpMwAMI5MialzW
 e7KeyDRoHoISEVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B53613A9B
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rJ8wA6EA9WKrXgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 13:14:09 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 18:43:56 +0530
Message-Id: <20220811131358.18906-3-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220811131358.18906-1-akumar@suse.de>
References: <20220811131358.18906-1-akumar@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/5] alarm05: use TST_EXP_* macros
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

- turn comment into docparse format
- make check fix: un-initialize static var
- simplify test using TST_EXP_* macros

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/alarm/alarm05.c | 30 ++++++-----------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/alarm/alarm05.c b/testcases/kernel/syscalls/alarm/alarm05.c
index c60f98994..2a1258f6a 100644
--- a/testcases/kernel/syscalls/alarm/alarm05.c
+++ b/testcases/kernel/syscalls/alarm/alarm05.c
@@ -7,8 +7,9 @@
  * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
- * Test Description:
+/*\
+ * [Description]
+ *
  *  The return value of the alarm system call should be equal to the
  *  amount previously remaining in the alarm clock.
  *  A SIGALRM signal should be received after the specified amount of
@@ -17,34 +18,17 @@
 
 #include "tst_test.h"
 
-static volatile int alarms_fired = 0;
+static volatile int alarms_fired;
 
 static void run(void)
 {
-	unsigned int ret;
-
 	alarms_fired = 0;
 
-	ret = alarm(10);
-	if (ret)
-		tst_res(TFAIL, "alarm() returned non-zero");
-	else
-		tst_res(TPASS, "alarm() returned zero");
-
+	TST_EXP_PASS(alarm(10));
 	sleep(1);
-
-	ret = alarm(1);
-	if (ret == 9)
-		tst_res(TPASS, "alarm() returned remainder correctly");
-	else
-		tst_res(TFAIL, "alarm() returned wrong remained %u", ret);
-
+	TST_EXP_VAL(alarm(1), 9);
 	sleep(2);
-
-	if (alarms_fired == 1)
-		tst_res(TPASS, "alarm handler fired once");
-	else
-		tst_res(TFAIL, "alarm handler filred %u times", alarms_fired);
+	TST_EXP_EQ_LU(alarms_fired, 1);
 }
 
 static void sighandler(int sig)
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
