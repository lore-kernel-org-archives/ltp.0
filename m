Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53FFC004C0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 16:03:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E17173CECF7
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 18:03:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC1CB3CECE9
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C19C714010ED
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 18:02:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A05121B09;
 Mon, 23 Oct 2023 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698076968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jtw9ff4wx3+hJxB+Z1kfQKIrfqSfOy/rDAw+tAqOUGE=;
 b=mj3d3AFnVYhE7W5VAa9D6IPHrOik4eJLVvfJzbZFLuD5HFdMb1ScHWcozMMU0f5+I4lYHk
 k/Jhrkh/CEZ9IS0eR0EsXt6vbxRgY48lFYk6e7FUTKXYbFN/aMKhkwJeae0SEUb37ffRBo
 ZC5eifEmYmq0KR3lCYJ5kKaGxtmASG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698076968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jtw9ff4wx3+hJxB+Z1kfQKIrfqSfOy/rDAw+tAqOUGE=;
 b=BEwe+uLB8YZaBpa5Jv6FObiC60Y/vc19JIWMoj2rWikGMkZHPVgZyWdUnpBF1b8eIwOPzg
 0KAa5ed4WgRX0yDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 247C9132FD;
 Mon, 23 Oct 2023 16:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cGnsByiZNmVhJAAAMHmgww
 (envelope-from <mkittler@suse.de>); Mon, 23 Oct 2023 16:02:48 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Mon, 23 Oct 2023 18:02:42 +0200
Message-ID: <20231023160242.3605-6-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023160242.3605-1-mkittler@suse.de>
References: <20231023160242.3605-1-mkittler@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
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
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 5/5] Extend ioctl02 to test termio and termios
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
 testcases/kernel/syscalls/ioctl/ioctl02.c | 170 +++++++++++++++++++---
 1 file changed, 147 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 5111d7178..00d51b367 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -8,22 +8,24 @@
 /*\
  * [Description]
  *
- * Testcase to test the TCGETS, and TCSETS ioctl implementations for
- * the tty driver
+ * Testcase to test the TCGETA/TCGETS, and TCSETA/TCSETS ioctl
+ * implementations for the tty driver
  *
  * In this test, the parent and child open the parentty and the childtty
  * respectively.  After opening the childtty the child flushes the stream
  * and wakes the parent (thereby asking it to continue its testing). The
- * parent, then starts the testing. It issues a TCGETS ioctl to get all
- * the tty parameters. It then changes them to known values by issuing a
- * TCSETS ioctl. Then the parent issues a TCGETS ioctl again and compares
- * the received values with what it had set earlier. The test fails if
- * TCGETS or TCSETS fails, or if the received values don't match those
- * that were set. The parent does all the testing, the requirement of the
- * child process is to moniter the testing done by the parent, and hence
- * the child just waits for the parent.
+ * parent, then starts the testing. It issues a TCGETA/TCGETS ioctl to
+ * get all the tty parameters. It then changes them to known values by
+ * issuing a TCSETA/TCSETS ioctl. Then the parent issues a TCSETA/TCGETS
+ * ioctl again and compares the received values with what it had set
+ * earlier. The test fails if TCGETA/TCGETS or TCSETA/TCSETS fails, or if
+ * the received values don't match those that were set. The parent does
+ * all the testing, the requirement of the child process is to moniter
+ * the testing done by the parent, and hence the child just waits for the
+ * parent.
  */
 
+#include <asm-generic/ioctls.h>
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
@@ -38,23 +40,54 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 
-static struct termios termio, save_io;
+static struct termio termio;
+static struct termios termios, termios_bak;
 
 static char *parenttty, *childtty;
 static int parentfd = -1, childfd = -1;
 static int parentpid, childpid;
 
 static int do_child_setup(void);
+static void prepare_termio(void);
+static void preapre_termios(void);
 static void run_ptest(void);
 static void run_ctest(void);
-static void chk_tty_parms(void);
+static void chk_tty_parms_termio(void);
+static void chk_tty_parms_termios(void);
 static void setup(void);
 static void cleanup(void);
 
 static char *device;
 
+static struct variant {
+	const char *name;
+	void *termio, *termio_bak;
+	void (*prepare)(void);
+	void (*check)(void);
+	int tcget, tcset;
+} variants[] = {
+	{
+		.name = "termio",
+		.termio = &termio,
+		.prepare = &prepare_termio,
+		.check = &chk_tty_parms_termio,
+		.tcget = TCGETA,
+		.tcset = TCSETA,
+	},
+	{
+		.name = "termios",
+		.termio = &termios,
+		.prepare = preapre_termios,
+		.check = &chk_tty_parms_termios,
+		.tcget = TCGETS,
+		.tcset = TCSETS,
+	},
+};
+
 static void verify_ioctl(void)
 {
+	tst_res(TINFO, "Testing %s variant", variants[tst_variant].name);
+
 	parenttty = device;
 	childtty = device;
 
@@ -80,11 +113,7 @@ static void verify_ioctl(void)
 	TST_CHECKPOINT_WAKE(0);
 }
 
-/*
- * run_ptest() - setup the various termio structure values and issue
- *		 the TCSETS ioctl call with the TEST macro.
- */
-static void run_ptest(void)
+static void prepare_termio(void)
 {
 	/* Use "old" line discipline */
 	termio.c_line = 0;
@@ -110,12 +139,50 @@ static void run_ptest(void)
 
 	/* Set output modes. */
 	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
+}
 
-	SAFE_IOCTL(parentfd, TCSETS, &termio);
+static void preapre_termios(void)
+{
+	/* Use "old" line discipline */
+	termios.c_line = 0;
+
+	/* Set control modes */
+	termios.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
+
+	/* Set control chars. */
+	for (int i = 0; i < NCC; i++) {
+		if (i == VEOL2)
+			continue;
+		termios.c_cc[i] = CSTART;
+	}
+
+	/* Set local modes. */
+	termios.c_lflag =
+	    ((unsigned short)(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH));
+
+	/* Set input modes. */
+	termios.c_iflag =
+	    BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY |
+	    IXOFF;
+
+	/* Set output modes. */
+	termios.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
+}
+
+/*
+ * run_ptest() - setup the various termio/termios structure values and issue
+ * the TCSETA/TCSETS ioctl call with the TEST macro.
+ */
+static void run_ptest(void)
+{
+	struct variant *v = &variants[tst_variant];
+
+	v->prepare();
+	SAFE_IOCTL(parentfd, v->tcset, v->termio);
 
 	/* Get termio and see if all parameters actually got set */
-	SAFE_IOCTL(parentfd, TCGETS, &termio);
-	chk_tty_parms();
+	SAFE_IOCTL(parentfd, v->tcget, v->termio);
+	v->check();
 }
 
 static void run_ctest(void)
@@ -125,7 +192,7 @@ static void run_ctest(void)
 	SAFE_CLOSE(childfd);
 }
 
-static void chk_tty_parms(void)
+static void chk_tty_parms_termio(void)
 {
 	int i, flag = 0;
 
@@ -174,6 +241,62 @@ static void chk_tty_parms(void)
 		flag++;
 	}
 
+	if (flag != 0)
+		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
+				"%d %s", flag, flag > 1 ? "errors" : "error");
+	else
+		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
+}
+
+static void chk_tty_parms_termios(void)
+{
+	int i, flag = 0;
+
+	if (termios.c_line != 0) {
+		tst_res(TINFO, "line discipline has incorrect value %o",
+			 termios.c_line);
+		flag++;
+	}
+
+	for (i = 0; i < NCC; i++) {
+		if (i == VEOL2) {
+			if (!termios.c_cc[i]) {
+				continue;
+			} else {
+				tst_res(TINFO, "control char %d has "
+					 "incorrect value %d", i, termios.c_cc[i]);
+				flag++;
+				continue;
+			}
+		}
+
+		if (termios.c_cc[i] != CSTART) {
+			tst_res(TINFO, "control char %d has incorrect "
+				 "value %d.", i, termios.c_cc[i]);
+			flag++;
+		}
+	}
+
+	if (termios.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
+		 | NOFLSH)) {
+		tst_res(TINFO, "lflag has incorrect value. %o",
+			 termios.c_lflag);
+		flag++;
+	}
+
+	if (termios.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
+		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
+		tst_res(TINFO, "iflag has incorrect value. %o",
+			 termios.c_iflag);
+		flag++;
+	}
+
+	if (termios.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
+		tst_res(TINFO, "oflag has incorrect value. %o",
+			 termios.c_oflag);
+		flag++;
+	}
+
 	if (flag != 0)
 		tst_res(TFAIL, "TCGETS/TCSETS tests FAILED with "
 				"%d %s", flag, flag > 1 ? "errors" : "error");
@@ -202,7 +325,7 @@ static void setup(void)
 	int fd = SAFE_OPEN(device, O_RDWR, 0777);
 
 	/* Save the current device information - to be restored in cleanup() */
-	SAFE_IOCTL(fd, TCGETS, &save_io);
+	SAFE_IOCTL(fd, TCGETS, &termios_bak);
 
 	/* Close the device */
 	SAFE_CLOSE(fd);
@@ -211,7 +334,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (parentfd >= 0) {
-		SAFE_IOCTL(parentfd, TCSETS, &save_io);
+		SAFE_IOCTL(parentfd, TCSETS, &termios_bak);
 		SAFE_CLOSE(parentfd);
 	}
 }
@@ -223,6 +346,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_ioctl,
+	.test_variants = 2,
 	.options = (struct tst_option[]) {
 		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
 		{}
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
