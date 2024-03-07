Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A72C54E49
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 07:40:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27C873CE993
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 08:40:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D9D3C8919
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 08:40:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=dbrendel@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C850F21BDE2
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 08:40:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709797236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1Ew8PHkmOGe7ibNVfR5bk6b6XNXVc0pUIhA81Y8/7uc=;
 b=LbC04ZJ1X/Owo3fVGTFigccpsyJmwcUNdEqzAT9JXJ/ihbVsmfQFHIWWbS8hLi8hNhIEdQ
 u/HMz8CpiUOUra/4ePevDHRq+iwA7C66L+C+FsTsOWkEobeuLVRNa+jJWrkScVmhjaXzdV
 wS5BZgB/ZEfhDfQK6DIp33FNViO3Vf4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-4P8o-XzwO3makQq0VGjmig-1; Thu, 07 Mar 2024 02:40:34 -0500
X-MC-Unique: 4P8o-XzwO3makQq0VGjmig-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33deb1f7afdso222612f8f.2
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 23:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709797232; x=1710402032;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Ew8PHkmOGe7ibNVfR5bk6b6XNXVc0pUIhA81Y8/7uc=;
 b=CBoTq52vTabUpRxGQrSw8m/UbFaRpq5lHlhesKzWjXMt/OCeQN9Opl/RmO6ASDw0ZZ
 xTG/2uMZDEfSvK6O+s7ORxg8OoVCAyVxffbgR+L+pfVyEJCOCOaCRew0Kn1CnqjwI3RM
 72lP/r+um5UpTzdKSsXs/mpqoy9oqxQ+1bZ1HFSdigAz5r4qLHPCA1QkiwSFvV8U1WE7
 Tw/QjiNtRfZ+ovumXfKRpJciQwZXLVJpPnOnx/QC/ivA/30QKoj2ZbFj5XPlzmZiIdcc
 juxUwuW02aCIf9AslQ6ZSAPgLzVm12sdtBpOlmHBdWRRv7SFtZFs5OHNWhSr2+wR8lAB
 oLYA==
X-Gm-Message-State: AOJu0YxJ87CJUGLDsAeReVgU++CWDBbxIBGNuGF2PBMknGeZDNP3w6qL
 VU6zZgTISb0vJE7d7M6Ux7KbGvVCfhD4D+KDlPThxIWGzF5PeAphxKMJlGJVtTYEoffHUGO2Q6g
 udF+PiAF0qNbD8jIX4sha4Flhh6aq62/tEMxQeOVAbGuad//SKoJ6qAcM/QKD5PGzSoRGJ18qXF
 dZIzJ8yCAHRZyL2K/VJpbRJDFehbd5xYVT
X-Received: by 2002:a05:6000:1e97:b0:33e:172f:5709 with SMTP id
 dd23-20020a0560001e9700b0033e172f5709mr13307854wrb.8.1709797232684; 
 Wed, 06 Mar 2024 23:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQL5BLZPC2BGwFT2OYJ6cwSxQaPaqXzbzuxkSD2w16RMQAWcQCHS7pJq2EnIUMMOZ+vw9mfQ==
X-Received: by 2002:a05:6000:1e97:b0:33e:172f:5709 with SMTP id
 dd23-20020a0560001e9700b0033e172f5709mr13307835wrb.8.1709797232145; 
 Wed, 06 Mar 2024 23:40:32 -0800 (PST)
Received: from T14s.redhat.com ([185.44.203.230])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a5d594d000000b0033e12b2e567sm18637702wri.35.2024.03.06.23.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 23:40:31 -0800 (PST)
From: Dennis Brendel <dbrendel@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  7 Mar 2024 08:40:19 +0100
Message-ID: <20240307074019.766020-1-dbrendel@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] munlockall: re-write test case
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

This uses the new API and actually verifies the expected behavior:

- there should not be any memory locked after starting the process
- we lock the process' memory and verify it has been locked
- we call munlockall(2) and verify the kernel reports that no more
  memory is locked

Signed-off-by: Dennis Brendel <dbrendel@redhat.com>
---

Changes compared to v3:

- remove useless size output in the mlockall() check
- use TST_EXP_PASS macro for calling munlockall()

 .../kernel/syscalls/munlockall/munlockall01.c | 146 ++++--------------
 1 file changed, 29 insertions(+), 117 deletions(-)

diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c b/testcases/kernel/syscalls/munlockall/munlockall01.c
index 51f731b65..7051b8535 100644
--- a/testcases/kernel/syscalls/munlockall/munlockall01.c
+++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
@@ -1,134 +1,46 @@
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
+		tst_brk(TBROK, "Locked memory after mlockall() should be > 0");
 
-		}
-	}
+	TST_EXP_PASS(munlockall(), "Unlock memory using munlockall()");
 
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
