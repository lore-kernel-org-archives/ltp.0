Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AA5C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 18:48:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997663CF63C
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 19:48:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B12923CD2D3
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 19:48:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 381C520118C
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 19:48:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF71621CC1;
 Fri,  1 Dec 2023 18:48:17 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C8E1E1344E;
 Fri,  1 Dec 2023 18:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id /MekL3EqamXmBQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 18:48:17 +0000
Date: Fri, 1 Dec 2023 19:48:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231201184816.GF2829815@pevik>
References: <20231114150922.28652-1-mkittler@suse.de>
 <20231114150922.28652-2-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231114150922.28652-2-mkittler@suse.de>
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.68 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; ARC_NA(0.00)[];
 R_SPF_SOFTFAIL(4.60)[~all]; DMARC_NA(1.20)[suse.cz];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 NEURAL_SPAM_LONG(2.99)[0.853]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EF71621CC1
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] Extend ioctl02 to test termio and termios
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I posted it to the cover letter, but better to add it also to the patch:

BTW this v3 is exactly the same as v2. What am I missing?

Cyril asked you [1] to pass flag parameter to the macro, because you modify it
and it's not a good code to modify variable in macro without passing it.
Obviously you should return it as well (not that compact code, but it's really
better).

I understood it like:

#define CMP_ATTR(term_exp, term, attr, flag) \
	({                                                      \
	flag += cmp_attr((term_exp).attr, (term).attr, #attr);	\
	flag;                                                   \
	})

To speedup this, I merged with following diff below.
Thanks!

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/ZUUV9MiVadNA75WY@yuki/

+++ testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -8,8 +8,7 @@
 /*\
  * [Description]
  *
- * Testcase to test the TCGETA/TCGETS, and TCSETA/TCSETS ioctl
- * implementations for the tty driver
+ * Test TCGETA/TCGETS and TCSETA/TCSETS ioctl implementations for tty driver.
  *
  * In this test, the parent and child open the parentty and the childtty
  * respectively.  After opening the childtty the child flushes the stream
@@ -27,19 +26,10 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <sys/ioctl.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <sys/stat.h>
 #include <termios.h>
 
 #include "lapi/ioctl.h"
-
-#include "tst_checkpoint.h"
 #include "tst_test.h"
-#include "tst_safe_macros.h"
 
 static struct termio termio, termio_exp;
 static struct termios termios, termios_exp, termios_bak;
@@ -176,21 +166,28 @@ static int cmp_c_cc(unsigned char *exp_c_cc, unsigned char *act_c_cc, int ncc)
 	return fails;
 }
 
-#define CMP_ATTR(term_exp, term, attr) \
-	(flag += cmp_attr((term_exp).attr, (term).attr, #attr))
+#define CMP_ATTR(term_exp, term, attr, flag)				\
+({															\
+	flag += cmp_attr((term_exp).attr, (term).attr, #attr);	\
+	flag;                                                   \
+})
 
-#define CMP_C_CC(term_exp, term) \
-	(flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc)))
+#define CMP_C_CC(term_exp, term, flag)								\
+({																	\
+	flag += cmp_c_cc(term_exp.c_cc, term.c_cc, sizeof(term.c_cc));	\
+	flag;															\
+})
 
 static void chk_tty_parms_termio(void)
 {
 	int flag = 0;
 
-	CMP_ATTR(termio_exp, termio, c_line);
-	CMP_C_CC(termio_exp, termio);
-	CMP_ATTR(termio_exp, termio, c_lflag);
-	CMP_ATTR(termio_exp, termio, c_iflag);
-	CMP_ATTR(termio_exp, termio, c_oflag);
+	flag = CMP_ATTR(termio_exp, termio, c_line, flag);
+	flag = CMP_C_CC(termio_exp, termio, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_lflag, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_iflag, flag);
+	flag = CMP_ATTR(termio_exp, termio, c_oflag, flag);
+
 	if (!flag)
 		tst_res(TPASS, "TCGETA/TCSETA tests");
 }
@@ -199,11 +196,12 @@ static void chk_tty_parms_termios(void)
 {
 	int flag = 0;
 
-	CMP_ATTR(termios_exp, termios, c_line);
-	CMP_C_CC(termios_exp, termios);
-	CMP_ATTR(termios_exp, termios, c_lflag);
-	CMP_ATTR(termios_exp, termios, c_iflag);
-	CMP_ATTR(termios_exp, termios, c_oflag);
+	flag = CMP_ATTR(termios_exp, termios, c_line, flag);
+	flag = CMP_C_CC(termios_exp, termios, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_lflag, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_iflag, flag);
+	flag = CMP_ATTR(termios_exp, termios, c_oflag, flag);
+
 	if (!flag)
 		tst_res(TPASS, "TCGETS/TCSETS tests");
 }
@@ -255,4 +253,4 @@ static struct tst_test test = {
 		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
 		{}
 	}
-};
\ No newline at end of file
+};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
