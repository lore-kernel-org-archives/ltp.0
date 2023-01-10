Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59895C46467
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 13:01:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15633CCB4E
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 14:01:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34A253CA6C2
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 14:01:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5ABF4200746
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 14:01:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 21F6875EFE
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673355699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sh9li3YLzxzFDl6K2UdsE0xSgCalanFSyDiLblAxuX0=;
 b=ZnjkRXFfG5wUls2onI4uliCGsMjRELct79GA08qpKqNWLYTFmzF5zj1GBI40QlDR4+rtPh
 BaG8h+Fn7VCtFt2WYNaisiMPM7vp9JSMcgbGeXF/hhdOTgGVaNRYZh90tF70VPpl+AaeGB
 I5GFxBrXkHkuOnT5nPNiGl3nRwlCtsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673355699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sh9li3YLzxzFDl6K2UdsE0xSgCalanFSyDiLblAxuX0=;
 b=fAU6aIIUgfcpaT4kDo5FUFwjpeQm6EQbhL0/3NU3huTMV9icZMnRaO/CHUHlOFbh2Vw9x3
 HWocY9yBdKCbQoCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9737313338
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 13:01:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3WeSFbJhvWMCLgAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 13:01:38 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 10 Jan 2023 18:31:35 +0530
Message-Id: <20230110130135.27979-1-akumar@suse.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] setregid01.c: Turn comment into docparse format and
 use TST_EXP_PASS macro
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
 .../kernel/syscalls/setregid/setregid01.c     | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid01.c b/testcases/kernel/syscalls/setregid/setregid01.c
index 8c9e11918..741028a4a 100644
--- a/testcases/kernel/syscalls/setregid/setregid01.c
+++ b/testcases/kernel/syscalls/setregid/setregid01.c
@@ -15,14 +15,16 @@
  * Co-pilot: Dave Fenner
  */
 
-/*
- * Testcase to test the basic functionality of setregid(2) systemm call.
+/*\
+ * [Description]
+ *
+ * Verify the basic functionality of setregid(2) system call.
  */
 
 #include "tst_test.h"
 #include "compat_tst_16.h"
 
-static gid_t gid, egid;	    /* current real and effective group id */
+static gid_t gid, egid;
 static gid_t neg_one = -1;
 
 static struct tcase {
@@ -30,23 +32,18 @@ static struct tcase {
 	gid_t *arg2;
 	const char *msg;
 } tcases[] = {
-	{&neg_one, &neg_one, "Dont change either real or effective gid" },
+	{&neg_one, &neg_one, "Leave real and effective both gids unchanged" },
 	{&neg_one, &egid,    "Change effective to effective gid" },
 	{&gid,     &neg_one, "Change real to real gid" },
 	{&neg_one, &gid,     "Change effective to real gid" },
-	{&gid,     &gid,     "Try to change real to current real" }
+	{&gid,     &gid,     "Change real and effective both gids to current real gid" }
 };
 
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 
-	TEST(SETREGID(*tc->arg1, *tc->arg2));
-
-	if (TST_RET == -1)
-		tst_res(TFAIL | TTERRNO, "%s", tc->msg);
-	else
-		tst_res(TPASS, "%s", tc->msg);
+	TST_EXP_PASS(SETREGID(*tc->arg1, *tc->arg2), "%s:", tc->msg);
 }
 
 static void setup(void)
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
