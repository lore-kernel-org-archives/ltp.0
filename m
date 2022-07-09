Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26EE6C433EF
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 16:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3CF03CA4AA
	for <ltp@archiver.kernel.org>; Sat,  9 Jul 2022 18:50:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA9723CA360
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E02D6006C4
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 18:50:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD8E921F3D
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657385406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yn4yM2FugtO4LZKnE7vq4AnOqK5tEe6SVrBqIOoT+yA=;
 b=lN+lTWZ05wJjGwDIKGrMMCVrBebBuzzGUczt2xnOt+YhdsYD6W3Mgnm6f9PsCXJH5hREKn
 bvxkNOlSfyMH6uCYX4lGeeNQBHJ8waaI11QRmZu2oz1B+3tLjfEpXz5Xp652SsNnVoOwXa
 smrIqmVJdqPZUwHhcqbP8O0+N5PRh5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657385406;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Yn4yM2FugtO4LZKnE7vq4AnOqK5tEe6SVrBqIOoT+yA=;
 b=mIG6jEJhxtmwWm6G2noqfz63p2GCbGOv/dZYN72gOHxs+Am4U0DCV4to4Zt6a39dDo4NkF
 Og6oBcHOFUjAyWCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47D9813482
 for <ltp@lists.linux.it>; Sat,  9 Jul 2022 16:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zn4yAr6xyWJeagAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sat, 09 Jul 2022 16:50:06 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sat,  9 Jul 2022 22:19:59 +0530
Message-Id: <20220709165000.27830-2-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] open08.c: Make use of TST_EXP_FAIL() and SAFE_CLOSE()
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
 testcases/kernel/syscalls/open/open08.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 29a23c2f7..8bb151447 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -68,25 +68,10 @@ static struct test_case_t {
 	{&unmapped_fname, O_CREAT, EFAULT}
 };
 
-void verify_open(unsigned int i)
+static void verify_open(unsigned int i)
 {
-	TEST(open(*tcases[i].fname, tcases[i].flags,
-		S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "call succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR == tcases[i].error) {
-		tst_res(TPASS, "expected failure - "
-				"errno = %d : %s", TST_ERR,
-				strerror(TST_ERR));
-	} else {
-		tst_res(TFAIL, "unexpected error - %d : %s - "
-				"expected %d", TST_ERR,
-				strerror(TST_ERR), tcases[i].error);
-	}
+	TST_EXP_FAIL(open(*tcases[i].fname, tcases[i].flags, 0644),
+				tcases[i].error);
 }
 
 static void setup(void)
@@ -105,7 +90,7 @@ static void setup(void)
 	SAFE_SETUID(ltpuser->pw_uid);
 
 	fildes = SAFE_CREAT(existing_fname, 0600);
-	close(fildes);
+	SAFE_CLOSE(fildes);
 
 	unmapped_fname = tst_get_bad_addr(NULL);
 }
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
