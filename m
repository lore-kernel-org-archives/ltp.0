Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111E6C4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 10:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12ED63CBEE9
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 11:53:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A06243CB74B
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:53:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D898140043E
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:53:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75EA3218CE;
 Fri,  3 Nov 2023 10:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699008821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HnnojpFM79n2huVb5g1Jv69VIbjSoy5kNnAv0TEDPD8=;
 b=tBJu3qip2LCz38bYtmZMH82oMb0AMyO3zFTwif8LbUnxlwi3gRL2VtfSjwZ53lCyNhy1Za
 PtjuhT84RfpfXMF0Nue6PnCpDtuYueQBxXug6y2y3qSL0xGuOqh0nvrYO1Tfc/Ohh5i2EQ
 GLviu2ZJyoLtUutts61pO0+Ep83mZSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699008821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HnnojpFM79n2huVb5g1Jv69VIbjSoy5kNnAv0TEDPD8=;
 b=2rkUSVw4gxZA1u7dt3EXIsdeyT12Niwv/9V3LjimSkx6kFjsE78r0fYhSdkJK3C0uq6otg
 Egj0q00Xu5lucBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F05A1348C;
 Fri,  3 Nov 2023 10:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dTLzFTXRRGXVJAAAMHmgww
 (envelope-from <mkittler@suse.de>); Fri, 03 Nov 2023 10:53:41 +0000
From: Marius Kittler <mkittler@suse.de>
To: ltp@lists.linux.it
Date: Fri,  3 Nov 2023 11:53:39 +0100
Message-ID: <20231103105339.21435-1-mkittler@suse.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Extend ioctl02 to test termio and termios
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

Testing the behavior of both sets of ioctl commands at the same time is
challenging because they use different structures. This change tries to
minimize the amount of code duplication (it is not fully possible) and to
minimize the amount of macro code (it is not fully avoidable).

To ease this, this change simplifies the checks:
* Create a separate function and macro for checking attributes
* Remove useless nested condition in loop for checking the control
  characters
    * The loop condition is `i < NCC` and the nested condition was
      `i == VEOL2`. The nested condition is completely useless because it
      is never reached because `VEOL2 > NCC`.
    * The same applies to the loop for initializing the structs.
    * This change introduces use of termios (where `VEOL2 < NCCS`) but
      extra handling for `VEOL2` can still be avoided.
* Implement the check for control characters in terms of the normal
  attribute check

Signed-off-by: Marius Kittler <mkittler@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl02.c | 191 +++++++++++++---------
 1 file changed, 118 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 8c6924386..1271a252d 100644
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
@@ -39,22 +41,54 @@
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
+	size_t termio_size;
+	void (*check)(void);
+	int tcget, tcset;
+} variants[] = {
+	{
+		.name = "termio",
+		.termio = &termio,
+		.termio_exp = &termio_exp,
+		.termio_size = sizeof(termio),
+		.check = &chk_tty_parms_termio,
+		.tcget = TCGETA,
+		.tcset = TCSETA,
+	},
+	{
+		.name = "termios",
+		.termio = &termios,
+		.termio_exp = &termios_exp,
+		.termio_size = sizeof(termios),
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
 
@@ -73,99 +107,107 @@ static void verify_ioctl(void)
 	run_ptest();
 
 	TST_CHECKPOINT_WAKE(0);
+	SAFE_CLOSE(parentfd);
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
-	for (int i = 0; i < NCC; i++) {
-		if (i == VEOL2)
-			continue;
-		termio.c_cc[i] = CSTART;
-	}
+	for (int i = 0; i < NCC; i++)
+		termio_exp.c_cc[i] = CSTART;
+	for (int i = 0; i < VEOL2; i++)
+		termios_exp.c_cc[i] = CSTART;
 
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
+	termios_exp.c_oflag = termio_exp.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
+}
 
-	SAFE_IOCTL(parentfd, TCSETA, &termio);
+/*
+ * run_ptest() - setup the various termio/termios structure values and issue
+ * the TCSETA/TCSETS ioctl call with the TEST macro.
+ */
+static void run_ptest(void)
+{
+	struct variant *v = &variants[tst_variant];
+
+	/* Init termio/termios structures used to check if all params got set */
+	memset(v->termio, 0, v->termio_size);
+
+	SAFE_IOCTL(parentfd, v->tcset, v->termio_exp);
 
 	/* Get termio and see if all parameters actually got set */
-	SAFE_IOCTL(parentfd, TCGETA, &termio);
-	chk_tty_parms();
+	SAFE_IOCTL(parentfd, v->tcget, v->termio);
+	v->check();
 }
 
-static void chk_tty_parms(void)
+static int cmp_attr(unsigned long long exp, unsigned long long act, const char *attr)
 {
-	int i, flag = 0;
+	if (act == exp)
+		return 0;
+	tst_res(TFAIL, "%s has incorrect value %llu, expected %llu",
+		attr, act, exp);
+	return 1;
+}
 
-	if (termio.c_line != 0) {
-		tst_res(TFAIL, "line discipline has incorrect value %o",
-			 termio.c_line);
-		flag++;
-	}
+static int cmp_c_cc(unsigned char *exp_c_cc, unsigned char *act_c_cc, int ncc)
+{
+	int i, fails = 0;
+	char what[32];
 
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
+	for (i = 0; i < ncc; ++i) {
+		sprintf(what, "control char %d", i);
+		fails += cmp_attr(exp_c_cc[i], act_c_cc[i], what);
 	}
+	return fails;
+}
 
-	if (termio.c_lflag != (ISIG | ICANON | XCASE | ECHO | ECHOE
-		 | NOFLSH)) {
-		tst_res(TFAIL, "lflag has incorrect value. %o",
-			 termio.c_lflag);
-		flag++;
-	}
+#define CMP_ATTR(term_exp, term, attr) \
+	(flag += cmp_attr((term_exp).attr, (term).attr, #attr))
 
-	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
-		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
-		tst_res(TFAIL, "iflag has incorrect value. %o",
-			 termio.c_iflag);
-		flag++;
-	}
+#define CMP_C_CC(term_exp, term) \
+	(flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc)))
 
-	if (termio.c_oflag != (OPOST | OLCUC | ONLCR | ONOCR)) {
-		tst_res(TFAIL, "oflag has incorrect value. %o",
-			 termio.c_oflag);
-		flag++;
-	}
+static void chk_tty_parms_termio(void)
+{
+	int flag = 0;
 
+	CMP_ATTR(termio_exp, termio, c_line);
+	CMP_C_CC(termio_exp, termio);
+	CMP_ATTR(termio_exp, termio, c_lflag);
+	CMP_ATTR(termio_exp, termio, c_iflag);
+	CMP_ATTR(termio_exp, termio, c_oflag);
 	if (!flag)
 		tst_res(TPASS, "TCGETA/TCSETA tests");
 }
 
+static void chk_tty_parms_termios(void)
+{
+	int flag = 0;
+
+	CMP_ATTR(termios_exp, termios, c_line);
+	CMP_C_CC(termios_exp, termios);
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
@@ -187,14 +229,16 @@ static void setup(void)
 
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
@@ -206,6 +250,7 @@ static struct tst_test test = {
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
