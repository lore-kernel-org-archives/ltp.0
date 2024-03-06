Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7D8C5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 08:53:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5463C3CE9C2
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 09:53:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B66733C2A69
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 09:53:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7BA21A00145
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 09:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709715204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gwD5+t/fvI9V9S/0aoFXjHSqc+SsgnkR5psqKuHj1TE=;
 b=WB+VR2c86Fx42J/9Zzrj+pstIZa/nt6ZxL9Y74gyPzFvO4BMzJFsHA6LyxCA5zM+XCJQeJ
 7YL7oDSUa/sX0mEreZZYv4COQ4k4Ib2B4Hn7qalDt0xzjbBWEROktPGLW46UDSUlKjpWsW
 KCqgjvfTWwRi7zPYA20SBHrT4Ty/Rz8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-5WaRJwS1OaSUlSON1RRt_w-1; Wed, 06 Mar 2024 03:53:22 -0500
X-MC-Unique: 5WaRJwS1OaSUlSON1RRt_w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-68f74aff2b0so70135326d6.1
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 00:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709715201; x=1710320001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gwD5+t/fvI9V9S/0aoFXjHSqc+SsgnkR5psqKuHj1TE=;
 b=SDkKcdczLIm1bOeURHutRE13j3OuWDF94bUyLBkmKK8hOVjQ8mEv3yq1odIWFGsBvL
 9Kk66x0jVHBviLJ+TWbvfqVDyh1xEQSF9MNgI0r4CyUkGxCY+RvPqYWUvj7HJUtRJQ9/
 PTNSRBtgyozBgn1hAjZP0DDmyREr8ydZgZhUIFe+uZDoYc1oHiD85AJZngTRuXTf/lKh
 WVZqwHcuQ52bgf1IewbOpL8E52nMnu91hU1nzhIMiqfVgI3Gmevuj2nr5kP6KX/6kIdy
 KRVVS9SnlqKJDsDrkd85fv/uvpUvZ7ztk4uD8SmN/PclZAgfo/EY1y+gQX2+tY8SyV1D
 symA==
X-Gm-Message-State: AOJu0YzK6zy9YxzJBh0FBkPgrmvOivzUzeCAmWv20zUW9AGtdbhIdprA
 rlvqZMaN5motqo++qzZniTVaXTzEmfTN1yHwSm4d2+iLPaqzOJwptdIXUE7msaBl/vHMkW24MFe
 JfM3MlueWCKYTotSx9vR71PhtbGsdU6G5QP3izZ5vvHbNZPVtKoQwL9Q4eCckXLldWCDovmSIkh
 BnsdtxakFXZMLsP0rFyAZFwk4w/Fa5zXuJ
X-Received: by 2002:a0c:e74d:0:b0:690:913b:6497 with SMTP id
 g13-20020a0ce74d000000b00690913b6497mr2223949qvn.40.1709715201652; 
 Wed, 06 Mar 2024 00:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa19QdxQ6R5INOI705pgY8EwhfWPVwUH/DDEHAT4oLMijm0/ruCKIWPItNHWXvZqPbM9MyQA==
X-Received: by 2002:a0c:e74d:0:b0:690:913b:6497 with SMTP id
 g13-20020a0ce74d000000b00690913b6497mr2223940qvn.40.1709715201215; 
 Wed, 06 Mar 2024 00:53:21 -0800 (PST)
Received: from T14s.redhat.com (103-200-156-095.ip-addr.knet-kl.de.
 [95.156.200.103]) by smtp.gmail.com with ESMTPSA id
 of2-20020a056214434200b0068fbc383a80sm229855qvb.108.2024.03.06.00.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 00:53:20 -0800 (PST)
From: Dennis Brendel <dbrendel@redhat.com>
To: ltp@lists.linux.it
Date: Wed,  6 Mar 2024 09:52:54 +0100
Message-ID: <20240306085254.534940-1-dbrendel@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] munlockall: add test case that verifies memory has
 been unlocked
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

Changes compared to v2:
- replacing munlockall01.c as suggested
- respecting line length of 100 chars
- use tst_brk(TBROK | TERRNO, ...) to print symbolic errno value
- remove braces in the final error/success conditional
- use the suggested success message

---
 .../kernel/syscalls/munlockall/munlockall01.c | 148 ++++--------------
 1 file changed, 31 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 51f731b65..2745a1aee 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -1,134 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
+ * Copyright Red Hat
+ * Author: Dennis Brendel <dbrendel@redhat.com>
  */
-/**************************************************************************
- *
- *    TEST IDENTIFIER	: munlockall01
- *
- *    EXECUTED BY	: root / superuser
- *
- *    TEST TITLE	: Basic test for munlockall(2)
- *
- *    TEST CASE TOTAL	: 1
- *
- *    AUTHOR		: sowmya adiga<sowmya.adiga@wipro.com>
- *
- *    SIGNALS
- * 	Uses SIGUSR1 to pause before test if option set.
- * 	(See the parse_opts(3) man page).
- *
- *    DESCRIPTION
- *	This is a phase I test for the munlockall(2) system call.
- *	It is intended to provide a limited exposure of the system call.
- *
- * 	Setup:
- *	  Setup signal handling.
- *	  Pause for SIGUSR1 if option specified.
- *
- * 	Test:
- *        Execute system call
- *	  Check return code, if system call failed (return=-1)
- *	  Log the errno and Issue a FAIL message.
- *	  Otherwise, Issue a PASS message.
- *
- * 	Cleanup:
- * 	  Print errno log and/or timing stats if options given
- *
- * USAGE:  <for command-line>
- *  munlockall01 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
- *		where,		-c n : Run n copies concurrently
- *	               		-e   : Turn on errno logging.
- *				-h   : Show this help screen
- *				-i n : Execute test n times.
- *				-I x : Execute test for x seconds.
- *				-p   : Pause for SIGUSR1 before starting
- *                      	-P x : Pause for x seconds between iterations.
- *                       	 t   : Turn on syscall timing.
- *
- * RESTRICTIONS
- * Must be root/superuser to run it.
- *****************************************************************************/
-#include <errno.h>
-#include <sys/mman.h>
-#include "test.h"
 
-void setup();
-void cleanup();
+/*\
+ * [Description]
+ *
+ * Verify that munlockall(2) unlocks all previously locked memory
+ */
 
-char *TCID = "munlockall01";
-int TST_TOTAL = 1;
+#include <sys/mman.h>
 
-#if !defined(UCLINUX)
+#include "tst_test.h"
 
-int main(int ac, char **av)
+static void verify_munlockall(void)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
+	unsigned long size = 0;
 
-	setup();
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
 
-	/* check looping state */
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
+	if (size != 0UL)
+		tst_brk(TBROK, "Locked memory after init should be 0 but is %ld", size);
 
-		tst_count = 0;
+	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
+		tst_brk(TBROK | TERRNO, "Could not lock memory using mlockall()");
 
-		TEST(munlockall());
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
 
-		/* check return code */
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL | TTERRNO, "munlockall() Failed with"
-				 " return=%ld", TEST_RETURN);
-		} else {
-			tst_resm(TPASS, "munlockall() passed with"
-				 " return=%ld ", TEST_RETURN);
+	if (size == 0UL)
+		tst_brk(TBROK, "Locked memory after mlockall() should be greater than 0, "
+			       "but is %ld", size);
 
-		}
-	}
+	if (munlockall() != 0)
+		tst_brk(TBROK | TERRNO, "Could not unlock memory using munlockall()");
 
-	/* cleanup and exit */
-	cleanup();
-	tst_exit();
+	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
 
+	if (size != 0UL)
+		tst_res(TFAIL, "Locked memory after munlockall() should be 0 but is %ld", size);
+	else
+		tst_res(TPASS, "Memory successfully locked and unlocked");
 }
 
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
-/* setup() - performs all ONE TIME setup for this test. */
-void setup(void)
-{
-	tst_require_root();
-
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-}
-
-/*
- * cleanup() - performs all ONE TIME cleanup for this test at
- *		completion or premature exit.
- */
-void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.test_all = verify_munlockall,
+};
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
