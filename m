Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6DEEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:41:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E95AC3CE85A
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 13:41:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A496C3CC0C4
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:40:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C3BE6600159
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:40:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 118351F38D;
 Mon, 11 Sep 2023 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694432456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sTkPA7psl9Up/RAEd1uzD89FGD6qoV/WaSNtOL1rgCk=;
 b=Z5eNnNdia4GiqNsW1Jt1/Fe4z8ypQl/OwKe1VL/JsxDm2lckZyPoeeB8uMUkLPGhFFTY9v
 iMwTNfvqWWSMtP76bqTNHOqI7xgjp5NMtcPGUxNUpNq+aqqQTVVJB9NFaMwb/ZRtzCmlrn
 cZsIGDxoBtcN3JNi/Fsb2zILGZqSnWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694432456;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sTkPA7psl9Up/RAEd1uzD89FGD6qoV/WaSNtOL1rgCk=;
 b=h1tv1uB48LkQ5Tl1MrnDCuy5WbjFoFlqUDUdSzUTV9xKp1JcQIPMgiHb0E4eRmrDfOo9h0
 vpylovps+0/sVrDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE95913780;
 Mon, 11 Sep 2023 11:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5y9UOcf8/mSlbwAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 11 Sep 2023 11:40:55 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 11 Sep 2023 13:40:43 +0200
Message-ID: <20230911114043.29828-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add test descriptions to ioctl01.c
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

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 3ca8a9a3b..d194bbc24 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -35,28 +35,24 @@ static struct termio termio;
 static struct termios termios;
 
 static struct tcase {
+	const char *desc;
 	int *fd;
 	int request;
 	void *s_tio;
 	int error;
 } tcases[] = {
-	/* file descriptor is invalid */
-	{&bfd, TCGETA, &termio, EBADF},
-	{&bfd, TCGETS, &termios, EBADF},
-	/* termio address is invalid */
-	{&fd, TCGETA, (struct termio *)-1, EFAULT},
-	{&fd, TCGETS, (struct termios *)-1, EFAULT},
-	// /* command is invalid */
+	{"File descriptor is invalid (termio)", &bfd, TCGETA, &termio, EBADF},
+	{"File descriptor is invalid (termios)", &bfd, TCGETS, &termios, EBADF},
+	{"Termio address is invalid", &fd, TCGETA, (struct termio *)-1, EFAULT},
+	{"Termios address is invalid", &fd, TCGETS, (struct termios *)-1, EFAULT},
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, &termio, ENOTTY},
-	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, &termio, ENOTTY},
-	{&fd_file, TCGETS, &termios, ENOTTY},
-	/* termio is NULL */
-	{&fd, TCGETA, NULL, EFAULT},
-	{&fd, TCGETS, NULL, EFAULT}
+	{"Command is invalid", &fd, INVAL_IOCTL, &termio, ENOTTY},
+	{"File descriptor is for a regular file (termio)", &fd_file, TCGETA, &termio, ENOTTY},
+	{"File descriptor is for a regular file (termios)", &fd_file, TCGETS, &termios, ENOTTY},
+	{"Termio is NULL", &fd, TCGETA, NULL, EFAULT},
+	{"Termios is NULL", &fd, TCGETS, NULL, EFAULT}
 };
 
 static char *device;
@@ -64,7 +60,7 @@ static char *device;
 static void verify_ioctl(unsigned int i)
 {
 	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
-		     tcases[i].error);
+		     tcases[i].error, "%s", tcases[i].desc);
 }
 
 static void setup(void)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
