Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2D7C61DA4
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 06:04:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D03B83CB229
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 07:04:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EAB03C2A67
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:04:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 377901000617
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 07:04:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EEF921C1A;
 Mon,  6 Feb 2023 06:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675663450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ul8iN6x9gXuuiw4hJ+PBoFjF7/dVHRAR86WTD8j3xRc=;
 b=ginFq0PN1aniL0aeipupEEeAwW7tVugLkTPxblAg3f+HJFa3wFTFGZH2870Vf/I72LV+M/
 L8eNUldAwedmTKKUNIJMIs08bW7C/AH5p6KyXwZnyMr83iSVxueQF7B8w+5suhzajLD5CB
 nt97cfPgPAsOZC1MxE6GSS0pMT5vFGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675663450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ul8iN6x9gXuuiw4hJ+PBoFjF7/dVHRAR86WTD8j3xRc=;
 b=m+PfF233/Oz2+91G15Cy93UTJBHCkPVTJpR1LA/hcbFA2BaolsiamCnNy/iCAojjrqXxc+
 5y6dN1y196uy5jBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B0F31390C;
 Mon,  6 Feb 2023 06:04:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dgcLEVqY4GNENQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 06:04:10 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Feb 2023 07:04:06 +0100
Message-Id: <20230206060406.12036-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED 1/1] ioctl01: cleanup
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

* use TST_EXP_FAIL()
* convert doc to docparse
* remove unused variable

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 37 ++++++++---------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 2989c0e9be..ccc48cdb23 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -2,17 +2,21 @@
 /*
  * Copyright (c) International Business Machines Corp., 2001
  * Copyright (c) 2020 Petr Vorel <petr.vorel@gmail.com>
+ * Copyright (c) Linux Test Project, 2002-2023
  * 07/2001 Ported by Wayne Boyer
  * 04/2002 Fixes by wjhuie
+ */
+
+/*\
+ * [Description]
  *
- *	Testcase to check the errnos set by the ioctl(2) system call.
+ * Testcase to check the errnos set by the ioctl(2) system call.
  *
- * ALGORITHM
- *	1. EBADF: Pass an invalid fd to ioctl(fd, ..) and expect EBADF.
- *	2. EFAULT: Pass an invalid address of arg in ioctl(fd, .., arg)
- *	3. EINVAL: Pass invalid cmd in ioctl(fd, cmd, arg)
- *	4. ENOTTY: Pass an non-streams fd in ioctl(fd, cmd, arg)
- *	5. EFAULT: Pass a NULL address for termio
+ * - EBADF: Pass an invalid fd to ioctl(fd, ...) and expect EBADF
+ * - EFAULT: Pass an invalid address of arg in ioctl(fd, ..., arg)
+ * - EINVAL: Pass invalid cmd in ioctl(fd, cmd, arg)
+ * - ENOTTY: Pass an non-streams fd in ioctl(fd, cmd, arg)
+ * - EFAULT: Pass a NULL address for termio
  */
 
 #include <errno.h>
@@ -54,27 +58,12 @@ static char *device;
 
 static void verify_ioctl(unsigned int i)
 {
-	TEST(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "call succeeded unexpectedly");
-		return;
-	}
-
-	if (TST_ERR != tcases[i].error) {
-		tst_res(TFAIL | TTERRNO,
-			"failed unexpectedly; expected %s",
-		        tst_strerrno(tcases[i].error));
-		return;
-	}
-
-	tst_res(TPASS | TTERRNO, "failed as expected");
+	TST_EXP_FAIL(ioctl(*(tcases[i].fd), tcases[i].request, tcases[i].s_tio),
+		     tcases[i].error);
 }
 
 static void setup(void)
 {
-	unsigned int i;
-
 	if (!device)
 		tst_brk(TBROK, "You must specify a tty device with -D option");
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
