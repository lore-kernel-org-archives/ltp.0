Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A8CC001DB
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 11:57:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C39F53CD06E
	for <ltp@archiver.kernel.org>; Fri, 11 Aug 2023 13:57:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC54D3CD065
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E78126008DD
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 13:55:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9268D2187C
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691754949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyb3sqYfC6xXJfBB6KvyeVubd/PSZvqJjM4R7KcdSPA=;
 b=oL7ZbsxXnwQR3ya4zCObKSoBr5KNxFKFW7kJdFuUbT6tOHuDqq9cIE1WqIqbELeUGzib0j
 FUa1RASF4wn0DWbW1O2SyAydGHbMmD1OBDjmWTEGs3yTt1K7wBJHKhjsiBjW70qkWKriKd
 TF3i43ViQQ8vf4NPV1xq8B05dEiuKag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691754949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyb3sqYfC6xXJfBB6KvyeVubd/PSZvqJjM4R7KcdSPA=;
 b=vw5LOE+U2ALUIFLgFQJt5dlrPwNHIyf/N7xpvzg/iFAfNjffq6bw1x/B+LiBO3NVpQE7IF
 F2PEPlWno44JNoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BC9E138E2
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ASPzHMUh1mQNWwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 11 Aug 2023 11:55:49 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 11 Aug 2023 13:56:46 +0200
Message-ID: <20230811115647.32387-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230811115647.32387-1-chrubis@suse.cz>
References: <20230811115647.32387-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] syscalls/chmod01: Make use of guarded buffers
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
 testcases/kernel/syscalls/chmod/chmod01.c | 28 +++++++++++++++--------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 9f5ec4c67..b3b828ac3 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -19,13 +19,16 @@
 
 static int modes[] = {0, 07, 070, 0700, 0777, 02777, 04777, 06777};
 
+static char *test_dir;
+static char *test_file;
+
 static struct variant {
-	char *name;
+	char **name;
 	unsigned int mode_mask;
 	char *desc;
 } variants[] = {
-	{TESTFILE, S_IFREG, "verify permissions of file"},
-	{TESTDIR, S_IFDIR, "verify permissions of directory"},
+	{&test_file, S_IFREG, "verify permissions of file"},
+	{&test_dir, S_IFDIR, "verify permissions of directory"},
 };
 
 static void verify_chmod(unsigned int n)
@@ -34,21 +37,21 @@ static void verify_chmod(unsigned int n)
 	int mode = modes[n];
 	struct variant *tc = &variants[tst_variant];
 
-	TST_EXP_PASS(chmod(tc->name, mode), "chmod(%s, %04o)",
-	             tc->name, mode);
+	TST_EXP_PASS(chmod(*tc->name, mode), "chmod(%s, %04o)",
+	             *tc->name, mode);
 
 	if (!TST_PASS)
 		return;
 
-	SAFE_STAT(tc->name, &stat_buf);
+	SAFE_STAT(*tc->name, &stat_buf);
 	stat_buf.st_mode &= ~tc->mode_mask;
 
 	if (stat_buf.st_mode == (unsigned int)mode) {
 		tst_res(TPASS, "stat(%s) mode=%04o",
-				tc->name, stat_buf.st_mode);
+				*tc->name, stat_buf.st_mode);
 	} else {
 		tst_res(TFAIL, "stat(%s) mode=%04o",
-				tc->name, stat_buf.st_mode);
+				*tc->name, stat_buf.st_mode);
 	}
 }
 
@@ -57,9 +60,9 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 
 	if (tst_variant)
-		SAFE_MKDIR(variants[tst_variant].name, MODE);
+		SAFE_MKDIR(*variants[tst_variant].name, MODE);
 	else
-		SAFE_TOUCH(variants[tst_variant].name, MODE, NULL);
+		SAFE_TOUCH(*variants[tst_variant].name, MODE, NULL);
 }
 
 static struct tst_test test = {
@@ -68,4 +71,9 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(modes),
 	.test = verify_chmod,
 	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&test_file, .str = TESTFILE},
+		{&test_dir, .str = TESTDIR},
+		{}
+	}
 };
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
