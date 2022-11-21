Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CD9C433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 11:50:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A5323CCBC0
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 12:50:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CA333C0727
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 12:50:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 294D32C884F
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 12:50:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B8AD1F85D
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669031442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ousBBVOEMCt1OzPBo21RzugBBf7GoQyfkMNKCYYVN6E=;
 b=R7zo3d54Jdq9QnxDvimyUKSPBdN21WgXKuFilz6XCpWKHrOJXvbZlkumR2QxTyoz3lHi1n
 gaEKvMoqGzNsbz1wihXu6yerP800JyBTapmqf9AP4VxBmk6geaDuH+V8WVW2enoY9AlEkv
 B8MaQYQYwCKp/sAJhegwGFpSq1qi32w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669031442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ousBBVOEMCt1OzPBo21RzugBBf7GoQyfkMNKCYYVN6E=;
 b=1ZGkxO4r3DayNU39kCIw9646Fungu0YFcumBPBigygx8k1NH0DUAzivWISeqdTvrp5M+dV
 JUXr0HTl6cySniDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE9231377F
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id a9bzJhFme2OwQAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:50:41 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 17:20:38 +0530
Message-Id: <20221121115038.27564-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrlimit02: add EFAULT case & use TST_EXP_FAIL()
 macro
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../kernel/syscalls/getrlimit/getrlimit02.c   | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit02.c b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
index 586ca5a67..9b68ce20b 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit02.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit02.c
@@ -18,33 +18,28 @@
 #include <sys/resource.h>
 #include "tst_test.h"
 
-#define RLIMIT_TOO_HIGH 1000
+#define INVALID_RES_TYPE 1000
 
 static struct rlimit rlim;
 
 static struct tcase {
-	int exp_errno;		/* Expected error no            */
-	char *exp_errval;	/* Expected error value string  */
-	struct rlimit *rlim;	/* rlimit structure             */
-	int res_type;		/* resource type                */
+	int exp_errno;
+	char *desc;
+	struct rlimit *rlim;
+	int res_type;
 } tcases[] = {
-	{ EINVAL, "EINVAL", &rlim, RLIMIT_TOO_HIGH}
+	{EFAULT, "invalid address", (void *)-1, RLIMIT_CORE},
+	{EINVAL, "invalid resource type", &rlim, INVALID_RES_TYPE}
 };
 
 static void verify_getrlimit(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	TEST(getrlimit(tc->res_type, tc->rlim));
-
-	if ((TST_RET == -1) && (TST_ERR == tc->exp_errno)) {
-		tst_res(TPASS, "expected failure; got %s",
-			 tc->exp_errval);
-	} else {
-		tst_res(TFAIL, "call failed to produce "
-			 "expected error;  errno: %d : %s",
-			 TST_ERR, strerror(TST_ERR));
-	}
+	TST_EXP_FAIL(getrlimit(tc->res_type, tc->rlim),
+				tc->exp_errno,
+				"getrlimit() with %s",
+				tc->desc);
 }
 
 static struct tst_test test = {
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
