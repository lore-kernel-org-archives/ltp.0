Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDBFC25B6B
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:47:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C9FC3CE13F
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 13:47:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C97093CCB50
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:47:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38DB51A010B7
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 13:47:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69F881FE3A;
 Thu, 26 Oct 2023 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698320839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4hDDb+DAkwESiH6X4qqpU11aE6MaXBeWfnnELUluNo=;
 b=CNa6b03Po3HOtC2QtoPUb8GILub52UbILxnY3yhodNR4h2ZiY21SrD3gxkOJ7vsu3B5tE0
 vjNKE/hXVINjL7JBdnsJQ0Q5XSjb0OvrN08HgJh7OBxea74hcp4Z6uoRjCraQrrtle7XZI
 /KLkNdVOn4iYX3JgNXL0gZmifOC0yao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698320839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4hDDb+DAkwESiH6X4qqpU11aE6MaXBeWfnnELUluNo=;
 b=9FuM4w+XfCHJ3ORYUzPkckyfBirjHNxTvGiQdW/sI8ZfZ6emKer1A79/s1recgQA/zeix0
 0drG9JQZmjKw4IBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 546F113A9E;
 Thu, 26 Oct 2023 11:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +M+rE8dROmW/fAAAMHmgww
 (envelope-from <mkittler@suse.de>); Thu, 26 Oct 2023 11:47:19 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Thu, 26 Oct 2023 13:47:15 +0200
Message-ID: <20231026114716.17545-5-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026114716.17545-1-mkittler@suse.de>
References: <20231026114716.17545-1-mkittler@suse.de>
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
Subject: [LTP] [PATCH v9 4/4] Extend ioctl02 to test termio and termios
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
 testcases/kernel/syscalls/ioctl/ioctl02.c | 191 ++++++++++++++--------
 1 file changed, 119 insertions(+), 72 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 8c6924386..febe7cdd8 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -8,26 +8,28 @@
 /*\
  * [Description]
  *
- * Testcase to test the TCGETA, and TCSETA ioctl implementations for
- * the tty driver
+ * Testcase to test the TCGETA/TCGETS, and TCSETA/TCSETS ioctl
+ * implementations for the tty driver
  *
  * In this test, the parent and child open the parentty and the childtty
  * respectively.  After opening the childtty the child flushes the stream
  * and wakes the parent (thereby asking it to continue its testing). The
- * parent, then starts the testing. It issues a TCGETA ioctl to get all
- * the tty parameters. It then changes them to known values by issuing a
- * TCSETA ioctl. Then the parent issues a TCGETA ioctl again and compares
- * the received values with what it had set earlier. The test fails if
- * TCGETA or TCSETA fails, or if the received values don't match those
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
 
 #include <stdio.h>
 #include <stdlib.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -39,22 +41,51 @@
 #include "tst_test.h"
 #include "tst_safe_macros.h"
 
-static struct termio termio, save_io;
+static struct termio termio, termio_exp;
+static struct termios termios, termios_exp, termios_bak;
 
 static char *parenttty, *childtty;
 static int parentfd = -1;
 static int parentpid, childpid;
 
 static void do_child(void);
+static void prepare_termio(void);
 static void run_ptest(void);
-static void chk_tty_parms(void);
+static void chk_tty_parms_termio(void);
+static void chk_tty_parms_termios(void);
 static void setup(void);
 static void cleanup(void);
 
 static char *device;
 
+static struct variant {
+	const char *name;
+	void *termio, *termio_exp, *termio_bak;
+	void (*check)(void);
+	int tcget, tcset;
+} variants[] = {
+	{
+		.name = "termio",
+		.termio = &termio,
+		.termio_exp = &termio_exp,
+		.check = &chk_tty_parms_termio,
+		.tcget = TCGETA,
+		.tcset = TCSETA,
+	},
+	{
+		.name = "termios",
+		.termio = &termios,
+		.termio_exp = &termios_exp,
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
 
@@ -73,99 +104,112 @@ static void verify_ioctl(void)
 	run_ptest();
 
 	TST_CHECKPOINT_WAKE(0);
+
+	if (tst_variant < sizeof(variants) - 1)
+		SAFE_CLOSE(parentfd);
 }
 
-/*
- * run_ptest() - setup the various termio structure values and issue
- *		 the TCSETA ioctl call with the TEST macro.
- */
-static void run_ptest(void)
+static void prepare_termio(void)
 {
 	/* Use "old" line discipline */
-	termio.c_line = 0;
+	termios_exp.c_line = termio_exp.c_line = 0;
 
 	/* Set control modes */
-	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
+	termios_exp.c_cflag = termio_exp.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
 
 	/* Set control chars. */
 	for (int i = 0; i < NCC; i++) {
 		if (i == VEOL2)
 			continue;
-		termio.c_cc[i] = CSTART;
+		termios_exp.c_cc[i] = termio_exp.c_cc[i] = CSTART;
 	}
 
 	/* Set local modes. */
-	termio.c_lflag =
+	termios_exp.c_lflag = termio_exp.c_lflag =
 	    ((unsigned short)(ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH));
 
 	/* Set input modes. */
-	termio.c_iflag =
+	termios_exp.c_iflag = termio_exp.c_iflag =
 	    BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY |
 	    IXOFF;
 
 	/* Set output modes. */
-	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
-
-	SAFE_IOCTL(parentfd, TCSETA, &termio);
+	termios_exp.c_oflag = termio_exp.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
 
-	/* Get termio and see if all parameters actually got set */
-	SAFE_IOCTL(parentfd, TCGETA, &termio);
-	chk_tty_parms();
+	/* Init termio/termios structures used to check if all params got set */
+	memset(&termio, 0, sizeof(termio));
+	memset(&termios, 0, sizeof(termios));
 }
 
-static void chk_tty_parms(void)
+/*
+ * run_ptest() - setup the various termio/termios structure values and issue
+ * the TCSETA/TCSETS ioctl call with the TEST macro.
+ */
+static void run_ptest(void)
 {
-	int i, flag = 0;
+	struct variant *v = &variants[tst_variant];
 
-	if (termio.c_line != 0) {
-		tst_res(TFAIL, "line discipline has incorrect value %o",
-			 termio.c_line);
-		flag++;
-	}
+	SAFE_IOCTL(parentfd, v->tcset, v->termio_exp);
 
-	for (i = 0; i < NCC; i++) {
-		if (i == VEOL2) {
-			if (!termio.c_cc[i]) {
-				continue;
-			} else {
-				tst_res(TFAIL, "control char %d has "
-					 "incorrect value %d", i, termio.c_cc[i]);
-				flag++;
-				continue;
-			}
-		}
-
-		if (termio.c_cc[i] != CSTART) {
-			tst_res(TFAIL, "control char %d has incorrect "
-				 "value %d.", i, termio.c_cc[i]);
-			flag++;
-		}
-	}
-
-	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
-		 | NOFLSH)) {
-		tst_res(TFAIL, "lflag has incorrect value. %o",
-			 termio.c_lflag);
-		flag++;
-	}
+	/* Get termio and see if all parameters actually got set */
+	SAFE_IOCTL(parentfd, v->tcget, v->termio);
+	v->check();
+}
 
-	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
-		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
-		tst_res(TFAIL, "iflag has incorrect value. %o",
-			 termio.c_iflag);
-		flag++;
+#define CMP_ATTR(tcexp, tcval, attr) \
+	do { \
+		if ((tcval).attr != (tcexp).attr) { \
+			tst_res(TINFO, #attr " has incorrect value %o", \
+				(tcval).attr); \
+			flag++; \
+		} \
+	} while (0)
+
+#define CHECK_CONTROL_CHARS(tcval) \
+	for (i = 0; i < NCC; i++) { \
+		if (i == VEOL2) { \
+			if (!(tcval).c_cc[i]) { \
+				continue; \
+			} else { \
+				tst_res(TFAIL, "control char %d has " \
+					 "incorrect value %d", i, (tcval).c_cc[i]); \
+				flag++; \
+				continue; \
+			} \
+		} \
+		if ((tcval).c_cc[i] != CSTART) { \
+			tst_res(TFAIL, "control char %d has incorrect " \
+				 "value %d.", i, (tcval).c_cc[i]); \
+			flag++; \
+		} \
 	}
 
-	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
-		tst_res(TFAIL, "oflag has incorrect value. %o",
-			 termio.c_oflag);
-		flag++;
-	}
+static void chk_tty_parms_termio(void)
+{
+	int i, flag = 0;
 
+	CMP_ATTR(termio_exp, termio, c_line);
+	CHECK_CONTROL_CHARS(termio);
+	CMP_ATTR(termio_exp, termio, c_lflag);
+	CMP_ATTR(termio_exp, termio, c_iflag);
+	CMP_ATTR(termio_exp, termio, c_oflag);
 	if (!flag)
 		tst_res(TPASS, "TCGETA/TCSETA tests");
 }
 
+static void chk_tty_parms_termios(void)
+{
+	int i, flag = 0;
+
+	CMP_ATTR(termios_exp, termios, c_line);
+	CHECK_CONTROL_CHARS(termios);
+	CMP_ATTR(termios_exp, termios, c_lflag);
+	CMP_ATTR(termios_exp, termios, c_iflag);
+	CMP_ATTR(termios_exp, termios, c_oflag);
+	if (!flag)
+		tst_res(TPASS, "TCGETS/TCSETS tests");
+}
+
 static void do_child(void)
 {
 	int cfd = SAFE_OPEN(childtty, O_RDWR, 0777);
@@ -187,14 +231,16 @@ static void setup(void)
 
 	int fd = SAFE_OPEN(device, O_RDWR, 0777);
 
-	SAFE_IOCTL(fd, TCGETA, &save_io);
+	SAFE_IOCTL(fd, TCGETS, &termios_bak);
 	SAFE_CLOSE(fd);
+
+	prepare_termio();
 }
 
 static void cleanup(void)
 {
 	if (parentfd >= 0) {
-		SAFE_IOCTL(parentfd, TCSETA, &save_io);
+		SAFE_IOCTL(parentfd, TCSETS, &termios_bak);
 		SAFE_CLOSE(parentfd);
 	}
 }
@@ -206,6 +252,7 @@ static struct tst_test test = {
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
