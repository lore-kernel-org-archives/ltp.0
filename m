Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A59C4332F
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 07:50:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EB533CC65B
	for <ltp@archiver.kernel.org>; Wed,  8 Nov 2023 08:50:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73563C62E0
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 08:49:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 89F651400B6E
 for <ltp@lists.linux.it>; Wed,  8 Nov 2023 08:49:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97C771F8AE;
 Wed,  8 Nov 2023 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699429788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/Emo8/49q3+pBIABXpYPg9pBpEBgY9DYglWE65/ZCU=;
 b=vG0zhrQvBW6KFI1Ghy7o8F7vI8CtrQUZBx005uSGlKgbTmbWusZXxNASscRJS/1K+p0alJ
 He1+XXeUtskxqSnu2qfLh9W/mL5HiAq+3JfGvc45Wg4XV83twfxLrOQqCbLe5jEgDtCsaA
 WxXrPeCokx0ex3QzeRMc4WuYgmfPMDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699429788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/Emo8/49q3+pBIABXpYPg9pBpEBgY9DYglWE65/ZCU=;
 b=MsGWbOCq+vf2gptm8ZWCsEmeHVVcxxKqpt5tzd3/vA5RT3n/h5xHvNv7jhrEN3jcAt3x6Q
 p6w0nkk5zXdyhQAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EC9B133F5;
 Wed,  8 Nov 2023 07:49:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AAzfGZw9S2WrIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Nov 2023 07:49:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Nov 2023 08:49:35 +0100
Message-ID: <20231108074935.1409644-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108074935.1409644-1-pvorel@suse.cz>
References: <20231108074935.1409644-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] link05: Use constant for number of links
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
Cc: tangmeng <tangmeng@uniontech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

No need to create variable, when number of links is not changed.

Fixes: d908fd870 ("link/link05: Convert to new API")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/link/link05.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/link/link05.c b/testcases/kernel/syscalls/link/link05.c
index 1d708c6f6..a188da18d 100644
--- a/testcases/kernel/syscalls/link/link05.c
+++ b/testcases/kernel/syscalls/link/link05.c
@@ -15,18 +15,17 @@
 #include "tst_test.h"
 
 #define BASENAME	"lkfile"
+#define NLINKS	1000
 
 static char fname[255];
 
-static int nlinks = 1000;
-
 static void verify_link(void)
 {
 	int cnt = 0, created;
 	char lname[1024];
 	struct stat fbuf, lbuf;
 
-	for (created = 1; created < nlinks; created++) {
+	for (created = 1; created < NLINKS; created++) {
 		sprintf(lname, "%s_%d", fname, created);
 		TST_EXP_PASS_SILENT(link(fname, lname), "%d: link(%s, %s)", created,
 							fname, lname);
@@ -36,7 +35,7 @@ static void verify_link(void)
 
 	SAFE_STAT(fname, &fbuf);
 
-	for (cnt = 1; cnt < nlinks; cnt++) {
+	for (cnt = 1; cnt < NLINKS; cnt++) {
 		sprintf(lname, "%s_%d", fname, cnt);
 
 		SAFE_STAT(lname, &lbuf);
@@ -45,16 +44,16 @@ static void verify_link(void)
 
 			tst_res(TFAIL,
 				 "link(%s, %s[1-%d]) ret %ld for %d files, stat values do not match %d %d",
-				 fname, fname, nlinks, TST_RET, nlinks,
+				 fname, fname, NLINKS, TST_RET, NLINKS,
 				 (int)fbuf.st_nlink, (int)lbuf.st_nlink);
 			break;
 		}
 	}
 
-	if (cnt == nlinks) {
+	if (cnt == NLINKS) {
 		tst_res(TPASS,
 			 "link(%s, %s[1-%d]) ret %ld for %d files, stat linkcounts match %d",
-			 fname, fname, nlinks, TST_RET, nlinks, (int)fbuf.st_nlink);
+			 fname, fname, NLINKS, TST_RET, NLINKS, (int)fbuf.st_nlink);
 	}
 
 cleanup:
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
