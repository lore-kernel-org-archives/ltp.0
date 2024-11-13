Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EF4D637AB
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731525350; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=uH5LIP92qu0aFpPFhkSAq+2tNPh6+DVlqpDJ2tgczTA=;
 b=Kz78NL6vDKeMuD9ZtdcZ0w+NEVNwB43kk/gHaMXZ+Gz3EMjejC+Cn1wYLpgV3jvsW2MqP
 xTbkY658NGMer8PX+I4HU24v0RHLYDxzqHoRxFLti8JBYf7J5mxg1jXcNIhiAglP38Usf7U
 cPBQGIGiEWUKG2FgFlZii2WUk+5bzIE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E6C33D6955
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 20:15:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA6EF3C198F
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 20:15:27 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 66ACE210B36
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 20:15:25 +0100 (CET)
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2fb49510250so66342051fa.0
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731525324; x=1732130124; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Znf0mt7itvqDc7BeoTztRyzfLwnEFfhDYH38xNScZO8=;
 b=aMk+es1x8TMpPKkaYNj+7YFAOhtPTVAIAttGiH+nVqpEfWT6qGuB20PRxuAJwS6SJM
 LTmjIRvnxwkt2Mi9QsJ1Do3HI7uvAy+7SwfeoQrbMKYmpFHMqelrkR5Ug+Um5ZQDUDMt
 OMGLZWpDaZQcFLM7sWUWavYWXwGBLorizij59fRAWOx8Dgniwqp57cbtUdeKrXMOQate
 JgMnZGQmWg+z/6yQNv6IW3B/m6nAOvAJw5kZG5BWllIvfS4qmxh4nI3Ap1S6LuSwbr/S
 WtRAqiSpQKhO6pkd6kPdCpPMTTU9HFgoM8niztnGrahzCCboWyxJ0FZr2C2NL9U5EKBS
 /WLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731525324; x=1732130124;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Znf0mt7itvqDc7BeoTztRyzfLwnEFfhDYH38xNScZO8=;
 b=oteNkWSe5Cj+R0NoGFPzhurs1YftRAkYDmyhM9UB7NRxFkdJX2bFHVxXlktBuT2UFE
 4dlocWu3GhUHJU9DJOmObXC5d2UkJTsIJmINiiGJoAfMMOm+NwulBgI7/Vm2ab+McA+m
 tV0Z5ThUuE4m8rGyfALmXtn/ym/3mzRZsAqwvWl2zbHLxGV/WRIUZaVsaEB6lGdRwtpK
 YUi4BDUJKiTf5TvipnlakeoV4A6raGBHC5EjusMuD40lhV1ieexqgMSXAxUkC2Y5h/kj
 ddEJNZ5RhKrgrVOb8Vu2iJBF7Dh5vynPkBuy3r4VBSwLWhzzcNLk9uIOVS9n4ayZVctF
 S4UA==
X-Gm-Message-State: AOJu0YzdPoKNrxi+CcTeoKnrc8NVj5pa3tlohytB0XyWFz0+A/VVAHbR
 JJYMp6b13ZwKJayVJBwl43npETlQ+JJJoL8G3mlqKwBoWNhsIGJU7OWdSdGrxgO7HPBJqu+wrAm
 k
X-Google-Smtp-Source: AGHT+IE4PZ4fe8sr44JPPYvhvSP6iXfdiZZm/7P9pVtfJTb3HRf5o6svn1j4QcbAY7CN3FX8pDlYmA==
X-Received: by 2002:a05:651c:544:b0:2fb:c20:dbc5 with SMTP id
 38308e7fff4ca-2ff4c618507mr25093501fa.29.1731525324385; 
 Wed, 13 Nov 2024 11:15:24 -0800 (PST)
Received: from localhost ([179.228.213.10]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee496af6d4sm3164869eaf.28.2024.11.13.11.15.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 11:15:22 -0800 (PST)
Date: Wed, 13 Nov 2024 16:15:17 -0300
MIME-Version: 1.0
Message-Id: <20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com>
X-B4-Tracking: v=1; b=H4sIAMT6NGcC/x3MQQqAIBBA0avErBNmrIV0lYgonWoWWmhEIN49a
 fkW/2dIHIUTDE2GyI8kOUMFtQ3YYwk7K3HVoFH3RNQpe4aH4z17v1xIyq0aDSNqgwQ1uiJv8v7
 DcSrlA7e5XohgAAAA
X-Change-ID: 20241113-convert_mmap01-db208e002801
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8207; i=rbm@suse.com;
 h=from:subject:message-id; bh=SS/N/JfE/YJaBbjY9xYfwyaI0Q3AF4kipSv8RwhIvdM=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnNPrH3t4maB4IjdAAgpxNkpx9Fv0/7nBDtMKEs
 T9TiyKzhrWJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZzT6xwAKCRDJC4p8Y4ZY
 pgG/D/40ONItgaeWO+c1FvK808lxigR3nrdIUOoowSSyWltJ0fYCCqPiWX63u7HotzMcvTwp1w5
 Jd8z4WZ1ndOC37/VePxWGoZs/+5IH0pW2PxqLSZUMogkzS7pVzBsM/rjBzoDtmbUh9jKY0iGO53
 eIAavGCNuddC8TE3ZILByeI2Z6QFbEDe5sdCsQwJ2ma8rcbuLW1EvHphAe0je9szghQUVXPwmBv
 pJLIpo/VQ5UsrSuz6xlNo2QNurUWSfX88mip20Ncy6Jou7cZUyXDEHVkeeaJy4hc5QPAs7mAsXo
 DRmBCXKBhFpKVMzfJYUAXN2R8K3Q08YmhPL7AfYy7RTdJ43uZYTnGk9yZQkhieOGPVlv2oPQ1rG
 rYj9krCVFxBWEH0v7SmAp9sf+39GPvdHJ3tPjvqkt2t3kPtJCbgNjglFU3l753vTlmwqVpEUlO1
 vWReW9Ne0kSYQuiqfta+jp5ypStmhmKewl3XZin1qXJqpM8PEsq/loeA3PBvETK0KMroF/pb4/Y
 SqqiP6QWJ/r48zBTPDFYfUHG+hKL98EQCGG9qrpPrHoeyt4qYPrPIuXaiydMYXSr4KckTcnTD7h
 WwSwGFysIO0DrfIynWj4L1rGoimu431jpKFA7L+JgibBMss7Q+SgJgv3PbQAY60SYlCGvFin37g
 u4NR/v027h0RyYQ==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Ricardo B. Marliere <rbm@suse.com>

Refactor the old mmap01 code into the new LTP API.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap01.c | 229 ++++++++++++--------------------
 1 file changed, 82 insertions(+), 147 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..b11d32e8df1b5dfa58863123171c48efdb86b05a 100644
--- a/testcases/kernel/syscalls/mmap/mmap01.c
+++ b/testcases/kernel/syscalls/mmap/mmap01.c
@@ -1,57 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2024 Ricardo B. Marliere <rbm@suse.com>
  *
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
+ * HISTORY
+ *	07/2001 Ported by Wayne Boyer
  */
 
-/*
- * Test Description:
+/*\
+ * [Description]
+ *
  *  Verify that, mmap() succeeds when used to map a file where size of the
  *  file is not a multiple of the page size, the memory area beyond the end
  *  of the file to the end of the page is accessible. Also, verify that
  *  this area is all zeroed and the modifications done to this area are
  *  not written to the file.
  *
- * Expected Result:
  *  mmap() should succeed returning the address of the mapped region.
  *  The memory area beyond the end of file to the end of page should be
  *  filled with zero.
  *  The changes beyond the end of file should not get written to the file.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
  */
-#include <stdio.h>
-#include <stdlib.h>
-#include <sys/types.h>
-#include <errno.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <signal.h>
-#include <stdint.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <sys/shm.h>
-
-#include "test.h"
-
-#define TEMPFILE	"mmapfile"
-
-char *TCID = "mmap01";
-int TST_TOTAL = 1;
+
+#include "tst_test.h"
+
+#define TEMPFILE "mmapfile"
 
 static char *addr;
 static char *dummy;
@@ -60,135 +33,97 @@ static size_t file_sz;
 static int fildes;
 static char cmd_buffer[BUFSIZ];
 
-static void setup(void);
-static void cleanup(void);
-
-int main(int ac, char **av)
+static void run(void)
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
-		 * Call mmap to map the temporary file beyond EOF
-		 * with write access.
-		 */
-		errno = 0;
-		addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
-			    MAP_FILE | MAP_SHARED, fildes, 0);
-
-		/* Check for the return value of mmap() */
-		if (addr == MAP_FAILED) {
-			tst_resm(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
-			continue;
-		}
-
-		/*
-		 * Check if mapped memory area beyond EOF are
-		 * zeros and changes beyond EOF are not written
-		 * to file.
-		 */
-		if (memcmp(&addr[file_sz], dummy, page_sz - file_sz)) {
-			tst_brkm(TFAIL, cleanup,
-				 "mapped memory area contains invalid "
-				 "data");
-		}
-
-		/*
-		 * Initialize memory beyond file size
-		 */
-		addr[file_sz] = 'X';
-		addr[file_sz + 1] = 'Y';
-		addr[file_sz + 2] = 'Z';
-
-		/*
-		 * Synchronize the mapped memory region
-		 * with the file.
-		 */
-		if (msync(addr, page_sz, MS_SYNC) != 0) {
-			tst_brkm(TFAIL | TERRNO, cleanup,
-				 "failed to synchronize mapped file");
-		}
-
-		/*
-		 * Now, Search for the pattern 'XYZ' in the
-		 * temporary file.  The pattern should not be
-		 * found and the return value should be 1.
-		 */
-		if (system(cmd_buffer) != 0) {
-			tst_resm(TPASS,
-				 "Functionality of mmap() successful");
-		} else {
-			tst_resm(TFAIL,
-				 "Specified pattern found in file");
-		}
-
-		/* Clean up things in case we are looping */
-		/* Unmap the mapped memory */
-		if (munmap(addr, page_sz) != 0) {
-			tst_brkm(TFAIL | TERRNO, NULL, "munmap failed");
-		}
+	addr = mmap(NULL, page_sz, PROT_READ | PROT_WRITE,
+		    MAP_FILE | MAP_SHARED, fildes, 0);
+
+	if (addr == MAP_FAILED) {
+		tst_res(TFAIL | TERRNO, "mmap of %s failed", TEMPFILE);
+		return;
+	}
+
+	/*
+	 * Check if mapped memory area beyond EOF are
+	 * zeros and changes beyond EOF are not written
+	 * to file.
+	 */
+	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
+		tst_brk(TFAIL, "mapped memory area contains invalid data");
+
+	/*
+	 * Initialize memory beyond file size
+	 */
+	addr[file_sz] = 'X';
+	addr[file_sz + 1] = 'Y';
+	addr[file_sz + 2] = 'Z';
+
+	/*
+	 * Synchronize the mapped memory region
+	 * with the file.
+	 */
+	if (msync(addr, page_sz, MS_SYNC) != 0) {
+		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
+		return;
+	}
+
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	if (system(cmd_buffer) != 0) {
+		tst_res(TPASS, "Functionality of mmap() successful");
+	} else {
+		tst_res(TFAIL, "Specified pattern found in file");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	/*
+	 * Clean up things in case we are looping
+	 * Unmap the mapped memory
+	 */
+	if (munmap(addr, page_sz) != 0) {
+		tst_res(TFAIL | TERRNO, "munmap failed");
+		return;
+	}
+}
+
+static void cleanup(void)
+{
+	if (dummy)
+		free(dummy);
+	if (fildes > 0)
+		SAFE_CLOSE(fildes);
 }
 
 static void setup(void)
 {
 	struct stat stat_buf;
-	char Path_name[PATH_MAX];
 	char write_buf[] = "hello world\n";
 
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	TEST_PAUSE;
-
-	tst_tmpdir();
-
-	/* Get the path of temporary file to be created */
-	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
-		tst_brkm(TFAIL | TERRNO, cleanup,
-			 "getcwd failed to get current working directory");
-	}
-
-	/* Creat a temporary file used for mapping */
-	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
-		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
-	}
+	/* Create a temporary file used for mapping */
+	fildes = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
 
 	/* Write some data into temporary file */
-	if (write(fildes, write_buf, strlen(write_buf)) != (long)strlen(write_buf)) {
-		tst_brkm(TFAIL, cleanup, "writing to %s", TEMPFILE);
-	}
+	SAFE_WRITE(SAFE_WRITE_ALL, fildes, write_buf, strlen(write_buf));
 
 	/* Get the size of temporary file */
-	if (stat(TEMPFILE, &stat_buf) < 0) {
-		tst_brkm(TFAIL | TERRNO, cleanup, "stat of %s failed",
-			 TEMPFILE);
-	}
+	SAFE_STAT(TEMPFILE, &stat_buf);
 	file_sz = stat_buf.st_size;
 
 	page_sz = getpagesize();
 
 	/* Allocate and initialize dummy string of system page size bytes */
-	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
-		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
-	}
+	dummy = SAFE_CALLOC(page_sz, sizeof(char));
 
 	/* Create the command which will be executed in the test */
-	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
+	snprintf(cmd_buffer, sizeof(cmd_buffer),
+		 "grep XYZ %s > /dev/null", TEMPFILE);
 }
 
-static void cleanup(void)
-{
-	close(fildes);
-	free(dummy);
-	tst_rmdir();
-}
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.test_all = run,
+};

---
base-commit: 865be36ffce81e795854d0bdd1cda17b4d5fd37d
change-id: 20241113-convert_mmap01-db208e002801

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
