Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE237C83F33
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 14:51:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 161413CEBFC
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 16:51:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE66A3CB8C0
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 16:50:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C623E1A00918
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 16:50:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3157F1F74B;
 Mon,  4 Sep 2023 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693839049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AXfVkCL07TBhx75HrT6gdTzYpeNGHL8cs1fPOCJ4nWY=;
 b=qthcxQlt0dRGKdPf7bjxK1P87+p5iuHBTOzSVD0nXnDydWSMrKxFXhvchaYjPOq9Z0yUX9
 2xLuPGDORIn6Bm7z16AmKM/LCSmWejADKeDQIqxZixmLfuRVzNx4/eq94EuZQw+E7KpIIJ
 WebBnNNATD71PyaX2FS1e4NDf/nKob8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693839049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=AXfVkCL07TBhx75HrT6gdTzYpeNGHL8cs1fPOCJ4nWY=;
 b=YiMOw54O0q5JSsgsg2A5YNO/CHIkvjqFIRtm27vSjH6ZPVlmOZIuzyVwoouduH6vftO8wd
 umufrc7iaVDr/LDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C4F213425;
 Mon,  4 Sep 2023 14:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kGL0Bcnu9WTNOgAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 04 Sep 2023 14:50:49 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 16:50:35 +0200
Message-ID: <20230904145035.22939-1-mkittler@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Use correct ioctl request for termios
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
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 1be38e79d..983208925 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -36,34 +36,35 @@ static struct termios termios;
 
 static struct tcase {
 	int *fd;
-	int request;
+	int request_tio;
+	int request_tios;
 	struct termio *s_tio;
 	struct termios *s_tios;
 	int error;
 } tcases[] = {
 	/* file descriptor is invalid */
-	{&bfd, TCGETA, &termio, &termios, EBADF},
+	{&bfd, TCGETA, TCGETS, &termio, &termios, EBADF},
 	/* termio address is invalid */
-	{&fd, TCGETA, (struct termio *)-1, (struct termios *)-1, EFAULT},
-	/* command is invalid */
+	{&fd, TCGETA, TCGETS, (struct termio *)-1, (struct termios *)-1, EFAULT},
+	// /* command is invalid */
 	/* This errno value was changed from EINVAL to ENOTTY
 	 * by kernel commit 07d106d0 and bbb63c51
 	 */
-	{&fd, INVAL_IOCTL, &termio, &termios, ENOTTY},
+	{&fd, INVAL_IOCTL, INVAL_IOCTL, &termio, &termios, ENOTTY},
 	/* file descriptor is for a regular file */
-	{&fd_file, TCGETA, &termio, &termios, ENOTTY},
+	{&fd_file, TCGETA, TCGETS, &termio, &termios, ENOTTY},
 	/* termio is NULL */
-	{&fd, TCGETA, NULL, NULL, EFAULT}
+	{&fd, TCGETA, TCGETS, NULL, NULL, EFAULT}
 };
 
 static char *device;
 
 static void verify_ioctl(unsigned int i)
 {
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
+	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tio, tcases[i].s_tio),
 		     tcases[i].error);
 
-	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tios),
+	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request_tios, tcases[i].s_tios),
 		     tcases[i].error);
 }
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
