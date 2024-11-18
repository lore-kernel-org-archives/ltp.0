Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D25AD49205
	for <ltp@archiver.kernel.org>; Mon, 18 Nov 2024 10:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731924969; h=date :
 mime-version : message-id : to : cc : subject : list-id :
 list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=/y024X2ayMBWWryJqk5+mWDTe6kyupCGaDR1SvArGNs=;
 b=abCkiXFloEJF4YdGLHnoTEq7/Z1qg+ybxvqi6OzNRxGbYvuYGObK/TadPtAmhBc4608fL
 CjfEEx+4CLFm0+7J2rU85276p1HHjS6WfC/mRCUtJhsLS1tISuNqbbNieFLSSlh1UoizHcu
 cb8QymOzNqSvKslptuDYn2BIoVVacoA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56EEB3D813B
	for <ltp@archiver.kernel.org>; Mon, 18 Nov 2024 11:16:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14A3C3D8126
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 11:15:48 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2F1031009BFC
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 11:15:47 +0100 (CET)
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2fb559b0b00so13675501fa.0
 for <ltp@lists.linux.it>; Mon, 18 Nov 2024 02:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731924946; x=1732529746; darn=lists.linux.it;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kqwG0CFWXMDhMDMCZ01sQLBNb0JSYDpzlvKaBF+LLFg=;
 b=NC+WRko++JxnEdS6/VN9PSm97b6TDv+UHlM/eiIojNARGlTVgqSoB1dQwWOoqymMEd
 4DSJ8lze0cBcKqzxg2C0sWvy3nG/l1X46NWRXj8xn054F2DQmNdoIjG3df4eiX6BTsYB
 3OKiWXenfRjV8Uz0DxWMKlFrpTOlOZV1WVihbyk/sTRFrV4drSgALlLZDfpKLANFA6g3
 ECZiWKr/nNuGEmbA1Tx0r7jqJwTIRp1jJmqrTI2nluYzC086NK7KQT18oKBCd2I0Qt89
 prXDjUXoApPLgm85RDTzF2E+U0d1gmsMTS3jTAqPzhbl5O8UqUvr0liYaVz15rD2KCfI
 71fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731924946; x=1732529746;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kqwG0CFWXMDhMDMCZ01sQLBNb0JSYDpzlvKaBF+LLFg=;
 b=BajJqhgy+5rbzriWfJl023c7sbyE1ZeBlioUrRkHNmwpMNjjA6FuvssutijlXVnggF
 bo05zYLVBzBSdNP2DSH5fLv/l6l4dn3zEQPMMPNC2B5deG3zAisjdkNQZGr6sZbQI8HL
 b+/br/bnCtBXpFECn2Y3mJ9NpAAn+9nPPPVlS2A7ScO8iDjq63xCUxCFpO4NXwc0FTl9
 LHytmAC39tl8j6TIRftQF4QnqkqKhuSTXChRGOWhfz0IXJcHQaT8f5lr7HUfJ56DXxUm
 dJuzcOOs9lBlSby9nXwoogGEOqYDu/Tpp1J1nsT5T68Z3ZCvTTjDASpqQZ2V2LEydJhW
 Omxw==
X-Gm-Message-State: AOJu0Ywi7NuB317KMH7OqtTwbKeg7+bzIO3p6IVN4kSFrOajMyY3gRkl
 ZhLFSeYvItsezfmdANBWMlY6UI3oyh03jw1aC1EUCWUUJ1mau6ZmH85Korq+HI5yY+x9MlxmYUL
 M
X-Google-Smtp-Source: AGHT+IHNjqN0Fs83l7yvhsUJIkaGrCSGKzCOliDVvfWAwMuXMLSWV4IKXazUaX48bmsGXczHuPQIGQ==
X-Received: by 2002:a05:651c:1590:b0:2ff:5897:2709 with SMTP id
 38308e7fff4ca-2ff60766f4emr47310111fa.38.1731924946123; 
 Mon, 18 Nov 2024 02:15:46 -0800 (PST)
Received: from localhost ([179.228.213.10]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29690223767sm644772fac.47.2024.11.18.02.15.43
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 02:15:44 -0800 (PST)
Date: Mon, 18 Nov 2024 07:15:40 -0300
MIME-Version: 1.0
Message-Id: <20241118-convert_mmap01-v3-1-b275c90035f5@suse.com>
X-B4-Tracking: v=1; b=H4sIAMsTO2cC/3XMQQrCMBCF4avIrI3MpMGmrryHiMRktFm0KUkNS
 undTbsqiMv34PsnSBw9JzjtJoicffKhL6Pa78C2pn+y8K5skCgVEVXChj5zHG9dZwYk4e4SNSN
 KjQQFDZEf/r0GL9eyW5/GED9rP9Py/k1lEiS4dkfkWqGy6pxeiQ82dLCUstxq9aNl0UYbqurGs
 dXNRs/z/AW7yNSB6QAAAA==
X-Change-ID: 20241113-convert_mmap01-db208e002801
To: ltp@lists.linux.it
Cc: 
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8840; i=rbm@suse.com;
 h=from:subject:message-id; bh=mAHWXUCSnnADyfNc8qr74DtFMfVhmQZOxkE2kwxCIYE=;
 b=owEBbAKT/ZANAwAIAckLinxjhlimAcsmYgBnOxPMdkELM95eiMWtW10cSAwe72kdFF3i0gTuK
 TxXmIp1ccGJAjIEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZzsTzAAKCRDJC4p8Y4ZY
 pmdpD/dOfhwf4TvCJLvzp4S9XYwWlwSVAEjoKhebU8QKZAaPthOVFr2ONb5rxxA3AIhxInM6fvx
 FoNBjFF9QPEUnMskxr7RVLIfzWLABWKXIt2fy2X913y77WvWpU5XfPupzaD0ijIkGmX2hMOK7uJ
 OaQTUjd6uXP4ItVbX/LI3PjpYc0l9UlFYnztu8agebJtQScrlonNBMEJJTIXR6cJO5tqccv65yw
 lakY6kbQiX1NzUHyr4fEQxkLA61NXqacWWBJwsfURtoS4DGhOC7IwUSinfF8347TCnGROFNtvGD
 m4KBNAZ/fd5/nA2J6vyIQHVSLolqEisFw3oz8U184kX70d3soz2iIGNsdqdkrzCkWx/XEwq6DdS
 sF+/pq6nAPxSAQH4/GsoVezjD8el+w+0qsW2zcdaeoeydlrcX4FQFEyzC+5i5nHn5VzykB6G7QM
 eYOaHdhkAI8AMPpnI9nvA7j87vtFPccHXa3M3mk6JKfhowz0QQC0U5JUOtQu2wLQWJreG2Vw0vu
 m9ZiFekiINjmog58XZ5kb0+GqXT5Al5T4hge6OslyoN7/vm8EDdtDjfdb89RmqQmWANoNculYIb
 15Jwi4ODEg2nILBFWqCpRmKeFD3N341x6YqnOsnDp8Bjm7CS8Xp819n9a8O6o14x0vbHdyoTo+8
 tEyZCLiMHQ3gx
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mmap01: Convert to new API
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
Changes in v3:
- Use SAFE_MMAP and SAFE_MUNMAP as suggested by Jan Stancek
- Re-aligned a few comments
- Link to v2: https://lore.kernel.org/r/20241114-convert_mmap01-v2-1-a8a1379dec89@suse.com

Changes in v2:
- Fixed metadata alignment
- Link to v1: https://lore.kernel.org/r/20241113-convert_mmap01-v1-1-e7d60e7404c4@suse.com
---
 testcases/kernel/syscalls/mmap/mmap01.c | 231 +++++++++++---------------------
 1 file changed, 76 insertions(+), 155 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
index 99266b57ffc16e6c3a0e31a2c87d0f8106f429e5..cb60fed024af7ad7a3114ad2838a5a52d5d3a1dc 100644
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
- *  Verify that, mmap() succeeds when used to map a file where size of the
- *  file is not a multiple of the page size, the memory area beyond the end
- *  of the file to the end of the page is accessible. Also, verify that
- *  this area is all zeroed and the modifications done to this area are
- *  not written to the file.
+/*\
+ * [Description]
  *
- * Expected Result:
- *  mmap() should succeed returning the address of the mapped region.
- *  The memory area beyond the end of file to the end of page should be
- *  filled with zero.
- *  The changes beyond the end of file should not get written to the file.
+ * Verify that, mmap() succeeds when used to map a file where size of the
+ * file is not a multiple of the page size, the memory area beyond the end
+ * of the file to the end of the page is accessible. Also, verify that
+ * this area is all zeroed and the modifications done to this area are
+ * not written to the file.
  *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
+ * mmap() should succeed returning the address of the mapped region.
+ * The memory area beyond the end of file to the end of page should be
+ * filled with zero.
+ * The changes beyond the end of file should not get written to the file.
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
@@ -60,135 +33,83 @@ static size_t file_sz;
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
+	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
+			 MAP_FILE | MAP_SHARED, fildes, 0);
+
+	/*
+	 * Check if mapped memory area beyond EOF are zeros and changes beyond
+	 * EOF are not written to file.
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
+	 * Synchronize the mapped memory region with the file.
+	 */
+	if (msync(addr, page_sz, MS_SYNC) != 0) {
+		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
+		return;
 	}
 
-	cleanup();
-	tst_exit();
+	/*
+	 * Now, search for the pattern 'XYZ' in the temporary file.
+	 * The pattern should not be found and the return value should be 1.
+	 */
+	if (system(cmd_buffer) != 0) {
+		tst_res(TPASS, "Functionality of mmap() successful");
+	} else {
+		tst_res(TFAIL, "Specified pattern found in file");
+		return;
+	}
+
+	SAFE_MUNMAP(addr, page_sz);
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
