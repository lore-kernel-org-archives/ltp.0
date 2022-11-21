Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD7FC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 11:51:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD4C83CCBA3
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 12:51:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6691C3C0727
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 12:51:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E57F278CBB8
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 12:51:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5832A1F899
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669031491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aPi57N+RJdyKYDO+CEwR1PsKgNsYT4yij8HEWQAhKd0=;
 b=gmMKgHVRud2YpAAwXUsDXb26ySCCTTwzepml5AvWSA3rA+SYY55NnoOcY1wmH7C3mibzjv
 jHDhyJ6Yjx012D0vBdgoL6cmuFMeDZDUa6zc/kH3ez3GLzsnfCChtcvY2U2K/0/7kp90LB
 DDTYuu2PP0EdlP3dVyt1b3umyNWXAvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669031491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aPi57N+RJdyKYDO+CEwR1PsKgNsYT4yij8HEWQAhKd0=;
 b=GQrVmmxWXfkEUFNrL64+7WbG8cz3vgQtmuux9J/ygLpDCqNdbdDO0OpiaydDUMssAEZJUz
 rRQ7DMFJRTHb7JDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C41261377F
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ADajIEJme2MkQQAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 11:51:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 21 Nov 2022 17:21:28 +0530
Message-Id: <20221121115128.27847-1-akumar@suse.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrlimit01: use TST_EXP_PASS() macro
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
 testcases/kernel/syscalls/getrlimit/getrlimit01.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit01.c b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
index 2a480dfa7..bea37ab1c 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit01.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit01.c
@@ -47,17 +47,9 @@ static void verify_getrlimit(unsigned int i)
 	struct rlimit rlim;
 	struct tcase *tc = &tcases[i];
 
-	TEST(getrlimit(tc->res, &rlim));
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO,
-			"getrlimit() test %s failed",
-			tc->res_str);
-	} else {
-		tst_res(TPASS,
-			"getrlimit() test %s success",
-			tc->res_str);
-	}
+	TST_EXP_PASS(getrlimit(tc->res, &rlim),
+				"getrlimit() test for resource type %s:",
+				tc->res_str);
 }
 
 static struct tst_test test = {
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
