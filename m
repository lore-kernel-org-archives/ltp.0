Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD43C54EED
	for <ltp@archiver.kernel.org>; Mon, 30 Jan 2023 04:03:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AAED3CB340
	for <ltp@archiver.kernel.org>; Mon, 30 Jan 2023 05:03:49 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7B7C3C03E4
 for <ltp@lists.linux.it>; Mon, 30 Jan 2023 05:03:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02CF16005EA
 for <ltp@lists.linux.it>; Mon, 30 Jan 2023 05:03:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBDA8219EA;
 Mon, 30 Jan 2023 04:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1675051416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BKkJctmrSCtcZXJPe6iXv+hGdef2BT219rAv3RhAyL4=;
 b=i9s9hUhJ8mnTbiCPridHfuyvVAIpkDQt6wirHhGpglQEqnzEf1lnT1QIgfavTznnBzSV2e
 c53cnbh98c4aicEshJ0N/gMmVvkVcnFJvKo6w1W80i2w8FtBzfmJqER0gxNS6XtOdeWQwY
 fGqW9tqEDGOrHZsKeTMUoLsdrHfFg4Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5303213A06;
 Mon, 30 Jan 2023 04:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q4qWC5hB12P6aAAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 30 Jan 2023 04:03:36 +0000
To: ltp@lists.linux.it
Date: Sun, 29 Jan 2023 13:39:30 -0500
Message-Id: <20230129183930.2045-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ioctl01.c:Test also struct termios
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ATM we're testing just legacy struct termio in ioctl01.c,
we also need test struct termios.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 28 ++++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 2989c0e9b..cc8d1d731 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -28,26 +28,28 @@ static int fd, fd_file;
 static int bfd = -1;
 
 static struct termio termio;
+static struct termios termios;
 
 static struct tcase {
 	int *fd;
 	int request;
 	struct termio *s_tio;
+	struct termios *s_tios;
 	int error;
 } tcases[] = {
 	/* file descriptor is invalid */
-	{&bfd, TCGETA, &termio, EBADF},
+	{&bfd, TCGETA, &termio, &termios, EBADF},
 	/* termio address is invalid */
-	{&fd, TCGETA, (struct termio *)-1, EFAULT},
+	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
 	/* command is invalid */
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, &termio, ENOTTY},
+	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
 	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, &termio, ENOTTY},
+	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
 	/* termio is NULL */
-	{&fd, TCGETA, NULL, EFAULT}
+	{&fd, TCGETA, NULL, NULL, EFAULT}
 };
 
 static char *device;
@@ -64,7 +66,21 @@ static void verify_ioctl(unsigned int i)
 	if (TST_ERR != tcases[i].error) {
 		tst_res(TFAIL | TTERRNO,
 			"failed unexpectedly; expected %s",
-		        tst_strerrno(tcases[i].error));
+			tst_strerrno(tcases[i].error));
+		return;
+	}
+
+	TEST(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios));
+
+	if (TST_RET != -1) {
+		tst_res(TFAIL, "call succeeded unexpectedly");
+		return;
+	}
+
+	if (TST_ERR != tcases[i].error) {
+		tst_res(TFAIL | TTERRNO,
+			"failed unexpectedly; expected %s",
+			tst_strerrno(tcases[i].error));
 		return;
 	}
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
