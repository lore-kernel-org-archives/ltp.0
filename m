Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6552E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736893677; h=date :
 mime-version : message-id : references : in-reply-to : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=TnJCieeExS28zjFl69fDOMNGgRYmmgAei5AllcF1yd8=;
 b=DPDTzQuytNnx+1+Cc3Q0rFjoBR86YevZTEOEVgjG/ae0aEw17Let6tVq3LVJECoSXtTst
 djwPWCu8V5LDtO6ge8l0sj4W6ILT6cBFA/aQVshld+xDtxnLrSvzMDEXd8jvxobnK9rFdBV
 84k+bSP3/sGHLpKU3H70hGruYWTSA/E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8A6A3C7AE7
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 23:27:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D8BA3C7B66
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:54 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DD08710009AB
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:26:53 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so3128146f8f.2
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:26:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736893612; x=1737498412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSyJr+nZjNT3cDiT+HeeyWBrqGxM7NY8nixr7dDK8nA=;
 b=qfIFhg+alIPFnm6rbTTi5RezNiYx4ew6M67Fw42gQOmBGzEbV2amqxR11tDegijZsh
 BgcZ+6gGNHdm+5ePtCxyC5Qomg1QjDxcDUiNLFUZ/bFb2Zt2yqZYThVpxYkz7iO8cZwW
 pbznbqvF1Hn5+5t5rBlpdYashjQZOQQginbFAUhMmn6rpzibkD7Ofjal7UFJ73la0xYv
 F/Vhr+HZbNdGjqJIQ3xh/NHBQkFitsT+zoisJwKw87ZILnhBbI/8qgmqDoemm/IkoXpt
 zsJe2lQwFTjh6odUA0pmvHxGjtJEXLrakaGQ+PzX8bsQidaeIKOTfQwGgWRmvwHlXViD
 WY6g==
X-Gm-Message-State: AOJu0Yz1Fp+BkBbfjDUjD+xQlCR/Exd/CKOZwcuwSYdEV2Zkt9b6TtD2
 GMXXYmm33vhY96evR78H1gHTNuFE+1seejd0pQLf5acqNkRSEo+/BLEAB826r7stpV95WPR7WZ5
 H
X-Gm-Gg: ASbGncs4dJa/7V7vP9U6Cso6mENH8+yQ2E4khxW1fu0UHqu9TchBlAtkafh8DPgh6N0
 EbakOR5MofHNzRphVrv3j/3Jhx53qYrBnsI26DzZVRio4EW7ierdxmyq75rgQuDwfsi/oBZ9S+u
 BAADzBIVRiE7XecewCDQl9ihm4jciZzRRJdoRIfGY37Ff7gST2C60Gvlv8p0HrCnIRR8KKZdaa0
 WTs/8D7PA1r2V7rUWYfLwYhQzwFB3LL8v2nSIlDhQ==
X-Google-Smtp-Source: AGHT+IFzgLvIT1ha0UWzd5tEaOx17lyiBSAJCRitH2/W6P0jYM5nOPC6vOYXEMadFWhFzqAL29fGZA==
X-Received: by 2002:a5d:59af:0:b0:382:31a1:8dc3 with SMTP id
 ffacd0b85a97d-38a87313151mr26448300f8f.35.1736893612422; 
 Tue, 14 Jan 2025 14:26:52 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad80545fc1sm5568377fac.13.2025.01.14.14.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 14:26:50 -0800 (PST)
Date: Tue, 14 Jan 2025 19:26:32 -0300
MIME-Version: 1.0
Message-Id: <20250114-conversions-v1-2-7869a9f786d0@suse.com>
References: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
In-Reply-To: <20250114-conversions-v1-0-7869a9f786d0@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10160; i=rbm@suse.com;
 h=from:subject:message-id; bh=h9ARUH8iIm5jZNeLGViJErpIMrrz4oQv/UpMnESSDgw=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhuScyWjFcgK94dNjvvc2Eiuk/2NNvtMK/9Obk
 eD3Z1KSRZeJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4bknAAKCRDJC4p8Y4ZY
 pu9pEACMVUfgi4Xh6uBwezO1OD2JBP5NhfVxg0mKQxq32R+D5yYN+wFZNJPoej8x6V0IjKF+WiF
 lAfkG1TXSdkFKOn2x6m75CuQM+6xBD9/O36Zu+r3vBCIHqmQkI4MPQWzlTE1YCFEPFZKfYwaR/J
 rXl4ecoI6tT7kqu3M1F3HaOF74aVz7+QDXxbZBI9ngalElCDsiXNmKFNSgfU+5FVufKJ5RibZe7
 /CvTCGDvVR3n4D60uLjtpXXRCz9HvU0J0atoGse8ahx1h58mIf2rrf+iGXQoBT2cbiNwbjgIuEt
 dwAx7SnF8L/zc84SA+KQNRIuMF4J5eLePHwdmwf7KQ9s0sMUZ7IxUr7rcHYfSA6pTTsBRBgvBCn
 Qt+SR+yv+Y81hMI7PcuCIs0DRLloj3cnVEmjAQaa4jrObXf9sv0lx6r+ysxPLfSGhpYPOou8fRH
 idwzOJLWUVzXsgol/LNd06hvmuPyBTqu9urJBOkNkbgsB1pJCPLUVHnR3ccy2E1K4v8QOp1aLt+
 41WnWl93aj4CN8JEaoVSKBbInjC9OE70+wVY8v1tHKd2L3fmN3lbSBcZq28f41Q9tZUUXI7KpBl
 ahqDLsFrDqnYO/JtrIYa91aGCQWwe5KVpnPauqjsSI3DR4S131AGyE/wfBE0HRt/+txbM33rI/W
 QVwP16HfZu2rgkg==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] mmap03: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Ricardo B. Marliere <rbm@suse.com>

Also add x86_64 if PKU is enabled.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap03.c | 274 ++++++++++++--------------------
 1 file changed, 99 insertions(+), 175 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap03.c b/testcases/kernel/syscalls/mmap/mmap03.c
index 9d94d2653661387d22f811cd959a87b8112c1167..8990acbecfb8dcad174df3a56fa512a39be16478 100644
--- a/testcases/kernel/syscalls/mmap/mmap03.c
+++ b/testcases/kernel/syscalls/mmap/mmap03.c
@@ -1,230 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software;  you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY;  without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- * the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) 2025 Linux Test Project
+ * 07/2001 Ported by Wayne Boyer
  */
 
-/*
- * Test Description:
- *  Call mmap() to map a file creating a mapped region with execute access
- *  under the following conditions -
- *	- The prot parameter is set to PROT_EXE
- *	- The file descriptor is open for read
- *	- The file being mapped has execute permission bit set.
- *	- The minimum file permissions should be 0555.
+/*\
+ * [Description]
  *
- *  The call should succeed to map the file creating mapped memory with the
- *  required attributes.
+ * Call mmap() to map a file creating a mapped region with execute access
+ * under the following conditions:
+ * - The prot parameter is set to PROT_EXEC
+ * - The file descriptor is open for read
+ * - The file being mapped has execute permission bit set
+ * - The minimum file permissions should be 0555
+ * The call should succeed to map the file creating mapped memory with the
+ * required attributes.
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region,
- *  and the mapped region should contain the contents of the mapped file.
- *  but with ia64 and PARISC/hppa,
- *  an attempt to access the contents of the mapped region should give
- *  rise to the signal SIGSEGV.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * mmap() should succeed returning the address of the mapped region,
+ * and the mapped region should contain the contents of the mapped file.
+ * but with ia64, PARISC/hppa and x86_64 (with PKU), an attempt to access
+ * the contents of the mapped region should give rise to the signal SIGSEGV.
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <setjmp.h>
 
-#include "test.h"
+#include <setjmp.h>
+#include <stdlib.h>
 
-#define TEMPFILE	"mmapfile"
+#include "tst_kconfig.h"
+#include "tst_test.h"
 
-char *TCID = "mmap03";
-int TST_TOTAL = 1;
+#define TEMPFILE "mmapfile"
 
 static size_t page_sz;
 static char *addr;
 static char *dummy;
 static int fildes;
-static volatile int pass = 0;
+static volatile int sig_flag = -1;
 static sigjmp_buf env;
 
-static void setup(void);
-static void cleanup(void);
-static void sig_handler(int sig);
-
-int main(int ac, char **av)
+/*
+ * This function gets executed when the test process receives the signal
+ * SIGSEGV while trying to access the contents of memory which is not accessible.
+ */
+static void sig_handler(int sig)
 {
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-
-		tst_count = 0;
-
-		/*
-		 * Call mmap to map the temporary file 'TEMPFILE'
-		 * with execute access.
-		 */
-		errno = 0;
-		addr = mmap(0, page_sz, PROT_EXEC,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap() failed on %s",
-				 TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Read the file contents into the dummy
-		 * variable.
-		 */
-		if (read(fildes, dummy, page_sz) < 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "reading %s failed", TEMPFILE);
-		}
-
-		/*
-		 * Check whether the mapped memory region
-		 * has the file contents.
-		 *
-		 * with ia64 and PARISC/hppa, this should
-		 * generate a SIGSEGV which will be caught below.
-		 *
-		 */
-
-		if (sigsetjmp(env, 1) == 0) {
-			if (memcmp(dummy, addr, page_sz)) {
-				tst_resm(TFAIL,
-					 "mapped memory region "
-					 "contains invalid data");
-			} else {
-				tst_resm(TPASS,
-					 "mmap() functionality is "
-					 "correct");
-			}
-		}
-#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
-		if (pass) {
-			tst_resm(TPASS, "Got SIGSEGV as expected");
-		} else {
-			tst_resm(TFAIL, "Mapped memory region with NO "
-				 "access is accessible");
-		}
-#endif
-
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to unmap the mmapped pages");
-		}
-		pass = 0;
-
+	if (sig == SIGSEGV) {
+		/* Set the global variable and jump back */
+		sig_flag = 1;
+		siglongjmp(env, 1);
+	} else {
+		tst_brk(TBROK, "received an unexpected signal: %d", sig);
 	}
-
-	cleanup();
-	tst_exit();
 }
 
 static void setup(void)
 {
 	char *tst_buff;
 
-	tst_sig(NOFORK, sig_handler, cleanup);
-
-	TEST_PAUSE;
+	SAFE_SIGNAL(SIGSEGV, sig_handler);
 
 	page_sz = getpagesize();
 
 	/* Allocate space for the test buffer */
-	if ((tst_buff = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, NULL, "calloc failed (tst_buff)");
-	}
+	tst_buff = SAFE_CALLOC(page_sz, sizeof(char));
 
 	/* Fill the test buffer with the known data */
 	memset(tst_buff, 'A', page_sz);
 
-	tst_tmpdir();
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_WRONLY | O_CREAT, 0666)) < 0) {
-		free(tst_buff);
-		tst_brkm(TFAIL | TERRNO, cleanup, "opening %s failed",
-			 TEMPFILE);
-	}
+	/* Create a temporary file used for mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_WRONLY | O_CREAT);
 
 	/* Write test buffer contents into temporary file */
-	if (write(fildes, tst_buff, page_sz) < (long)page_sz) {
-		free(tst_buff);
-		tst_brkm(TFAIL | TERRNO, cleanup, "writing to %s failed",
-			 TEMPFILE);
-	}
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, tst_buff, page_sz);
 
 	/* Free the memory allocated for test buffer */
 	free(tst_buff);
 
 	/* Make sure proper permissions set on file */
-	if (fchmod(fildes, 0555) < 0) {
-		tst_brkm(TFAIL, cleanup, "fchmod of %s failed", TEMPFILE);
-	}
+	SAFE_FCHMOD(fildes, 0555);
 
 	/* Close the temporary file opened for write */
-	if (close(fildes) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "closing %s failed",
-			 TEMPFILE);
-	}
+	SAFE_CLOSE(fildes);
 
 	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
 
 	/* Open the temporary file again for reading */
-	if ((fildes = open(TEMPFILE, O_RDONLY)) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "opening %s read-only failed", TEMPFILE);
-	}
+	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
 }
 
-/*
- *   This function gets executed when the test process receives
- *   the signal SIGSEGV while trying to access the contents of memory which
- *   is not accessible.
- */
-static void sig_handler(int sig)
+static void run(void)
 {
-	if (sig == SIGSEGV) {
-		/* set the global variable and jump back */
-		pass = 1;
-		siglongjmp(env, 1);
-	} else
-		tst_brkm(TBROK, cleanup, "received an unexpected signal");
+	addr = SAFE_MMAP(0, page_sz, PROT_EXEC, MAP_FILE | MAP_SHARED, fildes,
+			 0);
+
+	/* Read the file contents into the dummy variable. */
+	SAFE_READ(0, fildes, dummy, page_sz);
+
+	/*
+	 * Check whether the mapped memory region
+	 * has the file contents. With ia64, PARISC/hppa and x86_64 (with PKU),
+	 * this should generate a SIGSEGV which will be caught below.
+	 */
+	if (sigsetjmp(env, 1) == 0) {
+		if (memcmp(dummy, addr, page_sz)) {
+			tst_res(TINFO, "memcmp returned non-zero");
+			tst_res(TFAIL,
+				"mapped memory region contains invalid data");
+		} else {
+			tst_res(TINFO, "memcmp returned zero");
+			tst_res(TPASS, "mmap() functionality is correct");
+		}
+	}
+
+#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
+	if (sig_flag > 0)
+		tst_res(TPASS, "Got SIGSEGV as expected");
+	else
+		tst_res(TFAIL,
+			"Mapped memory region with NO access is accessible");
+#elif defined(__x86_64__)
+	struct tst_kconfig_var kconfig =
+		TST_KCONFIG_INIT("CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS");
+	tst_kconfig_read(&kconfig, 1);
+	if (kconfig.choice == 'y') {
+		if (sig_flag > 0)
+			tst_res(TPASS, "Got SIGSEGV as expected");
+		else
+			tst_res(TFAIL,
+				"Mapped memory region with NO access is accessible");
+	}
+#else
+	if (sig_flag > 0)
+		tst_res(TFAIL, "Got unexpected SIGSEGV");
+#endif
+
+	/* Clean up things in case we are looping */
+	sig_flag = -1;
+	SAFE_MUNMAP(addr, page_sz);
 }
 
 static void cleanup(void)
 {
-	close(fildes);
 	free(dummy);
-	tst_rmdir();
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+};

-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
