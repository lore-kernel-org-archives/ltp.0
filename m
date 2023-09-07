Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D61EC8732
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 14:22:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8133C3CE9C5
	for <ltp@archiver.kernel.org>; Thu,  7 Sep 2023 16:21:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E86313CC2C7
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 16:21:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19EB020473D
 for <ltp@lists.linux.it>; Thu,  7 Sep 2023 16:21:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CA6221898;
 Thu,  7 Sep 2023 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694096507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3Dv7t8pZHv2JY4QUGjAbCX+PiB5WWgJnJqHp9ABU9wY=;
 b=Dku22tufbai/mDjbPUfKivbmtHmcLvhYY390hiuaTg61t1XYvoQaZKm4U4e4jF0jCHtp00
 Iur1+G2eCR19zeNwhU9w9H98Vc63CkraspuRXeO1GIAR6ofqm+p1SDue10xcFAwBC7/1/+
 i+51wvEwr2prwrQv/vBgCUr4FiAwW00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694096507;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3Dv7t8pZHv2JY4QUGjAbCX+PiB5WWgJnJqHp9ABU9wY=;
 b=7mp+kCrQGrTLECXDFxGHOI2w1gDnAISkcfu7T7lJY74qYupwUHSMOf90useJR6GOFkLvv+
 6TPSyFgNozUE3IDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EAD18138F9;
 Thu,  7 Sep 2023 14:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NzxNOHrc+WRyWQAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 07 Sep 2023 14:21:46 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Sep 2023 16:21:40 +0200
Message-ID: <20230907142141.15388-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Use correct ioctl request for termios
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

With the termios struct one is supposed to use TCGETS instead of TCGETA,
see `man ioctl_tty`.

Related issue: https://github.com/linux-test-project/ltp/issues/637#issuecomment-1705334874

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 1be38e79d..3ca8a9a3b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -37,23 +37,26 @@ static struct termios termios;
 static struct tcase {
 	int *fd;
 	int request;
-	struct termio *s_tio;
-	struct termios *s_tios;
+	void *s_tio;
 	int error;
 } tcases[] = {
 	/* file descriptor is invalid */
-	{&bfd, TCGETA, &termio, &termios, EBADF},
+	{&bfd, TCGETA, &termio, EBADF},
+	{&bfd, TCGETS, &termios, EBADF},
 	/* termio address is invalid */
-	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
-	/* command is invalid */
+	{&fd, TCGETA, (struct termio *)-1, EFAULT},
+	{&fd, TCGETS, (struct termios *)-1, EFAULT},
+	// /* command is invalid */
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
+	{&fd, INVAL_IOCTL, &termio, ENOTTY},
 	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
+	{&fd_file, TCGETA, &termio, ENOTTY},
+	{&fd_file, TCGETS, &termios, ENOTTY},
 	/* termio is NULL */
-	{&fd, TCGETA, NULL, NULL, EFAULT}
+	{&fd, TCGETA, NULL, EFAULT},
+	{&fd, TCGETS, NULL, EFAULT}
 };
 
 static char *device;
@@ -62,9 +65,6 @@ static void verify_ioctl(unsigned int i)
 {
 	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
 		     tcases[i].error);
-
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
-		     tcases[i].error);
 }
 
 static void setup(void)
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
