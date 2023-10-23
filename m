Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25E4C004C0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:03:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075033CF9C4
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 18:03:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41C113CECEF
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3AFC51A0BC41
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C7801FE25;
 Mon, 23 Oct 2023 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698076968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5GUQAyl8BbAqwIsjAKs3GrHf6R4kpS5NpI90mSgHpA=;
 b=NFOq1DuV0YNlErC+3xczntsgkX5f6m12wc03ZImDsTTCjQC2AkrG4B94lXrqA8sq3Getck
 IqlXPfBZ6YD8gir6ULWJe91kM75hCe5k+1p9ri3Y87fF1J1b2J27/2hfVsDQQdSoTNrQ28
 Rhgloh2RpmEfxXZXLhMiYhUXcoNgiLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698076968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5GUQAyl8BbAqwIsjAKs3GrHf6R4kpS5NpI90mSgHpA=;
 b=i8RTD6NeEwkw2iVvI8wOdfvxbHorIuzxDTtFhsjX0qsQtPSivKzHxEMrYbKXtG/0oS+nnH
 E8Vp25DW1IUm8+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04AEC13A82;
 Mon, 23 Oct 2023 16:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eAdPOyeZNmVhJAAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 23 Oct 2023 16:02:47 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 18:02:41 +0200
Message-ID: <20231023160242.3605-5-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023160242.3605-1-mkittler@suse.de>
References: <20231023160242.3605-1-mkittler@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 4/5] Use termios instead of legacy struct in
 ioctl02.c
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
 testcases/kernel/syscalls/ioctl/ioctl02.c | 24 +++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index c66473a8d..5111d7178 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -8,17 +8,17 @@
 /*\
  * [Description]
  *
- * Testcase to test the TCGETA, and TCSETA ioctl implementations for
+ * Testcase to test the TCGETS, and TCSETS ioctl implementations for
  * the tty driver
  *
  * In this test, the parent and child open the parentty and the childtty
  * respectively.  After opening the childtty the child flushes the stream
  * and wakes the parent (thereby asking it to continue its testing). The
- * parent, then starts the testing. It issues a TCGETA ioctl to get all
+ * parent, then starts the testing. It issues a TCGETS ioctl to get all
  * the tty parameters. It then changes them to known values by issuing a
- * TCSETA ioctl. Then the parent issues a TCGETA ioctl again and compares
+ * TCSETS ioctl. Then the parent issues a TCGETS ioctl again and compares
  * the received values with what it had set earlier. The test fails if
- * TCGETA or TCSETA fails, or if the received values don't match those
+ * TCGETS or TCSETS fails, or if the received values don't match those
  * that were set. The parent does all the testing, the requirement of the
  * child process is to moniter the testing done by the parent, and hence
  * the child just waits for the parent.
@@ -38,7 +38,7 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 
-static struct termio termio, save_io;
+static struct termios termio, save_io;
 
 static char *parenttty, *childtty;
 static int parentfd = -1, childfd = -1;
@@ -82,7 +82,7 @@ static void verify_ioctl(void)
 
 /*
  * run_ptest() - setup the various termio structure values and issue
- *		 the TCSETA ioctl call with the TEST macro.
+ *		 the TCSETS ioctl call with the TEST macro.
  */
 static void run_ptest(void)
 {
@@ -111,10 +111,10 @@ static void run_ptest(void)
 	/* Set output modes. */
 	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
 
-	SAFE_IOCTL(parentfd, TCSETA, &termio);
+	SAFE_IOCTL(parentfd, TCSETS, &termio);
 
 	/* Get termio and see if all parameters actually got set */
-	SAFE_IOCTL(parentfd, TCGETA, &termio);
+	SAFE_IOCTL(parentfd, TCGETS, &termio);
 	chk_tty_parms();
 }
 
@@ -175,10 +175,10 @@ static void chk_tty_parms(void)
 	}
 
 	if (flag != 0)
-		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
+		tst_res(TFAIL, "TCGETS/TCSETS tests FAILED with "
 				"%d %s", flag, flag > 1 ? "errors" : "error");
 	else
-		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
+		tst_res(TPASS, "TCGETS/TCSETS tests SUCCEEDED");
 }
 
 static int do_child_setup(void)
@@ -202,7 +202,7 @@ static void setup(void)
 	int fd = SAFE_OPEN(device, O_RDWR, 0777);
 
 	/* Save the current device information - to be restored in cleanup() */
-	SAFE_IOCTL(fd, TCGETA, &save_io);
+	SAFE_IOCTL(fd, TCGETS, &save_io);
 
 	/* Close the device */
 	SAFE_CLOSE(fd);
@@ -211,7 +211,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (parentfd >= 0) {
-		SAFE_IOCTL(parentfd, TCSETA, &save_io);
+		SAFE_IOCTL(parentfd, TCSETS, &save_io);
 		SAFE_CLOSE(parentfd);
 	}
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
