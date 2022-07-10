Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2ACC43334
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 10:45:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D17633CA50C
	for <ltp@archiver.kernel.org>; Sun, 10 Jul 2022 12:45:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44E2C3C1BF3
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 12:44:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A50B1000419
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 12:44:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33EF9221C8
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657449893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mjpOrFSeHoIqHsOjm4WsS/KH9GMT6WeYofyuJh3KU0M=;
 b=11qSvbAv0pqT8SyzbKZVRz9m03dC2WgIPdYbC7x9iJXof9nwYbZp9I+L/OReuM0izB+1Y/
 CZSUju2v6wFCxZ8MHEwe26DmDDoNtxyru5KNAC3NwDz7kzKyB21e9M2kmM716HZ3xj6WdD
 /Kfh4zFm/uajO8pRwZ+GEY2um9vBBBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657449893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mjpOrFSeHoIqHsOjm4WsS/KH9GMT6WeYofyuJh3KU0M=;
 b=YgkvEmQZoMsn8YyR2aL/BHBuCOGY7Nfrn7X9DokT7MwxNJJHQjHhHyPkioSRlxNzZpbLKq
 94lAV1nrAiazwODQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89126132FD
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 10:44:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FKoMD6StymIVJAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Sun, 10 Jul 2022 10:44:52 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Sun, 10 Jul 2022 16:14:49 +0530
Message-Id: <20220710104449.10387-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] open08.c: Use TST_EXP_FAIL2() and SAFE_CLOSE()
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

Make use of TST_EXP_FAIL2() macro with testcase descriptions

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/open/open08.c | 36 ++++++++-----------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 890fe2818..0742324c9 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -33,34 +33,20 @@ static struct test_case_t {
 	char **fname;
 	int flags;
 	int error;
+	const char *desc;
 } tcases[] = {
-	{&existing_fname, O_CREAT | O_EXCL, EEXIST},
-	{&dir_fname, O_RDWR, EISDIR},
-	{&existing_fname, O_DIRECTORY, ENOTDIR},
-	{&toolong_fname, O_RDWR, ENAMETOOLONG},
-	{&user2_fname, O_WRONLY, EACCES},
-	{&unmapped_fname, O_CREAT, EFAULT}
+	{&existing_fname, O_CREAT | O_EXCL, EEXIST, "open() existing file with 'O_CREAT | O_EXCL'"},
+	{&dir_fname, O_RDWR, EISDIR, "open() existing directory with write access"},
+	{&existing_fname, O_DIRECTORY, ENOTDIR, "open() non-directory pathname with O_DIRECTORY"},
+	{&toolong_fname, O_RDWR, ENAMETOOLONG, "open() too long pathname"},
+	{&user2_fname, O_WRONLY, EACCES, "open() file without requested access rights"},
+	{&unmapped_fname, O_CREAT, EFAULT, "open() pathname with bad address"}
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
+	TST_EXP_FAIL2(open(*tcases[i].fname, tcases[i].flags, 0644),
+				tcases[i].error, "%s", tcases[i].desc);
 }
 
 static void setup(void)
@@ -79,7 +65,7 @@ static void setup(void)
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
